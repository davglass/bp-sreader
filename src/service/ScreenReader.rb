
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
                'zt.exe' => 'Zoomtext',
                'sh.exe' => 'Test Shell',
            }
            items.each { | key, value|
                cmd = `tasklist /nh /fi "IMAGENAME eq #{key}"`
                if cmd[0,4] != 'INFO'
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

