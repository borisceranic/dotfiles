var CompositeDisposable = require('atom').CompositeDisposable;
var ThemeReelView = require('./theme-reel-view');

module.exports = {
  themeReelView: null,
  statusBarTile: null,
  subscriptions: null,

  activate: function () {
    this.themeReelView = new ThemeReelView();

    var self = this;
    this.subscriptions = new CompositeDisposable();
    this.subscriptions.add(
       atom.commands.add('atom-workspace', {
          'theme-reel:next': function () {
             self.nextTheme.call(self);
          },
          'theme-reel:previous': function () {
             self.previousTheme.call(self);
          }
       })
    );

    var statusBar = document.querySelector('status-bar');
    this.statusBarTile = statusBar.addLeftTile({
      item: this.themeReelView.element,
      priority: -1000
    });
  },

  nextTheme: function () {
    this.chooseTheme(1);
  },

  previousTheme: function () {
    this.chooseTheme(-1);
  },

  chooseTheme: function (offset) {
    var themeNames = atom.themes.getLoadedThemes().filter(function (theme) {
      return theme.metadata && theme.metadata.theme === 'syntax';
    }).map(function (theme) {
      return theme.name;
    });

    var currentTheme = atom.themes.getActiveThemeNames()[0];
    var currentThemeIndex = themeNames.indexOf(currentTheme);

    var newThemeIndex = currentThemeIndex + offset;
    var newTheme = themeNames[newThemeIndex];

    if (!newTheme) {
      if (offset === -1) {
        newThemeIndex = themeNames.length - 1;
      } else {
        newThemeIndex = 0;
      }

      newTheme = themeNames[newThemeIndex];
    }

    var uiTheme = atom.themes.getActiveThemeNames()[1] || atom.themes.getActiveThemeNames()[0];

    atom.config.set('core.themes', [uiTheme, newTheme]);

    this.themeReelView.setTheme(newTheme, newThemeIndex, themeNames.length);
  },

  deactivate: function () {
    this.statusBarTile && this.statusBarTile.destroy();
    this.themeReelView.destroy();
    this.subscriptions.destroy();
  }
};
