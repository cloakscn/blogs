import re
import logging
from django.http.response import HttpResponseBadRequest, JsonResponse
from django.shortcuts import render, redirect
from django.urls import reverse
from django_redis import get_redis_connection
from django.http import HttpResponse
from utils.response_code import RETCODE
# Create your views here.
from django.views import View
from random import randint
from libs.yuntongxun.sms import CCP
from libs.captcha.captcha import captcha
from users.models import User
from django.db import DatabaseError
logger = logging.getLogger('django')

class RegisterView(View):

    def get(self, request):
        return render(request, 'register.html')

    def post(self, request):
        """
        1.接收数据
        2.验证数据
            2.1验证参数是否齐全
            2.2验证手机号格式是否正确
            2.3验证密码是否符和
            2.4密码和确认密码是否一致
        3.保存注册信息
        4.跳转到指定页面
        :param request:
        :return:
        """
        # 1.接收数据
        mobile = request.POST.get('mobile')
        password = request.POST.get('password')
        password2 = request.POST.get('password2')
        smscode = request.POST.get('sms_code')
        # 2.验证数据
        #     2.1验证参数是否齐全
        if not all([mobile, password, password2, smscode]):
            return HttpResponseBadRequest('缺少必要参数')
        #     2.2验证手机号格式是否正确
        if not re.match(r'^1[3-9]\d{9}$', mobile):
            return HttpResponseBadRequest('手机号不符合规则')
        #     2.3验证密码是否符和
        if not re.match(r'^[0-9A-Za-z]{8,20}$', password):
            return HttpResponseBadRequest('请输入8-20位密码，密码是字母和数字')
        #     2.4密码和确认密码是否一致
        if password != password2:
            return HttpResponseBadRequest('两次密码不一致')
        redis_conn = get_redis_connection('default')
        redis_sms_code = redis_conn.get('sms:%s' % mobile)
        if redis_sms_code is None:
            return HttpResponseBadRequest('短信验证码已过期')
        if smscode != redis_sms_code.decode():
            return HttpResponseBadRequest('短信验证码错误')
        # 3.保存注册信息
        # create_user可以对密码进行加密
        try:
            user = User.objects.create_user(username=mobile,
                                        mobile=mobile,
                                        password=password)
        except DatabaseError as e:
            logger.error(e)
            return HttpResponseBadRequest('注册失败')

        from django.contrib.auth import login
        login(request, user)
        # 4.跳转到指定页面
        # return HttpResponse('注册成功，重定向到首页')

        # redirect 重定向
        # reverse 是可以通过namespace：name 来获取视图所对应的路由
        response =  redirect(reverse('home:index'))
        # 设置cookie信息，用户登录持久化
        response.set_cookie('is_login', True)
        response.set_cookie('username', user.username, max_age=7*24*3600)
        return response

class ImageCodeViem(View):

    def get(self, request):
        """
        1.接受前端传递过来的uuid
        2.判断uuid是否获取到
        3.通过调用captcha 生成图片验证码（图片二进制和图片内容）
        4.将图片保存到redis中
            uuid作为一个key，图片内容作为一个value 同时我们还需要设置一个实效
        5.返回图片二进制
        :param request:
        :return:
        """
        # 1.接受前端传递过来的uuid
        uuid = request.GET.get('uuid')
        # 2.判断uuid是否获取到
        if uuid is None:
            return HttpResponseBadRequest('没有传入uuid')
        # 3.通过调用captcha 生成图片验证码（图片二进制和图片内容）
        text, image = captcha.generate_captcha()
        # 4.将图片保存到redis中
        #     uuid作为一个key，图片内容作为一个value 同时我们还需要设置一个实效
        redis_conn = get_redis_connection('default')
        # key 设置为 uuid
        # seconds 过期秒数 300秒
        # value text
        redis_conn.setex('img:%s' % uuid, 300, text)
        # 5.返回图片二进制
        return HttpResponse(image, content_type='image/jpeg')

