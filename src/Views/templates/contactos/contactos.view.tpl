<section class="contactenos">
  <div class="tituloo">
    <h2>Contáctenos</h2>
  </div>
  <div class="caja">
    <div class="contacto form">
      <h3>Envía un Mensaje</h3>
      <form action="index.php?page=Contactos_Contactos" method="post" id="contactForm">
        <div class="cajaform">
          <div class="row50">
            <div class="cajainput">
              <span>Nombre</span>
              <input type="text" name="txtNombre" id="txtNombre" placeholder="Andres" />
            </div>
            <div class="cajainput">
              <span>Apellido</span>
              <input type="text" name="txtApellido" id="txtApellido" placeholder="Castro" />
            </div>
          </div>
          <div class="row50">
            <div class="cajainput">
              <span>Correo</span>
              <input type="email" name="txtCorreo" id="txtCorreo" placeholder="ejemplo@email.com" />
            </div>
            <div class="cajainput">
              <span>Teléfono</span>
              <input type="tel" name="txtTelefono" id="txtTelefono" placeholder="9694-8564" />
            </div>
          </div>
          <div class="row100">
            <div class="cajainput">
              <span>Mensaje</span>
              <textarea name="txtMen" id="txtMen" placeholder="Escribe tu mensaje aquí..."></textarea>
            </div>
          </div>
          <div class="row100">
            <div class="cajainput">
              <button type="button" id="btnProcesar">Enviar</button>
            </div>
          </div>
        </div>
      </form>
    </div>

    <div class="contacto info" style="background-color: #cce3f0;">
      <h3>Info de Contacto</h3>
      <div class="cajainfo">
        <div>
          <span><ion-icon name="location"></ion-icon></span>
          <p>Taulabé, Comayagua <br />HONDURAS</p>
        </div>
        <div>
          <span><ion-icon name="mail"></ion-icon></span>
          <a href="mailto:fmfran7777@gmail.com">fmfran7777@gmail.com</a>
        </div>
        &nbsp
        <div>
          <span><ion-icon name="call"></ion-icon></span>
          <a href="tel:+50496940930">+504 9694-0930</a>
        </div>

        <ul class="sci">
          <li><a href="#"><ion-icon name="logo-instagram"></ion-icon></a></li>
          <li><a href="#"><ion-icon name="logo-linkedin"></ion-icon></a></li>
          <li><a href="#"><ion-icon name="logo-twitter"></ion-icon></a></li>
          <li><a href="#"><ion-icon name="logo-facebook"></ion-icon></a></li>
        </ul>
      </div>
    </div>

    <div class="map">
      <iframe 
        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3859.3344019714295!2d-87.9701093596203!3d14.693671685862853!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x8f65c7022b4b15f7%3A0x13944ff6de5370b8!2sTaulab%C3%A9%2C%20Comayagua!5e0!3m2!1sen!2shn!4v1753660913549!5m2!1sen!2shn" 
        width="100%"  
        height="100%" 
        style="border:0;" 
        allowfullscreen="" 
        loading="lazy" 
        referrerpolicy="no-referrer-when-downgrade">
      </iframe>
    </div>
  </div>

  <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
  <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>

  <script>
    document.addEventListener("DOMContentLoaded", () => {
        formValidatorInit();
    });

    function formValidatorInit() {
        const txtNombre = document.getElementById("txtNombre");
        const txtApellido = document.getElementById("txtApellido");
        const txtCorreo = document.getElementById("txtCorreo");
        const txtTelefono = document.getElementById("txtTelefono");
        const txtMen = document.getElementById("txtMen");

        const btnProcesar = document.getElementById("btnProcesar");
        const contactForm = document.getElementById("contactForm");

        const isEmpty = /^\s*$/gm;
        const isValidEmail = /^((?!\.)[\w\-_.]*[^.])(@\w+)(\.\w+(\.\w+)?[^.\W])$/gm;
        const isValidHonduranCelPhone = /^\+?\(?(504)?\)?\s?[389]\d{3}[\-\s]?\d{4}$/gm;

        btnProcesar.addEventListener("click", (e) => {
            e.preventDefault();
            e.stopPropagation();

            let hasErrors = false;

            if (isEmpty.test(txtNombre.value)) {
                alert("Error: El Nombre no es válido");
                hasErrors = true;
            }

            if (isEmpty.test(txtApellido.value)) {
                alert("Error: El Apellido no es válido");
                hasErrors = true;
            }

            if (!isValidEmail.test(txtCorreo.value)) {
                alert("Error: El Correo no es válido");
                hasErrors = true;
            }

            if (!isValidHonduranCelPhone.test(txtTelefono.value)) {
                alert("Error: Escribe un Teléfono hondureño válido");
                hasErrors = true;
            }

            if (isEmpty.test(txtMen.value)) {
                alert("Error: Escribe un mensaje para enviar");
                hasErrors = true;
            }

            if (!hasErrors) {
                contactForm.submit();
            }
        });
    }
  </script>
</section>