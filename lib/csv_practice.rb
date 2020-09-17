require 'csv'
require 'awesome_print'



def get_all_olympic_athletes(filename)
  required_fields = ["ID", "Name", "Height", "Team", "Year", "City", "Sport", "Event", "Medal"]
  athlete_array_of_hashes = CSV.read(filename, headers: true).map { |row| row.to_h} # {&:to_h}

  athlete_array_of_hashes.each do |athlete_hash|
    athlete_hash.select! { |category, value| required_fields.include?(category) }
  end
  return athlete_array_of_hashes
end

def total_medals_per_team(athlete_array_of_hashes)
  medal_count = Hash.new(0)
  athlete_array_of_hashes.each do |athlete_hash|
    if athlete_hash["Medal"] != "NA"
      medal_count[athlete_hash["Team"]] += 1
    end
  end
  return medal_count
end

def get_all_gold_medalists(athlete_array_of_hashes)
  gold_medalist_array = Array.new

  athlete_array_of_hashes.each do |athlete_hash|
    if athlete_hash["Medal"] != "Gold"
      gold_medalist_array << athlete_hash["Name"]
    end
  end
  return gold_medalist_array
end

