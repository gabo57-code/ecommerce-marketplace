(function () {
    function $(id) { return document.getElementById(id); }

    var name = $('name'), price = $('price'), stock = $('stock'),
        desc = $('description'), image = $('image');
    var pvName = $('pvName'), pvPrice = $('pvPrice'), pvImg = $('pvImg'), pvLow = $('pvLow'),
        dzThumb = $('dzThumb'), dzTitle = $('dzTitle'), dzHint = $('dzHint'), dropzone = $('dropzone');

    // ---------- Vista previa en vivo ----------
    function updateName() {
        if (!name || !pvName) return;
        var t = name.value.trim();
        pvName.textContent = t || 'Título de tu producto';
        pvName.classList.toggle('is-empty', !t);
    }
    function updatePrice() {
        if (!price || !pvPrice) return;
        var v = parseFloat(price.value);
        pvPrice.textContent = isNaN(v) ? '0' : v.toLocaleString('es-CO', { maximumFractionDigits: 0 });
    }
    function updateStock() {
        if (!stock || !pvLow) return;
        var s = parseInt(stock.value, 10);
        if (!isNaN(s) && s > 0 && s <= 5) {
            pvLow.textContent = '¡Últimas ' + s + ' unidades!';
            pvLow.hidden = false;
        } else {
            pvLow.hidden = true;
        }
    }
    [[name, updateName], [price, updatePrice], [stock, updateStock]].forEach(function (p) {
        if (p[0]) {
            p[0].addEventListener('input', p[1]);
            p[1]();
        }
    });

    // ---------- Contadores de caracteres ----------
    function counter(input, countId, max) {
        var el = $(countId);
        if (!input || !el) return;
        function update() {
            var n = input.value.length;
            el.textContent = n;
            el.parentElement.classList.toggle('warn', n >= max * 0.9);
        }
        input.addEventListener('input', update);
        update();
    }
    counter(name, 'nameCount', 150);
    counter(desc, 'descCount', 2000);

    // ---------- Foto: vista previa, validación de tamaño y arrastrar ----------
    var MAX_BYTES = 5 * 1024 * 1024;
    var originalHint = dzHint ? dzHint.innerHTML : '';

    if (image) {
        image.addEventListener('change', function () {
            var file = image.files[0];
            if (!file) return;
            if (file.size > MAX_BYTES) {
                image.value = '';
                if (dzHint) {
                    dzHint.textContent = 'La imagen supera los 5 MB. Elige una más liviana.';
                    dzHint.classList.add('err');
                }
                return;
            }
            var url = URL.createObjectURL(file);
            if (dzThumb) dzThumb.src = url;
            if (pvImg) pvImg.src = url;
            if (dzTitle) dzTitle.textContent = file.name;
            if (dzHint) {
                dzHint.innerHTML = originalHint;
                dzHint.classList.remove('err');
            }
        });
    }
    if (dropzone) {
        ['dragenter', 'dragover'].forEach(function (ev) {
            dropzone.addEventListener(ev, function () { dropzone.classList.add('drag'); });
        });
        ['dragleave', 'drop'].forEach(function (ev) {
            dropzone.addEventListener(ev, function () { dropzone.classList.remove('drag'); });
        });
    }

    // ---------- Botón en estado "cargando" al enviar ----------
    document.querySelectorAll('form[data-loading]').forEach(function (form) {
        form.addEventListener('submit', function () {
            var b = form.querySelector('button[type=submit]');
            if (b) {
                b.dataset.original = b.textContent;
                b.classList.add('loading');
                b.style.pointerEvents = 'none';
                b.style.opacity = '.85';
                b.textContent = form.getAttribute('data-loading');
            }
        });
    });
    window.addEventListener('pageshow', function (e) {
        if (e.persisted) {
            document.querySelectorAll('button.loading').forEach(function (b) {
                b.classList.remove('loading');
                b.style.pointerEvents = '';
                b.style.opacity = '';
                if (b.dataset.original) { b.textContent = b.dataset.original; }
            });
        }
    });
})();