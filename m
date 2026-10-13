Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB41350257E;
	Tue, 13 Oct 2026 13:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897565; cv=none; b=Lh4/NyUNy4NC4f5LMn7+zDX4njGMMD1gZ5un94btkEu9I4koifFjqq+m93u8YGOJjUoSrDsJM6ts7KwpPwjetMzMbBP6yW8ogzsif0nZRn7GyzgfnhQBjB8EspBHComSFKhE2EMMNGSikEdCZnz7v8wmDm8owCNOtDDT5pXJacM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897565; c=relaxed/simple;
	bh=BZSHSYS8bWfrrxVSTZuU4qHD6+dFSGJAf1y//QwC9SI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fs/0eFjMLd7q4SHsCJkISSzELhyZtKGN8AbDaSgjYJI83zLyBIgeO//Bmqghsj4Obun0usVASoOEg/JW688H/R6nId85KA1R0/fMW3w24EMDhr6r4xvoCbPokalSIGv+4+jQbJETP8sYb+BwDTrLVdQ1jQUCtth2iDMyr+dXVqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLCGj/JG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLCGj/JG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89AAF1F00893;
	Tue, 13 Oct 2026 13:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791897563;
	bh=OJX59ewLgFakPFAOpd/eXwtk1XM8b23RXUsGf1N1Cdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DLCGj/JG7cbpmpujfeGZfdFVIqqtiqeycHyb0OJqbqT2FihsFma6JzZCXVgrFL08y
	 a02BXhPuJ6Pz5JUFF9Q14PMLvguilaVWI34Fe6F0numuwkApn5QdjVy8g4ut4tCVSt
	 dav8X4qFLwSjoB6O8HXINe+kcNXvakXwnscu7Uk+zZGhztBisxp1P1Hfzc2Ls/HpL/
	 MH8qT/WVyL4BKAdLxoqNa2kKGmpTkqETJJkByV74dY/NpjZ2NjArCYuYZXKAefXRUQ
	 MEy7h9xj6Y9ZYUfoj9QYr9C7UbZLmczGUv20rnyoOF67PvLbPsOBs/gYTfnxvE6RrB
	 qy5abrzaH1ySA==
From: Imre Kaloz <kaloz@kernel.org>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 26/53] MIPS: SGI-IP27: pick the XBridge and PIC DMA address form by mask
Date: Tue, 13 Oct 2026 15:16:46 +0200
Message-ID: <2794236a52b74d4fb4f26c4288397976e0e0d4b0.1791890466.git.kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1791890466.git.kaloz@kernel.org>
References: <cover.1791890466.git.kaloz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

XBridge and PIC need bit 55 set in a 64-bit direct-mapped DMA address;
without it no data moves. arch_dma_set_mask() gives that form to a
device with a 64-bit mask. PIC in PCI-X mode decodes only that form.
PIC's PCI-X bit 33 lies outside b_wid_stat. Narrower devices use the
2GB 32-bit window, with SWIOTLB bouncing streaming buffers above it
and ZONE_DMA32 serving coherent ones. The IOC3 and IOC4 take DMA
unswapped and bit 55 swaps, so they stay on the window with swapping
off in their slots. An MFD cell maps through its PCI parent.

The 64MB bounce pool comes from node 0 whenever DRAM passes 2GB (any
multi-node Hub). A later patch flags PIC.

Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 arch/mips/Kconfig                          |  3 +
 arch/mips/include/asm/pci/bridge.h         |  7 ++
 arch/mips/pci/pci-xtalk-bridge.c           | 98 +++++++++++++++++++++-
 arch/mips/sgi-ip27/ip27-memory.c           | 18 ++++
 arch/mips/sgi-ip27/ip27-xtalk.c            | 15 +++-
 include/linux/pci_ids.h                    |  1 +
 include/linux/platform_data/xtalk-bridge.h |  2 +
 7 files changed, 139 insertions(+), 5 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b64f1a8ebf41..85f1c4bd6549 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -771,6 +771,7 @@ config SGI_IP27
 	select NR_CPUS_DEFAULT_64
 	select PCI_DRIVERS_GENERIC
 	select PCI_XTALK_BRIDGE
+	select SWIOTLB
 	select SYS_HAS_CPU_R10000
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
@@ -779,6 +780,7 @@ config SGI_IP27
 	select WAR_R10000_LLSC
 	select MIPS_L1_CACHE_SHIFT_7
 	select NUMA
