@MM.module "Models", (Models, App, Backbone, Marionette, $, _) ->

  Model = Models.Supers.Model
  Collection = App.Collections.Supers.Collection

  class Models.LifelistItem extends Model
    urlRoot: Collection.serverUrl('lifelist_items')

  # Put at bottom to avoid circular dependency (ugly commonjs exports hack)
  Lifelist = require('./Lifelist')
  LifelistCategory = require('./LifelistCategory')

  # Supermodel definitions
  LifelistItem.has().one('lifelist', 
    model: Lifelist
    inverse: 'lifelist_items'
  )

  LifelistItem.has().one('lifelist_category', 
    model: LifelistCategory
    inverse: 'lifelist_items'
  )