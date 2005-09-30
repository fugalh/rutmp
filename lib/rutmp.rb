require 'rutmp.so'
require 'yaml'
require 'time'
require 'generator'

module Rutmp
    def generator
	Generator.new do |g|
	    while u = getutent
		g.yield u
	    end
	end
    end
    class Utmp
	'pid line id user host exit session addr'.split.each { |m|
	    class_eval "alias_method :#{m}, :ut_#{m}"
	    class_eval "alias_method :#{m}=, :ut_#{m}="
	}
	def time
	    Time.at(ut_tv.tv_sec,ut_tv.tv_usec)
	end
	def time=(t)
	    ut_tv.tv_sec, ut_tv.tv_usec = t.tv_sec, t.tv_usec
	end
	def to_s
	    "#{ut_user},#{ut_line},#{time.xmlschema},#{ut_id}"
	end
	def to_yaml
	    {'ut_type',ut_type,'ut_pid',ut_pid,'ut_line',ut_line,'ut_id',ut_id,'ut_user',ut_user,'ut_host',ut_host,'ut_exit',{'e_termination',ut_exit.e_termination,'e_exit',ut_exit.e_exit},'ut_session',ut_session,'ut_tv',{'tv_sec',ut_tv.tv_sec,'tv_usec',ut_tv.tv_usec},'ut_addr',ut_addr,'time',time}.to_yaml
	end
	def dup
	    d = Utmp.new
	    "ut_type ut_pid ut_line ut_id ut_user ut_host ut_exit ut_session time ut_addr".split.each {|m| eval "d.#{m} = #{m}"}
	    d
	end
    end
end
