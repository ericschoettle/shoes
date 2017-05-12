require("bundler/setup")
Bundler.require(:default)
also_reload('lib/**/*.rb')

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get '/' do
  @brands = Brand.all()
  @stores = Store.all()
  erb :index
end

post '/brand' do
  brand = Brand.new({:name => params[:name], :price => params[:price]})
  if brand.save()
    redirect '/'
  else
    erb :error
  end
end

post '/store' do
  store = Store.new({:name => params[:name]})
  if store.save()
    redirect '/'
  else
    erb :error
  end
end

get 'brand/:id' do
  @brand = Brand.find(params[:id])
  erb :brand
end
