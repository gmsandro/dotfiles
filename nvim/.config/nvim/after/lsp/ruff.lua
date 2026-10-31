return {
  on_attach = function(client)
    -- Leave hover to ty
    client.server_capabilities.hoverProvider = false
  end,
}
