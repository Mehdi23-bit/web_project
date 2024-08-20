from .cart import Cart
from .category import Category

def cart(request):
    return {'cart':Cart(request)}
def category(request):
    return {'category':Category(request).cat}