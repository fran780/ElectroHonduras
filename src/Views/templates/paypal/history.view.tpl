<h1>Historial de Compras</h1>

<section class="grid">
    <div class="row">
        <form class="col-12 col-m-8" action="index.php" method="get">
            <div class="flex align-center">
                <div class="col-8 row">
                    <input type="hidden" name="page" value="Checkout_History">

                    <label class="col-3" for="orderid">Orden</label>
                    <input class="col-9" type="text" name="orderid" id="orderid" value="{{orderid}}" />

                    <label class="col-3" for="status">Estado</label>
                    <select class="col-9" name="status" id="status">
                        <option value="ALL" {{status_ALL}}>Todos</option>
                        <option value="COMPLETED" {{status_COMPLETED}}>Completado</option>
                        <option value="PENDING" {{status_PENDING}}>Pendiente</option>
                        <option value="FAILED" {{status_FAILED}}>Fallido</option>
                    </select>
                </div>
                <div class="col-4 align-end">
                    <button type="submit">Filtrar</button>
                </div>
            </div>
        </form>
    </div>
</section>

<section class="WWList">
    <table>
        <thead>
            <tr>
                <th>Orden</th>
                <th>Fecha</th>
                <th>Estado</th>
                <th>Productos</th>
                <th class="center">Total</th>
                <th class="center">Moneda</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            {{foreach transactions}}
            <tr>
                <td class="center">{{orderid}}</td>
                <td class="center">{{transdate}}</td>
                <td class="center">
                    <span class="{{statusClass}}">{{transstatus}}</span>
                </td>
                <td class="center">{{productsSummary}}</td>
                <td class="center">{{amount}}</td>
                <td class="center">{{currency}}</td>
                <td class="center">
                    <a href="index.php?page=Checkout_HistoryDetail&id={{transactionId}}">Ver</a>
                </td>
            </tr>
            {{endfor transactions}}
        </tbody>
    </table>
    {{pagination}}
</section>

<style>
/*  Celular  */
@media (max-width: 768px) {

  /* Un poco de padding lateral */
  .grid,
  .WWList {
    padding: 0 0.75rem;
  }

  /* FORMULARIO DE FILTROS */
  .grid .row form {
    width: 100%;
  }

  /* Contenedor principal en columna */
  .grid .row form .flex {
    flex-direction: column;
    align-items: stretch;
    gap: 0.75rem;
  }

  /* Bloques de campos a 100% */
  .grid .row form .col-8,
  .grid .row form .col-4 {
    flex: 0 0 100%;
    max-width: 100%;
  }

  .grid .row form .col-8.row {
    display: flex;
    flex-direction: column;
    gap: 0.6rem;
    width: 100%;
  }

  /* Labels y campos en columna, ancho completo */
  .grid .row form .col-8.row label,
  .grid .row form .col-8.row input,
  .grid .row form .col-8.row select {
    width: 100%;
    max-width: 100%;
    display: block;
  }

  .grid .row form .col-8.row label {
    margin-bottom: 0.15rem;
    font-weight: 600;
  }

  /* Botón Filtrar full width */
  .grid .row form .col-4.align-end {
    width: 100%;
    justify-content: flex-start;
  }

  .grid .row form .col-4.align-end button,
  .grid .row form button[type="submit"] {
    width: 100% !important;
    display: block;
    box-sizing: border-box;
    text-align: center;
  }

  /* TABLA CON SCROLL */
  .WWList {
    overflow-x: auto;
    -webkit-overflow-scrolling: touch;
  }

  .WWList table {
    min-width: 700px;
  }
}

/* 320px */
@media (max-width: 320px) {
  .grid,
  .WWList {
    padding: 0 0.5rem;
  }

  .grid .row form .col-4.align-end button,
  .grid .row form button[type="submit"] {
    font-size: 0.9rem;
    padding: 0.45rem 0.4rem;
  }

  .WWList table {
    min-width: 640px;
  }
}
</style>