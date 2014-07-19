class ListsController < ApplicationController

  def new
    @list = List.new
  end

  def create
    list = List.new
    list.name = params[:list][:name]
    list.owner = @current_user
    list.save!
    redirect_to "/lists/#{list.id}"
  end

  def show
    @list = List.find(params[:id])
    @response = @list.responses.where({user: @current_user}).first
    if @response == nil
      @response = Response.new({list: @list, user: @current_user})
    end
    @response.backfill
  end

  def add_item
    list = List.find(params[:id])
    item = Item.new({list: list})
    item.title = params[:item][:title]
    item.save!
    redirect_to "/lists/#{list.id}"
  end

  def destroy_item
    list = List.find(params[:list_id])
    if @current_user = list.owner
      item = Item.find(params[:id])
      item.delete
    end
    redirect_to "/lists/#{list.id}"
  end

  def add_response
    list = List.find(params[:id])
    response = list.responses.where({user: @current_user}).first
    if response == nil
      response = Response.new({list: list, user: @current_user})
    end
    list.items.each do |item|
      rank = params[item.id.to_s.to_sym]
      add_or_update_ranked_item(response, item, rank)
    end
    response.save
    redirect_to "/lists/#{list.id}"
  end

  def edit
  end

  def update
  end

  def destroy
    list = List.find(params[:id])
    if @current_user == list.owner
      ranked_items = list.responses.inject(Array.new) {|items, r| items.concat r.ranked_items}
      ranked_items.map { |ri| ri.delete }
      list.items.map { |i| i.delete }
      list.responses.map { |r| r.delete }
      list.delete
    end
    redirect_to "/"
  end

  private

  def add_or_update_ranked_item(response, item, rank)
    ranked_item = response.ranked_items.where({item: item}).first
    if ranked_item == nil
      ranked_item = RankedItem.new({ response: response, item: item })
    end
    ranked_item.rank = rank
    ranked_item.save
  end

end
