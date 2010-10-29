class <%= class_name.pluralize %>Controller < ApplicationController
  respond_to :html,:json
  
  protect_from_forgery :except => [:post_data]
  
  # Don't forget to edit routes if you're using RESTful routing
  # 
  #resources :<%=plural_name%>,:only => [:index] do
  #   collection do
  #     post "post_data"
  #   end
  # end
  #
  def post_data
    if params[:oper] == "del"
      <%= camel %>.find(params[:id]).destroy
    else
      <%= model_name %>_params = { <%= columns.collect { |x| ":" + x + " => params[:" + x + "],"}.join.chomp(",") %> }
      if params[:id] == "_empty"
        <%= model_name %> = <%= camel %>.create(<%= model_name %>_params)
      else
        <%= model_name %> = <%= camel %>.find(params[:id])
        <%= model_name %>.update_attributes(<%= model_name %>_params)
      end
    end
    
    render :nothing => true
  end


  def index
    index_columns ||= [<%= columns.collect { |x| ":" + x + "," }.join.chomp(',') %>]
    current_page = params[:page] ? params[:page].to_i : 1
    rows_per_page = params[:rows] ? params[:rows].to_i : 10

    conditions={:page => current_page, :per_page => rows_per_page}
    conditions[:order] = params["sidx"] + " " + params["sord"] if (params[:sidx] && params[:sord])
    
    if params[:_search] == "true"
      conditions[:conditions]=filter_by_conditions(index_columns)
    end
    
    @<%= plural_name %>=<%= camel %>.paginate(conditions)
    total_entries=@<%= plural_name %>.total_entries
    
    respond_with(@<%= plural_name %>) do |format|
      format.json { render :json => @<%= plural_name %>.to_jqgrid_json(index_columns, current_page, rows_per_page, total_entries)}  
    end
  end
  
  # private 
  # 
  # def filter_by_conditions(columns)
  #   conditions = ""
  #   columns.each do |column|
  #     conditions << "#{column} LIKE '%#{params[column]}%' AND " unless params[column].nil?
  #   end
  #   conditions.chomp("AND ")
  # end

end