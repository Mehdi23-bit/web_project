from . import views
from django.urls import path
app_name='payment'

urlpatterns = [
    path("",views.home,name="home"),
]
