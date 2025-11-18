<section class="container-l">
  <section class="depth-4">
    <h1>Carretilla de Compras</h1>
  </section>

  <section class="grid">

    <div class="row border-b header-row">
      <span class="col-1 center bold">#</span>
      <span class="col-4 center bold">Item</span>
      <span class="col-2 center bold">Precio</span>
      <span class="col-3 center bold">Cantidad</span>
      <span class="col-2 center bold">Subtotal</span>
    </div>

    {{foreach carretilla}}
    <div class="row border-b cart-row">
      <span class="col-1 center" data-label="#">{{row}}</span>
      <span class="col-4 center" data-label="Item">{{productName}}</span>
      <span class="col-2 center" data-label="Precio">{{crrprc}}</span>

      <span class="col-3 center" data-label="Cantidad">
        <form action="index.php?page=Carretilla_Carretilla" method="post">
          <div class="quantity-controls">
            <input type="hidden" name="productId" value="{{productId}}" />
            <button type="submit" name="removeOne" class="circle">−</button>
            <span class="quantity-value">{{crrctd}}</span>
            <button type="submit" name="addOne" class="circle">+</button>
          </div>
        </form>
      </span>

      <span class="col-2 center" data-label="Subtotal">{{subtotal}}</span>
    </div>
    {{endfor carretilla}}

    <div class="row total-row">
      <span class="col-10 right bold">Total</span>
      <span class="col-2 center bold">{{total}}</span>
    </div>

    <div class="checkout-btn-container">
      <a href="{{botonUrl}}" class="checkout-btn">
        <i class="fas fa-{{botonIcono}}"></i>{{botonTexto}}
      </a>
    </div>
  </section>
</section>


<style>
  .container-l {
    max-width: 1000px;
    margin: 2rem auto;
    padding: 1.5rem;
    background-color: #ffffff;
    border-radius: 12px;
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.06);
  }

  .depth-4 h1 {
    font-size: 2rem;
    color: black;
    text-align: center;
    margin-bottom: 1.5rem;
  }

  .grid {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }

  .row {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    background-color: #f8f9fa;
    border-radius: 6px;
    padding: 0.8rem;
  }

  .row.border-b {
    border-bottom: 1px solid #dee2e6;
  }

  /* Columnas */
  .col-1 { flex: 1; }
  .col-2 { flex: 2; }
  .col-3 { flex: 3; }
  .col-4 { flex: 4; }
  .col-10 { flex: 10; }

  .center { text-align: center; }
  .right { text-align: right; }
  .bold { font-weight: bold; }

  .circle {
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 50%;
    width: 36px;
    height: 36px;
    font-size: 1.2rem;
    font-weight: bold;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    line-height: 1;
  }

  .circle:hover {
    background-color: #0056b3;
  }

  .quantity-controls {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.5rem;
  }

  .quantity-value {
    font-size: 1rem;
    font-weight: 500;
    min-width: 24px;
    text-align: center;
  }

  .checkout-btn-container {
    display: flex;
    justify-content: flex-end;
    margin-top: 1rem;
  }

  .checkout-btn {
    background-color: #28a745;
    color: white !important;
    padding: 10px 18px;
    font-size: 1em;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    transition: background-color 0.3s ease;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
  }

  .checkout-btn:hover {
    background-color: #218838;
  }

  /*  RESPONSIVE  */

  /* 1024: solo un poco menos de padding */
  @media (max-width: 1024px) {
    .container-l {
      padding: 1.25rem;
    }

    .depth-4 h1 {
      font-size: 1.8rem;
    }
  }

  /* 768 y abajo: misma tabla, pero con scroll horizontal */
  @media (max-width: 768px) {
    .container-l {
      padding: 1rem 0.5rem;
    }

    .grid {
      overflow-x: auto;
    }

    .row {
      min-width: 600px;
    }

    .checkout-btn-container {
      justify-content: center;
      margin-top: 0.75rem;
    }

    .checkout-btn {
      width: 100%;
      justify-content: center;
    }
  }

  /* 425 */
  @media (max-width: 425px) {
    .row {
      min-width: 580px;
      padding: 0.7rem;
    }

    .depth-4 h1 {
      font-size: 1.4rem;
    }
  }

  /* 375 */
  @media (max-width: 375px) {
    .row {
      min-width: 560px;
      padding: 0.65rem;
    }

    .depth-4 h1 {
      font-size: 1.3rem;
    }
  }

  /* 320 */
  @media (max-width: 320px) {
    .row {
      min-width: 540px;
      padding: 0.6rem;
    }

    .depth-4 h1 {
      font-size: 1.2rem;
    }

    .circle {
      width: 30px;
      height: 30px;
      font-size: 1rem;
    }
  }
</style>