require_dependency 'news'

module RedmineNewsNotifier::Patches
  module NewsPatch

    def self.included(base)
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)
      base.class_eval do
        unloadable #permet de décharger la classe en mode dev
        acts_as_watchable
        alias_method_chain :attributes=, :watchers
        alias_method_chain :recipients, :watchers
      end
    end

    module ClassMethods

    end
  
    #ici nos méthodes d'instance
    module InstanceMethods

      def recipients_with_watchers
         recipients = recipients_without_watchers        
         recipients = recipients + watcher_recipients
         recipients.uniq
      end

      def attributes_with_watchers=(new_attributes, guard_protected_attributes = true)
        self.attributes_without_watchers = new_attributes
        self.watcher_user_ids = new_attributes[:watcher_user_ids] 
      end
    end  
  end
end
