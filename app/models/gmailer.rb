module Gmailer
  class Fetcher

    def self.get_mails(token, email, due, amount, from)
      debts = []
      gmail = Gmail.connect(:xoauth2, email, token)
      gmail.inbox.find(
        after: Date.today.beginning_of_month, from: from
      ).each do |m|
        m.attachments.each do |a|
          debts << parse_file(a, due, amount) if '.pdf'.in?(a.filename)
        end
      end
      gmail.logout
      debts
    end

    def self.parse_file(a, due, amount)
      data = {}
      file = Tempfile.new()
      file.write(a.body.decoded.force_encoding('UTF-8'))
      pdf = PDF::Reader.new(file.path)
      pdf.pages.each do |page|
        if !data['due']
          data['due'] = /\d+\.\d+\.\d+/.match(page.text.split(due)[1]).to_s
        end
        if !data['am']
          data['am'] = /\d+\.\d+/.match(page.text.split(amount)[1]).to_s
        end
      end
      file.close
      file.unlink
      data
    end
  end
end
