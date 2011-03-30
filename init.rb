require 'redmine'
require 'dispatcher' # Patches to the Redmine core.

Redmine::Plugin.register :redmine_news_notifier do
  name 'News Notifier plugin'
  author 'Cassidian Test & Services, BB'
  description 'Plugin used to set a list of users that will be notified when publishing a news'
  version '0.1.1'
end

Dispatcher.to_prepare :redmine_news_notifier do
  require_dependency 'news'
  require_dependency 'news_controller'
  require_dependency 'project'

  # loads news patch
  unless News.included_modules.include? RedmineNewsNotifier::Patches::NewsPatch
    News.send(:include, RedmineNewsNotifier::Patches::NewsPatch)
  end

  # loads news patch
  unless NewsController.included_modules.include? RedmineNewsNotifier::Patches::NewsControllerPatch
    NewsController.send(:include, RedmineNewsNotifier::Patches::NewsControllerPatch)
  end

  # loads project patch
  unless Project.included_modules.include? RedmineNewsNotifier::Patches::ProjectPatch
    Project.send(:include, RedmineNewsNotifier::Patches::ProjectPatch)
  end
end
