from django.db import models
from django.utils import timezone
# Create your models here.

class ArticleCategory(models.Model):
    """
    文章分类
    """
    # 分类标题
    title = models.CharField(max_length=100, blank=True)
    # 分类创建时间
    created = models.DateTimeField(default=timezone.now)

    # admin 站点显示，调试查看对象方便
    def __str__(self):

        return self.title

    class Meta:
        db_table = 'tb_catogory' # 修改表名
        verbose_name = '类别管理' # admin 站点显示
        verbose_name_plural = verbose_name

from users.models import User
from django.utils import timezone
class Article(models.Model):
    """
    作者
    标题
    标题图
    分类
    标签
    摘要信息
    浏览量
    评论量
    创建时间
    修改时间
    """
    # 作者
    # 参数on_delete 当用户信息删除后，文章信息也同时删除
    author = models.ForeignKey(User, on_delete=models.CASCADE)
    # 标题
    avatar = models.ImageField(upload_to='article/%Y%m%d/', blank=True)
    # 标题图
    title = models.CharField(max_length=20, blank=True)
    # 分类
    category = models.ForeignKey(ArticleCategory, null=True, blank=True, on_delete=models.CASCADE, related_name='article')
    # 标签
    tags = models.CharField(max_length=20, blank=True)
    # 摘要信息
    summary = models.CharField(max_length=200, blank=False, null=False)
    # 文章正文
    content = models.TextField()
    # 浏览量
    total_view = models.PositiveIntegerField(default=0)
    # 评论量
    comments = models.PositiveIntegerField(default=0)
    # 创建时间
    created = models.DateTimeField(default=timezone.now)
    # 修改时间
    updated = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = 'tb_article'
        ordering = ('-created',)
        verbose_name = '文章管理'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.title

class Comment(models.Model):
    """
    评论内容
    评论文章
    评论用户
    评论时间
    """
    comment = models.TextField()
    article = models.ForeignKey(Article, on_delete=models.SET_NULL, null=True)
    user = models.ForeignKey('users.User',on_delete=models.SET_NULL, null=True)
    created = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.article.title

    class Meta:
        db_table = 'tb_comment'
        verbose_name = '评论管理'
        verbose_name_plural = verbose_name