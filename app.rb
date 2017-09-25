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
get('/:id') do
@department = Department.find(params[:id].to_i)
@employees = @department.employees
erb :employee
end

post('/:id') do
  name = params.fetch("name")
  department = Department.find(params['dep_id'].to_i)
  employee = Employee.new(:name => name, :department_id => department.id)
  employee.save
  redirect back
end

get("/:id/edit") do
  @department = Department.find(params.fetch("id").to_i())
  erb(:department_edit)
end

patch("/departments/:id") do
  name = params.fetch("name")
  @department = Department.find(params.fetch("id").to_i())
  @department.update({:department => department})
  erb(:departments)
end
