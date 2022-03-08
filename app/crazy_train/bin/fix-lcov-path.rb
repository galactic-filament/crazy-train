cwd = Dir.pwd
lcov_path = "#{cwd}/coverage/lcov/crazy_train.lcov"
unless File.exist? lcov_path
  puts "lcov file does not exist: #{lcov_path}"

  exit 1
end

lcov_contents = File.read lcov_path
replaced_lcov_contents = lcov_contents.gsub("SF:./app", "SF:./app/crazy_train/app")
File.write lcov_path, replaced_lcov_contents