class SmsCodeViem(View):

    def get(self, request):
        """
        # 1.接收参数
        # 2.参数验证
        #     2.1验证参数是否齐全
        #     2.2图片验证码的验证
        # 3.生产短信验证码
        # 4.保存短信验证码到redis中
        # 5.发送短信
        # 6.返回响应
        :param request:
        :return:
        """
        # 1.接收参数
        mobile = request.GET.get('mobile')
        image_code = request.GET.get('image_code')
        uuid = request.GET.get('uuid')
        # 2.参数验证
        #     2.1验证参数是否齐全
        if not all([mobile, image_code, uuid]):
            return JsonResponse({'code': RETCODE.NECESSARYPARAMERR, 'errmsg': '缺少必要的参数 '})
        #     2.2图片验证码的验证
        redis_conn = get_redis_connection('default')
        redis_image_code = redis_conn.get('img:%s' % uuid)
        if redis_image_code is None:
            return JsonResponse({'code': RETCODE.IMAGECODEERR, 'errmsg': '图片验证码已过期'})
        try:
            redis_conn.delete('img:%s' % uuid)
        except Exception as e:
            logger.error(e)
        if redis_image_code.decode().lower() != image_code.lower():
            return JsonResponse({'code': RETCODE.IMAGECODEERR, 'errmsg': '图片验证码错误'})
        # 3.生产短信验证码
        sms_code = '%06d' % randint(0, 999999)
        logger.info(sms_code)
        # 4.保存短信验证码到redis中
        redis_conn.setex('sms:%s' % mobile, 300, sms_code)
        # 5.发送短信
        CCP().send_template_sms(mobile, [sms_code, 5], 1)
        # 6.返回响应
        return JsonResponse({'code': RETCODE.OK, 'errmsg': '短信发送成功'})

class LoginView(View):

    def get(self, request):

        return render(request, 'login.html')

    def post(self, request):
        """
         1.接收参数
         2.参数验证
         3.用户认证登录
         4.状态保持
         5.根据用户选择进行判断
         6.设置cookie
         7.返回响应
         :param request:
         :return:
         """
        # 1.接收参数
        mobile = request.POST.get('mobile')
        password = request.POST.get('password')
        remember = request.POST.get('remember')
        # 2.参数验证
        if not re.match(r'^1[3-9]\d{9}$', mobile):
            return HttpResponseBadRequest('手机号不符合规则')
        if not re.match(r'^[0-9A-Za-z]{8,20}$', password):
            return HttpResponseBadRequest('密码不符合规范')
        # 3.用户认证登录
        from django.contrib.auth import authenticate
        user = authenticate(mobile=mobile,
                            password=password)
        if user is None:
            return HttpResponseBadRequest('用户名或密码错误')
        # 4.状态保持
        from django.contrib.auth import login
        login(request, user)
        # 5.根据用户选择进行判断
        # 6.设置cookie
        # 7.根据next参数来进行页面跳转
        next_page = request.GET.get('next')
        if next_page:
            response = redirect(next_page)
        else:
            response = redirect(reverse('home:index'))
        if remember != 'on':
            # 浏览器关闭后
            request.session.set_expiry(0)
            response.set_cookie('is_login', True)
            response.set_cookie('username', user.username, max_age=1800)
        else:
            # 默认两周
            request.session.set_expiry(None)
            response.set_cookie('is_login', True)
            response.set_cookie('username', user.username, max_age=7*24*3600)
        # 7.返回响应
        return response

from django.contrib.auth import logout
class LogoutView(View):

    def get(self, request):
        # 1.session 数据清楚
        logout(request)
        # 2.删除部分cookie数据
        response = redirect(reverse('home:index'))
        response.delete_cookie('is_login')
        # 3.跳转到首页
        return response

