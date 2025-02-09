from django.db import models

class ProductsModel(models.Model):
    productUrl = models.CharField(max_length=300)
    producttitle = models.CharField(max_length=100)
    productDescription = models.CharField(max_length=400)
    productPrice = models.CharField(max_length=100)
    category = models.CharField(max_length=100, null=True, blank=True) 
