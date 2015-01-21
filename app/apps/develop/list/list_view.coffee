@MM.module "DevelopApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Layout extends App.Views.Layout
    template: "develop/list/list_layout"
    className: "with-banner padded-page"

    regions:
      headerRegion: "#header-region"
      menuRegion: "#menu-region"

  class List.Header extends App.Views.ItemView
    template: "develop/list/list_header"

  class List.MenuItem extends App.Views.ItemView
    template: "develop/list/list_menuitem"

    events:
      "click" : "itemClicked"

    itemClicked: (e) ->
      @trigger 'clicked', @model


  class List.MenuCategory extends App.Views.CompositeView
    template: "develop/list/list_menucategory"

    className: "accordion-group"
    itemView: List.MenuItem
    itemViewContainer: ".accordion-inner"

    events:
      "click .accordion-heading" : "toggleChoose"

    @include "Chooseable"

    initialize: ->
      @collection = @model.develop_items()

    itemEvents: 
      "clicked": (e, c, i) ->
        @trigger "item:clicked", i

  class List.Menu extends App.Views.CompositeView
    template: "develop/list/list_menu"

    itemView: List.MenuCategory
    itemViewContainer: ".accordion"

    id: "menu-inner"

    itemEvents:
      'item:clicked': (e, m, i) ->
        console.log i
        @trigger "menu:item:clicked", i