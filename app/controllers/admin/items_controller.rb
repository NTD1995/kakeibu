class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_item, only: [:edit, :update, :destroy]

  # 項目一覧画面
  def index
    @expenses = Item.where(category: "支出")
    @incomes = Item.where(category: "収入")
    @new_item = Item.new(category: "支出")
  end

  # 項目新規追加処理
  def create
    @item = Item.new(item_params)
    if @item.save
      @expenses = Item.where(category: "支出")
      @incomes = Item.where(category: "収入")
      redirect_to admin_items_path, notice: "項目が追加されました。"
    else
      @expenses = Item.where(category: "支出")
      @incomes = Item.where(category: "収入")
      flash.now[:alert] = "項目が追加されませんでした。"
      render :index
    end
  end

  # 項目編集画面
  def edit
  end

  # 項目編集処理
  def update
    if @item.update(item_params)
      redirect_to admin_items_path, notice: "項目が更新されました。"
    else
      flash.now[:alert] = "項目が更新されませんでした。"
      render :edit
    end
  end

  # 項目削除処理
  def destroy
    @item.destroy
    redirect_to admin_items_path, alert: "項目を削除しました。"
  end

  private

  def item_params
    params.require(:item).permit(:name, :category)
  end

  # 各アクション内で項目情報を使用
  def set_item
    @item = Item.find(params[:id])
  end
end
