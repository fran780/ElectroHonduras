<h1>Gestión de productos</h1>

<section class="grid">
    <div class="row">
        <form class="col-12 col-m-8" action="index.php" method="get">
            <div class="flex align-center">
                <div class="col-8 row">
                    <input type="hidden" name="page" value="Productos_ProductosList">

                    <label class="col-3" for="partialName">Nombre</label>
                    <input class="col-9" type="text" name="partialName" id="partialName" value="{{partialName}}" />

                    <label class="col-3" for="status">Estado</label>
                    <select class="col-9" name="status" id="status">
                        <option value="EMP" {{status_EMP}}>Todos</option>
                        <option value="ACT" {{status_ACT}}>Activo</option>
                        <option value="INA" {{status_INA}}>Inactivo</option>
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
                <th>Imagen</th>
                <th>ID</th>
                <th>Nombre</th>
                <th>Descripción</th>
                <th>Precio</th>
                <th>Stock</th>
                <th>Estado</th>

                <th>
                    Acciones

                    {{if ~product_INS}}
                    <!-- Botón de escritorio -->
                    <div class="nuevo-desktop-wrapper">
                        <button type="button" class="btn-nuevo-desktop"
                            onclick="window.location.href='index.php?page=Productos_ProductosForm&mode=INS'">
                            Nuevo
                        </button>
                    </div>
                    {{endif ~product_INS}}
                </th>
            </tr>
        </thead>

        <tbody>
            {{foreach productos}}
            <tr>
                <td class="center">
                    <img src="{{productImgUrl}}" alt="imagen"
                        style="width: 64px; height: 64px; object-fit: cover;">
                </td>
                <td class="center">{{productId}}</td>
                <td class="center">{{productName}}</td>
                <td class="center">{{productDescription}}</td>
                <td class="center">{{productPrice}}</td>
                <td class="center">{{productStock}}</td>
                <td class="center">{{productStatusDsc}}</td>
                <td class="center">
                    {{if ~product_DSP}}
                    <a href="index.php?page=Productos_ProductosForm&mode=DSP&productId={{productId}}">Ver</a>
                    {{endif ~product_DSP}}

                    {{if ~product_UPD}}
                    &nbsp;<a href="index.php?page=Productos_ProductosForm&mode=UPD&productId={{productId}}">Editar</a>
                    {{endif ~product_UPD}}

                    {{if ~product_DEL}}
                    &nbsp;<a href="index.php?page=Productos_ProductosForm&mode=DEL&productId={{productId}}">Eliminar</a>
                    {{endif ~product_DEL}}
                </td>
            </tr>
            {{endfor productos}}
        </tbody>
    </table>

    <!-- Botón Celular -->
    {{if ~product_INS}}
    <div class="nuevo-mobile">
        <button type="button"
            onclick="window.location.href='index.php?page=Productos_ProductosForm&mode=INS'">
            Nuevo
        </button>
    </div>
    {{endif ~product_INS}}

    {{pagination}}
</section>

<style>

/* NUEVO BOTÓN DE ESCRITORIO */
.nuevo-desktop-wrapper {
    position: relative;
    height: 0;
}

.btn-nuevo-desktop {
    position: absolute;
    top: -100px;
    left: 50%;
    transform: translateX(-50%);
}

/* Ocultar botón de escritorio en celular */
@media (max-width: 768px) {
    .btn-nuevo-desktop {
        display: none;
    }
}

/* BOTÓN CELULAR*/
.nuevo-mobile button {
    width: 100%
}

/* Ocultar en escritorio */
.nuevo-mobile {
    display: none;
}

/* RESPONSIVE */
@media (max-width: 768px) {
    .grid,
    .WWList {
        padding: 0 0.75rem;
    }

    .grid .row form .flex {
        flex-direction: column;
        gap: 0.75rem;
    }

    .grid .row form .col-8,
    .grid .row form .col-4 {
        max-width: 100%;
        flex: 100%;
    }

    .grid .row form .col-8.row {
        display: flex;
        flex-direction: column;
        gap: 0.6rem;
    }

    .grid .row form .col-4.align-end button {
        width: 100%;
    }

    .WWList {
        overflow-x: auto;
    }

    .WWList table {
        min-width: 700px;
    }

    /* Mostrar botón Celular */
    .nuevo-mobile {
        display: block;
        margin-top: 1rem;
    }
}

/* 320px */
@media (max-width: 320px) {
    .nuevo-mobile button {
        font-size: 0.9rem;
        padding: 0.65rem;
    }
}

</style>