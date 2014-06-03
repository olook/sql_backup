# encoding: utf-8

##
# Backup Generated: sql_backup
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t sql_backup [-c <path_to_configuration_file>]
#
# For more information about Backup's components, see the documentation at:
# http://meskyanichi.github.io/backup
#
Model.new(:sql_backup, 'Backup da base de aplicação') do

  ##
  # MySQL [Database]
  #
  database MySQL do |db|
    # To dump all databases, set `db.name = :all` (or leave blank)
    db.name               = "olook_production"
    db.username           = "olook"
    db.password           = "1zPp8xk"
    db.host               = "olookdb1.ct2t45qjbvrd.us-east-1.rds.amazonaws.com"
    db.port               = 3306
    # db.socket             = "/tmp/mysql.sock"
    # Note: when using `skip_tables` with the `db.name = :all` option,
    # table names should be prefixed with a database name.
    # e.g. ["db_name.table_to_skip", ...]
    db.skip_tables        = ['sessions', 'carts_backup']
    #db.only_tables        = []
    db.additional_options = ["--quick", "--single-transaction", "--compact", "--compress"]
  end

  ##
  # Amazon Simple Storage Service [Storage]
  #
  store_with S3 do |s3|
    # AWS Credentials
    s3.access_key_id     = "AKIAJ2WH3XLYA24UTAJQ"
    s3.secret_access_key = "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"
    # Or, to use a IAM Profile:
    # s3.use_iam_profile = true

    s3.region            = "us-east-1"
    s3.bucket            = "olook-sql-backups"
    s3.path              = ""
    s3.keep 		 = 20
  end

  compress_with Bzip2

  ##
  # Mail [Notifier]
  #
  # The default delivery method for Mail Notifiers is 'SMTP'.
  # See the documentation for other delivery options.
  #
  notify_by Mail do |mail|
    mail.on_success           = true
    mail.on_warning           = true
    mail.on_failure           = true

    mail.from                 = "convite@olook.com.br"
    mail.to                   = "nelson.haraguchi@olook.com.br", "tiago.almeida@olook.com.br", "rafael.manoel@olook.com.br"
    mail.address              = "smtp.gmail.com"
    mail.port                 = 587
    mail.domain               = "olook.com.br"
    mail.user_name            = "convite@olook.com.br"
    mail.password             = "olook123abc"
    mail.authentication       = "plain"
    mail.encryption           = :starttls
  end

end