+	select ZONE_DMA32
 	help
 	  These are the SGI Origin 200, Origin 2000 and Onyx 2 Graphics
 	  workstations, and the IP35 machines built around the Bedrock hub
@@ -1254,6 +1256,7 @@ config PCI_GT64XXX_PCI0
 
 config PCI_XTALK_BRIDGE
 	bool
+	select ARCH_HAS_DMA_SET_MASK
 
 config NO_EXCEPT_FILL
 	bool
diff --git a/arch/mips/include/asm/pci/bridge.h b/arch/mips/include/asm/pci/bridge.h
index eaeafccd82c7..647ea5c9e34b 100644
--- a/arch/mips/include/asm/pci/bridge.h
+++ b/arch/mips/include/asm/pci/bridge.h
@@ -413,6 +413,9 @@ struct bridge_err_cmdword {
 #define BRIDGE_STAT_PCI_GIO_N		(0x1 << 5)
 #define BRIDGE_STAT_PENDING		(0x1F << 0)
 
+/* PIC-only widget status bit, upper 32 bits of the register. */
+#define PIC_STAT_PCIX_ACTIVE		(0x1ull << 33)
+
 /* Bridge widget control register bits definition */
 #define BRIDGE_CTRL_FLASH_WR_EN		(0x1ul << 31)
 #define BRIDGE_CTRL_EN_CLK50		(0x1 << 30)
@@ -797,6 +800,7 @@ struct bridge_err_cmdword {
 #define PCI64_ATTR_PREC		0x0400000000000000
 #define PCI64_ATTR_VIRTUAL	0x0200000000000000
 #define PCI64_ATTR_BAR		0x0100000000000000
+#define PCI64_ATTR_SWAP		0x0080000000000000	/* XBridge, PIC */
 #define PCI64_ATTR_RMF_MASK	0x00ff000000000000
 #define PCI64_ATTR_RMF_SHFT	48
 
@@ -810,6 +814,9 @@ struct bridge_controller {
 	unsigned int		int_mapping[8][2];
 	u32			ioc3_sid[8];
 	nasid_t			nasid;
+	bool			is_xbridge;
+	bool			is_pic;
+	bool			is_pcix;
 };
 
 #define BRIDGE_CONTROLLER(bus) \
diff --git a/arch/mips/pci/pci-xtalk-bridge.c b/arch/mips/pci/pci-xtalk-bridge.c
index 8b56c754245d..03ccb82a6189 100644
--- a/arch/mips/pci/pci-xtalk-bridge.c
+++ b/arch/mips/pci/pci-xtalk-bridge.c
@@ -23,22 +23,106 @@
 #define CRC16_INIT	0
 #define CRC16_VALID	0xb001
 
+/* An IOC3/IOC4 MFD cell DMAs through its PCI parent's bridge. */
+static struct pci_dev *bridge_dma_pdev(struct device *dev)
+{
+	while (dev && !dev_is_pci(dev))
+		dev = dev->parent;
+
+	return dev ? to_pci_dev(dev) : NULL;
+}
+
 /*
  * Common phys<->dma mapping for platforms using pci xtalk bridge
  */
 dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct bridge_controller *bc = BRIDGE_CONTROLLER(pdev->bus);
+	struct pci_dev *pdev = bridge_dma_pdev(dev);
+	struct bridge_controller *bc;
+
+	/* A crosstalk widget addresses memory by physical address. */
+	if (!pdev)
+		return paddr;
+
+	bc = BRIDGE_CONTROLLER(pdev->bus);
+
+	/*
+	 * XBridge and PIC need bit 55 set in a 64-bit direct-mapped address.
+	 * Outside PCI-X mode, a device with a narrower mask uses the 2GB
+	 * 32-bit window instead; its bus_dma_limit stays at the window's top,
+	 * so SWIOTLB bounces any buffer above it.
+	 */
+	if (bc->is_xbridge || bc->is_pic) {
+		if (!pdev->dev.bus_dma_limit)
+			return bc->baddr | PCI64_ATTR_SWAP | paddr;
+		return BRIDGE_DMA_DIRECT_BASE + paddr;
+	}
 
 	return bc->baddr + paddr;
 }
 
 phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dma_addr)
 {
+	struct pci_dev *pdev = bridge_dma_pdev(dev);
+	struct bridge_controller *bc;
+
+	if (!pdev)
+		return dma_addr;
+
+	bc = BRIDGE_CONTROLLER(pdev->bus);
+
+	if (bc->is_xbridge || bc->is_pic) {
+		if (!(dma_addr & PCI64_ATTR_BAR))
+			return dma_addr - BRIDGE_DMA_DIRECT_BASE;
+		return dma_addr & ~(0x1ffUL << 55);
+	}
+
 	return dma_addr & ~(0xffUL << 56);
 }
 
