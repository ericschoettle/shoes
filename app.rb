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
  @brand = Brand.new({:name => params[:name], :price => params[:price]})
  if @brand.save()
    redirect '/'
  else
    erb :brand_error
  end
end

post '/store' do
  @store = Store.new({:name => params[:name]})
  if @store.save()
    redirect '/'
  else
    erb :store_error
  end
end

get '/brand/:id' do
  @brand = Brand.find(params[:id])
  erb :brand
end

patch '/brand/:id/add/stores' do
  brand = Brand.find(params[:id])
  store_ids = params[:store_ids]
  if store_ids != []
    store_ids.each() do |id|
      brand.stores.push(Store.find(id))
    end
  end
  redirect ('/brand/' + params[:id])
end

delete '/brand/:id/remove/stores' do
  brand = Brand.find(params[:id])
  store_ids = params[:store_ids]
  if store_ids != []
    store_ids.each() do |id|
      brand.stores.destroy(Store.find(id))
    end
  end
  redirect ('/brand/' + params[:id])
end

patch '/brand/:id' do
  brand = Brand.find(params[:id])
  if params[:name] == ""
    name = brand.name()
  else
    name = params[:name]
  end

  if params[:price] == ""
    price = brand.price()
  else
    price = params[:price]
  end

  brand.update({:name => name, :price => price})
  redirect ('/brand/' + params[:id])
end

delete '/brand/:id' do
  brand = Brand.find(params[:id])
  brand.destroy()
  redirect '/'
end

get '/store/:id' do
  @store = Store.find(params[:id])
  erb :store
end

patch '/store/:id/add/brands' do
  store = Store.find(params[:id])
  brand_ids = params[:brand_ids]
  if brand_ids != []
    brand_ids.each() do |id|
      store.brands.push(Brand.find(id))
    end
  end
  redirect ('/store/' + params[:id])
end

delete '/store/:id/remove/brands' do
  store = Store.find(params[:id])
  brand_ids = params[:brand_ids]
  if brand_ids != []
    brand_ids.each() do |id|
      store.brands.destroy(Brand.find(id))
    end
  end
  redirect ('/store/' + params[:id])
end

patch '/store/:id' do
  store = Store.find(params[:id])
  if params[:name] == ""
    name = store.name()
  else
    name = params[:name]
  end

  store.update({:name => name})
  redirect ('/store/' + params[:id])
end

delete '/store/:id' do
  store = Store.find(params[:id])
  store.destroy()
  redirect '/'
end
