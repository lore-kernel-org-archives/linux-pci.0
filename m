Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.medvecky.net ([85.118.132.146]:40655 "EHLO
        mail.medvecky.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751832AbdL2U7M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Dec 2017 15:59:12 -0500
To: linux-pci@vger.kernel.org, Martin Mares <mj@ucw.cz>
From: Rudolf Marek <r.marek@assembler.cz>
Subject: [PATCH] pciutils: Add the support for a DOS/DJGPP environment
Message-ID: <13afd9a4-3b56-b60d-19fc-1bad7b96e0ee@assembler.cz>
Date: Fri, 29 Dec 2017 21:58:41 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------D4F1BA52AD9DAA780327665D"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------D4F1BA52AD9DAA780327665D
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit

Hi,

Here is bit a blast from the past. The flashrom still supports the DOS/DJGPP environment, which requires
pciutils to be compiled with DJGPP. I originally developed this patch in 2010,
and I respun it for latest pciutils.

* Add DJGPP as an OS target
* Stop if endianess macros are not defined
* Introduce new intel_io_lock/unclock function to synchronize
  I/O operations.

There is a small issue left that "lspci" and "lspci.exe" are created. The ".exe" variants
are not installed and also not cleaned. No idea if you want to fix that or not.

Signed-off-by: Rudolf Marek <r.marek@assembler.cz>

Compiled with:

 make ZLIB=no DNS=no HOST=i386-djgpp-djgpp CROSS_COMPILE=i586-pc-msdosdjgpp- \
     PREFIX=/ DESTDIR=$PWD/../libpci-libgetopt  \
     STRIP="--strip-program=i586-pc-msdosdjgpp-strip -s" install install-lib

If you put to C:\share\pci.ids file, the lspci.exe will also display the human readable output.

Thanks
Rudolf

--------------D4F1BA52AD9DAA780327665D
Content-Type: text/x-patch;
 name="0001-Add-the-support-for-a-DOS-DJGPP-environment.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename*0="0001-Add-the-support-for-a-DOS-DJGPP-environment.patch"

=46rom 10436832ed28bf1cd43fb423367f00f7006f4e8a Mon Sep 17 00:00:00 2001
From: Rudolf Marek <r.marek@assembler.cz>
Date: Fri, 29 Dec 2017 21:26:31 +0100
Subject: [PATCH] Add the support for a DOS/DJGPP environment

* Add DJGPP as an OS target
* Stop if endianess macros are not defined
* Introduce new intel_io_lock/unclock function to synchronize
  I/O operations.

Signed-off-by: Rudolf Marek <r.marek@assembler.cz>
---
 README                |  1 +
 lib/configure         |  6 +++++-
 lib/i386-io-beos.h    |  8 ++++++++
 lib/i386-io-cygwin.h  |  8 ++++++++
 lib/i386-io-djgpp.h   | 45 +++++++++++++++++++++++++++++++++++++++++++++=

 lib/i386-io-haiku.h   |  8 ++++++++
 lib/i386-io-hurd.h    |  8 ++++++++
 lib/i386-io-linux.h   |  8 ++++++++
 lib/i386-io-sunos.h   |  8 ++++++++
 lib/i386-io-windows.h |  8 ++++++++
 lib/i386-ports.c      | 49 ++++++++++++++++++++++++++++++++++++---------=
----
 lib/sysdep.h          | 10 ++++++++++
 lspci.h               |  2 +-
 13 files changed, 154 insertions(+), 15 deletions(-)
 create mode 100644 lib/i386-io-djgpp.h

diff --git a/README b/README
index cd30a84..847d02c 100644
--- a/README
+++ b/README
@@ -27,6 +27,7 @@ In runs on the following systems:
 	BeOS		(via syscalls)
 	Haiku		(via /dev/misc/poke)
 	Darwin		(via IOKit)
+	DOS/DJGPP	(via i386 ports)
=20
 It should be very easy to add support for other systems as well (volunte=
ers
 wanted; if you want to try that, I'll be very glad to see the patches an=
d
diff --git a/lib/configure b/lib/configure
index 363f5b4..ff63816 100755
--- a/lib/configure
+++ b/lib/configure
@@ -120,7 +120,11 @@ case $sys in
 		echo >>$m 'WITH_LIBS+=3D-lpci'
 		LIBRESOLV=3D
 		;;
-    	gnu)
+	gnu)
+		echo_n " i386-ports"
+		echo >>$c '#define PCI_HAVE_PM_INTEL_CONF'
+		;;
+	djgpp)
 		echo_n " i386-ports"
 		echo >>$c '#define PCI_HAVE_PM_INTEL_CONF'
 		;;
