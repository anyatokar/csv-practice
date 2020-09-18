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
    if athlete_hash["Medal"] == "Gold"
      gold_medalist_array << athlete_hash
    end
  end
  return gold_medalist_array
end


# Write descriptions for 2 test cases that test the core functionality, and are nominal tests.
#   1) each hash doesn't include any key that isn't required
#   2) each hash includes the correct number of key-value pairs

# In the tests, how do we "Arrange" and setup the data of all Olympic athletes?
#   olympic_athletes = get_all_olympic_athletes(OLYMPIC_DATA_FILENAME)
#
# How did we "Assert" and check that the method returns a hash?
#   expect(athlete).must_be_instance_of Hash
#
# How did we "Assert" and check that the method returns an accurate hash?
#    there's already an expected totals hash with the values calculated.
#    it is used to compare against:
#       expected_totals.each do |expected_team, expected_count|
#         expect(total_medals[expected_team]).must_equal expected_count
#
# What nominal tests did we miss?
#   could test to see that select athletes are included.
#   could test medal counts for a specific country
#
# Write descriptions for 2 edge test cases that aren't in our tests. (Don't write the tests, just come up with your test cases for practice!)
# TDD the implementation of total_medals_per_team(olympic_data) with the provided tests.
#   1) test for misspelling
#   2) test for different capitalization of the same thing

