@MM.module "MenteesApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Layout extends App.Views.Layout
    template: 'mentees/list/list_layout'

    id: 'mentee-list'

    regions:
      menteesRegion: "#mentees-region"

  class List.Empty extends App.Views.ItemView
    template: "mentees/list/empty"
    tagName: "a"
    className: "item"

  class List.Mentee extends App.Views.ItemView
    template: "mentees/list/mentee"
    tagName: "a"
    className: "mentee item item-dark item-thumbnail-left"
    attributes: ->
      href: "#mentees/" + @model.id
    events:
      "click": "activateClass"
    activateClass: ->
      @$el.addClass('active')

  class List.Mentees extends App.Views.CompositeView
    template: "mentees/list/mentees"
    itemView: List.Mentee
    emptyView: List.Empty
    tagName: "div"
    className: "list"
    # itemViewContainer: "ul"

