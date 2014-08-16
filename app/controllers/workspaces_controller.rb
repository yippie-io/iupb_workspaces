using StringNumberCheck # ../refinements/string_number_check.rb

class WorkspacesController < ApplicationController
  def geo_search
    if lat = params[:lat].try(:valid_float?) and lng = params[:lng].try(:valid_float?)
      @workspaces = Workspace.by_distance(origin: [Float(lat), lng])
    else
      index
    end
  end

  def index
    @workspaces = Workspace.includes(:buildings).order("buildings.name")
  end
end
