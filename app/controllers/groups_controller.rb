# frozen_string_literal: true

class GroupsController < ApplicationController
  before_action :set_group, only: %i[show edit update destroy]
  before_action :set_users_group, only: :show
  before_action :set_groups, only: :index

  def index; end

  def show; end

  def new
    @group = Group.new
  end

  def edit; end

  def create
    @group = Group.new(group_params)

    if @group.save
      redirect_to @group, notice: I18n.t('group.create_success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @group.update(group_params)
      redirect_to @group, notice: I18n.t('group.update_success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @group.destroy
      redirect_to groups_url, notice: I18n.t('group.destroy_success')
    else
      redirect_to groups_url, alert: I18n.t('group.destroy_failure')
    end
  end

  private

  def set_group
    @group = Group.includes(users_groups: :user).find(params[:id])
  end

  def set_users_group
    @pagy, @users_group = pagy(UsersGroup.includes(:user).where(group_id: @group.id))
  end

  def group_params
    params.require(:group).permit(:name)
  end

  def set_groups
    @pagy, @groups = pagy(Group.includes(:organizers).all)
  end
end
