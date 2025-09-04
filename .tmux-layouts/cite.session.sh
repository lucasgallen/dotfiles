# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
#session_root "~/Projects/cite"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "cite"; then
  window_root "~/git/work/privacy-services-platform"

  new_window "dev"
  select_window 0
  split_h 50
  select_pane 0
  run_cmd "npm run dev"
  select_pane 1
  run_cmd "node websocket-dev-server.mjs"

  new_window "git"
  select_window 1
  run_cmd "git status"

  new_window "nvim"
  select_window 2
  run_cmd "nvim"

  new_window "db"

  new_window "terraform"
  select_window 4
  run_cmd "cd terraform/dev"
  run_cmd "aws sso login"
  run_cmd "npm run terra:out terraform/dev"

  select_window 3
  run_cmd "sudo npm run db:start && npm run db:seed:dev"
fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