diff --git a/lib/i386-io-beos.h b/lib/i386-io-beos.h
index a107a4e..a0ee6c9 100644
--- a/lib/i386-io-beos.h
+++ b/lib/i386-io-beos.h
@@ -57,3 +57,11 @@ outl (u32 value, u16 port)
 {
   write_isa_io(0, (void *)(u32)port, sizeof(value), value);
 }
+
+static inline void intel_io_lock(void)
+{
+}
+
+static inline void intel_io_unlock(void)
+{
+}
diff --git a/lib/i386-io-cygwin.h b/lib/i386-io-cygwin.h
index 4af2f81..1602248 100644
--- a/lib/i386-io-cygwin.h
+++ b/lib/i386-io-cygwin.h
@@ -20,3 +20,11 @@ intel_cleanup_io(struct pci_access *a UNUSED)
   iopl(3);
   return -1;
 }
+
+static inline void intel_io_lock(void)
+{
+}
+
+static inline void intel_io_unlock(void)
+{
+}
diff --git a/lib/i386-io-djgpp.h b/lib/i386-io-djgpp.h
new file mode 100644
index 0000000..41885db
--- /dev/null
+++ b/lib/i386-io-djgpp.h
@@ -0,0 +1,45 @@
+/*
+ *	The PCI Library -- Access to i386 I/O ports on DJGPP
+ *
+ *	Copyright (c) 2010, 2017 Rudolf Marek <r.marek@assembler.cz>
+ *
+ *	Can be freely distributed and used under the terms of the GNU GPL.
+ */
+
+#include <pc.h>
+#include <dos.h>
+#define outb(x,y) outportb(y, x)
+#define outw(x,y) outportw(y, x)
+#define outl(x,y) outportl(y, x)
+
+#define inb  inportb
+#define inw  inportw
+#define inl  inportl
+
+static int irq_enabled;
+
+static int
+intel_setup_io(struct pci_access *a UNUSED)
+{
+  return 1;
+}
+
+static inline int
+intel_cleanup_io(struct pci_access *a UNUSED)
+{
+  return 1;
+}
+
+static inline void intel_io_lock(void)
+{
+  asm volatile("" : : : "memory");
+  irq_enabled =3D disable();
+}
+
+static inline void intel_io_unlock(void)
+{
+  asm volatile("" : : : "memory");
+  if (irq_enabled) {
+    enable();
+  }
+}
diff --git a/lib/i386-io-haiku.h b/lib/i386-io-haiku.h
index 2a824f9..2bbe592 100644
--- a/lib/i386-io-haiku.h
+++ b/lib/i386-io-haiku.h
@@ -122,3 +122,11 @@ outl (u32 value, u16 port)
   port_io_args args =3D { POKE_SIGNATURE, port, sizeof(u32), value };
   ioctl(poke_driver_fd, POKE_PORT_WRITE, &args, sizeof(args));
 }
+
+static inline void intel_io_lock(void)
+{
+}
+
+static inline void intel_io_unlock(void)
+{
+}
diff --git a/lib/i386-io-hurd.h b/lib/i386-io-hurd.h
index b61d656..d6df909 100644
--- a/lib/i386-io-hurd.h
+++ b/lib/i386-io-hurd.h
@@ -25,3 +25,11 @@ intel_cleanup_io(struct pci_access *a UNUSED)
=20
   return -1;
 }
+
+static inline void intel_io_lock(void)
+{
+}
+
+static inline void intel_io_unlock(void)
+{
+}
diff --git a/lib/i386-io-linux.h b/lib/i386-io-linux.h
index 1e52d73..b39b4eb 100644
--- a/lib/i386-io-linux.h
+++ b/lib/i386-io-linux.h
@@ -20,3 +20,11 @@ intel_cleanup_io(struct pci_access *a UNUSED)
   iopl(3);
   return -1;
 }
