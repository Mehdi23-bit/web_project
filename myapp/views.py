from django.shortcuts import render,get_object_or_404,redirect
from .models import Produit
from .forms import ProduitForm
from django.contrib.auth.decorators import login_required
from .forms import UserUpdateForm
# Create your views here.



def product_list(request):
   products=Produit.objects.all()

   return render(request,'product_listing.html',{'products':products})





def super_user(request):
   
     if request.method =='POST':
        if 'save' in request.POST:
          pk=request.POST.get('save')
          if pk:  
                produit = get_object_or_404(Produit, pk=pk)
                form = ProduitForm(request.POST, request.FILES, instance=produit)
                
          else:  
                form = ProduitForm(request.POST, request.FILES)
                
          if form.is_valid():
                form.save()
                return redirect('myapp:super_user')
          else:
              products=Produit.objects.all()
              return render(request,'super_user.html',{'form':form,'produit':products})
        elif 'delete' in request.POST:
          pk = request.POST.get('delete')
          produit = get_object_or_404(Produit, pk=pk)
          produit.delete()
          products=Produit.objects.all() 
          return redirect('myapp:super_user')

        elif 'modify' in request.POST:
          pk=request.POST.get('modify')
          products=Produit.objects.all()
          produit=Produit.objects.get(pk=pk)
          return render(request,'super_user.html',{'produit':products,'id':produit.pk,'modify':True})
     else :
   
        products=Produit.objects.all() 
        return render(request,'super_user.html',{'produit':products,'modify':False})
   
@login_required
def update_user_info(request):
    if request.method == 'POST':
        form = UserUpdateForm(request.POST, instance=request.user)
        if form.is_valid():
            form.save()
      
            return redirect('myapp:product_list')  # Redirect to some page after update