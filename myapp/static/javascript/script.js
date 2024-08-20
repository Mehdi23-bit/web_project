
/*let icon_cart=document.querySelector('.icon-cart')


let cartTab=document.querySelector('.cartTab')


let close_btn=document.querySelector('.close')


let addtocards=document.querySelectorAll('.addtocard')

let account=document.querySelector('.account_icon')

let container=document.querySelector('.container')


icon_cart.addEventListener('click',()=>{
cartTab.classList.toggle('showTab')
})

close_btn.addEventListener('click',()=>{
    cartTab.classList.remove('showTab')
})

let spans=[]

/*addtocards.forEach(addtocard=>{
    addtocard.addEventListener('click', (event) => {
    let parent = event.target.parentElement;
    let children = parent.children;
    let icon_quantity=document.querySelector('.icon-cart span')
    const list = document.querySelector('.list');

    const item = document.createElement('div');
    const image = document.createElement('div');
    const name = document.createElement('div');
    const price = document.createElement('div');
    const quantity = document.createElement('div');

    item.className = 'item';
    image.className = 'image';
    name.className = 'name';
    price.className = 'price';
    quantity.className = 'quantity';

    const clonedImage = children[0].cloneNode(true);
    const clonedName = children[1].innerText;
    const clonedPrice = children[2].innerText;

    name.textContent = clonedName;
    price.textContent = clonedPrice;
    quantity.innerHTML="<span><</span><span>1</span><span>></span>"
    image.appendChild(clonedImage);
    item.append(image, name, price,quantity);
    list.appendChild(item);
    icon_quantity.textContent=Number(icon_quantity.textContent)+1
    addSpanEventListeners();
})});


function addSpanEventListeners() {
    const spans = document.querySelectorAll('.quantity span');
    spans.forEach(span=>{
        span.removeEventListener('click',add_min)
    })
    spans.forEach(span => {
        span.addEventListener('click',add_min);
    })
}

function   add_min(event){
        let target = event.target;
        let parent = target.parentElement;
        let list=document.querySelector('.list');
        let item=parent.parentElement
        let icon_quantity=document.querySelector('.icon-cart span')
        let quant = parent.children[1];
        let temp=Number(quant.textContent)
        console.log(quant.textContent); 
        if(target.textContent=='<'){ 
            temp--;
            quant.textContent=temp
        }
        else if(target.textContent=='>'){
            temp++;
            quant.textContent=temp
        }
        if(temp==0){
            list.removeChild(item)
            icon_quantity.textContent=Number(icon_quantity.textContent)-1
        }
    }
    let home=document.querySelector('.home');
    let account_div=document.querySelector('.account');
    let orders=document.querySelector(".span1");
    let account_info_span=document.querySelector(".span2");
    let order_history=document.querySelector(".order_history")
    let account_update=document.querySelector(".account_update")

    orders.addEventListener('click',()=>{
        if(!account_update.classList.contains('hidden_container')){
            account_update.classList.add('hidden_container')
        }
        if(order_history.classList.contains('hidden_container')){
            order_history.classList.remove('hidden_container')
        }
    })
    account_info_span.addEventListener('click',()=>{
        if(account_update.classList.contains('hidden_container')){
            account_update.classList.remove('hidden_container')
        }
        if(!order_history.classList.contains('hidden_container')){
            order_history.classList.add('hidden_container')
        }
    })


    account.addEventListener('click',()=>{
        if(!container.classList.contains('hidden_container')){
            container.classList.add('hidden_container')
        }
        if(account_div.classList.contains('hidden_container')){
            account_div.classList.remove('hidden_container')
            account_div.classList.add('show')
        }
        
    })
    home.addEventListener('click',()=>{

        if(!account_div.classList.contains('hidden_container')){
            account_div.classList.add('hidden_container')
            account_div.classList.remove('show')
        }

        if(container.classList.contains('hidden_container')){
            container.classList.remove('hidden_container')
        }
    })

    let account_list = Array.from(document.querySelector(".account .content").children);

account_list.forEach((item) => {
    item.addEventListener("click", () => {
        account_list.forEach(i => {
            i.classList.remove('border');
            i.classList.remove('active');
        });
        item.classList.add('border');
        
        // Delay adding the 'active' class to trigger the animation
        setTimeout(() => {
            item.classList.add('active');
        }, 10);
    });
});*/