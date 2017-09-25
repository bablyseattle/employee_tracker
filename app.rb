require("sinatra")
require("sinatra/reloader")
require("sinatra/activerecord")
also_reload("lib/**/*.rb")
require("./lib/department")
require("./lib/employee")
require("pg")

get('/') do
  @departments= Department.all
  erb :index
end
post('/') do
  description = params.fetch("description")
  department = Department.new(:description => description)
  department.save
  redirect '/'
end
get('/:department_id') do
@employees = Employees.find(params.fetch("department_id").to_i())
erb :employee
end

post('/:department_id') do
  name = params.fetch("name")
  employee = Employee.new(:name => name)
  employee.save
  redirect '/:department_id'
end
