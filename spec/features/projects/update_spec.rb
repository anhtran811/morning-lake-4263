# require 'rails_helper'

# RSpec.describe 'update contestant count' do
#   describe 'Extension 2' do
#     it 'will update the contestant count on the project show page' do
#       jay = Contestant.create!(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
#       gretchen = Contestant.create!(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
#       recycled_material_challenge = Challenge.create!(theme: "Recycled Material", project_budget: 1000)
#       news_chic = recycled_material_challenge.projects.create!(name: "News Chic", material: "Newspaper")
#       ContestantProject.create!(contestant_id: jay.id, project_id: news_chic.id)
#       ContestantProject.create!(contestant_id: gretchen.id, project_id: news_chic.id)

#       visit "/projects/#{news_chic.id}"
      
#       expect(news_chic.contestant_count).to eq(2)
      
#       kentaro = Contestant.create!(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
#       ContestantProject.create!(contestant_id: kentaro.id, project_id: news_chic.id)
      
#       fill_in('Contestant identification', with: kentaro.id)
#       click_on 'Add Contestant To Project'
      
#       expect(news_chic.contestant_count).to eq(3)
#     end 
#   end
# end