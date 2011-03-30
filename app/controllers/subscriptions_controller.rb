class SubscriptionsController < ApplicationController

  helper :application
  include ApplicationHelper

  before_filter :find_project

  def set_watchers
    @selected_users = []
  
    if params[:subscriptions_list_id] != ""
      sl = SubscriptionsList.find(params[:subscriptions_list_id])
      @selected_users = sl.subscribers.collect(&:id)
    end
    render :partial => "news/watchers", :locals => {:selected_users => @selected_users, :project => @project}
  end

  def index
    if authorize_for('news','edit')
      puts "authorized"
      @slists = @project.subscriptions_lists.sort
    else
      render_403
    end
  end

  def add_news_subscriptions_list

    slist = params[:subscriptions_list]

    if slist[:name]

      if slist[:id] != ""
        sl = SubscriptionsList.find_or_create_by_id_and_name(:id => slist[:id], :name => slist[:name], :project => @project)
        sl.subscribers.clear
      else
        sl = SubscriptionsList.new(:project => @project, :name => params[:subscriptions_list][:name])
      end

      if params[:users_ids]
        # add users
        params[:users_ids].each{|uid|
          sl.subscriptions << Subscription.new(:user_id => uid)
        }
      end
      
      if sl.save
        respond_to do |format|
          format.js do
            # IE doesn't support the replace_html rjs method for select box options
            render(:update) {|page| page.replace "subscriptions_list_id",
              content_tag('select', '<option></option>' + options_from_collection_for_select(@project.subscriptions_lists.sort, 'id', 'name', sl.id), 
                          {:id => "subscriptions_list_id", 
                           :style => "width:10em",
                           :onChange => remote_function(:update => 'news_watchers',
                                                        :url => { :controller => :subscriptions, :action => :set_watchers },
                                                        :with => "'subscriptions_list_id='+this.value+'&project_id=#{@project.id}'"
                                                       )
                          }
              )
            }
          end
        end
      else
        respond_to do |format|
          format.js do
            render(:update) {|page| page.alert(l(:error_unable_create_list)) }
          end
        end
      end
    end
  end

  def delete_subscriptions_list
    if authorize('news','new')
      if @sl = SubscriptionsList.find(params[:subscriptions_list][:id])
        if @sl.destroy
          flash[:notice] = l(:notice_successful_delete)
        end
      end
    end

    redirect_to(:action => 'index', :project_id => @project.id)
  end

private
  
  def find_project
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

end
