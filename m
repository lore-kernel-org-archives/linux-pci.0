Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:15206 "EHLO
	relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751258AbbJ2NA3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 29 Oct 2015 09:00:29 -0400
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Wolfram Sang <wsa@the-dreams.de>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/4] PCI: rcar: Add support for ARM64 and multiple
 instances
Date: Thu, 29 Oct 2015 13:00:22 +0000
Message-ID: <PS1PR06MB118061CA5128E4C1A2C70A18F5200@PS1PR06MB1180.apcprd06.prod.outlook.com>
References: <1443781507-5011-1-git-send-email-phil.edworthy@renesas.com>
 <20151029123755.GC2351@katana>
In-Reply-To: <20151029123755.GC2351@katana>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Wolfram,

On 29 October 2015 12:38, Wolfram wrote:
> > Fixes and changes to get PCIe working on ARM64 with mulitple instances.
> 
> > I've tested these on ARM (Koelsch board), and it works fine.
> > I've also tested on ARM64 (Salvator-X board), but I currently have an issue
> 
> I wanted to test these patches on arm64 as well, but even after merging
> pci-next, I still get:
> 
> drivers/pci/host/pcie-rcar.c: In function 'rcar_pcie_setup':
> drivers/pci/host/pcie-rcar.c:380:4: error: implicit declaration of function
> 'pci_ioremap_io' [-Werror=implicit-function-declaration]
> 
> So, what do I miss?
Ouch, my bad. I have been working with our out-of-tree BSP for the Salvator-X board on
http://git.kernel.org/cgit/linux/kernel/git/horms/renesas-bsp.git,  rcar-3.0.2 tag along
with some patches from colleagues. I hadn't noticed this patch:

>From 913ff73dcf19bb57b0a7ad69e51105560d69fa9b Mon Sep 17 00:00:00 2001
From: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
Date: Thu, 24 Sep 2015 22:55:58 +0900
Subject: [PATCH 03/15] arm64: PCI(e) arch support for ioremap function

Refered the followings patch:
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/269206.html

Signed-off-by: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
---
 arch/arm64/include/asm/io.h |    2 ++
 arch/arm64/mm/ioremap.c     |   13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 44be1e0..cea3651 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -149,6 +149,8 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
 #define IO_SPACE_LIMIT		(PCI_IO_SIZE - 1)
 #define PCI_IOBASE		((void __iomem *)PCI_IO_START)
 
+extern int pci_ioremap_io(unsigned int offset, phys_addr_t phys_addr);
+
 /*
  * String version of I/O memory access operations.
  */
diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
index 01e88c8..34f09a6 100644
--- a/arch/arm64/mm/ioremap.c
+++ b/arch/arm64/mm/ioremap.c
@@ -104,6 +104,19 @@ void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size)
 }
 EXPORT_SYMBOL(ioremap_cache);
 
+#ifdef CONFIG_PCI
+int pci_ioremap_io(unsigned int offset, phys_addr_t phys_addr)
+{
+	BUG_ON(offset + SZ_64K > IO_SPACE_LIMIT);
+
+	return ioremap_page_range((unsigned long)PCI_IOBASE + offset,
+				  (unsigned long)PCI_IOBASE + offset + SZ_64K,
+				  phys_addr,
+				  __pgprot(PROT_NORMAL_NC));
+}
+EXPORT_SYMBOL_GPL(pci_ioremap_io);
+#endif
+
 /*
  * Must be called after early_fixmap_init
  */
-- 
1.7.9.5

Additionally, I have found out that MSI on R-Car PCIe upstream is broken. You can
workaround this by reverting f075915ac0b11847fcfc8c4d55526a317e71c4d1 and
f075915ac0b11847fcfc8c4d55526a317e71c4d1 until we fix this.


> > with inbound PCI accesses. I am reasonably sure that this problem is hardware
> > related.
> 
> Any news if this is really HW related?
I found out that the PCIe controller HW only supports 32-bit AXI bus addresses, so it
works fine if you limit the available memory. The driver will need some work to use
the IPMMU at some point.

Thanks
Phil

