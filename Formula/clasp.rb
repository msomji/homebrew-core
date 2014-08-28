require 'formula'

class Clasp < Formula
  homepage 'http://potassco.sourceforge.net/'
  url 'https://downloads.sourceforge.net/project/potassco/clasp/3.1.0/clasp-3.1.0-source.tar.gz'
  sha1 '57297b641d6900a639e09c2a1c73549707f337b7'

  option 'with-mt', 'Enable multi-thread support'

  depends_on 'tbb' if build.with? "mt"

  def install
    if build.with? "mt"
      ENV['TBB30_INSTALL_DIR'] = Formula["tbb"].opt_prefix
      build_dir = 'build/release_mt'
    else
      build_dir = 'build/release'
    end

    args = %W[
      --config=release
      --prefix=#{prefix}
    ]
    args << "--with-mt" if build.with? "mt"

    bin.mkpath
    system "./configure.sh", *args
    system "make", "-C", build_dir, "install"
  end
end
