require 'rails_helper'

# As a visitor,
# When I visit a project's show page ("/projects/:id"),
# I see that project's name and material
# And I also see the theme of the challenge that this project belongs to.
# (e.g.    Litfit
#     Material: Lamp Shade
#   Challenge Theme: Apartment Furnishings)

RSpec.describe "Project's show page" do
  describe 'User story 1' do
    it 'can see the projects name, material, and challenge theme' do
      recycled_material_challenge = Challenge.create!(theme: "Recycled Material", project_budget: 1000)
      news_chic = recycled_material_challenge.projects.create!(name: "News Chic", material: "Newspaper")
      boardfit = recycled_material_challenge.projects.create!(name: "Boardfit", material: "Cardboard Boxes")
      
      visit "/projects/#{news_chic.id}"

      expect(page).to have_content(news_chic.name)
      expect(page).to have_content("Material: #{news_chic.material}")
      expect(page).to have_content("Challenge Theme: #{recycled_material_challenge.theme}")
      expect(page).to_not have_content(boardfit.name)
    end
  end

# As a visitor,
# When I visit a project's show page
# I see a count of the number of contestants on this project

# (e.g.    Litfit
#     Material: Lamp Shade
#   Challenge Theme: Apartment Furnishings
#   Number of Contestants: 3 )

  describe 'User story 3' do
    it 'can show the number of contestants on this project' do
      jay = Contestant.create!(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
      gretchen = Contestant.create!(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
      kentaro = Contestant.create!(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)

      recycled_material_challenge = Challenge.create!(theme: "Recycled Material", project_budget: 1000)

      news_chic = recycled_material_challenge.projects.create!(name: "News Chic", material: "Newspaper")

      ContestantProject.create!(contestant_id: jay.id, project_id: news_chic.id)
      ContestantProject.create!(contestant_id: gretchen.id, project_id: news_chic.id)
      ContestantProject.create!(contestant_id: kentaro.id, project_id: news_chic.id)

      visit "/projects/#{news_chic.id}"

      expect(page).to have_content("Number of contestants: 3")
    end
  end
end