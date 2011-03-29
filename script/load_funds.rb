require 'spreadsheet'
require 'open-uri'

def load_fund(adm, run, fondo)
  split_run = run.split('-')
  if fondo =~ /^(.*) ([^ ]+)$/
    nombre = $1
    serie = $2
  else
    nombre = fondo.strip
    serie = 'UNICA'
  end
  puts "#{nombre}/#{serie}"
  f = adm.funds.find_or_create_by_run_and_run_dv_and_name(split_run[0], split_run[1], nombre)
  s = Series.find_or_create_by_name(serie)
  sf = f.specific_funds.find_or_create_by_series_id(s.id)

  return sf
end

Time::DATE_FORMATS[:query] = "%Y%m%d"
adm = Administrator.first
date = 2.day.ago
s_date = date.to_s(:query)
puts 'Administradora: ' + adm.name, 'Fecha: ' + s_date
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
    specific_fund.save_quote(date, cuota)
  end
end

