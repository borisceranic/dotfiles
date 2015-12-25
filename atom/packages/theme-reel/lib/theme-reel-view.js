function ThemeReelView() {
  this.element = document.createElement('div');
  this.element.classList.add('inline-block', 'theme-reel');
  this.element.textContent = '';
  this.element.style.display = 'none';
}

ThemeReelView.prototype.initialize = function () {};
ThemeReelView.prototype.serialize = function () {};

ThemeReelView.prototype.destroy = function () {
  return this.element.remove();
};

ThemeReelView.prototype.setTheme = function (newTheme, newThemeIndex, totalThemes) {
  this.theme = newTheme;

  var themeNumber = newThemeIndex + 1;
  this.element.textContent = newTheme + ' (' + themeNumber + '/' + totalThemes + ')';
  this.element.style.display = '';

  setTimeout(function () {
    if (this.theme === newTheme) {
      this.element.textContent = '';
      this.element.style.display = 'none';
    }
  }.bind(this), 2000);
};

module.exports = ThemeReelView;
