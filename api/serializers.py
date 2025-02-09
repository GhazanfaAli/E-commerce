from rest_framework import serializers
from .models import ProductsModel

class ProductSerializers(serializers.ModelSerializer):
    class Meta:
        model = ProductsModel
        fields = ['id','productUrl','producttitle','productDescription','productPrice']
