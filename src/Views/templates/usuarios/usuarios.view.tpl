<h1>Gestión de Usuarios</h1>
<section class="grid">
    <div class="row">
        <form class="col-12 col-m-8" action="index.php" method="get">
            <div class="flex align-center">
                <div class="col-8 row">
                    <input type="hidden" name="page" value="Usuarios_Usuarios">

                    <label class="col-3" for="partialName">Nombre</label>
                    <input class="col-9" type="text" name="partialName" id="partialName" value="{{partialName}}" />

                    <label class="col-3" for="partialEmail">Correo</label>
                    <input class="col-9" type="text" name="partialEmail" id="partialEmail" value="{{partialEmail}}" />

                    <label class="col-3" for="status">Estado</label>
                    <select class="col-9" name="status" id="status">
                        <option value="ALL" {{status_ALL}}>Todos</option>
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
                <th>
                    Id
                    {{ifnot OrderByUsercod}}
                    <a href="index.php?page=Usuarios_Usuarios&orderBy=usercod&orderDescending=0"><i
                            class="fas fa-sort"></i></a>
                    {{endifnot OrderByUsercod}}
                    {{if OrderUsercodDesc}}
                    <a href="index.php?page=Usuarios_Usuarios&orderBy=clear&orderDescending=0"><i
                            class="fas fa-sort-down"></i></a>
                    {{endif OrderUsercodDesc}}
                    {{if OrderUsercod}}
                    <a href="index.php?page=Usuarios_Usuarios&orderBy=usercod&orderDescending=1"><i
                            class="fas fa-sort-up"></i></a>
                    {{endif OrderUsercod}}
                </th>

                <th class="left">
                    Nombre
                    {{ifnot OrderByUsername}}
                    <a href="index.php?page=Usuarios_Usuarios&orderBy=username&orderDescending=0"><i
                            class="fas fa-sort"></i></a>
                    {{endifnot OrderByUsername}}
                    {{if OrderUsernameDesc}}
                    <a href="index.php?page=Usuarios_Usuarios&orderBy=clear&orderDescending=0"><i
                            class="fas fa-sort-down"></i></a>
                    {{endif OrderUsernameDesc}}
                    {{if OrderUsername}}
                    <a href="index.php?page=Usuarios_Usuarios&orderBy=username&orderDescending=1"><i
                            class="fas fa-sort-up"></i></a>
                    {{endif OrderUsername}}
                </th>

                <th class="left">
                    Correo
                    {{ifnot OrderByUseremail}}
                    <a href="index.php?page=Usuarios_Usuarios&orderBy=useremail&orderDescending=0"><i
                            class="fas fa-sort"></i></a>
                    {{endifnot OrderByUseremail}}
                    {{if OrderUseremailDesc}}
                    <a href="index.php?page=Usuarios_Usuarios&orderBy=clear&orderDescending=0"><i
                            class="fas fa-sort-down"></i></a>
                    {{endif OrderUseremailDesc}}
                    {{if OrderUseremail}}
                    <a href="index.php?page=Usuarios_Usuarios&orderBy=useremail&orderDescending=1"><i
                            class="fas fa-sort-up"></i></a>
                    {{endif OrderUseremail}}
                </th>

                <th class="left">Roles</th>

                <th>Estado</th>
                <th>
                    Acciones
                    <!-- Botón NUEVO de escritorio: NO se toca -->
                    <div style="position:relative; height:0;">
                        <button type="button"
                            onclick="window.location.href='index.php?page=Usuarios_Usuario&mode=INS'"
                            style="position:absolute; top:-118px; left:50%; transform:translateX(-50%);">
                            Nuevo
                        </button>
                    </div>
                </th>
            </tr>
        </thead>
        <tbody>
            {{foreach usuarios}}
            <tr>
                <td class="center">{{usercod}}</td>
                <td class="center">{{username}}</td>
                <td class="center">{{useremail}}</td>
                <td class="center">{{rolesList}}</td>
                <td class="center">{{userestDsc}}</td>
                <td class="center">
                    <a href="index.php?page=Usuarios_Usuario&mode=DSP&usercod={{usercod}}">Ver</a>
                    &nbsp;
                    <a href="index.php?page=Usuarios_Usuario&mode=UPD&usercod={{usercod}}">Editar</a>
                    &nbsp;
                    {{if canDelete}}
                    <a href="index.php?page=Usuarios_Usuario&mode=DEL&usercod={{usercod}}">Eliminar</a>
                    {{endif canDelete}}
                    {{ifnot canDelete}}
                    <span class="action-disabled" title="No puede eliminar su propia cuenta">Eliminar</span>
                    {{endifnot canDelete}}
                </td>
            </tr>
            {{endfor usuarios}}
        </tbody>
    </table>

    <!-- Botón NUEVO solo para pantallas pequeñas -->
    <div class="nuevo-mobile">
        <button type="button"
            onclick="window.location.href='index.php?page=Usuarios_Usuario&mode=INS'">
            Nuevo
        </button>
    </div>

    {{pagination}}
</section>


<style>
/* Por defecto: ocultar botón Celular */
.nuevo-mobile {
  display: none;
}

/*  TABLET Y Celulares: FORM VERTICAL y TABLA SCROLL  */
@media (max-width: 768px) {

  /* Un poco de padding lateral */
  .grid,
  .WWList {
    padding: 0 0.75rem;
  }

  /*  FORMULARIO DE FILTROS  */
  .grid .row form {
    width: 100%;
  }

  /* Contenedor principal en columna */
  .grid .row form .flex {
    flex-direction: column;
    align-items: stretch;
    gap: 0.75rem;
  }

  /* Bloques de campos  a 100% */
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

  /* Labels y campos en columna, a todo el ancho */
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

  /*  TABLA CON SCROLL HORIZONTAL  */
  .WWList {
    overflow-x: auto;
    -webkit-overflow-scrolling: touch;
  }

  .WWList table {
    min-width: 700px;   
  }

  /*  BOTÓN NUEVO Celular  */
  .nuevo-mobile {
    display: block;
    margin-top: 1rem;
    width: 100%;
  }

  .nuevo-mobile button {
    width: 100%;
    display: block;
    box-sizing: border-box;
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

  .nuevo-mobile button {
    font-size: 0.95rem;
  }
}
</style>
