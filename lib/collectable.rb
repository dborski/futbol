require 'CSV'

module Collectable
  def create_objects(file_path, object)
    csv = CSV.read("#{file_path}", headers: true, header_converters: :symbol )
    csv.map{|row| object.new(row)}
  end
end
