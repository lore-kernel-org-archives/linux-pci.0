Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34933 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754058AbaKPKFj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 16 Nov 2014 05:05:39 -0500
From: Thomas Renninger <trenn@suse.de>
To: Martin Mares <mj@ucw.cz>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] lspci: Show device name as exported by BIOS (sysfs label attribute) (V2)
Date: Sun, 16 Nov 2014 11:05:37 +0100
Message-ID: <1985533.HjfPJX4Efo@linux-oxht.site>
In-Reply-To: <mj+md-20141114.213146.9845.albireo@ucw.cz>
References: <1390856419-35985-1-git-send-email-trenn@suse.de> <15082489.1nYBiW1zHH@skinner> <mj+md-20141114.213146.9845.albireo@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, November 14, 2014 10:34:39 PM Martin Mares wrote:
> Hi!
> 
> > Hm, while using the latest 3.3.0 tarball with our pciutils dist
> > package I realized that this diff does not perfectly patch
> > anymore.
> > 
> > Unfortunately without author, looks like a gcc guy added it.
> > I paste it in the end
> > You may want to incorporate (a shortened version?) it if appropriate.
> 
> No, I don't want :-)  While it simplifies the code on Linux, it breaks
> many other platforms.

Of course not the whole patch.
The OS specific stuff must stay.

It is about (be careful, copy and pasted) these
which seem to be a nice code reduction:

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


         Thomas
