<section class="container-m row px-4 py-4">
    <h1>{{FormTitle}}</h1>
</section>

<section class="container-m row px-4 py-4">
    {{with txn}}
    <form class="col-12 col-m-8 offset-m-2">
        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="orderid">Orden</label>
            <input class="col-12 col-m-9" type="text" id="orderid" readonly value="{{orderid}}" />
        </div>

        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="transdate">Fecha</label>
            <input class="col-12 col-m-9" type="text" id="transdate" readonly value="{{transdate}}" />
        </div>

        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="transstatus">Estado</label>
            <input class="col-12 col-m-9" type="text" id="transstatus" readonly value="{{transstatus}}" />
        </div>

        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="amount">Total</label>
            <input class="col-12 col-m-9" type="text" id="amount" readonly value="{{amount}}" />
        </div>

        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="currency">Moneda</label>
            <input class="col-12 col-m-9" type="text" id="currency" readonly value="{{currency}}" />
        </div>

        <div class="row my-4">
            <div class="col-12">
                <h2>Productos comprados</h2>
            </div>
            <div class="col-12">
                <table class="tabla-productos">
                    <thead>
                        <tr>
                            <th>Producto</th>
                            <th class="center">Cantidad</th>
                            <th class="right">Subtotal</th>
                            <th class="right">Comisión PayPal</th>
                            <th class="right">Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        {{if items}}
                        {{foreach items}}
                        <tr>
                            <td>{{productName}}</td>
                            <td class="center">{{quantity}}</td>

                            <!-- Subtotal = neto (lo que te queda) -->
                            <td class="right">{{lineNetDisplay}}</td>

                            <!-- Comisión PayPal -->
                            <td class="right">{{lineFeeDisplay}}</td>

                            <!-- Total = bruto (neto + comisión) -->
                            <td class="right"><strong>{{lineGrossDisplay}}</strong></td>
                        </tr>
                        {{endfor items}}
                        {{with totals}}
                        <tr class="total-row">
                            <td colspan="2" class="right"><strong>Totales generales</strong></td>
                            <td class="right">{{netDisplay}}</td>
                            <td class="right">{{feeDisplay}}</td>
                            <td class="right">{{grossDisplay}}</td>
                        </tr>
                        {{endwith totals}}
                        {{endif items}}

                        {{ifnot items}}
                        <tr>
                            <td colspan="5" class="center">No hay productos registrados para esta transacción.</td>
                        </tr>
                        {{endifnot items}}
                    </tbody>
                </table>
            </div>
        </div>
    </form>
    {{endwith txn}}
</section>

<section class="container-m row px-4 py-4">
    <div class="col-12 col-m-8 offset-m-2 align-end">
        <button class="col-12 col-m-2" type="button" id="btnCancelar">Regresar</button>
    </div>
</section>

<script>
    document.addEventListener("DOMContentLoaded", () => {
        const btnCancelar = document.getElementById("btnCancelar");
        btnCancelar.addEventListener("click", (e) => {
            e.preventDefault();
            e.stopPropagation();
            window.location.assign("index.php?page=Checkout_History");
        });
    });
</script>

<style>
    .tabla-productos {
        width: 100%;
        border-collapse: collapse;
        margin-top: 10px;
    }

    .tabla-productos th,
    .tabla-productos td {
        border: 1px solid #ccc;
        padding: 8px 10px;
    }

    .tabla-productos th {
        background-color: #f4f4f4;
        text-align: center;
    }

    .tabla-productos .center {
        text-align: center;
    }

    .tabla-productos .right {
        text-align: center;
    }

    .total-row {
        background-color: #f9f9f9;
        font-weight: bold;
    }
</style>