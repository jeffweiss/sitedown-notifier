# sitedown-notifier
Elixir app which monitors web sites for downtime.

## Goals
- Use supervised GenServer processes to monitor pages on the web by URL. 
- Initialze new workers from command line (eventually a web UI).
- When web pages become unresponsive (status code not 200), notify a user by email / SMS / whatever.
