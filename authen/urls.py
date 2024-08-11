from django.urls import path
from . import views
from django.contrib.auth import views as auth_views

app_name='authen'

urlpatterns=[

    path('success/',views.success,name='success'),
    path('',views.login_page,name='login_page'),
    path('login/',views.login_,name='login'),
    path('logout/', auth_views.LogoutView.as_view(next_page='authen:login_page'), name='logout'), 
    path('sign_in/',views.sign_in,name='sign_in'),
    path('sign_page/',views.sign_page,name='sign_page'),
    
   
]