function init
  # See:
  # https://docs.docker.com/compose/reference/down/
  docker-compose down --volumes --remove-orphans --rmi all
  build
  start
  sleep 60
  docker-compose exec web rails db:create db:migrate
end
