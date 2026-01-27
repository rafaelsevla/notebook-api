class AppName
  def initialize(app, app_name)
    @app = app
    @app_name = app_name
  end

  def call(env)
    if env["PATH_INFO"] == "/"
      return [ 200, { "content-type" => "text/html" }, [ "Teste!" ] ]
    end

    status, headers, response = @app.call(env)
    headers["X-App-Name"] = @app_name.to_s
    [ status, headers, response ]
  end
end
