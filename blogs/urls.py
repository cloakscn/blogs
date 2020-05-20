"""blogs URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
# 1. 导入系统的logging
import logging
from django.contrib import admin
from django.urls import path, include
from django.http import HttpResponse
# 2. 获取日志器
# logger = logging.getLogger('django')
#
# def log(request):
#     # 3. 使用日志器
#     logger.info('info')
#     return HttpResponse('test')

urlpatterns = [
    path('admin/', admin.site.urls),
    # 设置元组
    # urlconf_module 子应用的路由
    # app_name
    path('', include(('users.urls', 'users'), namespace='register')),
    path('', include(('home.urls', 'home'), namespace='home')),
    # path('', log),
]
# 图片访问路由
from django.conf import settings
from django.conf.urls.static import static
urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
