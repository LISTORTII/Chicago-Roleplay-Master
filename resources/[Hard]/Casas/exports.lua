addEventHandler("onResourceStart", resourceRoot, function ( )
	dbCasas = Connection("sqlite", "Casas.db")
	if dbCasas then
		print("Conectado a la base de datos 'Casas.db'")
	else
		print("Error al conectar con la DB")
	end
end);

function databaseQuery( ... )
	if dbCasas then
		local s = dbCasas:query(...)
		local result = s:poll(-1)
		return result
	else
		return false
	end
end

function databaseUpdate( ... )
	if dbCasas then
		return dbCasas:exec(...)
	else
		return false
	end
end

function databaseInsert( ... )
	if dbCasas then
		return dbCasas:exec(...)
	else
		return false
	end
end

function databaseDelete( ... )
	if dbCasas then
		return dbCasas:exec(...)
	else
		return false
	end
end
