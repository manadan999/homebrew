require 'formula'

class Spin < Formula
  url 'http://spinroot.com/spin/Src/spin525.tar.gz'
  homepage 'http://spinroot.com/spin/whatispin.html'
  md5 '03345f9713e7b4f82d2d8ec319802b9c'
  version '5.2.5'

  def patches
    DATA
  end

  def install
    fails_with_llvm
    ENV.deparallelize

    # Compile and install the binary.
    cd("Src#{version}") do
      system "make"
      bin.install "spin"
    end

    # Copy the man page.
    man1.install "Man/spin.1"
  end
end

# manual patching is required by the spin install process
__END__
diff --git a/Src5.2.5/makefile b/Src5.2.5/makefile
index 67f22aa..596c893 100755
--- a/Src5.2.5/makefile
+++ b/Src5.2.5/makefile
@@ -12,10 +12,10 @@
 
 CC=gcc -DNXT 		# -DNXT enables the X operator in LTL
 # CC=cc -m32 -DNXT 	# for 32bit compilation on a 64bit system
-CFLAGS=-ansi -D_POSIX_SOURCE -Wno-format-security	# on some systems add: -I/usr/include
+#CFLAGS=-ansi -D_POSIX_SOURCE -Wno-format-security	# on some systems add: -I/usr/include
 
-# for a more picky compilation:
-# CFLAGS=-std=c99 -Wstrict-prototypes -pedantic -fno-strength-reduce -fno-builtin -W -Wshadow -Wpointer-arith -Wcast-qual -Winline -Wall -g
+# for a more picky compilation: 
+CFLAGS=-std=c99 -Wstrict-prototypes -pedantic -fno-strength-reduce -fno-builtin -W -Wshadow -Wpointer-arith -Wcast-qual -Winline -Wall -g -DMAC -DCPP="\"gcc -E -x c -xassembler-with-cpp\""
 
 #	on PC:		add -DPC to CFLAGS above
 #	on Solaris:	add -DSOLARIS
