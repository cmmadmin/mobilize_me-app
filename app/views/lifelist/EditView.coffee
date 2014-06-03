MM = require( 'MentorMe' )
template = require('templates/lifelist/Edit')
EditCategoryView = require('./EditCategoryView')
LifelistCategories = require('collections/LifelistCategories')

module.exports = class EditView extends Marionette.CompositeView
  template: template
  className: 'lifelist-edit'

  itemView: EditCategoryView
  itemViewContainer: '.lifelistCategories'
  
  events:
    'click #save-lifelist' : 'saveItems'

  initialize: (options) ->
    @selectedItems = options.selectedItems
    @items = @collection
    @profile = options.profile
    categories = options.collection.map (item) ->
      item.lifelist_category()
    @collection = new LifelistCategories(categories)

  saveItems: ->
    @items.each (item) =>
      if !item.get('selected') && @selectedItems.contains(item)
        @profile.unpickLifelistItem item
      else if item.get('selected') && !@selectedItems.contains(item)
        @profile.pickLifelistItem item
    @trigger('lifelist:edit:confirm:clicked')
    Backbone.history.navigate('mentees/' + @profile.get('id'), true)

  itemViewOptions: (model, index) ->
    selectedItems: @selectedItems
    lifelist: @model