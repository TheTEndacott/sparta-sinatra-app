require "sinatra"
require "sinatra/contrib"
require "sinatra/reloader" if development?
require "pg"
require_relative "controllers/cars_controller.rb"
require_relative "models/cars.rb"

use Rack::MethodOverride
run CarsController