from . import views
from django.urls import path
app_name='payment'

urlpatterns = [
    path("return_view/",views.return_view,name='return-view'),
    path("cancel_view/",views.cancel_view,name='cancel-view'),
    path("pay/",views.pay,name='pay'),
]
