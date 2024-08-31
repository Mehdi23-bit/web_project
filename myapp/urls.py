from django.urls import path
from . import views

app_name='myapp'

urlpatterns = [
    path('pro/',views.product_list,name='product_list'),
    path('super_user/',views.super_user,name='super_user'),
    path('add/',views.add,name='add'),
    path('update/',views.update,name='update'),
    path('cartTab/',views.cartTab,name='cartTab'),
    path('delete/',views.delete,name='delete_pro'),
    path('profile/',views.profile,name='profile'),
    path('category/',views.category,name='category'),
    path('shipping_info/',views.shipping_info,name="shipping_info"),
    path('update_ship/',views.update_ship,name='update_ship'),
    path('orders/',views.orders,name='orders')
]


