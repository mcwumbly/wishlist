class ListsController < ApplicationController

  def index
    @lists = List.all
  end

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
  end

  def add_item
    list = List.find(params[:id])
    item = Item.new({list: list})
    item.title = params[:item][:title]
    item.save!
    redirect_to "/lists/#{list.id}"
  end

  def add_response
    list = List.find(params[:id])
    response = list.responses.where({user: @current_user}).first
    if response == nil
      response = Response.new({list: list, user: @current_user})
    end
    response.ranked_items.delete_all
    list.items.each do |item|
      add_or_update_ranked_item(response, item.id, params[item.id.to_s.to_sym])
    end
    redirect_to "/lists/#{list.id}"
  end

  def edit
  end

  def update
  end

  private

  def add_or_update_ranked_item(response, item_id, rank)
    ranked_item = response.ranked_items.where({item_id: item_id}).first
    if ranked_item == nil
      ranked_item = RankedItem.new({ response: response, item_id: item_id })
    end
    ranked_item.rank = rank
    ranked_item.save
  end

end