+
+static inline void intel_io_lock(void)
+{
+}
+
+static inline void intel_io_unlock(void)
+{
+}
diff --git a/lib/i386-io-sunos.h b/lib/i386-io-sunos.h
index 3e08e73..6221d13 100644
--- a/lib/i386-io-sunos.h
+++ b/lib/i386-io-sunos.h
@@ -64,3 +64,11 @@ outl (u32 value, u16 port)
 {
   __asm__ __volatile__ ("outl (%w1)": :"a" (value), "Nd" (port));
 }
+
+static inline void intel_io_lock(void)
+{
+}
+
+static inline void intel_io_unlock(void)
+{
+}
diff --git a/lib/i386-io-windows.h b/lib/i386-io-windows.h
index 6e3dec0..d5823ee 100644
--- a/lib/i386-io-windows.h
+++ b/lib/i386-io-windows.h
@@ -67,3 +67,11 @@ intel_cleanup_io(struct pci_access *a UNUSED)
   //TODO: DeInitializeWinIo!
   return 1;
 }
+
+static inline void intel_io_lock(void)
+{
+}
+
+static inline void intel_io_unlock(void)
+{
+}
diff --git a/lib/i386-ports.c b/lib/i386-ports.c
index 421bbfd..0b1677a 100644
--- a/lib/i386-ports.c
+++ b/lib/i386-ports.c
@@ -26,6 +26,8 @@
 #include "i386-io-haiku.h"
 #elif defined(PCI_OS_BEOS)
 #include "i386-io-beos.h"
+#elif defined(PCI_OS_DJGPP)
+#include "i386-io-djgpp.h"
 #else
 #error Do not know how to access I/O ports on this OS.
 #endif
@@ -106,12 +108,16 @@ conf1_detect(struct pci_access *a)
       a->debug("...no I/O permission");
       return 0;
     }
+
+  intel_io_lock();
   outb (0x01, 0xCFB);
   tmp =3D inl (0xCF8);
   outl (0x80000000, 0xCF8);
   if (inl (0xCF8) =3D=3D 0x80000000)
     res =3D 1;
   outl (tmp, 0xCF8);
+  intel_io_unlock();
+
   if (res)
     res =3D intel_sanity_check(a, &pm_intel_conf1);
   return res;
@@ -121,10 +127,12 @@ static int
 conf1_read(struct pci_dev *d, int pos, byte *buf, int len)
 {
   int addr =3D 0xcfc + (pos&3);
+  int res =3D 1;
=20
   if (pos >=3D 256)
     return 0;
=20
+  intel_io_lock();
   outl(0x80000000 | ((d->bus & 0xff) << 16) | (PCI_DEVFN(d->dev, d->func=
) << 8) | (pos&~3), 0xcf8);
=20
   switch (len)
@@ -139,19 +147,23 @@ conf1_read(struct pci_dev *d, int pos, byte *buf, i=
nt len)
       ((u32 *) buf)[0] =3D cpu_to_le32(inl(addr));
       break;
     default:
-      return pci_generic_block_read(d, pos, buf, len);
+      res =3D pci_generic_block_read(d, pos, buf, len);
     }
-  return 1;
+
+  intel_io_unlock();
+  return res;
 }
=20
 static int
 conf1_write(struct pci_dev *d, int pos, byte *buf, int len)
 {
   int addr =3D 0xcfc + (pos&3);
+  int res =3D 1;
=20
   if (pos >=3D 256)
     return 0;
=20
+  intel_io_lock();
   outl(0x80000000 | ((d->bus & 0xff) << 16) | (PCI_DEVFN(d->dev, d->func=
) << 8) | (pos&~3), 0xcf8);
=20
   switch (len)
@@ -166,9 +178,10 @@ conf1_write(struct pci_dev *d, int pos, byte *buf, i=
nt len)
       outl(le32_to_cpu(((u32 *) buf)[0]), addr);
       break;
     default:
-      return pci_generic_block_write(d, pos, buf, len);
+      res =3D pci_generic_block_write(d, pos, buf, len);
     }
-  return 1;
+  intel_io_unlock();
+  return res;
 }
=20
 /*
@@ -178,6 +191,8 @@ conf1_write(struct pci_dev *d, int pos, byte *buf, in=
t len)
 static int
 conf2_detect(struct pci_access *a)
 {
+  int res =3D 0;
+
   if (!conf12_setup_io(a))
     {
       a->debug("...no I/O permission");
@@ -186,18 +201,20 @@ conf2_detect(struct pci_access *a)
=20
   /* This is ugly and tends to produce false positives. Beware. */
