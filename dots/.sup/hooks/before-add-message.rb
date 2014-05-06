if message.list_address
    addr = message.list_address
    if addr.is_a? Person
        addr = message.list_address.email
    end

    return unless addr.is_a? String

    if addr.start_with? 'gensim@googlegroups.com'
        message.add_label :gensim
    elsif addr.start_with? 'arch-announce@archlinux.org'
        message.add_label :archlinux
    end
end

#sup-heliotrope/sup <sup@noreply.github.com>

if message.recipients.any? { |person| person.email =~ /.*@noreply\.github\.com/i }
    message.add_label :github
end
