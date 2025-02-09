from django.urls import path
from api import views

urlpatterns = [
    path('productModel/', views.ProductList.as_view(), name='product_list') ,
    path('productModel/categories/<str:category>/', views.ProductCategoryList.as_view(), name='product_category_list'),
]