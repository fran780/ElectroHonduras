<section class="container-l">
  <section class="depth-4">
    <h1>Checkout</h1>
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
    <div class="row border-b">
      <span class="col-1 center">{{row}}</span>
      <span class="col-4 center">{{productName}}</span>
      <span class="col-2 center">{{crrprc}}</span>
      <span class="col-3 center">{{crrctd}}</span>
      <span class="col-2 center">{{subtotal}}</span>
    </div>
    {{endfor carretilla}}

    <div class="row total-row">
      <span class="col-3 offset-7 center bold">Total</span>
      <span class="col-2 center bold">{{total}}</span>
    </div>

    <div class="checkout-actions">
      <form action="index.php?page=checkout_checkout" method="post" class="col-6">
        <button type="submit" name="cancelPurchase" class="btn-cancel">
          <i class="fas fa-times-circle"></i> Cancelar compra
        </button>
      </form>
      <form action="index.php?page=checkout_checkout" method="post" class="col-6 right">
        <button type="submit" class="btn-confirm">
          <i class="fas fa-check-circle"></i> Finalizar compra
        </button>
      </form>
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

  .bold {
    font-weight: bold;
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

  .col-1 { flex: 1; }
  .col-2 { flex: 2; }
  .col-3 { flex: 3; }
  .col-4 { flex: 4; }
  .col-6 { flex: 6; }
  .col-12 { flex: 12; }

  .offset-7 {
    margin-left: auto;
  }

  .center { text-align: center; }
  .right  { text-align: right; }

  .row:last-of-type span {
    font-size: 1.2rem;
    font-weight: bold;
  }

  .btn-cancel,
  .btn-confirm {
    width: 100%;
    color: white;
    padding: 8px 14px;
    font-size: 0.95em;
    font-weight: 500;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    transition: background-color 0.3s ease;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 0.5rem;
  }

  .btn-cancel {
    background-color: #6c757d;
  }

  .btn-cancel:hover {
    background-color: #5a6268;
  }

  .btn-confirm {
    background-color: #28a745;
  }

  .btn-confirm:hover {
    background-color: #218838;
  }

  .checkout-actions {
    display: flex;
    justify-content: space-between;
    gap: 1rem;
    margin-top: 1.5rem;
    background: none;
    padding: 0;
  }

  /* RESPONSIVE */

  /* 1024: ligeros ajustes de padding y título */
  @media (max-width: 1024px) {
    .container-l {
      padding: 1.25rem;
    }

    .depth-4 h1 {
      font-size: 1.8rem;
    }
  }

  /* 768 y abajo: tabla con scroll horizontal y botones centrados */
  @media (max-width: 768px) {
    .container-l {
      padding: 1rem 0.5rem;
    }

    /* scroll horizontal para toda la tabla */
    .grid {
      overflow-x: auto;
    }

    .row {
      min-width: 600px;
    }

    /* acciones de checkout: una debajo de otra, full width */
    .checkout-actions {
      flex-direction: column;
      align-items: stretch;
    }

    .checkout-actions form {
      width: 100%;
    }

    .btn-cancel,
    .btn-confirm {
      width: 100%;
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
  }
</style>