<section class="container-m row px-4 py-4">
  <h1>{{FormTitle}}</h1>
</section>

<section class="container-m row px-4 py-4">
  {{with usuario}}
  <form action="index.php?page=Usuarios_Usuario&mode={{~mode}}&usercod={{usercod}}" method="POST"
    class="col-12 col-m-8 offset-m-2">

    <div class="row my-2 align-center">
      <label class="col-12 col-m-3" for="usercodD">Código</label>
      <input class="col-12 col-m-9" readonly disabled type="text" name="usercodD" id="usercodD" placeholder="Código"
        value="{{usercod}}" />
      <input type="hidden" name="mode" value="{{~mode}}" />
      <input type="hidden" name="usercod" value="{{usercod}}" />
      <input type="hidden" name="usuario_xss_token" value="{{~usuario_xss_token}}" />
    </div>

    <div class="row my-2 align-center">
      <label class="col-12 col-m-3" for="username">Nombre</label>
      <input class="col-12 col-m-9" {{~readonly}} type="text" name="username" id="username"
        placeholder="Nombre del Usuario" value="{{username}}" />
      {{if username_error}}
      <div class="col-12 col-m-9 offset-m-3 error">{{username_error}}</div>
      {{endif username_error}}
    </div>

    <div class="row my-2 align-center">
      <label class="col-12 col-m-3" for="useremail">Correo</label>
      <input class="col-12 col-m-9" {{~readonly}} type="email" name="useremail" id="useremail"
        placeholder="Correo del Usuario" value="{{useremail}}" />
      {{if useremail_error}}
      <div class="col-12 col-m-9 offset-m-3 error">{{useremail_error}}</div>
      {{endif useremail_error}}
    </div>

    <div class="row my-2 align-center">
      <label class="col-12 col-m-3" for="userest">Estado</label>
      <select name="userest" id="userest" class="col-12 col-m-9" {{if ~readonly}} readonly disabled {{endif ~readonly}}
        {{~userestDisabledAttr}}>
        <option value="ACT" {{userest_act}}>Activo</option>
        <option value="INA" {{userest_ina}}>Inactivo</option>
      </select>
      {{if userest_error}}
      <div class="col-12 col-m-9 offset-m-3 error">{{userest_error}}</div>
      {{endif userest_error}}
    </div>

    <div class="row my-2 align-start">
      <label class="col-12 col-m-3" for="rolesList">Roles</label>
      <div class="col-12 col-m-9" id="rolesList">
        <div class="row">
          {{ifnot ~hasRoles}}
          <div class="col-12">No hay roles disponibles</div>
          {{endifnot ~hasRoles}}
          {{foreach ~roles}}
          <label class="col-12 col-m-6 my-1 role-option">
            <input type="checkbox" name="roles[]" value="{{rolescod}}" {{checked}} {{rolesDisabledAttr}} />
            <span>{{rolesdsc}}</span>
          </label>
          {{endfor ~roles}}
        </div>
        {{if ~roles_error}}
        <div class="col-12 col-m-9 offset-m-3 error">{{~roles_error}}</div>
        {{endif ~roles_error}}
      </div>
    </div>

    {{endwith usuario}}

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
      window.location.assign("index.php?page=Usuarios_Usuarios");
    });
  });
</script>

<style>
  /* SOLO TABLET */
  @media (min-width: 600px) and (max-width: 1199px) {

    /* En tablet queremos que los botones estén en fila */
    .form-actions {
      display: flex;
      flex-direction: row;
      justify-content: flex-end;
      align-items: center;
      gap: 0.5rem;
    }

    .form-actions button {
      width: auto;
      max-width: none;
      padding: 0.7rem 1rem;
      white-space: nowrap;
    }
  }
</style>