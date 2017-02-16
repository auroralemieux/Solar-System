
 # Get creative! Give each instance of Planet at least five attributes. These could be diameters, mass, moons... whatever!
# Allow these attributes to be set using a hash in initialize.
# You should be able to create many different planets with different properties, like Mercury, Venus, Earth, Mars, Jupiter, etc.

# this defines the SolarSystem class
class SolarSystem

  attr_reader :planets, :formation_year
  attr_accessor :name

  def initialize(name, formation_year)
    @name = name.capitalize
    @planets = []
    @formation_year = formation_year
    # print_planets
  end

  # this is how you add new planets to your SolarSystem
  # initially there are no planets
  def add_planet(new_planet)
    @planets << new_planet
  end

  # add a method to determine the distance from any other planet
  def distance_from_other_planets(first_planet, second_planet)
    puts "\n#{first_planet.name} is #{(first_planet.distance_from_the_sun_in_miles - second_planet.distance_from_the_sun_in_miles).abs} miles from #{second_planet.name}.\n\n"
  end

  # returns the local year of the planet based on it's rotation since the beginning of the solar system
  def years_since_beginning_of_solar_system
    @planets.each do |planet|
      days_since_formation = @formation_year / 365.26
      local_year_of_planet = days_since_formation * planet.rate_of_solar_rotation
      puts "On #{planet.name}, the current year is #{local_year_of_planet.round(0)}."
    end
  end

  # once you've got some planets added it will print their information
  # pulling from the planet's data
  def print_planets
    puts "\n#{@name} has #{@planets.length} planets and was formed #{@formation_year} years ago."
    puts "\nHere are the planets in the #{@name} solar system:\n\n"
    @planets.each do |planet|
      puts "#{planet.print_planet_data}"
    end
    puts "\n"
  end

  def continue_or_quit
    print "Would you like to view another planet? (y/n): "
    continue = gets.chomp
    case continue
    when "y", "yes"
      pick_a_planet
    when "n", "no"
      exit
    else
      continue_or_quit
    end
  end

  # repeated options to ask about a planet
  def pick_a_planet
    display_planet = nil
    puts "\nPlease choose from the following list of planets."
    planet_names = []
    @planets.each do |planet| # gets the names of the planets that currently exist in solar system
      planet_names << planet.name
    end
    puts planet_names

    # get planet choice and validate
    print "\nWhich planet would you like to \"learn\" more about? "
    planet_choice = gets.chomp.capitalize
    planet_choice = planet_choice.gsub(" ", "")
    while !planet_names.include? planet_choice
      print "Sorry, which planet? "
      planet_choice = gets.chomp.capitalize
    end

    # print the planet info for the chosen planet
    @planets.each do |planet|
      if planet.name == planet_choice
        puts planet.print_planet_data
      end
    end

    continue_or_quit
  end

  # user is greeted and then goes to pick a planet
  def welcome
    puts "Welcome to my Alternative Planet Facts program!"
    puts "This is a useful tool for wasting time!"
    pick_a_planet
  end

end # this ends the solar system class

# this defines the Planet class
class Planet

  attr_reader :moons, :rings, :surface_temp, :diameter_in_earths, :rate_of_solar_rotation, :distance_from_the_sun_in_miles
  attr_accessor :name

  def initialize(name, planet_hash)
    @name = name.capitalize
    @planet_hash = planet_hash
    @moons = @planet_hash[@name][:moons]
    @rings = @planet_hash[@name][:rings]
    @surface_temp = @planet_hash[@name][:surface_temp]
    @diameter_in_earths = @planet_hash[@name][:diameter_in_earths]
    @rate_of_solar_rotation = @planet_hash[@name][:rate_of_solar_rotation]
    @distance_from_the_sun_in_miles = @planet_hash[@name][:distance_from_the_sun_in_miles]
    # print_planet_data
  end

  # if the data hash you use to create this planet object
  # does not contain your planet name, this is false
  def validate_planet
    if @planet_hash.key? @name
      return true
    elsif planet != @name
      puts "Sorry, I don't know anything about planet #{@name}!"
      return false
    end
  end

  # pretty printing your planet's info!
  def print_planet_data

    if validate_planet

      # print the moon info
      print "#{@name} has #{@moons.length} moon(s) and has"

      # rings information
      if @rings
        puts " rings!"
      else
        puts " no rings."
      end

      # other data here
      puts "#{@name} is #{@surface_temp} and is as wide as #{@diameter_in_earths} Earth(s)!"
      puts "#{@name}'s rate of solar rotation is #{@rate_of_solar_rotation} Earth days."
      puts "It's #{@distance_from_the_sun_in_miles} miles from the sun!"

    end
  end



