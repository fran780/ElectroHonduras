<section class="faq">
  <h1 class="center">Preguntas Frecuentes</h1>
  <div class="acordeon">
    <div class="acordeon-item">
      <button class="acordeon-encabezado" type="button">
        ¿Cómo puedo crear una cuenta?
        <span class="flecha"></span>
      </button>
      <div class="acordeon-contenido">
        <p>Seleccione la opción "Crear Cuenta" en el menú y complete el formulario con sus datos.</p>
      </div>
    </div>
    <div class="acordeon-item">
      <button class="acordeon-encabezado" type="button">
        ¿Cuál es la política de devoluciones?
        <span class="flecha"></span>
      </button>
      <div class="acordeon-contenido">
        <p>Puede devolver cualquier producto dentro de los 30 días posteriores a la compra.</p>
      </div>
    </div>
    <div class="acordeon-item">
      <button class="acordeon-encabezado" type="button">
        ¿Cómo contacto al soporte?
        <span class="flecha"></span>
      </button>
      <div class="acordeon-contenido">
        <p>Escríbanos a fmfran7777@gmail.com y con gusto le atenderemos.</p>
      </div>
    </div>

    <!-- Nuevas preguntas -->
    <div class="acordeon-item">
      <button class="acordeon-encabezado" type="button">
        ¿Todos los productos que venden son nuevos?
        <span class="flecha"></span>
      </button>
      <div class="acordeon-contenido">
        <p>Sí, todos nuestros productos son completamente nuevos, originales y cuentan con garantía.</p>
      </div>
    </div>
    <div class="acordeon-item">
      <button class="acordeon-encabezado" type="button">
        ¿Hacen envíos a todo Honduras?
        <span class="flecha"></span>
      </button>
      <div class="acordeon-contenido">
        <p>Sí, realizamos entregas seguras a cualquier parte de Honduras.</p>
      </div>
    </div>
    <div class="acordeon-item">
      <button class="acordeon-encabezado" type="button">
        ¿Cuánto tiempo tarda la entrega?
        <span class="flecha"></span>
      </button>
      <div class="acordeon-contenido">
        <p>El tiempo de entrega varía entre 2 y 5 días hábiles, dependiendo de la ubicación del cliente.</p>
      </div>
    </div>
    <div class="acordeon-item">
      <button class="acordeon-encabezado" type="button">
        ¿Qué métodos de pago aceptan?
        <span class="flecha"></span>
      </button>
      <div class="acordeon-contenido">
        <p>Actualmente aceptamos pagos únicamente a través de PayPal.</p>
      </div>
    </div>
  </div>
   <div class="acordeon-item">
      <button class="acordeon-encabezado" type="button">
        ¿Qué moneda utilizan?
        <span class="flecha"></span>
      </button>
      <div class="acordeon-contenido">
        <p>Utilizamos el dolar, por lo tanto todo los precios mostrados y los pagos que se realizan son en dolares</p>
      </div>
    </div>
  </div>
</section>

<script>
  document.addEventListener('DOMContentLoaded', () => {
    const encabezados = document.querySelectorAll('.acordeon-encabezado');
    encabezados.forEach(encabezado => {
      encabezado.addEventListener('click', () => {
        const item = encabezado.parentElement;
        item.classList.toggle('activo');
      });
    });
  });
</script>