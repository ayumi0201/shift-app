# 環境構築

## アプリを作成
バージョンは、Rails6系のうち最新を使用
- アプリを作成
```
rails _6.1.6_ new . --database=postgresql --skip-bundle --skip-test
```
- Gemのインストール
```
bundle install
```
***
## postgresqlの設定
- postgresqlをインストール
```
brew install postgresql
```
- 起動コマンド
```
brew services start postgresql
```
### postgresqlを`postgres`コマンドで起動できるようPGDATA設定
- 環境変数を設定ファイル(`~/.zshrc`)に記載
```
export PGDATA='/usr/local/var/postgres'
```
- 起動コマンド(短縮)
```
postgres
```
（`brew services start postgresql`でも引き続き起動可能）<br>
※ 起動時に以下のエラーが発生する場合がある
- エラー内容
```
DETAIL:  The data directory was initialized by PostgreSQL version 11, which is not compatible with this version 14.0.
```
- 対処法
```
brew postgresql-upgrade-database
```

### ロールの設定
ロール＝ユーザー。ロールごとに権限を付与できる<br>
postgresql立ち上げ時はスーパーユーザー`postgres`(全権限付与)<br>
スーパーユーザーの状態で新しくロールを作成し特定の権限を付与する<br>
- PostgreSQLを起動し別ターミナルでPostgreSQL内に入る
```
psql -d postgres
```
- ロールを作成（ログイン、DB作成の権限付与）
```
CREATE ROLE 名前 LOGIN CREATEDB;
```
- ロールが作成できているか一覧表示
```
\du
```
***
### データベース作成から起動まで
- データベース作成
```
bundle exec rails db:create
```
- マイグレーション実行
```
bundle exec rails db:migrate
```
- シードデータ作成
```
bundle exec rails db:seed
```
-  起動し`localhost:3000`へアクセス
```
bundle exec rails s
```
※ 起動時に以下のエラーが発生する場合がある
- エラー内容
```
Webpacker configuration file not found
```
- 対処法
```
bundle exec rails webpacker:install
```
