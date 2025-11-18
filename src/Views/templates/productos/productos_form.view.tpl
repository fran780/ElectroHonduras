<section class="container-m row px-4 py-4">
    <h1>{{FormTitle}}</h1>
</section>

<section class="container-m row px-4 py-4">
    {{with producto}}
    <form action="index.php?page=Productos_ProductosForm&mode={{~mode}}&productId={{productId}}" method="POST"
        class="col-12 col-m-8 offset-m-2">

        <input type="hidden" name="producto_xss_token" value="{{~producto_xss_token}}">
        <input type="hidden" name="productId" value="{{productId}}">

        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="productName">Nombre</label>
            <input class="col-12 col-m-9" {{~readonly}} type="text" name="productName" id="productName"
                placeholder="Nombre del producto" value="{{productName}}" />
            {{if productName_error}}
            <div class="col-12 col-m-9 offset-m-3 error">{{productName_error}}</div>
            {{endif productName_error}}
        </div>

        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="productDescription">Descripción</label>
            <input class="col-12 col-m-9" {{~readonly}} type="text" name="productDescription" id="productDescription"
                placeholder="Descripción" value="{{productDescription}}" />
            {{if productDescription_error}}
            <div class="col-12 col-m-9 offset-m-3 error">{{productDescription_error}}</div>
            {{endif productDescription_error}}
        </div>

        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="productPrice">Precio</label>
            <input class="col-12 col-m-9" {{~readonly}} type="number" step="0.01" name="productPrice" id="productPrice"
                placeholder="Precio" value="{{productPrice}}" />
            {{if productPrice_error}}
            <div class="col-12 col-m-9 offset-m-3 error">{{productPrice_error}}</div>
            {{endif productPrice_error}}
        </div>

        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="productImgUrl">URL Imagen</label>
            <input class="col-12 col-m-9" {{~readonly}} type="text" name="productImgUrl" id="productImgUrl"
                placeholder="https://..." value="{{productImgUrl}}" />
        </div>

        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="productStock">Stock</label>
            <input class="col-12 col-m-9" {{~readonly}} type="number" name="productStock" id="productStock"
                placeholder="Cantidad disponible" value="{{productStock}}" />
            {{if productStock_error}}
            <div class="col-12 col-m-9 offset-m-3 error">{{productStock_error}}</div>
            {{endif productStock_error}}
        </div>

        <div class="row my-2 align-center">
            <label class="col-12 col-m-3" for="productStatus">Estado</label>
            <select name="productStatus" id="productStatus" class="col-12 col-m-9" {{if ~readonly}} disabled {{endif ~readonly}}>
                <option value="ACT" {{productStatus_act}}>Activo</option>
                <option value="INA" {{productStatus_ina}}>Inactivo</option>
            </select>
        </div>

        {{endwith producto}}

        <div class="row my-4 align-center flex-end form-actions">
            {{if showCommitBtn}}
            <button class="primary col-12 col-m-2" type="submit" name="btnConfirmar">Confirmar</button>
            &nbsp;
            {{endif showCommitBtn}}
            <button class="col-12 col-m-2" type="button" id="btnCancelar">
                {{if showCommitBtn}}Cancelar{{endif showCommitBtn}}
                {{ifnot showCommitBtn}}Regresar{{endifnot showCommitBtn}}
            </button>
        </div>
    </form>
</section>

<script>
    document.addEventListener("DOMContentLoaded", () => {
        const btnCancelar = document.getElementById("btnCancelar");
        btnCancelar.addEventListener("click", (e) => {
            e.preventDefault();
            e.stopPropagation();
            window.location.assign("index.php?page=Productos_ProductosList");
        });
    });
</script>

<style>
/*  TELÉFONO Y TABLET  */
@media (max-width: 1024px) {

  .container-m {
    padding: 0 0.75rem;
  }

  /* Labels e inputs a todo el ancho en celulares/tablet */
  form .row label,
  form .row input,
  form .row select {
    width: 100%;
    max-width: 100%;
  }

  /* Contenedor de botones */
  .form-actions {
    flex-direction: column;
    width: 100%;
    justify-content: center;
    align-items: center;
    gap: 0.75rem;
  }

  /* Botones: que crezcan en alto y no corten el texto */
  .form-actions button {
    width: 100%;
    max-width: 260px;            
    box-sizing: border-box;
    height: auto;                
    line-height: 1.2;            
    padding: 0.7rem 1rem;        
    white-space: nowrap;
  }
}
</style>
