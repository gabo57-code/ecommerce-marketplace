(function () {
    // 1) Palabra que va cambiando en el titular
    var rot = document.getElementById('rot');
    if (rot) {
        var words = rot.dataset.words
            ? rot.dataset.words.split(',')
            : ['comprar', 'vender', 'descubrir', 'ahorrar', 'emprender'];
        var i = 0;
        setInterval(function () {
            rot.classList.add('out');
            setTimeout(function () {
                i = (i + 1) % words.length;
                rot.textContent = words[i];
                rot.classList.remove('out');
            }, 350);
        }, 2400);
    }

    // 2) Parallax: los iconos se mueven suavemente con el mouse
    var floats = document.querySelectorAll('.fl');
    if (floats.length && window.matchMedia('(pointer: fine)').matches) {
        document.addEventListener('mousemove', function (e) {
            var cx = window.innerWidth / 2, cy = window.innerHeight / 2;
            var dx = (e.clientX - cx) / cx, dy = (e.clientY - cy) / cy;
            floats.forEach(function (el) {
                var d = parseFloat(el.getAttribute('data-depth')) || 20;
                el.style.setProperty('--px', (dx * d) + 'px');
                el.style.setProperty('--py', (dy * d) + 'px');
            });
        });
    }

    // 3) Notificaciones que aparecen una tras otra
    var toasts = document.querySelectorAll('.toast');
    if (toasts.length) {
        var t = 0;
        toasts[0].classList.add('show');
        setInterval(function () {
            toasts[t].classList.remove('show');
            t = (t + 1) % toasts.length;
            toasts[t].classList.add('show');
        }, 3200);
    }

    // 4) Mostrar / ocultar contraseña
    document.querySelectorAll('.toggle-pass').forEach(function (btn) {
        btn.addEventListener('click', function () {
            var input = btn.parentElement.querySelector('input');
            var show = input.type === 'password';
            input.type = show ? 'text' : 'password';
            btn.classList.toggle('on', show);
            btn.setAttribute('aria-label', show ? 'Ocultar contraseña' : 'Mostrar contraseña');
        });
    });

    // 5) Botón en estado "cargando" al enviar el formulario
    document.querySelectorAll('form[data-loading]').forEach(function (form) {
        form.addEventListener('submit', function () {
            var b = form.querySelector('button[type=submit]');
            if (b) {
                b.dataset.original = b.textContent;
                b.classList.add('loading');
                b.textContent = form.getAttribute('data-loading');
            }
        });
    });
    window.addEventListener('pageshow', function (e) {
        if (e.persisted) {
            document.querySelectorAll('button.loading').forEach(function (b) {
                b.classList.remove('loading');
                if (b.dataset.original) { b.textContent = b.dataset.original; }
            });
        }
    });
})();