'use strict'

/** @type {import('@adonisjs/lucid/src/Schema')} */
const Schema = use('Schema')

class EstabelecimentoSchema extends Schema {
  up () {
    this.create('estabelecimentos', (table) => {
	  table.increments()
	  table.string('nome', 250).notNullable()
	  table.float('latitude').notNullable()
	  table.float('longitude').notNullable()
      table.timestamps()
    })
  }

  down () {
    this.drop('estabelecimentos')
  }
}

module.exports = EstabelecimentoSchema
