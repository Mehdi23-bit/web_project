from django.shortcuts import render,get_object_or_404,redirect
from .models import Produit
from .forms import ProduitForm
from django.contrib.auth.decorators import login_required
from .forms import UserUpdateForm
from .cart import Cart
from .models import Produit
from django.http import JsonResponse
from django.views.decorators.cache import never_cache
from .category import Category
from payment.forms import ShippingForm
from payment.models import Shipping

def profile(request):
    return render(request,'profile.html')

@never_cache
def product_list(request):
    category=Category(request)
    if category.cat == 'all':
        products=Produit.objects.all()
        return render(request, 'product_listing.html', {'products': products})
  
    products = Produit.objects.filter(category=category.cat)
    return render(request, 'product_listing.html', {'products': products})


def category(request):
    category=Category(request)
    if request.POST.get('action')=='category':
        cat=request.POST.get('category')
        category.add(category=cat)
        if cat=='all':
          products=Produit.objects.all()
        else:
          products=Produit.objects.filter(category=cat)
        
        products_list=list(products.values('id','nom','prix','quantite','image','category'))
        for product in products_list:
            product['image']='/media/'+product['image']
            
        return JsonResponse({'products':products_list,'success':True})

@never_cache
def cartTab(request):
    return render(request,'cartTab.html')


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
        
def add(request):
  cart =Cart(request)
  if request.method=='POST':
    if request.POST.get('action')=='post':
        product_id=int(request.POST.get('product_id'))
        product=get_object_or_404(Produit,id=product_id)
        cart.add(product=product)
        if  cart.session.modified:
          response=JsonResponse({'length': len(cart),
                               'last_product': cart.get_last_prod(),
                               
                               })
        else:
         response=JsonResponse({'length': len(cart)})   
        
        return response
    

    
def update(request):
    cart=Cart(request)
    
    if request.POST.get('action')=='update':
        product_id=int(request.POST.get('product_id'))
        qte=int(request.POST.get('qte'))
        cart.update(product_id,qte)
        total=cart.tot_al()
        price=Produit.objects.get(pk=product_id).prix
        return JsonResponse({"qte":qte,
                             "price":price,
                             'total':total['total'],
                             'taxed_total':total['taxed_total']
                             })
    
def delete(request):
    cart=Cart(request)
    
    if request.POST.get('action')=='delete':
        product_id=request.POST.get('product_id')
        cart.delete(product_id)
        total=cart.tot_al()
        return JsonResponse({'id':product_id,
                             'len':len(cart),
                             'total':total['total'],
                             'taxed_total':total['taxed_total']})
def shipping_info(request):
   try:
    shipping_info = Shipping.objects.get(user=request.user)
    form = ShippingForm(initial={
        'first_name': shipping_info.first_name,
        'last_name': shipping_info.last_name,
        'adresse1': shipping_info.adresse1,
        'adresse2': shipping_info.adresse2,
        'email':shipping_info.email,
        'city': shipping_info.city,
        'province': shipping_info.province,
        'zipcode': shipping_info.zipcode,
        'country': shipping_info.country,
    
    })
   except Shipping.DoesNotExist:
    shipping_info=None
    form=ShippingForm()
    
    return render(request, "shipping_info.html", {'form': form})
def update_ship(request):
    try:
        # User has an existing shipping address, populate the form
        shipping_address = request.user.shipping_address
        form = ShippingForm(request.POST or None, instance=shipping_address)
    except Shipping.DoesNotExist:
        # User doesn't have a shipping address, create a new form
        form = ShippingForm(request.POST or None)

    if request.method == 'POST' and form.is_valid():
        form.save(user=request.user)
        return redirect('myapp:shipping_info')
    

    return render(request, 'shipping_info.html', {'form': form})
               
def get_ship(user):
    try:
        return user.shipping_address.pk
    except Shipping.DoesNotExist:
        return None