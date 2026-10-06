document.addEventListener('DOMContentLoaded', () => {
  // Confirmaciones antes de eliminar semanas o archivos.
  document.querySelectorAll('[data-confirm]').forEach(el => {
    el.addEventListener('click', e => {
      if (!confirm(el.dataset.confirm)) e.preventDefault();
    });
  });

  // Navegación interactiva del portafolio: cambia de sección sin abrir otra página.
  const views = Array.from(document.querySelectorAll('.page-view[data-page]'));
  const navButtons = Array.from(document.querySelectorAll('.nav-switch[data-view]'));
  const viewTriggers = Array.from(document.querySelectorAll('.view-trigger[data-view]'));
  const reduceMotion = window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches;


  // Corazones animados en el fondo del portafolio y del panel de control.
  // Son decorativos: no bloquean botones, formularios ni tarjetas.
  const createFloatingHearts = () => {
    const targets = [];

    const publicArea = document.querySelector('.spa-content');
    if (publicArea) {
      targets.push({ element: publicArea, count: 300 });
    }

    const adminArea = document.querySelector('.admin-shell');
    if (adminArea) {
      targets.push({ element: adminArea, count: 300 });
    }

    // Generador pseudoaleatorio estable para que la distribución no cambie
    // de forma brusca cada vez que se actualiza la interfaz.
    let seed = 24071998;
    const random = () => {
      seed = (seed * 9301 + 49297) % 233280;
      return seed / 233280;
    };

    targets.forEach(({ element, count }) => {
      if (element.querySelector(':scope > .floating-hearts')) return;

      const layer = document.createElement('div');
      layer.className = 'floating-hearts';
      layer.setAttribute('aria-hidden', 'true');

      for (let i = 0; i < count; i += 1) {
        const heart = document.createElement('span');
        heart.className = 'floating-heart';
        heart.textContent = '♡';

        const size = Math.round(14 + random() * 30);
        const opacity = (0.20 + random() * 0.10).toFixed(3);
        const duration = (12 + random() * 16).toFixed(1);
        const delay = (-random() * 18).toFixed(1);
        const rotate = Math.round(-18 + random() * 36);

        heart.style.setProperty('--heart-left', `${(2 + random() * 96).toFixed(1)}%`);
        heart.style.setProperty('--heart-top', `${(2 + random() * 96).toFixed(1)}%`);
        heart.style.setProperty('--heart-size', `${size}px`);
        heart.style.setProperty('--heart-opacity', opacity);
        heart.style.setProperty('--heart-duration', `${duration}s`);
        heart.style.setProperty('--heart-delay', `${delay}s`);
        heart.style.setProperty('--heart-rotate', `${rotate}deg`);

        layer.appendChild(heart);
      }

      element.insertBefore(layer, element.firstChild);
    });
  };

  createFloatingHearts();


  const showView = (name, moveTop = true) => {
    const target = views.find(view => view.dataset.page === name);
    if (!target) return;

    views.forEach(view => {
      const active = view === target;
      view.hidden = !active;
      view.classList.toggle('is-active', active);
    });

    navButtons.forEach(btn => {
      const active = btn.dataset.view === name;
      btn.classList.toggle('active', active);
      btn.setAttribute('aria-selected', String(active));
      if (active) btn.setAttribute('aria-current', 'page');
      else btn.removeAttribute('aria-current');
    });

    if (moveTop) {
      window.scrollTo({ top: 0, behavior: reduceMotion ? 'auto' : 'smooth' });
    }
  };

  navButtons.forEach(btn => btn.addEventListener('click', () => showView(btn.dataset.view)));
  viewTriggers.forEach(btn => btn.addEventListener('click', () => showView(btn.dataset.view)));

  // Login modal con el estilo de la referencia.
  const loginModal = document.querySelector('#loginModal');
  const openLoginButtons = document.querySelectorAll('.login-trigger');
  const closeLogin = document.querySelector('#closeLogin');

  const openLogin = () => {
    if (!loginModal) return;
    if (typeof loginModal.showModal === 'function') loginModal.showModal();
    else loginModal.setAttribute('open', '');
    const firstInput = loginModal.querySelector('input');
    if (firstInput) setTimeout(() => firstInput.focus(), 30);
  };

  const hideLogin = () => {
    if (!loginModal) return;
    if (typeof loginModal.close === 'function' && loginModal.open) loginModal.close();
    else loginModal.removeAttribute('open');
  };

  openLoginButtons.forEach(btn => btn.addEventListener('click', openLogin));
  if (closeLogin) closeLogin.addEventListener('click', hideLogin);
  if (loginModal) {
    loginModal.addEventListener('click', e => {
      if (e.target === loginModal) hideLogin();
    });
  }

  // Mostrar u ocultar contraseña.
  document.querySelectorAll('[data-password-toggle]').forEach(button => {
    button.addEventListener('click', () => {
      const input = document.getElementById(button.dataset.passwordToggle);
      if (!input) return;
      const showing = input.type === 'text';
      input.type = showing ? 'password' : 'text';
      button.textContent = showing ? '◉' : '◌';
      button.setAttribute('aria-label', showing ? 'Mostrar contraseña' : 'Ocultar contraseña');
      input.focus();
    });
  });

  // Los accesos sociales son demostrativos; informan sin abandonar el sitio.
  document.querySelectorAll('.social-demo').forEach(button => {
    button.addEventListener('click', () => {
      const card = button.closest('.login-card-v2');
      const message = card ? card.querySelector('[data-social-message], #socialMessage') : null;
      if (message) {
        message.textContent = `Acceso con ${button.dataset.provider} no está conectado. Usa noemi@gmail.com.`;
      }
    });
  });

  // Buscador del panel de control para filtrar semanas en tiempo real.
  const search = document.querySelector('#weekSearch');
  const weekCards = Array.from(document.querySelectorAll('[data-week-card]'));
  const result = document.querySelector('#searchResult');
  if (search && weekCards.length) {
    const filterWeeks = () => {
      const q = search.value.trim().toLowerCase();
      let visible = 0;
      weekCards.forEach(card => {
        const text = (card.dataset.search || card.textContent || '').toLowerCase();
        const show = !q || text.includes(q);
        card.hidden = !show;
        if (show) visible += 1;
      });
      if (result) result.textContent = `${visible} semana${visible === 1 ? '' : 's'}`;
    };
    search.addEventListener('input', filterWeeks);
  }

  // Menú lateral: resalta la opción seleccionada sin recargar para secciones internas.
  const sideLinks = Array.from(document.querySelectorAll('.side-link'));
  sideLinks.forEach(link => {
    const href = link.getAttribute('href') || '';
    if (href.startsWith('#')) {
      link.addEventListener('click', e => {
        const target = document.querySelector(href);
        if (!target) return;
        e.preventDefault();
        sideLinks.forEach(item => item.classList.remove('active'));
        link.classList.add('active');
        target.scrollIntoView({ behavior: reduceMotion ? 'auto' : 'smooth', block: 'start' });
      });
    }
  });


  // CORRECCIÓN: los modales de semanas se mueven directamente al <body>.
  // Así el cuadro queda por encima del menú superior y no se corta en la parte de arriba.
  const weekModalOverlays = Array.from(document.querySelectorAll('.week-upload-overlay'));
  weekModalOverlays.forEach(overlay => {
    if (overlay.parentElement !== document.body) {
      document.body.appendChild(overlay);
    }
  });

  // Tarjetas de semanas: al hacer clic, abre un cuadro emergente robusto.
  // Se usa un overlay <div> en lugar de <dialog> para evitar problemas de compatibilidad.
  const weekOpenCards = Array.from(document.querySelectorAll('[data-week-open]'));
  let activeWeekOverlay = null;
  let lastWeekTrigger = null;

  const openWeekDialog = (overlayId, trigger = null) => {
    const overlay = document.getElementById(overlayId);
    if (!overlay) return;

    if (activeWeekOverlay && activeWeekOverlay !== overlay) {
      activeWeekOverlay.hidden = true;
      activeWeekOverlay.classList.remove('is-open');
      activeWeekOverlay.setAttribute('aria-hidden', 'true');
    }

    lastWeekTrigger = trigger || document.activeElement;
    activeWeekOverlay = overlay;
    overlay.hidden = false;
    overlay.setAttribute('aria-hidden', 'false');

    // Fuerza una actualización de layout antes de aplicar la animación.
    void overlay.offsetWidth;
    overlay.classList.add('is-open');
    document.body.classList.add('week-modal-open');

    const focusTarget = overlay.querySelector('.ornate-dialog-close, input[type="file"], button, a');
    if (focusTarget) setTimeout(() => focusTarget.focus(), 20);
  };

  const closeWeekDialog = (overlay) => {
    if (!overlay) return;
    overlay.classList.remove('is-open');
    overlay.setAttribute('aria-hidden', 'true');
    document.body.classList.remove('week-modal-open');

    // Ocultar después de la pequeña animación de salida.
    setTimeout(() => {
      overlay.hidden = true;
    }, reduceMotion ? 0 : 130);

    activeWeekOverlay = null;
    if (lastWeekTrigger && typeof lastWeekTrigger.focus === 'function') {
      setTimeout(() => lastWeekTrigger.focus(), 0);
    }
  };

  weekOpenCards.forEach(card => {
    const open = () => openWeekDialog(card.dataset.weekOpen, card);

    card.addEventListener('click', e => {
      // La tarjeta completa abre la semana. Solo se excluyen enlaces o controles reales.
      if (e.target.closest('a,input,select,textarea,form')) return;
      open();
    });

    card.addEventListener('keydown', e => {
      if (e.key === 'Enter' || e.key === ' ') {
        e.preventDefault();
        open();
      }
    });
  });

  document.querySelectorAll('[data-week-open-button]').forEach(button => {
    button.addEventListener('click', e => {
      e.preventDefault();
      e.stopPropagation();
      openWeekDialog(button.dataset.weekOpenButton, button);
    });
  });

  document.querySelectorAll('.week-upload-overlay').forEach(overlay => {
    overlay.querySelectorAll('[data-week-close]').forEach(button => {
      button.addEventListener('click', () => closeWeekDialog(overlay));
    });

    // Solo se cierra cuando se hace clic en el fondo oscuro, no dentro del cuadro.
    overlay.addEventListener('click', e => {
      if (e.target === overlay) closeWeekDialog(overlay);
    });
  });

  document.addEventListener('keydown', e => {
    if (e.key === 'Escape' && activeWeekOverlay) {
      closeWeekDialog(activeWeekOverlay);
    }
  });

  // Muestra cuántos archivos se seleccionaron en cada control múltiple.
  document.querySelectorAll('input[type="file"][multiple]').forEach(input => {
    input.addEventListener('change', () => {
      const label = input.closest('label');
      if (!label) return;

      let status = label.querySelector('.file-selection-status');
      if (!status) {
        status = document.createElement('span');
        status.className = 'file-selection-status';
        label.appendChild(status);
      }

      const count = input.files ? input.files.length : 0;
      if (count === 0) {
        status.textContent = 'Ningún archivo seleccionado.';
      } else if (count === 1) {
        status.textContent = `1 archivo seleccionado: ${input.files[0].name}`;
      } else {
        status.textContent = `${count} archivos seleccionados. Se subirán todos juntos.`;
      }
    });
  });

  // Después de subir un archivo, vuelve directamente a la sección y semana utilizadas.
  const urlParams = new URLSearchParams(window.location.search);
  if (urlParams.get('view') === 'semanas') {
    showView('semanas', false);
  }
  const requestedWeek = urlParams.get('openWeek');
  if (requestedWeek && /^\d+$/.test(requestedWeek)) {
    showView('semanas', false);
    setTimeout(() => openWeekDialog(`weekModal-${requestedWeek}`), 80);
  }

});
