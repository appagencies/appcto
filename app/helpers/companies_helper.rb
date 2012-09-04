module CompaniesHelper

  BUDGETS = [["Any budget", 0],["Below $5,000", 1],["$5,000 - $15,000", 2], ["$15,000 - $50,000", 3], ["Over $50,000", 4]]

  PLATFORMS = ["ios","android","blackberry","windows"]

  def all_countries_and_regions

    Carmen::Country.all.map do |country|
      country.name
      if country.subregions?
        country.subregions do |region|
          region.name
        end
      end
    end
  end

end
