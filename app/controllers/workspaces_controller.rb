using StringNumberCheck # ../refinements/string_number_check.rb

class WorkspacesController < ApplicationController
  def geo_search
    if lat = params[:lat].try(:valid_float?) and lng = params[:lng].try(:valid_float?)
      @workspaces = Workspace.by_distance(origin: [Float(lat), Float(lng)])
    else
      index
    end
  end

  def index
    @workspaces = Workspace.includes(:buildings).order("buildings.name")
  end

  def feedback
    find_workspace
    cr = ChangeRequest.new
    if params[:kind] == "geoupdate" && params[:lat].try(:valid_float?) and params[:lng].try(:valid_float?)
      cr.lat = Float(params[:lat])
      cr.lng = Float(params[:lng])

      cr.feedback = {accuracy: params[:accuracy], altitude: params[:altitude]} if params[:accuracy] or params[:altitude]
      if cr.save
        render :json => "thanks for your feedback!", :status => :ok
      end
    else
      return_paramter_fail
    end
  end

  protected
  def find_workspace
    @workspace = Workspace.find(params[:workspace_id] || params[:id])
  end

  private
  def return_paramter_fail
    render :nothing => true, :status => :bad_request
  end
end