+void pcibios_bus_add_device(struct pci_dev *pdev)
+{
+	struct bridge_controller *bc = BRIDGE_CONTROLLER(pdev->bus);
+
+	if ((bc->is_xbridge || bc->is_pic) && !bc->is_pcix)
+		pdev->dev.bus_dma_limit = DMA_BIT_MASK(32);
+}
+
+/*
+ * Only a 64-bit mask covers the target widget bits 63:60 of a direct address.
+ * The IOC3 and IOC4 stay on the 32-bit window: they take DMA unswapped, and
+ * bit 55 byte-swaps the 64-bit direct form. A PIC bus in PCI-X mode decodes
+ * only the 64-bit direct form, so its devices never use the window.
+ */
+void arch_dma_set_mask(struct device *dev, u64 mask)
+{
+	struct pci_dev *pdev;
+	struct bridge_controller *bc;
+
+	if (!dev_is_pci(dev))
+		return;
+
+	pdev = to_pci_dev(dev);
+	bc = BRIDGE_CONTROLLER(pdev->bus);
+	if (!bc->is_xbridge && !bc->is_pic)
+		return;
+
+	if (bc->is_pcix) {
+		if (mask != DMA_BIT_MASK(64))
+			dev_warn(dev, "DMA mask %#llx unusable, PIC bus is in PCI-X mode\n",
+				 mask);
+		return;
+	}
+
+	if (mask == DMA_BIT_MASK(64) &&
+	    !(pdev->vendor == PCI_VENDOR_ID_SGI &&
+	      (pdev->device == PCI_DEVICE_ID_SGI_IOC3 ||
+	       pdev->device == PCI_DEVICE_ID_SGI_IOC4)))
+		dev->bus_dma_limit = 0;
+	else
+		dev->bus_dma_limit = DMA_BIT_MASK(32);
+}
+
 /*
  * Most of the IOC3 PCI config register aren't present
  * we emulate what is needed for a normal PCI enumeration
@@ -109,6 +193,8 @@ static void bridge_disable_swapping(struct pci_dev *dev)
 
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SGI, PCI_DEVICE_ID_SGI_IOC3,
 	bridge_disable_swapping);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SGI, PCI_DEVICE_ID_SGI_IOC4,
+			 bridge_disable_swapping);
 
 
 /*
@@ -928,6 +1014,14 @@ static int bridge_probe(struct platform_device *pdev)
 	bc->baddr = (u64)bd->masterwid << 60 | PCI64_ATTR_BAR;
 	bc->base = (struct bridge_regs *)bd->bridge_addr;
 	bc->intr_addr = bd->intr_addr;
+	bc->is_xbridge = bd->is_xbridge;
+	bc->is_pic = bd->is_pic;
+	if (bc->is_pic) {
+		unsigned long stat = (unsigned long)&bc->base->b_wid_stat;
+
+		bc->is_pcix = __raw_readq((void *)(stat & ~7UL)) &
+			      PIC_STAT_PCIX_ACTIVE;
+	}
 
 	/*
 	 * Clear all pending interrupts.
diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
index 98184dfcd8c5..a497bf0cbf37 100644
--- a/arch/mips/sgi-ip27/ip27-memory.c
+++ b/arch/mips/sgi-ip27/ip27-memory.c
@@ -19,8 +19,10 @@
 #include <linux/nodemask.h>
 #include <linux/sizes.h>
 #include <linux/swap.h>
+#include <linux/swiotlb.h>
 #include <linux/pfn.h>
 #include <linux/highmem.h>
+#include <asm/bootinfo.h>
 #include <asm/page.h>
 #include <asm/pgalloc.h>
 #include <asm/sections.h>
@@ -435,5 +437,21 @@ void __init prom_meminit(void)
 
 void __init arch_zone_limits_init(unsigned long *max_zone_pfns)
 {
+	/* The 32-bit DMA window of XBridge and PIC reaches only the first 2GB. */
+	max_zone_pfns[ZONE_DMA32] = min(max_low_pfn, PFN_DOWN(SZ_2G));
 	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
 }
