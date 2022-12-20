class ProjectsController < ApplicationController
  def show
    @project = Project.find(params[:id])
    @challenge = @project.challenge
  end
  
  def update
    # @project = Project.find(params[:id])
    # @contestant = Contestant.find(params[:contestant_identification])
    ContestantProject.create!(project_id: params[:id], contestant_id: params[:contestant_identification])
    redirect_to "/projects/#{params[:id]}"
    # redirect_to "/projects/#{@project.id}"
  end
end