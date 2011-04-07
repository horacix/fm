require 'spreadsheet'
require 'open-uri'

def load_fund(adm, run, fondo)
  fondo.delete! '(*)'
  if fondo =~ /^(.*) ([^ ]+)$/
    nombre = $1
    serie = $2.delete('.')
  else
    nombre = fondo.strip
    serie = 'UNICA'
  end
  puts "#{nombre}/#{serie}"

  split_run = run.split('-')
  f = adm.funds.find_by_run(split_run[0])
  if f.nil?
    return nil
  end
  s = adm.series.find_by_name(serie)
  if s.nil?
    return nil
  end
  sf = f.specific_funds.find_by_series_id(s.id)

  return sf
end

adm = Administrator.find_by_name(ARGV[0])
from = 5.year.ago.to_date
unless ARGV[1].nil?
  from = Date.parse(ARGV[1])
end
to = 1.day.ago.to_date
unless ARGV[2].nil?
  to = Date.parse(ARGV[2])
end

from.upto(to) do |date|
  puts adm.name + '/' + date.to_s
  s_date = date.to_s.delete("-")
  url = "http://www.aafm.cl/tecnoera/index.php?clase=informe&metodo=rentabilidad_excel&adm=#{adm.code}&tipo=&inv=&fecha=#{s_date}"
  doc = open(url)
  book = Spreadsheet.open(doc)
  sheet = book.worksheet 0
  sheet.each 12 do |row|
    a = row[0]
    if a.eql?(adm.name)
      run = row[1]
      fondo = row[2]
      cuota = row[3]
      specific_fund = load_fund(adm, run, fondo)
      unless specific_fund.nil?
        specific_fund.save_quote(date, cuota)
      end
    end
  end
end

