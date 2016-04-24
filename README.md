# Vim::FactoryのAnsible Playbook

## 検証済み実行環境
- MacOS 10.9.5
- Ansible 1.8.2

## Ansibleのインストール
Mac OS
```
$ brew install ansible
```

## 使い方
### 開発環境へのインストール
下記コマンド実行後、webとttyのconfigファイルを書き換える必要がある
```
$ ansible-playbook -i development site.yml -u deploy -K -vvvv --ask-vault-pass
```

### 本番環境へのインストール
```
$ ansible-playbook -i production site.yml -u deploy -K -vvvv --ask-vault-pass
```

## serverspec
```
$ bundle exec rake -T
rake serverspec        # Run serverspec to all hosts
rake serverspec:app    # Run serverspec to app.vimfactory-test.com
rake serverspec:proxy  # Run serverspec to proxy.vimfactory-test.com

$ bundle exec rake serverspec SSH_CONFIG=sshconfig ENVIRONMENT=development ASK_SUDO_PASSWORD=true
$ bundle exec rake serverspec SSH_CONFIG=sshconfig ENVIRONMENT=production ASK_SUDO_PASSWORD=true

// sudoパスワードの入力が面倒な場合は、環境変数にセットするか下記のコマンドのように指定する
$ bundle exec rake serverspec SSH_CONFIG=sshconfig ENVIRONMENT=development SUDO_PASSWORD=xxxxxxxxx
```
