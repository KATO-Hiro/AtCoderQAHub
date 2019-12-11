function docker_usage
  # See:
  # https://qiita.com/wakaba260/items/0a00c6c3aa7183a1cb99#%E3%83%A9%E3%83%83%E3%83%91%E3%83%BC%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88%E3%82%92%E6%9B%B8%E3%81%8F
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
