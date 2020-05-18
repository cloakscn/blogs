from django.http.response import HttpResponseBadRequest
from django.shortcuts import render
from django_redis import get_redis_connection
from django.http import HttpResponse

# Create your views here.
from django.views import View

from libs.captcha.captcha import captcha


class RegisterView(View):

    def get(self, request):

        return render(request, 'register.html')

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
        redis_conn.setex('img:%s'% uuid, 300, text)
        # 5.返回图片二进制
        return HttpResponse(image, content_type='image/jpeg')
        pass