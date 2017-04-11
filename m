Return-Path: <linux-arch-owner@vger.kernel.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH v3 30/32] arm: implement ioremap_nopost() interface
Date: Tue, 11 Apr 2017 13:29:10 +0100
Message-Id: <20170411122923.6285-31-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
References: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCI bus specifications (rev 3.0, 3.2.5 "Transaction Ordering
and Posting") define rules for PCI configuration space transactions
ordering and posting, that state that configuration writes have to
be non-posted transactions.

Current ioremap interface on ARM provides mapping functions that
provide "bufferable" writes transactions (ie ioremap uses MT_DEVICE
memory type) aka posted writes, so PCI host controller drivers have
no arch interface to remap PCI configuration space with memory
attributes that comply with the PCI specifications for configuration
space.

Implement an ARM specific ioremap_nopost() interface that allows to
map PCI config memory regions with MT_UNCACHED memory type (ie strongly
ordered - non-posted writes), providing a remap function that complies
with PCI specifications for config space transactions.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>
---
 arch/arm/include/asm/io.h | 9 +++++++++
 arch/arm/mm/ioremap.c     | 7 +++++++
 arch/arm/mm/nommu.c       | 9 +++++++++
 3 files changed, 25 insertions(+)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 42871fb..28b15be 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -352,6 +352,7 @@ static inline void memcpy_toio(volatile void __iomem *to, const void *from,
  * mapping has specific properties.
  *
  * Function		Memory type	Cacheability	Cache hint
+ * ioremap_nopost()	SO		n/a		n/a
  * ioremap()		Device		n/a		n/a
  * ioremap_nocache()	Device		n/a		n/a
  * ioremap_cache()	Normal		Writeback	Read allocate
@@ -372,6 +373,12 @@ static inline void memcpy_toio(volatile void __iomem *to, const void *from,
  * compiler may generate unaligned accesses - eg, via inlining its own
  * memcpy.
  *
+ * ioremap_nopost() maps memory as strongly ordered, to be used for
+ * specific mappings (eg PCI config space) that require non-posted
+ * write transactions. Strongly ordered transactions are ordered wrt
+ * device mappings, which means that ioremap_nopost() is the same
+ * as ioremap() except for non-posted writes behaviour.
+ *
  * All normal memory mappings have the following properties:
  * - reads can be repeated with no side effects
  * - repeated reads return the last value written
@@ -407,6 +414,8 @@ void __iomem *ioremap_wc(resource_size_t res_cookie, size_t size);
 #define ioremap_wc ioremap_wc
 #define ioremap_wt ioremap_wc
 
+void __iomem *ioremap_nopost(resource_size_t res_cookie, size_t size);
+
 void iounmap(volatile void __iomem *iomem_cookie);
 #define iounmap iounmap
 
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index ff0eed2..4ffaf16 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -463,6 +463,13 @@ void iounmap(volatile void __iomem *cookie)
 }
 EXPORT_SYMBOL(iounmap);
 
+void __iomem *ioremap_nopost(resource_size_t res_cookie, size_t size)
+{
+	return arch_ioremap_caller(res_cookie, size, MT_UNCACHED,
+				   __builtin_return_address(0));
+}
+EXPORT_SYMBOL_GPL(ioremap_nopost);
+
 #ifdef CONFIG_PCI
 static int pci_ioremap_mem_type = MT_DEVICE;
 
diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index 3b5c7aa..dfd736a 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -21,6 +21,8 @@
 #include <asm/mpu.h>
 #include <asm/procinfo.h>
 
+#include <asm/mach/map.h>
+
 #include "mm.h"
 
 unsigned long vectors_base;
@@ -433,6 +435,13 @@ void __iomem *ioremap_wc(resource_size_t res_cookie, size_t size)
 }
 EXPORT_SYMBOL(ioremap_wc);
 
+void __iomem *ioremap_nopost(resource_size_t res_cookie, size_t size)
+{
+	return __arm_ioremap_caller(res_cookie, size, MT_UNCACHED,
+				    __builtin_return_address(0));
+}
+EXPORT_SYMBOL(ioremap_nopost);
+
 void *arch_memremap_wb(phys_addr_t phys_addr, size_t size)
 {
 	return (void *)phys_addr;
-- 
2.10.0
