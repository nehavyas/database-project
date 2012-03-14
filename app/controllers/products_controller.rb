class ProductsController < ApplicationController
  skip_before_filter :authorize, :only => [ :show, :index]
  # GET /products
  # GET /products.json
  def index
    @cart = current_cart
    @products = Product.scoped

    if not params[:category_id].blank?
      @products = @products.search_by_category(params[:category_id])
    end

    if not params[:name].blank?
      @products = @products.search_by_name(params[:name])
    end

    if not params[:min_price].blank?
      @products = @products.search_where_price_gte(params[:min_price])
    end

    if not params[:max_price].blank?
      @products = @products.search_where_price_lte(params[:max_price])
    end

    @products = @products.paginate :page =>params[:page],
                                 :per_page => 10

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @products }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @cart = current_cart
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @cart = current_cart
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @product }
    end
  end

  # GET /products/1/edit
  def edit
    @cart = current_cart
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    @cart = current_cart
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, :notice => 'Product was successfully created.' }
        format.json { render :json => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
        format.json { render :json => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @cart = current_cart
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, :notice => 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  def who_bought
    @product = Product.find(params[:id])
    respond_to do |format|
      format.atom
    end
  end
end
