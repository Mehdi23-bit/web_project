from django.urls import path
from . import views

app_name='myapp'

urlpatterns = [
    path('pro/',views.product_list,name='product_list'),
    path('super_user/',views.super_user,name='super_user')
]
