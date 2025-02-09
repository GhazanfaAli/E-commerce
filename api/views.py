from .models import ProductsModel
from .serializers import ProductSerializers
from rest_framework.generics import ListAPIView

# Create your views here.

class ProductList(ListAPIView):
    queryset = ProductsModel.objects.all()
    serializer_class = ProductSerializers

class ProductCategoryList(ListAPIView):
    serializer_class = ProductSerializers

    def get_queryset(self):
        category = self.kwargs['category']
        return ProductsModel.objects.filter(category=category)  # Filter by category    