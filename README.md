# 環境構築

## GitHubにリモートリポジトリを作成
- `Initialize this repository with:` は以下を指定する
  - `Add a README file`にチェックを入れる
  - Add .gitignore下のセレクトボックスで`.gitignore template: Rails`を選択
- リポジトリ作成後ローカルにクローンする
***
## ローカルにクローンする方法
リモートリポジトリで`code▼`を選択しHTTPSかSSHをコピー<br>
ローカルで作成したいディレクトリまで移動し以下を入力<br>
- HTTPSの場合
```
git clone https://github.com/YOUR-USERNAME/YOUR-REPOSITORY
```
- SSHの場合
```
git clone git@github.com:/YOUR-USERNAME/YOUR-REPOSITORY
```
***
## アプリを作成
バージョンは、Rails6系のうち最新を使用<br>
※ リモートリポジトリをクローンしたディレクトリで実行すること
- 最新のバージョンをインストール
```
gem install rails -v 6.1.6
```
- バージョンの確認コマンド
```
gem list rails
```
- アプリを作成
```
rails _6.1.6_ new . --database=postgresql --skip-bundle --skip-test
```
rails newの際に、README、.gitignoreを更新するか聞かれるので
  README → Yキー、.gitignore → nキーを入力する
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
- バージョンの確認コマンド
```
postgres --version
```
- postgresqlの起動コマンド
```
brew services start postgresql
```
### postgresqlを`postgres`コマンドで起動できるようPGDATA設定
- ターミナルで以下を実行
```
vi ~/.zshrc
```
- 開いたファイルに以下の環境変数を追記
```
export PGDATA='/usr/local/var/postgres'
```
- 変更内容を反映させる
```
source ~./zshrc
```
※ ターミナルでbashを使っている場合 `.zshrc` → `.bashrc`に変更すること
- postgresqlの起動コマンド(短縮)
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
- ロールを作成
```
CREATE ROLE 名前;
```
- ロールが作成できているか一覧表示
```
\du
```
#### ログイン権限を渡す
- ロール作成時にログイン権限を渡す
```
CREATE ROLE 名前 LOGIN;
　　or
CREATE USER 名前;
```
※ どちらかのコマンドを実行。両方のコマンドを実行すると「既にユーザーが存在している」とエラーが出るので注意
- 既存のロールにログイン権限を渡す
```
ALTER ROLE 名前 LOGIN;
```
#### DB作成の権限を渡す
- ロール作成時にDB作成の権限を渡す
```
CREATE ROLE 名前 CREATEDB;
```
- 既存のロールにDB作成の権限を渡す
```
ALTER ROLE 名前 CREATEDB;
```

***
### データベース作成
```
bundle exec rails db:create
```
### 起動し`localhost:3000`へアクセス
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
