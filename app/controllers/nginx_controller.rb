require 'nginx'

class NginxController < ApplicationController

  def generate
    t = Template.where(:active_flg => Template::ACTIVE_FLG[:ACTIVE]).first
    Nginx.template = t.body
    Nginx.generate_conf
    redirect_to action: 'show'
  end

  def edit
    @body = Nginx.read
  end

  def edit_template
  end

  def update
    @body = params[:body]
    Nginx.write @body
    flash[:info] = "更新nginx配置文件成功"
    render action: 'edit'
  end

  def show
    @conf =  Nginx.read
    # ap @conf
  end

  def reload
    Nginx.reload
    redirect_to action: 'show'
  end

end
