require 'spreadsheet'
require 'open-uri'

def load_fund(adm, run, fondo, tipo)
  fondo.delete! '(*)'
  if fondo =~ /^(.*) ([^ ]+)  $/
    nombre = $1
    serie = $2
  else
    nombre = fondo.strip
    serie = 'UNICA'
  end
  puts "#{nombre}/#{serie}"

  split_run = run.split('-')
  f = adm.funds.find_or_create_by_run_and_run_dv_and_name(split_run[0], split_run[1], nombre)
  if f.fund_type.nil?
    f.fund_type = FundType.find_or_create_by_name(tipo)
    f.save!
  end
  s = adm.series.find_or_create_by_name(serie)
  sf = f.specific_funds.find_or_create_by_series_id(s.id)

  return sf
end

date = 2.day.ago.to_date
url = "http://www.aafm.cl/estadisticas_publico/resumen_excel.php?dia=#{date.day}&mes=#{date.month}&anio=#{date.year}"

doc = open(url)
book = Spreadsheet.open(doc)
sheet = book.worksheet 0

Administrator.all.each do |adm|
  puts 'Administradora: ' + adm.name, 'Fecha: ' + date
  sheet.each 12 do |row|
    a = row[0]
    if a.eql?(adm.name)
      run = row[1]
      fondo = row[2]
      cuota = row[6]
      tipo = row[8]
      specific_fund = load_fund(adm, run, fondo, tipo)
      specific_fund.save_quote(date, cuota)
    end
  end
end

