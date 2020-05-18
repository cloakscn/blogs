# 进行users子应用的视图路由
from django.urls import path
from users.views import LoginView

urlpatterns = [
    # path的第一个参数是路由
    # path的第二个参数是视图函数名
    path('register/', LoginView.as_view(), name='register'),
]