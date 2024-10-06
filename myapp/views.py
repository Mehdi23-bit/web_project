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
from payment.forms import CustomPayPalPaymentsForm
from django.urls import reverse
from ll_project.settings import PAYPAL_RECEIVER_EMAIL
from django.views.decorators.csrf import csrf_exempt
from authen.models import Order
from django.contrib import messages

@never_cache
def home(request):
   return render(request,"home.html")
@never_cache   
def profile(request):
    return render(request,'account.html')

@never_cache
def orders(request):
   user=request.user
   orders=Order.objects.filter(user=user)
   products=[]
   for order in orders: 
      for id in list(order.data.keys()):
          product=Produit.objects.get(pk=int(id))
          qte=order.data[id]["qte"]
          order_time=order.time
          total=qte*(product.prix)
          products.append({"product":product,"qte":qte,"order_time": order_time,"total":total})
   products.reverse()
   return render(request,'orders.html',{'products':products})

@never_cache
@csrf_exempt
@login_required
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
@csrf_exempt
def cartTab(request):
    cart=Cart(request)
    amount=cart.tot_al()["total"]
    item_names=cart.get_names()
    product_ids=list(cart.get_prod().keys())
    print(request.session["session_key"])
    user_id=request.user.id
    paypal_dict = {
        "business": PAYPAL_RECEIVER_EMAIL,
        "amount": amount,
        "item_name": item_names,
        "invoice": "unique-invoice-id",
        "notify_url": request.build_absolute_uri(reverse('paypal-ipn')),
        "return": request.build_absolute_uri(reverse('payment:return-view')),
        "cancel_return": request.build_absolute_uri(reverse('payment:cancel-view')),
        "custom":f"{user_id},{','.join(product_ids)}",  # Custom command to correlate to some function later (optional)
    }
    print("myapp view")
    # Create the instance.
    form = CustomPayPalPaymentsForm(initial=paypal_dict)
    if request.GET.get('action')=='update_paypal':
       return JsonResponse({
        'form_html':form.render()
        })
    else:
      context = {"form": form}
      return render(request,'cartTab.html',context)

from django.contrib.auth.decorators import user_passes_test
from django.core.exceptions import PermissionDenied

def superuser_required(view_func):
    """
    Decorator for views that checks if the user is a superuser.
    """
    def check_superuser(user):
        if not user.is_superuser:
            raise PermissionDenied
        return True

    return user_passes_test(check_superuser)(view_func)

@superuser_required
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
        print("before printing")
        cart.add(product=product)
        print(len(cart))
        print("after printing")
        response=JsonResponse({'length': len(cart),
                              'last_product': cart.get_last_prod(),
                                                           })
        return response
    

    
def update(request):
    cart=Cart(request)
    
    if request.POST.get('action')=='update':
        product_id=int(request.POST.get('product_id'))
        qte=int(request.POST.get('qte'))
        cart.update(product_id,qte)
        total=cart.tot_al()
        price=Produit.objects.get(pk=product_id).prix
        quantity=cart.__len__
        return JsonResponse({"qte":quantity,
                             "price":price,
                             'total':total['total'],
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
        messages.success(request, 'Your shipping details have been saved')
    
    else:
        messages.error(request, 'Something went wrong while processing your shipping')
    return redirect("myapp:cartTab")
               
def get_ship(user):
    try:
        return user.shipping_address.pk
    except Shipping.DoesNotExist:
        return None
    
def clothes_category(request):
   if request.method=="GET":
     type=request.GET.get("type")
     products=Produit.objects.filter(category=type)
     num = products.count()
     return render(request,"clothes_category.html",{"category":type,"number":num,"products":products})
     