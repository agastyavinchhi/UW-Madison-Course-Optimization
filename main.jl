using CSV
using DataFrames

df = CSV.read("uwcourses.csv", DataFrame)

list_courses = []
for col in eachcol(df)
    for course in col
        if ismissing(course) == true
            continue
        end
        push!(list_courses, course)
    end
end
final_list_courses = collect(Set(list_courses)) 

println(final_list_courses)