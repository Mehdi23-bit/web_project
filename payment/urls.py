from . import views
from django.urls import path
app_name='payment'

urlpatterns = [

    path("paypal-ipn/",views.paypal_ipn,name='paypal-ipn'),
    path("return_view/",views.return_view,name='return-view'),
    path("cancel_view/",views.cancel_view,name='cancel-view'),
   

]
