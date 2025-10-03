# Devenv Config
# See: https://devenv.sh/reference/options/

{ pkgs, ... }:

{
  env = {
    DATABASE_URL = "postgresql://pointercrate@localhost/pointercrate";
    LIST_SIZE = 75;
    EXTENDED_LIST_SIZE = 150;
    ROCKET_PORT = 1971;
  };

  packages = [
    pkgs.openssl
    pkgs.sqlx-cli
  ];

  languages.rust.enable = true;

  services.postgres = {
    enable = true;
    listen_addresses = "localhost";
    initialScript = "CREATE USER pointercrate SUPERUSER;";
    initialDatabases = [
      { name = "pointercrate"; }
    ];
  };

  processes = {
    server = {
      exec = "cargo run -p pointercrate-example";
    };
  };
}
