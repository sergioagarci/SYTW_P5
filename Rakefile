desc "Ejecutar el cliente"
task :default do
  sh "rackup"
end

desc "Ejecutar el cliente con la eleccion de Rock"
task :rock do
  sh %q{curl -v 'http://localhost:9292?choice=rock'}
end

desc "Ejecutar el cliente con la eleccion de Paper"
task :paper do
  sh %q{curl -v 'http://localhost:9292?choice=paper'}
end

desc "Ejecutar el cliente con la eleccion de Scissors"
task :scissors do
  sh %q{curl -v 'http://localhost:9292?choice=scissors'}
end

desc "Ejecutar tests con Pruebas Unitarias"
task :test do
  sh "ruby -Ilib -Itest test/tc_rps.rb"
end

desc "Ejecutar tests rspec"
task :spec do
  sh "rspec -Ilib -Ispec spec/rsack/server_spec.rb"
end