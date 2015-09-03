GithubClonerView = require './github-cloner-view'
{CompositeDisposable} = require 'atom'

module.exports = GithubCloner =
  githubClonerView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @githubClonerView = new GithubClonerView(state.githubClonerViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @githubClonerView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'github-cloner:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @githubClonerView.destroy()

  serialize: ->
    githubClonerViewState: @githubClonerView.serialize()

  toggle: ->
    console.log 'GithubCloner was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
