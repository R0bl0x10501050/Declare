-- Name: Declare
-- Made by: R0bl0x10501050
-- Repo: https://github.com/R0bl0x10501050/Declare

local function hasProperty(object, propertyName)
	local success, _ = pcall(function() 
		object[propertyName] = object[propertyName]
	end)
	return success
end

local function hasEvent(object, eventName)
	local success, _ = pcall(function() 
		local t = object[eventName]:Connect(function() end)
		t:Disconnect()
	end)
	return success
end

local Declare = {}

function Declare.Insert(ClassName)
	if not ClassName then
		error("[Declare] - A ClassName must be provided!")
	end
	
	return function(tbl)
		local tree = Instance.new(ClassName)
		
		for k, v in pairs(tbl) do
			if table.find({"Class", "ClassName", "Children"}, k) then
				continue
			elseif k:match("Event:(%a*)") then
				local eventName = k:match("Event:(%a*)")
				if not hasEvent(tree, eventName) then
					continue
				end
				if typeof(v) ~= "function" then
					error("[Declare] - Event listener for "..eventName.." must be a function!")
				end
				tree[eventName]:Connect(v)
			else
				tree[k] = v
			end
		end
		
		if tbl['Children'] and typeof(tbl['Children']) == 'table' then
			for _, child in ipairs(tbl['Children']) do
				child.Parent = tree
			end
		end
		
		return tree
	end
end

function Declare.Template(ClassName)
	if not ClassName then
		error("[Declare] - A ClassName must be provided!")
	end
	
	return function(tbl)
		local tree = Instance.new(ClassName)
		local connections = {}
		
		do -- To kill variable scope so k and v can be reused
			for k, v in pairs(tbl) do
				if table.find({"Class", "ClassName", "Children"}, k) then
					continue
				elseif k:match("Event:%w*") then
					local eventName = k:match("Event:(%w*)")
					if not hasEvent(tree, eventName) then
						print(tree, eventName)
						continue
					end
					if typeof(v) ~= "function" then
						error("[Declare] - Event listener for "..eventName.." must be a function!")
					end
					table.insert(connections, {
						eventName = eventName,
						callback = v
					})
				else
					tree[k] = v
				end
			end
			
			if tbl['Children'] and typeof(tbl['Children']) == 'table' then
				for _, child in ipairs(tbl['Children']) do
					child.Parent = tree
				end
			end
		end
		
		return function(newTbl)
			tree = tree:Clone()
			for newK, newV in pairs(newTbl) do
				if table.find({"Class", "ClassName", "Children"}, newK) then
					continue
				elseif newK:match("Event:%w*") then
					local eventName = newK:match("Event:(%w*)")
					if not hasEvent(tree, eventName) then
						continue
					end
					if typeof(newV) ~= "function" then
						error("[Declare] - Event listener for "..eventName.." must be a function!")
					end
					table.insert(connections, {
						eventName = eventName,
						callback = newV
					})
				else
					tree[newK] = newV
				end
			end
			
			for _, v in ipairs(connections) do
				tree[v.eventName]:Connect(v.callback)
			end
			
			if newTbl['Children'] and typeof(newTbl['Children']) == 'table' then
				for _, child in ipairs(newTbl['Children']) do
					child.Parent = tree
				end
			end
			
			return tree
		end
	end
end

function Declare.Mount(tree, parent)
	tree.Parent = parent
end

return Declare
