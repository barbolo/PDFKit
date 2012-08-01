#!/usr/bin/env ruby

$:.unshift File.expand_path( "#{File.dirname(__FILE__)}/../lib" )
require 'pdfkit'
format=ARGV.first || "png"

#PDFKit.configure do |config|
#  config.wkhtmltopdf   = File.dirname(__FILE__)+"/wkhtmltopdf"
#  config.wkhtmltoimage = File.dirname(__FILE__)+"/wkhtmltoimage"
#end

options                         = Hash.new
options['no-stop-slow-scripts'] = true

case format
  when 'pdf'
    convert = :to_pdf
  else
    convert = "to_#{format}".to_sym
    options[:width]   = 254
    options[:quality] = 10
end

o = PDFKit.new( File.new('thumbnail.html'), options)

File.open("thumbnail.#{format}","w+") do |f|
  f.puts o.send( *convert )
end

puts "WROTE: thumbnail.#{format}"