class ForgetPasswordView(View):

    def get(self, request):

        return render(request, 'forget_password.html')

    def post(self, request):
        """
        1.接收数据
        2.验证数据
        3.用户信息查询
        4.如果手机号查询成功，修改密码
        5.未查出，注册新用户
        6.页面重定向登录页面
        7.返回响应
        :param request:
        :return:
        """
        # 1.接收数据
        mobile = request.POST.get('mobile')
        password = request.POST.get('password')
        password2 = request.POST.get('password2')
        smscode = request.POST.get('sms_code')
        # 2.验证数据
        if not all([mobile, password, password2, smscode]):
            return HttpResponseBadRequest('参数不全')
        if not re.match(r'^1[3-9]\d{9}$', mobile):
            return HttpResponseBadRequest('手机号不符合规范')
        if not re.match(r'^[0-9A-Za-z]{8,20}$', password):
            return HttpResponseBadRequest('请输入8-20位密码，密码是字母和数字')
        if password != password2:
            return HttpResponseBadRequest('两次密码不一致')
        redis_conn = get_redis_connection('default')
        redis_sms_code = redis_conn.get('sms:%s' % mobile)
        if redis_sms_code is None:
            return HttpResponseBadRequest('短信验证码已过期')
        if smscode != redis_sms_code.decode():
            return HttpResponseBadRequest('短信验证码错误')
        # 3.用户信息查询
        try:
            user = User.objects.get(mobile = mobile)
        except User.DoesNotExist:
            # 5.未查出，注册新用户
            try:
                User.objects.create_user(username=mobile,
                                     mobile=mobile,
                                     password=password)
            except Exception:
                return HttpResponseBadRequest('创建失败，请稍后重试')
        else:
            # 4.如果手机号查询成功，修改密码
            user.set_password(password)
            user.save()
        # 6.页面重定向登录页面
        response = redirect(reverse('users:login'))
        # 7.返回响应
        return response

from django.contrib.auth.mixins import LoginRequiredMixin
# 如果用户未登录，进行默认跳转
# 默认跳转路由是： accounts/login?next=xxx
class UserClientView(LoginRequiredMixin, View):

    def get(self, request):
        # 获取登录信息
        user = request.user
        # 组织获取用户信息
        context = {
            'username': user.username,
            'mobile': user.mobile,
            'avatar': user.avatar.url if user.avatar else None,
            'user_desc':user.user_desc
        }
        return render(request, 'center.html', context=context)

    def post(self, request):
        """
        1.接收参数
        2.将参数保存
        3.跟新cookie信息
        4.刷新当前页面（重定向）
        5.返回响应
        :param request:
        :return:
        """
        user = request.user
        # 1.接收参数
        username = request.POST.get('username', user.username)
        user_desc = request.POST.get('desc', user.user_desc)
        avatar = request.FILES.get('avatar')
        # 2.将参数保存
        try:
            user.username = username
            user.user_desc = user_desc
            if avatar:
                user.avatar = avatar
            user.save()
        except Exception as e:
            logger.error(e)
            return HttpResponseBadRequest('修改失败请稍后再试')
        # 3.跟新cookie信息
        # 4.刷新当前页面（重定向）
        response = redirect(reverse('users:center'))
        response.set_cookie('username', user.username, max_age=1800)
        # 5.返回响应
        return response

from home.models import ArticleCategory, Article
class WriteBlogView(LoginRequiredMixin, View):

    def get(self, request):
        # 查询所有分类
        categories = ArticleCategory.objects.all()

        context = {
            'categories':categories
        }
        return render(request, 'write_blog.html', context=context)

    def post(self, request):
        """
        1.接收数据
        2.验证数据
        3.数据入库
        4.跳转到指定页面（暂时首页）
        :param request:
        :return:
        """
        # 1.接收数据
        avatar = request.FILES.get('avatar')
        title = request.POST.get('title')
        category_id = request.POST.get('category')
        tags = request.POST.get('tags')
        summary = request.POST.get('sumary')
        content = request.POST.get('content')
        user = request.user
        # 2.验证数据
        if not all([avatar, title, category_id, tags, summary, content]):
            return HttpResponseBadRequest('参数不全')
        try:
            category = ArticleCategory.objects.get(id = category_id)
        except ArticleCategory.DoesNotExist:
            return HttpResponseBadRequest('没有此分类')
        # 3.数据入库
        try:
            article = Article.objects.create(
                author=user,
                avatar=avatar,
                title=title,
                tags=tags,
                category=category,
                summary=summary,
                content=content,
            )
        except Exception as e:
            logger.error(e)
            return HttpResponseBadRequest('发布失败，请稍后再试')
        # 4.跳转到指定页面（暂时首页
        return redirect(reverse('home:index'))