require 'sinatra/base'
require 'sinatra/reloader'

class TaskApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  # Enable method override for DELETE requests
  use Rack::MethodOverride

  # In-memory task storage
  set :tasks, []

  get '/' do
    @tasks = settings.tasks
    erb :index
  end

  post '/tasks' do
    task_name = params[:task_name]
    if task_name && !task_name.strip.empty?
      settings.tasks << {
        id: settings.tasks.length + 1,
        name: task_name,
        completed: false
      }
    end
    redirect '/'
  end

  post '/tasks/:id/complete' do
    task_id = params[:id].to_i
    task = settings.tasks.find { |t| t[:id] == task_id }
    task[:completed] = true if task
    redirect '/'
  end

  delete '/tasks/:id' do
    task_id = params[:id].to_i
    settings.tasks.reject! { |t| t[:id] == task_id }
    redirect '/'
  end
end
