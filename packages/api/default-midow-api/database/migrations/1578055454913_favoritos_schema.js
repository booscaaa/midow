'use strict'

/** @type {import('@adonisjs/lucid/src/Schema')} */
const Schema = use('Schema')

class FavoritosSchema extends Schema {
  up () {
    this.create('favoritos', (table) => {
	  table.increments()
	  table.integer('estabelecimento_id').unsigned().references('id').inTable('estabelecimentos')
	  table.integer('user_id').unsigned().references('id').inTable('users')
      table.timestamps()
    })
  }

  down () {
    this.drop('favoritos')
  }
}

module.exports = FavoritosSchema
