require "pry" # this is for debugging in case there's an anomaly

# how about a hash for log output
hLog = { :same => [], :corrupt => [], :missing => [] }

#
# - first make a list of all the files in the dups folder
#

alist = Dir["dups/*"]

#
# - then isolate the root filename for FileUtils comparison
#

acmp = alist.map do |a|
    # duplicate files look like this "dups/blahblah(1).ext"
    a.sub /dups\/(.*)\(1\)/, '\1'
    # so we substituted the middle/root part for the full string
end

#
# - then run through the list, make the comparisons and take appropriate action
#

alist.each_index do |i|
# there's a much Matti-er way to do this, but not for me! For I shall be known
#               henceforth as Pigpen The Unclean! Muhahaha!
    if File.exists? acmp[i]
        if FileUtils.cmp alist[i], acmp[i]
            hLog[:same].push "#{alist[i]} and #{acmp[i]} are the same."
            next
        else
            hLog[:corrupt].push "#{acmp[i]} is corrupt, replacing..."
            FileUtils.cp alist[i], "fixed/#{acmp[i]}"
            next
        end
    else # if we made it to here then the file is either missing or ?*&%!
        hLog[:missing].push "oh dear, #{acmp[i]} is missing, replacing..."
        begin
        FileUtils.cp alist[i], "fixed/#{acmp[i]}"
        rescue
            puts "WTF?!? This should not happen!"
            # I guess we're *&#%@$!
            binding.pry
            # this pops me into the pry console in the current runtime state and
            # context of this script so I can see what's going on and try stuff
        end
    end
# hey, it worked at least
end

#
# - lastly, output the results to the log file

File.open("../filefixer.log.txt","w") do |logfile|
    logfile << "These files were corrupt:\n#{hLog[:corrupt].join("\n")}"
    logfile << "\n\n"
    logfile << "These files were missing:\n#{hLog[:missing].join("\n")}"
    logfile << "\n\n"
    logfile << "But the rest were ok:\n #{hLog[:same].join("\n")}"
end

# no need to close the file if you use the file object in it's own block

