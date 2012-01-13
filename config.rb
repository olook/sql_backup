# -*- encoding: utf-8 -*-
#
# MySQL Backup configuration
# AUTHOR: zanst <stephano.zanzin@codeminer42.com>
#

require 'backup'

Backup::Model.new(:sql_backup, 'olook_production database on db2') do
  split_into_chunks_of 4000

  database MySQL do |database|
    database.name = 'olook_production'
    database.username = 'root'
    database.password = '1zPp8xk'
    database.skip_tables = ['sessions']
    database.additional_options = ['--single-transaction --quick'] 
  end

  compress_with Bzip2 do |compression|
    compression.best = true
    compression.fast = false
  end

  store_with S3 do |s3|
    s3.access_key_id = 'AKIAJ2WH3XLYA24UTAJQ'
    s3.secret_access_key = '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'
    s3.bucket = 'olook_sql_backups'
    s3.path = '/'
    s3.keep = 20
  end

  notify_by Mail do |mail|
    mail.on_success = true
    mail.on_warning = true
    mail.on_failure = true

    mail.from = 'convite@olook.com.br'
    mail.to = 'felipe.mattosinho@olook.com.br', 'stephano.zanzin@codeminer42.com', 'hugo.borges@codeminer42.com', 'rinaldi.fonseca@codeminer42.com'
    mail.address = 'smtp.gmail.com'
    mail.port = 587
    mail.domain = 'olook.com.br'
    mail.user_name = 'convite@olook.com.br'
    mail.password = 'olook123abc'
    mail.authentication = 'plain'
    mail.enable_starttls_auto = true
  end
end

