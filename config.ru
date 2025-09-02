require 'rack'
require 'json'

require_relative 'app/infrastructure/web/app'
require_relative 'app/mock/users_repository'
require_relative 'app/domain/products/product_repository'

users_repo = Mock::UsersRepository.new
products_repo = Domain::Products::ProductRepository.new

app = Infrastructure::Web::App.new(
  users_repo: users_repo,
  products_repo: products_repo
)

run app
