require "open-uri"

class WorkplaceCrawler
  
  attr_reader :root_host, :root_path
  
  SUB_PAGES = %w(gebaeude-a-am gebaeude-b-c-d gebaeude-h-j-l gebaeude-o gebaeude-p-sp hnifuerstenallee-gebaeude-f gebaeude-bi)
  
  def initialize(root_host = "http://www.uni-paderborn.de", root_path = "/studium/abi-2013/wir-sind-vorbereitet/mehr-raum/studentische-arbeitsplaetze/")
    @root_host = root_host
    @root_path = root_path
  end
  
  def each_url
    prefix = root_host + root_path
    SUB_PAGES.map do |page|
      prefix + page
    end.each
  end
  
  def crawl_buildings_and_workplaces(url)
    doc = Nokogiri::HTML(open(url))
    buildings = doc.css("div.content2 h1").map(&:content).map(&:strip)
    workplace_tables = doc.css("div.content2 table").map do |table|
      table.css("tbody")
    end
    workplace_tables.each_with_index do |table, index|
      building = buildings[index]
      next if building.nil?
      parse_table_for_building(table, building)
    end
  end
  
  def parse_table_for_building(table, _building)
    building = Building.find_or_create_by_name(_building)
    workspace_objects = table.css("tr").map do |row|
      columns = row.css("td")
      next if columns.length != 5
      floor = columns[0].content.strip
      location = columns[1].content.strip
      image = columns[2].css("img").first.attr("src")
      qty = columns[3].content.strip
      equipments = columns[4].css("img").map {|img| attr("src")}.map do |eq_url|
        Equipment.find_or_create_by_image_url("eq_url")
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
    workspace_objects.each(&:save!)
  end
  
end