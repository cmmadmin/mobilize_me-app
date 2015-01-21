@MM.module "DevelopApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Layout extends App.Views.Layout
    template: "develop/show/show_layout"
    className: "with-banner padded-page"

    regions:
      headerRegion: "#header-region"
      menuRegion: "#menu-region"