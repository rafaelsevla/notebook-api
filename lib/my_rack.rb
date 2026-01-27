require "rack"
require "rackup" # O Rack 3 separou o servidor em uma gem própria

app = Proc.new do |env|
  # Retornar o body em um array é o padrão, mas agora o Rack 3
  # é mais rigoroso com headers e tipos de dados.
  [ 200, { "content-type" => "text/html" }, [ "Hello from Rack! <br> #{env}" ] ]
end

# A forma moderna de rodar manualmente via código:
Rackup::Handler.get("puma").run(app, Port: 3000, Host: "0.0.0.0")
