FROM mysql:5.7

HEALTHCHECK --interval=30s --timeout=5s --retries=3 CMD mysqladmin ping -h localhost -u root -p"$MYSQL_ROOT_PASSWORD" || exit 1
