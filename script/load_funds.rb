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
  f = adm.funds.create(:run => split_run[0], :run_dv => split_run[1], :name => nombre)
  if f.id.nil?
    f = adm.funds.where(:run=> split_run[0]).first
  end
  s = f.series.create(:name => serie)
  if s.id.nil?
    s = Series.where(:name => serie).first
    sf = f.specific_funds.create(:series_id => s)
  else
    sf = SpecificFund.where(:fund_id => f, :series_id => s).first
  end
  
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

