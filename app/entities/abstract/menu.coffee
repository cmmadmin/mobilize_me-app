@MM.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.MenuItem extends App.Entities.Model

  class Entities.MenuItemsCollection extends App.Entities.Collection
    model: Entities.MenuItem

  class Entities.Menu extends App.Entities.Model

    initialize: ->
      items = this.get("items")
      if (items)
        this.items = new Entities.MenuItemsCollection(items)
        this.unset("items")

  class Entities.MenusCollection extends App.Entities.Collection
    model: Entities.Menu

    #chooseByName: (menu) ->
      #  @choose (@findWhere(name: menu) or @first())

    @include "SingleChooser"

  API =
    getMenus: ->
      new Entities.MenusCollection [
        { name: "Snap Shot", icon: "snapshot.png", items: [
        ] }
        { name: "Develop", icon: "develop.png", items: [
          { name: "World Christian Track", description: "Moving from Growing Christian to World Christian", trigger: "develop:world_track:clicked" }
          { name: "Mobilizer Track", description: "Moving from World Christian to Mobilizer", trigger: "develop:mobilizer_track:clicked" }
          { name: "Multiplier Track", description: "Multiplying More Mobilizers", trigger: "develop:multiplier_track:clicked" }
        ] }
      ]

  App.reqres.setHandler "menu:entities", ->
    API.getMenus()