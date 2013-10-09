require "open-uri"

class WorkplaceCrawler
  
  attr_reader :root_host, :root_path
  
  SUB_PAGES = %w(gebaeude-a-am gebaeude-b-c-d gebaeude-h-j-l gebaeude-o gebaeude-p-sp hnifuerstenallee-gebaeude-f gebaeude-bi)
  
  def initialize(root_host = "http://www.uni-paderborn.de", root_path = "/studium/abi-2013/wir-sind-vorbereitet/mehr-raum/studentische-arbeitsplaetze/")
    @root_host = root_host
    @root_path = root_path
  end
  
  def run!
    urls.each do |url|
      crawl_buildings_and_workplaces(url)
    end
  end
  
  def urls
    prefix = root_host + root_path
    SUB_PAGES.map do |page|
      prefix + page
    end
  end
  
  def crawl_buildings_and_workplaces(url)
    puts "opening #{url}..."
    doc = Nokogiri::HTML(open(url))
    buildings = doc.css("div#content2 h1").map(&:content).map(&:strip)
    buildings = buildings.drop(1) unless buildings.length == 1
    puts 'found buildings: ' + buildings.join(', ')
    workplace_tables = doc.css("div#content2 table").map do |table|
      table.css("tbody")
    end
    workplace_tables.each_with_index do |table, index|
      building = buildings[index]
      next if building.nil?
      parse_table_for_building(table, building)
    end
  end
  
  def parse_table_for_building(table, _building)
    print "parsing building #{_building}... "
    building = Building.find_or_create_by_name(_building)
    workspace_objects = table.css("tr").map do |row|
      columns = row.css("td")
      next if columns.length != 5
      floor = columns[0].content.strip
      location = columns[1].content.strip
      image = columns[2].css("img").first.attr("src")
      qty = columns[3].content.strip
      equipments = columns[4].css("img").map {|img| img.attr("src")}.map do |eq_url|
        Equipment.find_or_create_by_image_url(eq_url)
      end.compact
      Workspace.new.tap do |w|
        w.floor = floor
        w.location = location
        w.image_url = image
        w.qty = qty
        w.equipments = equipments
        w.building = building
      end
    end.compact
    if workspace_objects.any?
      building.workspaces.delete_all
      workspace_objects.each(&:save)
      puts 'done'
    else
      puts "no workspaces found for #{_building}"
    end
  end
  
end