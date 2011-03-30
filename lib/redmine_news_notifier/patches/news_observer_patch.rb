require_dependency 'mailer'

module RedmineNewsNotifier::Patches
  module NewsObserverPatch

    def self.included(base)
      base.send(:include, InstanceMethods)

      base.extend(InstanceMethods)
      base.class_eval do
        unloadable #permet de décharger la classe en mode dev
      end
    end
    
    module ClassMethods
    end

    module InstanceMethods

      def after_create(news)
        puts "new after_create"
        Mailer.deliver_news_added_with_watchers(news)
      end
    end
  end
end