=20
+  intel_io_lock();
   outb(0x00, 0xCFB);
   outb(0x00, 0xCF8);
   outb(0x00, 0xCFA);
   if (inb(0xCF8) =3D=3D 0x00 && inb(0xCFA) =3D=3D 0x00)
-    return intel_sanity_check(a, &pm_intel_conf2);
-  else
-    return 0;
+    res =3D intel_sanity_check(a, &pm_intel_conf2);
+  intel_io_unlock();
+  return res;
 }
=20
 static int
 conf2_read(struct pci_dev *d, int pos, byte *buf, int len)
 {
+  int res =3D 1;
   int addr =3D 0xc000 | (d->dev << 8) | pos;
=20
   if (pos >=3D 256)
@@ -206,6 +223,8 @@ conf2_read(struct pci_dev *d, int pos, byte *buf, int=
 len)
   if (d->dev >=3D 16)
     /* conf2 supports only 16 devices per bus */
     return 0;
+
+  intel_io_lock();
   outb((d->func << 1) | 0xf0, 0xcf8);
   outb(d->bus, 0xcfa);
   switch (len)
@@ -220,16 +239,17 @@ conf2_read(struct pci_dev *d, int pos, byte *buf, i=
nt len)
       ((u32 *) buf)[0] =3D cpu_to_le32(inl(addr));
       break;
     default:
-      outb(0, 0xcf8);
-      return pci_generic_block_read(d, pos, buf, len);
+      res =3D pci_generic_block_read(d, pos, buf, len);
     }
   outb(0, 0xcf8);
-  return 1;
+  intel_io_unlock();
+  return res;
 }
=20
 static int
 conf2_write(struct pci_dev *d, int pos, byte *buf, int len)
 {
+  int res =3D 1;
   int addr =3D 0xc000 | (d->dev << 8) | pos;
=20
   if (pos >=3D 256)
@@ -237,6 +257,8 @@ conf2_write(struct pci_dev *d, int pos, byte *buf, in=
t len)
=20
   if (d->dev >=3D 16)
     d->access->error("conf2_write: only first 16 devices exist.");
+
+  intel_io_lock();
   outb((d->func << 1) | 0xf0, 0xcf8);
   outb(d->bus, 0xcfa);
   switch (len)
@@ -251,11 +273,12 @@ conf2_write(struct pci_dev *d, int pos, byte *buf, =
int len)
       outl(le32_to_cpu(* (u32 *) buf), addr);
       break;
     default:
-      outb(0, 0xcf8);
-      return pci_generic_block_write(d, pos, buf, len);
+      res =3D pci_generic_block_write(d, pos, buf, len);
     }
+
   outb(0, 0xcf8);
-  return 1;
+  intel_io_unlock();
+  return res;
 }
=20
 struct pci_methods pm_intel_conf1 =3D {
diff --git a/lib/sysdep.h b/lib/sysdep.h
index b864e90..f3756b6 100644
--- a/lib/sysdep.h
+++ b/lib/sysdep.h
@@ -68,6 +68,16 @@ typedef u16 word;
 #endif
 #endif
=20
+#ifdef PCI_OS_DJGPP
+  #define BIG_ENDIAN 4321
+  #define LITTLE_ENDIAN	1234
+  #define BYTE_ORDER LITTLE_ENDIAN
+#endif
+
+#if !defined(BYTE_ORDER)
+#error "BYTE_ORDER not defined for your platform"
+#endif
+
 #if BYTE_ORDER =3D=3D BIG_ENDIAN
 #define cpu_to_le16 swab16
 #define cpu_to_le32 swab32
diff --git a/lspci.h b/lspci.h
index 9ef0919..bcd007e 100644
--- a/lspci.h
+++ b/lspci.h
@@ -14,7 +14,7 @@
  *  This increases our memory footprint, but only slightly since we don'=
t
  *  use alloca() much.
  */
-#if defined (__FreeBSD__) || defined (__NetBSD__) || defined (__OpenBSD_=
_) || defined (__DragonFly__)
+#if defined (__FreeBSD__) || defined (__NetBSD__) || defined (__OpenBSD_=
_) || defined (__DragonFly__) || defined (__DJGPP__)
 /* alloca() is defined in stdlib.h */
 #elif defined(__GNUC__) && !defined(PCI_OS_WINDOWS)
 #include <alloca.h>
--=20
2.7.4


--------------D4F1BA52AD9DAA780327665D--
