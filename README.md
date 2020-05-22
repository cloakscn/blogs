######技术亮点
  1. 采用Vue作为前端框架
  2. 采用Django作为后端框架
  3. 采用Django模板引擎
  4. 采用云通讯短**送
  5. 采用session技术
<hr>

#### django基本命令

[更多知识请点击访问](https://code.ziqiangxuetang.com/django)

```
# 新建一个django project
django-admin.py startproject project_name
# 新建app(一般一个项目有多个app,当然通用的app也可以再多个项目中使用)
python manage.py startapp app_name
# 创建数据库表 或 更改数据库信息
	# 创建更改的文件
python manage.py makemigrations
	# 将生成的py文件应用到数据库
python manage.py migrate
# 使用开发服务器
python manage.py runserver
# 清空数据库
python manage.py flush
# 创建超级管理员
python manage.py createsuperuser
# 导出、导入数据
python manage.py dumpdata appname > appname.json
python manage.py loaddata appname.json
```

##数据库连接
```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'HOST': '127.0.0.1',
        'PORT': 3306,
        'USER': 'root',
        'PASSWORD': 'haosql',
        'NAME': 'djangoblog'
    }
}
```
##redis配置
```python
CACHES = {
    "default": {
        "BACKEND": "django_redis.cache.RedisCache",
        "LOCATION": "redis://127.0.0.1:6379/0",
        "OPTIONS": {
            "CLIENT_CLASS": "django_redis.client.DefaultClient",
        },
    },
    "session": {
        "BACKEND": "django_redis.cache.RedisCache",
        "LOCATION": "redis://127.0.0.1:6379/1",
        "OPTIONS": {
            "CLIENT_CLASS": "django_redis.client.DefaultClient",
        }
    }
}
# session由数据库存储改为redis
SESSION_ENGINE = "django.contrib.sessions.backends.cache"
SESSION_CACHE_ALIAS = "session"
```
##配置工程日志
1. 配置工程日志


```python
LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,  # 是否禁用已经存在的日志器
    'formatters': {  # 日志信息显示的格式
        'verbose': {
            'format': '%(levelname)s %(asctime)s %(module)s %(lineno)d %(message)s'
        },
        'simple': {
            'format': "%(levelname)s %(module)s %(lineno)d %(message)s"
        },
    },
    'filters': {  # 对日志进行过滤
        'require_debug_true': {  # django在debug模式下才输出日志
            '()': 'django.utils.log.RequireDebugTrue',
        },
    },
    'handlers': {  # 日志处理方法
        'console': {  # 像终端输出日志
            'level': 'INFO',
            'filters': ['require_debug_true'],
            'class': 'logging.StreamHandler',
            'formatter': 'simple',
        },
        'file': {  # 向文件中输出日志
            'level': 'INFO',
            'class': 'logging.handlers.RotatingFileHandler',
            'filename': os.path.join(BASE_DIR, 'logs/blog.log'),  # 日志文件的位置
            'maxBytes': 300 * 1024 * 1024,
            'backupCount': 10,
            'formatter': 'verbose',
        },
    },
    'loggers': {  # 日志器
        'django': {  # 定义了一个名为django的日志器
            'handlers': ['console', 'file'],  # 可以同时向终端与文件中输出日志
            'propagate': True,  # 是否继续传递日志信息
            'level': 'INFO',  # 日志器接受的最低日志级别
        }
    },
}
```
2. 在根目录下创建logs文件

3. 日志记录器的使用
	

不同的应用程序所定义的日志等级可能会有所差别，分的详细点的会包含以下几个等级
* FATA/CRITICAL = 重大的，危险的
* ERROR = 错误
* WARNING = 警告
* INFO = 信息
* DEBUG = 调试
* NOTSET = 没有设置

```python
import logging
logger = logging.getlogger()
logger.debug('debug')
logger.info('info')
logger.error('error')
```