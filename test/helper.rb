require "fileutils"

class TempTree
  attr_reader :dir

  def initialize
    @dir = Dir.mktmpdir
    yield self if block_given?
  end

  def mkdir(path)
    FileUtils.mkdir_p join(path)
  end

  def file(path, data='')
    mkdir File.dirname(path)
    File.write join(path), data
  end

  def remove(path)
    FileUtils.rm_rf join(path)
  end

  def exist?(path)
    File.exist? join(path)
  end

  def join(path)
    File.join(@dir, path)
  end

  def destroy
    FileUtils.rm_rf(@dir, noop: true, verbse: true)
  end

end
