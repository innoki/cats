use Mix.Config

config :trot,
  port: (System.get_env("PORT") || 4040),
  router: Cats,
  heartbeat: "/cats/alive"
