FROM redis:alpine

HEALTHCHECK --interval=30s --timeout=3s --retries=3 CMD redis-cli ping | grep PONG || exit 1
