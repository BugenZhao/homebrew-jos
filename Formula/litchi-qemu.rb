class LitchiQemu < Formula

  desc "Litchi Emulator"
  homepage "http://wiki.qemu.org"
  url "https://github.com/mit-pdos/6.828-qemu.git", :using => :git, :tag => "2.3.0"
  bottle do
    root_url "https://dl.bintray.com/bugenzhao/bottles-litchi"
    sha256 "96273ec7ad270c202bf99608c265d3ef18d2cf5dadfd0cfd2b565feeeacb23ae" => :catalina
  end

  conflicts_with "qemu"

  depends_on "pkg-config" => :build
  depends_on "libtool" => :build
  depends_on "jpeg"
  depends_on "gnutls"
  depends_on "glib"
  depends_on "pixman"
  depends_on "lzo"
  depends_on "ncurses"
  depends_on "snappy"
  depends_on "vde" => :optional
  depends_on "sdl" => :optional
  depends_on "gtk+" => :optional
  depends_on "libssh2" => :optional

  def install
    ENV["LIBTOOL"] = "glibtool"

    args = %W[
      --target-list=i386-softmmu,x86_64-softmmu
      --prefix=#{prefix}
      --cc=#{ENV.cc}
      --host-cc=#{ENV.cc}
      --enable-cocoa
      --disable-bsd-user
      --disable-guest-agent
      --disable-kvm
    ]

    args << (build.with?("sdl") ? "--enable-sdl" : "--disable-sdl")
    args << (build.with?("vde") ? "--enable-vde" : "--disable-vde")
    args << (build.with?("gtk+") ? "--enable-gtk" : "--disable-gtk")
    args << (build.with?("libssh2") ? "--enable-libssh2" : "--disable-libssh2")

    system "./configure", *args
    system "make", "V=1", "install"
  end
end
