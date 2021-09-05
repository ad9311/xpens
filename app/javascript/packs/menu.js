function* toggle(menu) {
  while (true) {
    menu.classList += ' menu-show';
    yield 1
    menu.classList = 'menu';
    yield 0
  }
}

const close = (menu, toggle) => {
  toggle.next();
  menu.classList = 'menu';
}

const menu = document.getElementById('menu');
const ham = document.getElementById('ham');
const gen = toggle(menu);

ham.addEventListener('click', () => gen.next());
