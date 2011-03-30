require_dependency 'project'
module RedmineNewsNotifier::Patches
  module ProjectPatch

    def self.included(base)
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)
      base.class_eval do
        unloadable #permet de décharger la classe en mode dev
        has_many :subscriptions_lists
      end
    end

    module ClassMethods

    end
  
    #ici nos méthodes d'instance
    module InstanceMethods
    end  
  end
end
