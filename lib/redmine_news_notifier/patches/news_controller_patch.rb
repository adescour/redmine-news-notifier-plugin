module RedmineNewsNotifier::Patches
  module NewsControllerPatch
    def self.included(base) # :nodoc:
      base.send(:include, InstanceMethods)
      base.extend(InstanceMethods)
      base.class_eval do
        unloadable #permet de décharger la classe en mode dev
        alias_method_chain :new, :watchers
      end
    end

    module InstanceMethods

      def new_with_watchers
        @news = News.new(:project => @project, :author => User.current)
        if request.post?
          @news.attributes = params[:news]
          @news.watcher_user_ids = params[:news]['watcher_user_ids'] if User.current.allowed_to?(:add_news_watchers, @project)
            if @news.save
              flash[:notice] = l(:notice_successful_create)
              redirect_to :controller => 'news', :action => 'index', :project_id => @project
            end
        end
      end

    end    
  end
end