+
+/*
+ * XBridge and PIC devices on the 2GB 32-bit DMA window bounce through
+ * SWIOTLB, so cap the pool there; which widgets exist isn't known this
+ * early, so reserve it whenever node memory reaches past the window.
+ */
+void __init plat_swiotlb_setup(void)
+{
+	phys_addr_t old_limit = memblock_get_current_limit();
+
+	memblock_set_current_limit(min_t(phys_addr_t, old_limit, SZ_2G));
+	swiotlb_init(max_low_pfn > PFN_DOWN(SZ_2G), SWIOTLB_VERBOSE);
+	memblock_set_current_limit(old_limit);
+}
diff --git a/arch/mips/sgi-ip27/ip27-xtalk.c b/arch/mips/sgi-ip27/ip27-xtalk.c
index baa937b474a8..bd2ac24452f5 100644
--- a/arch/mips/sgi-ip27/ip27-xtalk.c
+++ b/arch/mips/sgi-ip27/ip27-xtalk.c
@@ -23,7 +23,13 @@
 #define XXBOW_WIDGET_PART_NUM	0xd000	/* Xbow in Xbridge */
 #define BASE_XBOW_PORT		8     /* Lowest external port */
 
-static void bridge_platform_create(nasid_t nasid, int widget, int masterwid)
+enum xtalk_bridge_type {
+	XTALK_BRIDGE,
+	XTALK_XBRIDGE,
+};
+
+static void bridge_platform_create(nasid_t nasid, int widget, int masterwid,
+				   enum xtalk_bridge_type type)
 {
 	struct xtalk_bridge_platform_data *bd;
 	struct sgi_w1_platform_data *wd;
@@ -85,6 +91,7 @@ static void bridge_platform_create(nasid_t nasid, int widget, int masterwid)
 	bd->intr_addr	= BIT_ULL(47) + 0x01800000 + PI_INT_PEND_MOD;
 	bd->nasid	= nasid;
 	bd->masterwid	= masterwid;
+	bd->is_xbridge	= type == XTALK_XBRIDGE;
 
 	bd->mem.name	= "Bridge PCI MEM";
 	bd->mem.start	= offset + (widget << SWIN_SIZE_BITS) + BRIDGE_DEVIO0;
@@ -136,8 +143,10 @@ static int probe_one_port(nasid_t nasid, int widget, int masterwid)
 
 	switch (partnum) {
 	case BRIDGE_WIDGET_PART_NUM:
+		bridge_platform_create(nasid, widget, masterwid, XTALK_BRIDGE);
+		break;
 	case XBRIDGE_WIDGET_PART_NUM:
-		bridge_platform_create(nasid, widget, masterwid);
+		bridge_platform_create(nasid, widget, masterwid, XTALK_XBRIDGE);
 		break;
 	default:
 		pr_info("xtalk:n%d/%d unknown widget (0x%x)\n",
@@ -228,7 +237,7 @@ static void xtalk_probe_node(nasid_t nasid)
 
 	switch (partnum) {
 	case BRIDGE_WIDGET_PART_NUM:
-		bridge_platform_create(nasid, 0x8, 0xa);
+		bridge_platform_create(nasid, 0x8, 0xa, XTALK_BRIDGE);
 		break;
 	case XBOW_WIDGET_PART_NUM:
 	case XXBOW_WIDGET_PART_NUM:
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 63774ae2bf71..fc92822b1509 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1113,6 +1113,7 @@
 #define PCI_VENDOR_ID_SGI		0x10a9
 #define PCI_DEVICE_ID_SGI_IOC3		0x0003
 #define PCI_DEVICE_ID_SGI_LITHIUM	0x1002
+#define PCI_DEVICE_ID_SGI_IOC4		0x100a
 
 #define PCI_VENDOR_ID_WINBOND		0x10ad
 #define PCI_DEVICE_ID_WINBOND_82C105	0x0105
diff --git a/include/linux/platform_data/xtalk-bridge.h b/include/linux/platform_data/xtalk-bridge.h
index 51e5001f2c05..171b5bcf56e4 100644
--- a/include/linux/platform_data/xtalk-bridge.h
+++ b/include/linux/platform_data/xtalk-bridge.h
@@ -17,6 +17,8 @@ struct xtalk_bridge_platform_data {
 	unsigned long io_offset;
 	nasid_t	nasid;
 	int	masterwid;
+	bool	is_xbridge;
+	bool	is_pic;
 };
 
 #endif /* PLATFORM_DATA_XTALK_BRIDGE_H */
-- 
2.47.3

