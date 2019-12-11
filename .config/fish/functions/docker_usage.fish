function docker_usage
  echo "Commands:"
  echo "  init            Initialize image."
  echo "  build           Build or rebuild image."
  echo "  start           Run the server in the background."
  echo "  stop            Stop the server."
  echo "  dstatus         View container(s) status."
  echo "  restart         Restart server."
  echo "  logs            View the server logs in the background."
  echo "  up              Run the server in the foreground."
  echo "  run_rspec       Run tests with RSpec."
  echo ""

  echo "  open_container  Open a container with bash."
  echo "  open_rails_db   View database using rails command."
end
