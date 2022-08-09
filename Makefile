run:
	go run ./cmd/api

migration:
	@echo 'Creating migration files for ${name}...'
	migrate create -seq -ext=.sql -dir=./migrations ${name}

psql:
	psql ${GREENLIGHT_DB_DSN}

up:
	@echo "running up migrations..."
	migrate -path ./migrations -database ${GREENLIGHT_DB_DSN} up