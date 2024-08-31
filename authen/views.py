from django.shortcuts import render,redirect
from django.contrib.auth import authenticate,login
from django.contrib.auth.decorators import login_required
from django.contrib.auth import logout
from .forms import LoginForm,SignInForm
from django.contrib import messages
from .models import Profile
from .save_session import load_persistent_data,save_persistent_data
@login_required
def custom_logout_view(request):
    #if request.user.is_authenticated:
        print("I begin saving")
        # Make sure to pass the actual user object, not request.user
        user = request.user
        session_key = request.session['session_key']
        save_persistent_data(user, session_key)
        print("I am done with saving")
        logout(request)  # Log out the user
        return redirect('authen:login_page')  # Redirect to the login page




@login_required
def success(request):
    if request.user.is_superuser:
        return redirect('myapp:super_user')
    else: 
     return redirect('myapp:product_list')


def login_page(request):
    if request.user.is_authenticated:
        return redirect('/success/')
    form = LoginForm()
    return render(request,'login.html',{'form':form})

def login_(request):
    if request.method=='POST':
        form=LoginForm(request.POST)
        if form.is_valid():
            username = form.cleaned_data['username']
            password = form.cleaned_data['password']
            user = authenticate(username=username, password=password)
            #if user is not None:
            request.session['session_key'] = load_persistent_data(user)
            login(request, user)
            if user.is_superuser:
               return redirect('myapp:super_user')
            else: 
                    return redirect('myapp:product_list')

        else:
                error_message = "Le nom d'utilisateur ou le mot de passe est incorrect."
                context = {'error_message': error_message,'form':form}
                return render(request, 'login.html', context)
            

    else:
        error_message = "vous avez des error en les information que vous submiter"
        context = {'error_message': error_message,'form':form}
        return render(request, 'login.html', context)
    
            
def sign_in(request):
    if request.method == 'POST':
        form=SignInForm(request.POST)
        if form.is_valid():
            user=form.save()
            username = form.cleaned_data['username']
            messages.success(request,"Vous enrigestrer l'utilisateur " +username+' avec succès' )
           
            return redirect('authen:login_page')
            
        else:

           return render(request,'sign_in.html',{'form': form})
        
def sign_page(request):
   form=SignInForm()
   return render(request,'sign_in.html',{'form': form})