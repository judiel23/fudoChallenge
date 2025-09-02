require 'rack'
require 'json'

require_relative 'app/infrastructure/web/app'
require_relative 'app/mock/users_repository'
require_relative 'app/domain/products/product_repository'
require_relative 'app/infrastructure/web/middlewares/jwt_auth_middleware'

users_repo = Mock::UsersRepository.new
products_repo = Domain::Products::ProductRepository.new

use Rack::Deflater  
use Infrastructure::Web::Middleware::JwtAuthMiddleware


use Rack::Static,
  urls: ["/openapi.yaml"],
  root: File.expand_path(".", __dir__),
  header_rules: [
    [:all, {'cache-control' => 'no-store'}]
  ]

use Rack::Static,
  urls: ["/AUTHORS"],
  root: File.expand_path(".", __dir__),
  header_rules: [
    [:all, {'cache-control' => 'public, max-age=86400'}]
  ]


app = Infrastructure::Web::App.new(
  users_repo: users_repo,
  products_repo: products_repo
)

run app
