from django.core.paginator import Paginator
from django.core.paginator import EmptyPage
from django.shortcuts import render, redirect
from django.urls import reverse
from django.views import View
from home.models import ArticleCategory, Article
from django.http.response import HttpResponseNotFound


# Create your views here.
class IndexView(View):
    def get(self, request):
        """
        1.获取所有分类信息
        2.接收用户点击的分类id
        3.根据分类id进行分类查询
        4.获取分页参数
        5.根据分类信息查询文章数据
        6.创建分页器
        7.进行分页处理
        8.组织数据
        :param request:
        :return:
        """
        # 1.获取所有分类信息
        categories = ArticleCategory.objects.all()
        # 2.接收用户点击的分类id
        cat_id = request.GET.get('cat_id', 1)
        # 3.根据分类id进行分类查询
        try:
            category = ArticleCategory.objects.get(id=cat_id)
        except ArticleCategory.DoesNotExist:
            return HttpResponseNotFound('没有此分类')
        # 4.获取分页参数
        page_num = request.GET.get('page_num', 1)
        page_size = request.GET.get('page_size', 10)
        # 5.根据分类信息查询文章数据
        articles = Article.objects.filter(category=category)
        # 6.创建分页器
        paginator = Paginator(articles, per_page=page_size)
        # 7.进行分页处理
        try:
            page_articles = paginator.page(page_num)
        except EmptyPage:
            return HttpResponseNotFound('empty page')
        # 总页数
        total_page = paginator.num_pages
        # 8.组织数据
        context = {
            'categories': categories,
            'category': category,
            'articles': page_articles,
            'page_size': page_size,
            'total_page': total_page,
            'page_num': page_num,
        }
        return render(request, 'index.html', context=context)

from home.models import Comment
class DetailView(View):

    def get(self, request):
        """
        1.接收数据
        2.根据id进行数据查询
        3.查询分类数据
        4.获取分页请求参数
        5.根据文章信息请求参数
        6.创建分页器
        7.进行分页处理
        8.组织模板数据
        :param request:
        :return:
        """

        # 1.接收数据
        id = request.GET.get('id')
        # 2.根据id进行数据查询
        try:
            article = Article.objects.get(id=id)
        except Article.DoesNotExist:
            return render(request, '404.html')
        else:
            article.total_view += 1
            article.save()
        # 3.查询分类数据
        categories = ArticleCategory.objects.all()
        # 查询浏览量前十的文章数据
        hot_articles = Article.objects.order_by('-total_view')[:9]
        # 4.获取分页请求参数
        page_size = request.GET.get('page_size', 10)
        page_num = request.GET.get('page_num', 1)
        comments = Comment.objects.filter(article=article).order_by('-created')
        # 5.根据文章信息请求参数
        total_count = comments.count()
        # 6.创建分页器
        from django.core.paginator import Paginator, EmptyPage
        paginator = Paginator(comments, page_size)
        # 7.进行分页处理
        try:
            page_comments = paginator.page(page_num)
        except EmptyPage:
            return HttpResponseNotFound('empty page')
        # 总页数
        total_page = paginator.num_pages
        # 8.组织模板数据
        context = {
            'categories': categories,
            'category': article.category,
            'article': article,
            'hot_articles': hot_articles,
            'total_count': total_count,
            'comments': page_comments,
            'page_size': page_size,
            'total_page': total_page,
            'page_num': page_num,
        }
        return render(request, 'detail.html', context=context)

    def post(self, request):
        """
        1.接收信息
        2.判断用户是否登录
        3.登录则可以接收
            3.1接收评论数据
            3.2验证文章是否存在
            3.3保存评论数据
            3.4修改评论数量
        4.未登录用户跳转登录
        :param request:
        :return:
        """

        # 1.接收信息
        user = request.user
        # 2.判断用户是否登录
        if user and user.is_authenticated:
            # 3.登录则可以接收
            #     3.1接收评论数据
            id = request.POST.get('id')
            comment = request.POST.get('content')
            #     3.2验证文章是否存在
            try:
                article = Article.objects.get(id=id)
            except Article.DoesNotExist:
                return HttpResponseNotFound('没有此此文章')
            #     3.3保存评论数据
            Comment.objects.create(
                comment=comment,
                article=article,
                user=user,
            )
            #     3.4修改评论数量
            article.comments += 1
            article.save()
            # 刷新当前页面
            path = reverse('home:detail') + '?id={}'.format(article.id)
            return redirect(path)
        else:
        # 4.未登录用户跳转登录
            return credits(reversed('home:index'))
