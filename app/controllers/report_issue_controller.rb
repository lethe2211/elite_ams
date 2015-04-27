class ReportIssueController < ApplicationController

  # GET
  def choose_room
  end

  # POST
  def choose_asset_category
    @room = Room.find(params[:room_id])
    @asset_categories = AssetCategory.joins({:assets => :room}).where(:rooms => {id: params[:room_id]}).uniq
  end

  # POST
  def choose_asset
    @room = Room.find(params[:room_id])
    @asset_category = AssetCategory.find(params[:asset_category_id])
  end

  # POST
  def describe
    @room = Room.find(params[:room_id])
    @asset_category = AssetCategory.find(params[:asset_category_id])
    @asset = Asset.find(params[:asset_id])
  end

  # POST
  def thank_you
    @report = Report.new(report_params)
    @report.save
  end

  # GET
  def how_to
  end

  private
    def report_params
      params.permit(:description, :room_id, :asset_category_id, :asset_id)
    end
end
