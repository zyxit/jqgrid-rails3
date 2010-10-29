class <%= class_name.pluralize %>Controller < ApplicationController
  
  protect_from_forgery :except => [:post_data]
    
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
    <%= plural_name %> = <%= camel %>.find(:all) do
      if params[:_search] == "true"
        <% columns.each_with_index do |col, i| -%>
        <%= col %> =~ "%#{params[:<%= col %>]}%" if params[:<%= col %>].present?
        <% end -%>
      end
      paginate :page => params[:page], :per_page => params[:rows]      
      order_by "#{params[:sidx]} #{params[:sord]}"
    end
    if request.xhr?
      render :json => <%= plural_name %>.to_jqgrid_json([<%= columns.collect { |x| ":" + x + "," }.join.chomp(',') %>], params[:page], params[:rows], <%= plural_name %>.total_entries) and return
    end
  end

end
