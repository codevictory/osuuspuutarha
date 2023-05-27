defmodule OsuuspuutarhaWeb.Router do
  use OsuuspuutarhaWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {OsuuspuutarhaWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :admin_browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {OsuuspuutarhaWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", OsuuspuutarhaWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/privacy", PageController, :privacy

    live "/ilmoittautuminen", OrderLive.Registration, :index
    live "/ilmoittautuminen/uusi", OrderLive.Registration, :new
  end

  scope "/hallinta", OsuuspuutarhaWeb do
    pipe_through :admin_browser

    live "/tilaukset", OrderLive.Index, :index
    live "/tilaukset/uusi", OrderLive.Index, :new
    live "/tilaukset/:id/muokkaa", OrderLive.Index, :edit

    live "/tilaukset/:id", OrderLive.Show, :show
    live "/tilaukset/:id/nayta/muokkaa", OrderLive.Show, :edit
  end

  scope "/lataukset", as: :exports, alias: OsuuspuutarhaWeb.Exports do
    pipe_through :admin_browser
    resources "/tilaukset", OrderController, only: [:index]
  end

  # Other scopes may use custom stacks.
  # scope "/api", OsuuspuutarhaWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: OsuuspuutarhaWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  defp auth(conn, _opts) do
    username = System.fetch_env!("BA_USERNAME")
    password = System.fetch_env!("BA_PASSWORD")

    Plug.BasicAuth.basic_auth(conn, username: username, password: password)
  end
end
