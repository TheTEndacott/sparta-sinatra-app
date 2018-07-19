class CarsController < Sinatra::Base
  # sets root as the parent-directory of the current file
  set :root, File.join(File.dirname(__FILE__), '..')

  # sets the view directory correctly
  set :views, Proc.new { File.join(root, "views") }

  configure :development do
    register Sinatra::Reloader
  end

  # INDEX
  get "/" do
    @title = "Car List"
    @cars = Car.all
    erb :"cars/index"
  end

  # NEW
  get "/new" do
    @car = Car.new

    @car.id = ""

    erb :"cars/new"
  end

  # SHOW
  get "/:id" do
    id = params[:id].to_i
    @car = Car.find(id)

    erb :"cars/show"
  end

  # CREATE
  post "/" do
    car = Car.new

    car.make = params[:make]
    car.model = params[:model]
    car.country = params[:country]

    car.save

    redirect "/"
  end

  # EDIT
  get "/:id/edit" do
    id = params[:id].to_i
    @car = Car.find(id)
    erb :"cars/edit"
  end

  # UPDATE
  put "/:id" do
    id = params[:id].to_i

    car = Car.find(id)
    car.make = params[:make]
    car.model = params[:model]
    car.country = params[:country]

    car.save

    redirect "/"
  end

  # DESTROY
  delete ":id" do
    id = params[:id].to_i

    Car.destroy(id)

    redirect "/"
  end














end # Close class