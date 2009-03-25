
class ScreenReader
    
    def initialize(args)
        @os = 'win' #default to windows
        if RUBY_PLATFORM.downcase.include?("darwin")
            @os = 'mac'
        end
        
    end

    def detect(bp, args)
        callback = args['callback']
        reader = false
        version = nil
        name = nil
        if @os == 'mac'
            cmd = `ps x | grep screenreaderd | grep -v grep`
            if cmd != ''
                name = 'VoiceOver'
                reader = true
                tmp = `/usr/sbin/screenreaderd -v 2>&1`
                tmp = tmp.split(':')
                version = tmp[2].strip
            end
        else
            items = {
                'Jfw.exe' => 'Jaws For Windows',
                'wineyes.exe' => 'Window-eyes',
                'nvda.exe' => 'NVDA',
                'zt.exe' => 'Zoomtext'
            }
            items.each { | key, value|
                cmdLine = "tasklist /nh /fo CSV /fi \"IMAGENAME eq #{key}\" 2>&1"
                pipe = IO.popen(cmdLine)
                cmd = pipe.readlines
                pipe.close
                
                #TODO Need to get the version number here..
                version = nil
		        cleaned = cmd[0].slice(0,4).strip
		        #puts "CMD2: #{key} '#{cleaned}'"

                if cleaned and cleaned != 'INFO'
                    reader = true
                    name = value
                end
            }
        end
        callback.invoke({
            'name' => name,
            'active' => reader,
            'version' => version
        });
    end

end



rubyCoreletDefinition = {
  'class' => "ScreenReader",
  'name'  => "ScreenReader",
  'major_version' => 0,
  'minor_version' => 0,
  'micro_version' => 1,
  'documentation' => 
    'Screen Reader Detection on Windows and OSX',

  'functions' =>
  [
    {
      'name' => 'detect',
      'documentation' => "Detect the process",
      'arguments' =>
      [
          {
            'name' => 'callback',
            'type' => 'callback',
            'required' => true,
            'documentation' => 'This will be called when the detection is finished'
          }
      ]
    }
  ] 
}

