require 'rake'
require 'rspec/core/rake_task'

environment  = ENV['ENVIRONMENT']
hosts = [
  {
    :name   => "proxy.vimfactory-#{environment}",
    :roles  => %w( base proxy )
  },
  {
    :name   => "app.vimfactory-#{environment}",
    :roles  => %w( base app )
  },
  {
    :name   => "websocket.vimfactory-#{environment}",
    :roles  => %w( base websocket )
  },
  {
    :name   => "container.vimfactory-#{environment}",
    :roles  => %w( base container )
  }
]

hosts = hosts.map do |host|
  {
    :name       => host[:name],
    :short_name => host[:name].split('.')[0],
    :roles      => host[:roles]
  }
end

desc "Run serverspec to all hosts"
task :serverspec => 'serverspec:all'

namespace :serverspec do
  task :all => hosts.map { |h| 'serverspec:' + h[:short_name] }
  hosts.each do |host|
    desc "Run serverspec to #{host[:name]}"
    RSpec::Core::RakeTask.new(host[:short_name].to_sym) do |t|
      ENV['TARGET_HOST'] = host[:name]
      t.pattern = 'spec/{' + host[:roles].join(',') + '}/*_spec.rb'
    end
  end
end

desc "Deploy"
namespace :deploy do
  require "io/console"
  require "open3"

  STDOUT.sync = true
  desc "Deploy to development server"
  task :development do
    sudo_password = ask_sudo_password
    deploy('development', sudo_password)
    test('development', sudo_password)
  end

  desc "Deploy to production server"
  task :production do
    sudo_password = ask_sudo_password
    deploy('production', sudo_password)
    test('production', sudo_password)
  end

  def deploy(env, sudo_password)
    Open3.pipeline("ansible-playbook -i #{env} site.yml -u deploy --extra-vars 'ansible_sudo_pass=#{sudo_password}'")
  end

  def test(env, sudo_password)
    Open3.pipeline("bundle exec rake serverspec SSH_CONFIG=sshconfig ENVIRONMENT=#{env} SUDO_PASSWORD=#{sudo_password}")
  end

  def ask_sudo_password
    print "SUDO Password: "
    STDIN.noecho &:gets
  end
end
