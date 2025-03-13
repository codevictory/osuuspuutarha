import Config

config :osuuspuutarha, OsuuspuutarhaWeb.Endpoint,
  cache_static_manifest: "priv/static/cache_manifest.json",
  url: [host: "portaali.livonsaarenosuuspuutarha.fi", port: 443],
  check_origin: [
    "https://portaali.livonsaarenosuuspuutarha.fi"
  ]

config :logger, level: :info