end # end of Planet class

# this is the data used to check when creating planets for our solar system
planets_data = {
  "Earth" => {
    moons: ["Luna"],
    rings: false,
    surface_temp: "fine",
    diameter_in_earths: 1,
    rate_of_solar_rotation: 365.26,
    distance_from_the_sun_in_miles: 93_000_000
  },
  "Mercury" => {
    moons: [],
    rings: false,
    surface_temp: "very hot",
    diameter_in_earths: 10.75,
    rate_of_solar_rotation: 58.7,
    distance_from_the_sun_in_miles: 36_000_000
  },
  "Venus" => {
    moons: [],
    rings: false,
    surface_temp: "super hot",
    diameter_in_earths: 2.5,
    rate_of_solar_rotation: 224.68,
    distance_from_the_sun_in_miles: 67_200_000
  },
  "Mars" => {
    moons: ["Deimos", "Phobos"],
    rings: false,
    surface_temp: "middling",
    diameter_in_earths: 1,
    rate_of_solar_rotation: 686.98,
    distance_from_the_sun_in_miles: 141_600_000
  },
  "Jupiter" => {
    moons: ["Many moons"],
    rings: false,
    surface_temp: "getting colder",
    diameter_in_earths: 1,
    rate_of_solar_rotation: 11.862 * 365.26,
    distance_from_the_sun_in_miles: 483_600_000
  },
  "Saturn" => {
    moons: ["lotsa moons"],
    rings: true,
    surface_temp: "still getting colder",
    diameter_in_earths: 1,
    rate_of_solar_rotation: 29.456 * 365.26,
    distance_from_the_sun_in_miles: 886_700_000
  },
  "Neptune" => {
    moons: ["so many moons"],
    rings: true,
    surface_temp: "even colder",
    diameter_in_earths: 1,
    rate_of_solar_rotation: 164.81 * 365.26,
    distance_from_the_sun_in_miles: 2_794_400_000
  },
  "Uranus" => {
    moons: ["more moons"],
    rings: false,
    surface_temp: "pretty cold",
    diameter_in_earths: 1,
    rate_of_solar_rotation: 84.07 * 365.26,
    distance_from_the_sun_in_miles: 1_784_000_000
  },
  "Pluto" => {
    moons: ["Charon"],
    rings: false,
    surface_temp: "yikes, super cold",
    diameter_in_earths: 1,
    rate_of_solar_rotation: 247.7 * 365.26,
    distance_from_the_sun_in_miles: 3_674_500_000
  }
}

neptune = Planet.new("neptune", planets_data)
saturn = Planet.new("saturn", planets_data)
earth = Planet.new("earth", planets_data)
venus = Planet.new("venus", planets_data)
mars = Planet.new("mars", planets_data)

milky_way = SolarSystem.new("milky way", 5_000_000_000)

milky_way.add_planet(neptune)
milky_way.add_planet(saturn)
milky_way.add_planet(earth)
milky_way.add_planet(venus)
milky_way.add_planet(mars)

milky_way.print_planets
milky_way.years_since_beginning_of_solar_system
milky_way.distance_from_other_planets(venus,mars)

milky_way.welcome
