if message.has_label? :deleted and message.has_label? :inbox
    mesage.remove_label :deleted
end

if message.list_address
    addr = message.list_address
    if addr.is_a? Person
        addr = message.list_address.email
    end

    return unless addr.is_a? String

    is_junk = False
    addr = addr.downcase
    subj = message.subject.downcase

    if addr.ends_with? '@listserv.ieee.org'
        message.add_label :ieee
        message.add_label :likely_junk
    elsif addr.ends_with? '@listserv.acm.org'
        message.add_label :acm
        message.add_label :likely_junk
    end

    if addr == 'gensim@googlegroups.com'
        message.add_label :gensim
    elsif addr == 'arch-announce@archlinux.org'
        message.add_label :archlinux
    elsif addr == 'software-eng@listserv.ua.edu'
        message.add_label :serg
    elsif addr == 'cs-graduates@listserv.ua.edu'
        message.add_label :csgrads
    elsif addr == 'tide-together@listserv.ua.edu'
        message.add_label :tidetogether
    elsif addr == 'studentnews@listserv.ua.edu'
        message.add_label :news
    elsif addr == 'acm-w-public@listserv.acm.org'
        message.add_label :womens
        message.remove_label :likely_junk
    end

    is_junk ||= subj.starts_with? 'celebrating achievement:'
    is_junk ||= subj.starts_with? 'ua student news for '
    is_junk ||= addr == 'coe-all-students@listserv.ua.edu'


    if is_junk
        message.remove_label :inbox
        message.add_label :deleted
        message.add_label :junk
    end

end

#sup-heliotrope/sup <sup@noreply.github.com>

if message.recipients.any? { |person| person.email =~ /.*@noreply\.github\.com/i }
    message.add_label :github
end
