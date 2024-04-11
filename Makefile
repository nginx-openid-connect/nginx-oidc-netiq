.PHONY: start watch down clean clean-cache unit-test functional-test test

start:
	bash generate-cert.sh
	docker-compose up -d

ps:
	docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Ports}}\t{{.Names}}"

watch:
	watch 'docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Ports}}\t{{.Names}}"'

down:
	docker-compose down

clean-netiq: 
	docker kill nginx-oidc-netiq
	docker rmi --force nginx_oidc_netiq

clean-keycloak:
	docker kill keycloak
	docker rmi --force quay.io/keycloak/keycloak:24.0.2

clean: 
	docker kill $$(docker ps -q) 2> /dev/null || true
	docker system prune -a
	docker volume rm $(docker volume ls -qf dangling=true)
