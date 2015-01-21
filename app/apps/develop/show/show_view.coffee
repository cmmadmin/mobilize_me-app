@MM.module "DevelopApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Layout extends App.Views.Layout
    template: "develop/show/show_layout"
    className: "with-banner padded-page"

    regions:
      headerRegion: "#header-region"
      menuRegion: "#menu-region"

  class Show.Header extends App.Views.ItemView
    template: "develop/show/show_header"

  class Show.MenuItem extends App.Views.ItemView
    template: "develop/show/show_menuitem"

    events:
      "click" : "itemClicked"

    itemClicked: (e) ->
      @trigger 'clicked', @model


  class Show.MenuCategory extends App.Views.CompositeView
    template: "develop/show/show_menucategory"

    className: "accordion-group"
    itemView: Show.MenuItem
    itemViewContainer: ".accordion-inner"

    events:
      "click .accordion-heading" : "toggleChoose"

    @include "Chooseable"

    initialize: ->
      @collection = @model.develop_items()

    itemEvents: 
      "clicked": (e, c, i) ->
        @trigger "item:clicked", i

  class Show.Menu extends App.Views.CompositeView
    template: "develop/show/show_menu"

    itemView: Show.MenuCategory
    itemViewContainer: ".accordion"

    id: "menu-inner"

    itemEvents:
      'item:clicked': (e, m, i) ->
        @trigger('menu:item:clicked', i)