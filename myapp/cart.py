from .models import Produit
from decimal import Decimal
from authen.models import Profile,Produit
from authen.save_session import *

class Cart:
    def __init__(self, request):
        self.session = request.session
        cart = self.session.get('session_key')
        self.user = request.user
        self.tax=Decimal('1.1')
        
        if not cart:
            # Initialize the cart if it doesn't exist in the session
            cart = self.session['session_key'] = {}
           

        self.cart = cart

    def add(self, product):
        product_id = str(product.id)
        
        if product_id in self.cart:
            # Increase the quantity if the product is already in the cart
            self.session.modified = False
        else:
            # Add the product to the cart with an initial quantity of 1
            self.cart[product_id] = {"qte": 1,"name":product.nom}
            
            session_key = self.session['session_key']
            save_persistent_data(self.user, session_key)
            self.session.modified = True

    def __len__(self):
        # Return the total number of unique products in the cart
        return len(self.cart)

    def get_prod(self):
        ids = list(self.cart.keys())
        products = {}
        
        # Retrieve all products with a single query for efficiency
        product_objects = Produit.objects.filter(pk__in=ids)
        
        for product in product_objects:
            product_id = str(product.id)
            qte = self.cart[product_id]["qte"]
            products[product_id] = {
                "name": product.nom,
                "img": product.image.url,
                "price": product.prix,
                "qte": qte,
                "id":product.id,
                "total":qte*product.prix
            }
        
        return products

    def get_last_prod(self):
        # Get the last product added to the cart
        last_product_id = list(self.cart.keys())[-1]
        productdb = Produit.objects.get(pk=last_product_id)
        qte = self.cart[str(last_product_id)]["qte"]
        product = {
            "name": productdb.nom,
            "img": productdb.image.url,
            "price": productdb.prix,
            "qte":qte
        }
        
        return product
    def update(self,product_id,qte):
        self.cart[str(product_id)]["qte"]=qte
        session_key = self.session['session_key']
        save_persistent_data(self.user, session_key)
        
        

    def delete(self,product_id):
      print("i am deleting1")
      del  self.cart[str(product_id)]
      print('i am deleting2')
      session_key = self.session['session_key']
      save_persistent_data(self.user, session_key)
      

    def tot_al(self):
        total=0
        for item in list( self.cart.keys()):
           total=total+(Produit.objects.get(pk=int(item)).prix)*(self.cart[item]["qte"])

        taxed_total=total*self.tax

        return {
            'total':total,
            'taxed_total':taxed_total
        }
    def get_names(self):
       names=[]
       for id in list(self.cart.keys()):
           names.append(self.cart[id]['name'])
       return names