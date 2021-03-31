class StationNotFoundError < StandardError
end

class Route
  def initialize
    @stations = load_stations
  end

  def find_path(options)
    create_direction_list(
      find_station_index(options[:origin]),
      find_station_index(options[:destination])
    )
    # Using Slice
    # p (starting_station..destination_station)
    # length = (destination_station - starting_station) + 1
    # p @stations.slice(starting_station, length)
  end

  def create_direction_list(origin, destination)
    if destination < origin
      return @stations[destination..origin].reverse
    else
      return @stations[origin..destination]
    end
  end

  def find_station_index(station)
    # puts "Variable station is #{station}"
    station_index = @stations.index(station)
    raise StationNotFoundError if station_index.nil?

    station_index
  end

  def load_stations
    file_path = './stations.txt'
    if File.exist?(file_path)
      @stations = File.read(file_path).split("\n")
    else
      puts 'file not found'
    end
  end
end

options = {
  origin: 'Marshall',
  destination: 'Tarneit'
}

route = Route.new
p route.find_path(options)
