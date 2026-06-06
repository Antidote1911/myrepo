#!/usr/bin/env bash
set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
PKG_DIR="$REPO_DIR/x86_64"
DB_NAME="packarch"

echo "==> Reconstruction de la base de données..."
cd "$PKG_DIR"
rm -f "$DB_NAME".db "$DB_NAME".db.tar.gz "$DB_NAME".files "$DB_NAME".files.tar.gz
repo-add -n -R "$DB_NAME.db.tar.gz" *.pkg.tar.zst
echo "==> Base de données mise à jour."

echo "==> Envoi sur GitHub..."
cd "$REPO_DIR"
git add -A
git commit -m "update $(date '+%Y-%m-%d %H:%M')"
git push --force-with-lease origin master
echo "==> Dépôt synchronisé."
