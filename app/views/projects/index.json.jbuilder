json.array! @projects do |project|
	json.id project.id
	json.name project.name
	json.issues_count project.issues.size
	json.user_id project.user_id
end