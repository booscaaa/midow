'use strict'

/** @typedef {import('@adonisjs/framework/src/Request')} Request */
/** @typedef {import('@adonisjs/framework/src/Response')} Response */
/** @typedef {import('@adonisjs/framework/src/View')} View */

/**
 * Resourceful controller for interacting with estabelecimentos
 */

const Estabelecimento = use("App/Models/Estabelecimento")

class EstabelecimentoController {
  /**
   * Show a list of all estabelecimentos.
   * GET estabelecimentos
   *
   * @param {object} ctx
   * @param {Request} ctx.request
   * @param {Response} ctx.response
   * @param {View} ctx.view
   */
  async index({
    request,
    response,
    view
  }) {
	const estabelecimentos = await Estabelecimento.all();
    return estabelecimentos;
  }

  /**
   * Render a form to be used for creating a new estabelecimento.
   * GET estabelecimentos/create
   *
   * @param {object} ctx
   * @param {Request} ctx.request
   * @param {Response} ctx.response
   * @param {View} ctx.view
   */
  async create({
    request,
    response,
    view
  }) {}

  /**
   * Create/save a new estabelecimento.
   * POST estabelecimentos
   *
   * @param {object} ctx
   * @param {Request} ctx.request
   * @param {Response} ctx.response
   */
  async store({
    request,
    response
  }) {
    const data = request.only(['nome', 'latitude', 'longitude']);

    const estabelecimento = await Estabelecimento.create(data);

    return estabelecimento;
  }

  /**
   * Display a single estabelecimento.
   * GET estabelecimentos/:id
   *
   * @param {object} ctx
   * @param {Request} ctx.request
   * @param {Response} ctx.response
   * @param {View} ctx.view
   */
  async show({
    params,
    request,
    response,
    view
  }) {}

  /**
   * Render a form to update an existing estabelecimento.
   * GET estabelecimentos/:id/edit
   *
   * @param {object} ctx
   * @param {Request} ctx.request
   * @param {Response} ctx.response
   * @param {View} ctx.view
   */
  async edit({
    params,
    request,
    response,
    view
  }) {}

  /**
   * Update estabelecimento details.
   * PUT or PATCH estabelecimentos/:id
   *
   * @param {object} ctx
   * @param {Request} ctx.request
   * @param {Response} ctx.response
   */
  async update({
    params,
    request,
    response
  }) {}

  /**
   * Delete a estabelecimento with id.
   * DELETE estabelecimentos/:id
   *
   * @param {object} ctx
   * @param {Request} ctx.request
   * @param {Response} ctx.response
   */
  async destroy({
    params,
    request,
    response
  }) {}
}

module.exports = EstabelecimentoController
