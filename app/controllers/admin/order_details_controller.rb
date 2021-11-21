class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!
  
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    @order = @order_detail.order
    
    # 製作ステータス、注文ステータスの更新
    if @order_detail.making_status == "製作中"
      @order.update(status: 2)
      flash[:notice] = "製作ステータスを更新しました"
      @order.save
    end
    
    # 注文個数と製作完了個数がイコールならば
    if @order.order_details.count == @order.order_details.where(making_status: 3).count
      @order.update(status: 3)
      flash[:norice] = "製作ステータスを更新しました"
      @order.save
    end
    redirect_to request.referer
  end
  
  private
  def order_detail_params
    params.require(:order_detail).permit(:order_id, :making_status, :count, :order_id)
  end
end
