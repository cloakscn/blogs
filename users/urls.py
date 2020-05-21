# 进行users子应用的视图路由
from django.urls import path
from users.views import RegisterView, ImageCodeViem, SmsCodeViem, LoginView, LogoutView, ForgetPasswordView, \
    UserClientView, WriteBlogView

urlpatterns = [
    # path的第一个参数是路由
    # path的第二个参数是视图函数名
    path('register/', RegisterView.as_view(), name='register'),

    # 图片验证码的路由
    path('imagecode/', ImageCodeViem.as_view(), name='imagecode'),

    # 短信路由
    path('smscode/', SmsCodeViem.as_view(), name='smscode'),

    # 登录路由
    path('login/', LoginView.as_view(), name='login'),

    # 退出登录
    path('logout/', LogoutView.as_view(), name='logout'),

    # 忘记密码
    path('forgetpassword/', ForgetPasswordView.as_view(), name='forgetpassword'),

    # 个人中心
    path('center/', UserClientView.as_view(), name='center'),

    # 博客发布
    path('writeblog/', WriteBlogView.as_view(), name='writeblog'),

]