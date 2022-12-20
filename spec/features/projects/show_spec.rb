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
      
      expect(page).to have_content("Number of contestants: #{news_chic.contestant_count}")
    end
  end

# As a visitor,
# When I visit a project's show page
# I see the average years of experience for the contestants that worked on that project
# (e.g.    Litfit
#     Material: Lamp Shade
#   Challenge Theme: Apartment Furnishings
#   Number of Contestants: 3
#   Average Contestant Experience: 10.25 years)
  describe 'Extension 1' do
    it 'can show the average years of experience for the contestants by project' do
      jay = Contestant.create!(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
      gretchen = Contestant.create!(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
      kentaro = Contestant.create!(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)

      recycled_material_challenge = Challenge.create!(theme: "Recycled Material", project_budget: 1000)
      furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)

      news_chic = recycled_material_challenge.projects.create!(name: "News Chic", material: "Newspaper")
      upholstery_tux = furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")

      ContestantProject.create!(contestant_id: jay.id, project_id: news_chic.id)
      ContestantProject.create!(contestant_id: gretchen.id, project_id: news_chic.id)
      ContestantProject.create!(contestant_id: kentaro.id, project_id: news_chic.id)
      ContestantProject.create(contestant_id: jay.id, project_id: upholstery_tux.id)
      ContestantProject.create(contestant_id: kentaro.id, project_id: upholstery_tux.id)

      visit "/projects/#{news_chic.id}"
      
      within("#avg_contestant_exp-#{news_chic.id}") do
        expect(news_chic.contestants.avg_contestant_experience).to eq(11.0)
      end

      visit "/projects/#{upholstery_tux.id}"
      
      within("#avg_contestant_exp-#{upholstery_tux.id}") do
        expect(upholstery_tux.contestants.avg_contestant_experience).to eq(10.5)
      end

      expect(page).to have_content("Average Contestant Experience:")
    end
  end

# As a visitor,
# When I visit a project's show page
# I see a form to add a contestant to this project
# When I fill out a field with an existing contestants id
# And hit "Add Contestant To Project"
# I'm taken back to the project's show page
# And I see that the number of contestants has increased by 1
# And when I visit the contestants index page
# I see that project listed under that contestant's name

  describe 'Extension 2' do
    it 'can add a contestant to a project' do
      jay = Contestant.create!(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
      gretchen = Contestant.create!(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
      recycled_material_challenge = Challenge.create!(theme: "Recycled Material", project_budget: 1000)
      news_chic = recycled_material_challenge.projects.create!(name: "News Chic", material: "Newspaper")
      ContestantProject.create!(contestant_id: jay.id, project_id: news_chic.id)
      ContestantProject.create!(contestant_id: gretchen.id, project_id: news_chic.id)

      visit "/projects/#{news_chic.id}"
      fill_in('Contestant identification', with: "#{jay.id}")
      click_on 'Add Contestant To Project'

      expect(current_path).to eq("/projects/#{news_chic.id}")
    end
    
    it 'will update the contestant count on the project show page' do
      jay = Contestant.create!(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
      gretchen = Contestant.create!(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
      recycled_material_challenge = Challenge.create!(theme: "Recycled Material", project_budget: 1000)
      news_chic = recycled_material_challenge.projects.create!(name: "News Chic", material: "Newspaper")
      ContestantProject.create!(contestant_id: jay.id, project_id: news_chic.id)
      ContestantProject.create!(contestant_id: gretchen.id, project_id: news_chic.id)
      
      visit "/projects/#{news_chic.id}"
      
      expect(news_chic.contestant_count).to eq(2)
      expect(page).to have_content("Number of contestants: 2")
      
      kentaro = Contestant.create!(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
      
      fill_in('Contestant identification', with: kentaro.id)
      click_on 'Add Contestant To Project'
      
      expect(news_chic.contestant_count).to eq(3)
      expect(page).to have_content("Number of contestants: 3")
      expect(current_path).to eq("/projects/#{news_chic.id}")
    end 
  end
end