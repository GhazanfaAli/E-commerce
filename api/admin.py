from django.contrib import admin
from .models import ProductsModel

# Register your models here.

@admin.register(ProductsModel)
class ProductAdmin(admin.ModelAdmin):
    list_display = ['id','productUrl','producttitle','productDescription','productPrice']
    search_fields = ['producttitle', 'category']
