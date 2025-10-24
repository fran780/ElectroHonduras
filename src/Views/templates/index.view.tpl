<h1 style="text-align:center">ElectroHonduras</h1>
<div class="product-list">
  {{foreach products}}
  <div class="product" data-productId="{{productId}}">
    <img src="{{productImgUrl}}" alt="{{productName}}">
    <h2>{{productName}}</h2>
    <p>{{productDescription}}</p>
    <div style="text-align:center;">
      <span class="price"><i class="fa-solid fa-tag"></i> {{productPrice}}</span>
      <span class="stock"><i class="fa-solid fa-box"></i> {{productStock}} disponibles</span>
    </div>
    {{if ~SHOW_CART}}
    <form action="index.php?page=index" method="post">
      <input type="hidden" name="productId" value="{{productId}}">
      <button type="submit" name="addToCart" class="add-to-cart">
        <i class="fa-solid fa-cart-plus"></i> Agregar al carrito
      </button>
    </form>
    {{endif ~SHOW_CART}}
  </div>
  {{endfor products}}
</div>