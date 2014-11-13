Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40014 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933132AbaKMPXe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 13 Nov 2014 10:23:34 -0500
From: Thomas Renninger <trenn@suse.de>
To: Martin Mares <mj@ucw.cz>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] lspci: Show device name as exported by BIOS (sysfs label attribute) (V2)
Date: Thu, 13 Nov 2014 16:23:33 +0100
Message-ID: <15082489.1nYBiW1zHH@skinner>
In-Reply-To: <mj+md-20141101.161427.20168.albireo@ucw.cz>
References: <1390856419-35985-1-git-send-email-trenn@suse.de> <mj+md-20141101.152159.17702.albireo@ucw.cz> <mj+md-20141101.161427.20168.albireo@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

and sorry for the late reply.

On Saturday, November 01, 2014 05:16:08 PM Martin Mares wrote:
> > Thanks, applied. (With minor changes, like using OBJBUFSIZE instead of
> > a hard-coded constant 1024.)
> 
> ... I realized that your way of reading the label attribute was
> completely different from reading of most other device attributes.
> 
> I changed it, now it read only on request by pci_fill_info() with the
> PCI_FILL_LABEL flag.
> 
> Could you please check that the version in pciutils.git still works
> for you?

I tried with latest 3.3.0 version and things work as expected:
lspci  -v |grep DeviceName:
        DeviceName:  USB HS EHCI Controller #2 #3
        DeviceName:  USB HS EHCI Controller #1
        DeviceName:  SATA Controller #1
        DeviceName:  Onboard LAN #1
        DeviceName:  Onboard LAN #2
        DeviceName:  Onboard Video (PILOT-3)

Thanks a lot!

Hm, while using the latest 3.3.0 tarball with our pciutils dist
package I realized that this diff does not perfectly patch
anymore.

Unfortunately without author, looks like a gcc guy added it.
I paste it in the end
You may want to incorporate (a shortened version?) it if appropriate.
Be careful, needs patch -p0

    Thomas


Dear kernel developers. we plead to you, please use documented,optimized userspace interfaces, thanks !

--- lib/sysdep.h.orig
+++ lib/sysdep.h
@@ -18,71 +18,10 @@
 typedef u8 byte;
 typedef u16 word;
 
-#ifdef PCI_OS_WINDOWS
-#define strcasecmp strcmpi
-#endif
-
-#ifdef PCI_HAVE_LINUX_BYTEORDER_H
-
-#include <asm/byteorder.h>
-#define cpu_to_le16 __cpu_to_le16
-#define cpu_to_le32 __cpu_to_le32
-#define le16_to_cpu __le16_to_cpu
-#define le32_to_cpu __le32_to_cpu
-
-#else
-
-#ifdef PCI_OS_LINUX
 #include <endian.h>
-#define BYTE_ORDER __BYTE_ORDER
-#define BIG_ENDIAN __BIG_ENDIAN
-#endif
-
-#ifdef PCI_OS_SUNOS
-#include <sys/byteorder.h>
-#define BIG_ENDIAN 4321
-#ifdef _LITTLE_ENDIAN
-#define BYTE_ORDER 1234
-#else
-#define BYTE_ORDER 4321
-#endif
-#endif
-
-#ifdef PCI_OS_WINDOWS
-#ifdef __MINGW32__
-  #include <sys/param.h>
-#else
-  #include <io.h>
-  #define BIG_ENDIAN 4321
-  #define LITTLE_ENDIAN	1234
-  #define BYTE_ORDER LITTLE_ENDIAN
-  #define snprintf _snprintf
-#endif
-#endif
-
-#if BYTE_ORDER == BIG_ENDIAN
-#define cpu_to_le16 swab16
-#define cpu_to_le32 swab32
-#define le16_to_cpu swab16
-#define le32_to_cpu swab32
-
-static inline word swab16(word w)
-{
-  return (w << 8) | ((w >> 8) & 0xff);
-}
 
-static inline u32 swab32(u32 w)
-{
-  return ((w & 0xff000000) >> 24) |
-         ((w & 0x00ff0000) >> 8) |
-         ((w & 0x0000ff00) << 8)  |
-         ((w & 0x000000ff) << 24);
-}
-#else
-#define cpu_to_le16(x) (x)
-#define cpu_to_le32(x) (x)
-#define le16_to_cpu(x) (x)
-#define le32_to_cpu(x) (x)
-#endif
+#define cpu_to_le16 htole16
+#define cpu_to_le32 htole32
+#define le16_to_cpu le16toh
+#define le32_to_cpu le32toh
 
-#endif

