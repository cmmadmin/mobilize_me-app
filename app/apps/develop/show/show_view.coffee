@MM.module "DevelopApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Layout extends App.Views.Layout
    template: "develop/show/show_layout"
    className: "full-page padded-page"

    regions:
      headerRegion: "#header-region"
      goalRegion: "#goal-region"
      itemRegion: "#item-region"
      footerRegion: "#footer-region"

  class Show.Header extends App.Views.ItemView
    template: "develop/show/show_header"

  class Show.Goal extends App.Views.ItemView
    template: "develop/show/show_goal"
    className: "develop-goal-container"

  class Show.Item extends App.Views.ItemView
    template: "develop/show/show_item"
    className: "develop-item-content"

  class Show.Footer extends App.Views.ItemView
    template: "develop/show/show_footer"
    className: "bar bar-footer bar-balanced"