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
                    {{if ~product_INS}}
                    <a href="index.php?page=Productos_ProductosForm&mode=INS">Nuevo</a>
                    {{endif ~product_INS}}
                </th>
            </tr>
        </thead>
        <tbody>
            {{foreach productos}}
            <tr>
                <td class="center">
                    <img src="{{productImgUrl}}" alt="imagen" style="width: 64px; height: 64px; object-fit: cover;">
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
    {{pagination}}
</section>