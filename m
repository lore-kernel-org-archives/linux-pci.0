Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v2 2/4] asm-generic/io.h: Remove unused generic __ioremap()
 definition
From: Bjorn Helgaas <bhelgaas@google.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org
Date: Mon, 20 Mar 2017 13:42:53 -0500
Message-ID: <20170320184253.4858.12956.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170320182014.4858.22352.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20170320182014.4858.22352.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Several arches use __ioremap() to help implement the generic ioremap(),
ioremap_nocache(), and ioremap_wc() interfaces, but this usage is all
inside the arch/ directory.

The only __ioremap() uses outside arch/ are in the ZorroII RAM disk driver
and some framebuffer drivers that are only buildable on m68k and powerpc,
and they use the versions provided by those arches.

There's no need for a generic version of __ioremap(), so remove it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/io.h |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 978d2e27ce1d..e0a331a22346 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -843,15 +843,6 @@ static inline void __iomem *ioremap(phys_addr_t offset, size_t size)
 }
 #endif
 
-#ifndef __ioremap
-#define __ioremap __ioremap
-static inline void __iomem *__ioremap(phys_addr_t offset, size_t size,
-				      unsigned long flags)
-{
-	return ioremap(offset, size);
-}
-#endif
-
 #ifndef ioremap_nocache
 #define ioremap_nocache ioremap_nocache
 static inline void __iomem *ioremap_nocache(phys_addr_t offset, size_t size)
