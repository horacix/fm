# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'nokogiri'
require 'open-uri'
url = 'http://www.aafm.cl/estadisticas_publico/valor_cuota_diaria.php?consulta=4'
doc = Nokogiri::HTML(open(url))

adm = Administrator.first
puts a.name

doc.css('a').each do |link|
  if link['href'] =~ /\b.+.pdf/
    begin
      File.open('filename_to_save_to.pdf', 'wb') do |file|
        downloaded_file = open(link['href'])
        file.write(downloaded_file.read())
      end
    rescue => ex
      puts "Something went wrong...."
    end
  end
end