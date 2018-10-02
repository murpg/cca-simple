user                  nginx;
worker_processes      1;
pid                   /run/nginx.pid;

events {
  worker_connections  1024;
}

http {
  sendfile      on;

  access_log    /var/log/nginx/access.log;
  error_log     /var/log/nginx/error.log;

  log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                    '$status $body_bytes_sent "$http_referer" '
                    '"$http_user_agent" "$http_x_forwarded_for"';

  server {
    listen 80;

    location / {
      # allow access only from certain IP addresses
      ${allow_application_ip_block}
      deny all;
      try_files $uri $uri/ @backend;
    }

    location /CFIDE {
      deny all;
    }

    location /CFIDE/administrator {
      # allow access only from certain IP addresses
      ${allow_admin_ip_block}
      deny all;
      try_files $uri $uri/ @backend;
    }

    location @backend {
      proxy_pass          http://app:8080;
      proxy_redirect      off;
      proxy_http_version  1.1;
      proxy_set_header    Host                $host;
      proxy_set_header    X-Forwarded-Host    $host;
      proxy_set_header    X-Forwarded-Server  $host;
      proxy_set_header    X-Forwarded-For     $proxy_add_x_forwarded_for;
      proxy_set_header    X-Forwarded-Proto   $scheme;
      proxy_set_header    X-Real-IP           $remote_addr;
    }
  }
}
