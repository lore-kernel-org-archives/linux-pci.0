Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:32990 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932204AbbFDVuP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jun 2015 17:50:15 -0400
Received: by obbea3 with SMTP id ea3so42178539obb.0
        for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2015 14:50:14 -0700 (PDT)
Subject: [PATCH 7/7] PCI: Remove unused pci_dma_burst_advice()
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: "David S. Miller" <davem@davemloft.net>
Date: Thu, 04 Jun 2015 16:50:12 -0500
Message-ID: <20150604215012.2399.56382.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150604214614.2399.5142.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150604214614.2399.5142.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_dma_burst_advice() was added by e24c2d963a60 ("[PATCH] PCI: DMA
bursting advice") but apparently never used.  Remove it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: David S. Miller <davem@davemloft.net>
---
 arch/alpha/include/asm/pci.h       |   16 ----------------
 arch/arm/include/asm/pci.h         |   10 ----------
 arch/frv/include/asm/pci.h         |   10 ----------
 arch/ia64/include/asm/pci.h        |   19 -------------------
 arch/microblaze/include/asm/pci.h  |   10 ----------
 arch/mips/include/asm/pci.h        |   10 ----------
 arch/parisc/include/asm/pci.h      |   19 -------------------
 arch/powerpc/include/asm/pci.h     |   30 ------------------------------
 arch/sh/include/asm/pci.h          |   18 ------------------
 arch/sparc/include/asm/pci_32.h    |   10 ----------
 arch/sparc/include/asm/pci_64.h    |   19 -------------------
 arch/unicore32/include/asm/pci.h   |   10 ----------
 arch/x86/include/asm/pci.h         |    7 -------
 drivers/net/ethernet/sun/cassini.c |    1 -
 include/linux/pci.h                |   11 -----------
 15 files changed, 200 deletions(-)

diff --git a/arch/alpha/include/asm/pci.h b/arch/alpha/include/asm/pci.h
index f7f680f..8b02afe 100644
--- a/arch/alpha/include/asm/pci.h
+++ b/arch/alpha/include/asm/pci.h
@@ -71,22 +71,6 @@ extern void pcibios_set_master(struct pci_dev *dev);
 /* implement the pci_ DMA API in terms of the generic device dma_ one */
 #include <asm-generic/pci-dma-compat.h>
 
-static inline void pci_dma_burst_advice(struct pci_dev *pdev,
-					enum pci_dma_burst_strategy *strat,
-					unsigned long *strategy_parameter)
-{
-	unsigned long cacheline_size;
-	u8 byte;
-
-	pci_read_config_byte(pdev, PCI_CACHE_LINE_SIZE, &byte);
-	if (byte == 0)
-		cacheline_size = 1024;
-	else
-		cacheline_size = (int) byte * 4;
-
-	*strat = PCI_DMA_BURST_BOUNDARY;
-	*strategy_parameter = cacheline_size;
-}
 #endif
 
 /* TODO: integrate with include/asm-generic/pci.h ? */
diff --git a/arch/arm/include/asm/pci.h b/arch/arm/include/asm/pci.h
index 585dc33..a563544 100644
--- a/arch/arm/include/asm/pci.h
+++ b/arch/arm/include/asm/pci.h
@@ -31,16 +31,6 @@ static inline int pci_proc_domain(struct pci_bus *bus)
  */
 #define PCI_DMA_BUS_IS_PHYS     (1)
 
-#ifdef CONFIG_PCI
-static inline void pci_dma_burst_advice(struct pci_dev *pdev,
-					enum pci_dma_burst_strategy *strat,
-					unsigned long *strategy_parameter)
-{
-	*strat = PCI_DMA_BURST_INFINITY;
-	*strategy_parameter = ~0UL;
-}
-#endif
-
 #define HAVE_PCI_MMAP
 extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
                                enum pci_mmap_state mmap_state, int write_combine);
diff --git a/arch/frv/include/asm/pci.h b/arch/frv/include/asm/pci.h
index 2035a4d..a6d4ed0 100644
--- a/arch/frv/include/asm/pci.h
+++ b/arch/frv/include/asm/pci.h
@@ -41,16 +41,6 @@ extern void pci_free_consistent(struct pci_dev *hwdev, size_t size,
 /* Return the index of the PCI controller for device PDEV. */
 #define pci_controller_num(PDEV)	(0)
 
-#ifdef CONFIG_PCI
-static inline void pci_dma_burst_advice(struct pci_dev *pdev,
-					enum pci_dma_burst_strategy *strat,
-					unsigned long *strategy_parameter)
-{
-	*strat = PCI_DMA_BURST_INFINITY;
-	*strategy_parameter = ~0UL;
-}
-#endif
-
 /*
  *	These are pretty much arbitrary with the CoMEM implementation.
  *	We have the whole address space to ourselves.
diff --git a/arch/ia64/include/asm/pci.h b/arch/ia64/include/asm/pci.h
index 32ea19a..b897fae 100644
--- a/arch/ia64/include/asm/pci.h
+++ b/arch/ia64/include/asm/pci.h
@@ -52,25 +52,6 @@ extern unsigned long ia64_max_iommu_merge_mask;
 
 #include <asm-generic/pci-dma-compat.h>
 
-#ifdef CONFIG_PCI
-static inline void pci_dma_burst_advice(struct pci_dev *pdev,
-					enum pci_dma_burst_strategy *strat,
-					unsigned long *strategy_parameter)
-{
-	unsigned long cacheline_size;
-	u8 byte;
-
-	pci_read_config_byte(pdev, PCI_CACHE_LINE_SIZE, &byte);
-	if (byte == 0)
-		cacheline_size = 1024;
-	else
-		cacheline_size = (int) byte * 4;
-
-	*strat = PCI_DMA_BURST_MULTIPLE;
-	*strategy_parameter = cacheline_size;
-}
-#endif
-
 #define HAVE_PCI_MMAP
 extern int pci_mmap_page_range (struct pci_dev *dev, struct vm_area_struct *vma,
 				enum pci_mmap_state mmap_state, int write_combine);
diff --git a/arch/microblaze/include/asm/pci.h b/arch/microblaze/include/asm/pci.h
index e910a29..b42ed68 100644
--- a/arch/microblaze/include/asm/pci.h
+++ b/arch/microblaze/include/asm/pci.h
@@ -42,16 +42,6 @@
  */
 #define pcibios_assign_all_busses()	0
 
-#ifdef CONFIG_PCI
-static inline void pci_dma_burst_advice(struct pci_dev *pdev,
-					enum pci_dma_burst_strategy *strat,
-					unsigned long *strategy_parameter)
-{
-	*strat = PCI_DMA_BURST_INFINITY;
-	*strategy_parameter = ~0UL;
-}
-#endif
-
 extern int pci_domain_nr(struct pci_bus *bus);
 
 /* Decide whether to display the domain number in /proc */
diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index d969299..70dcc54 100644
--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -113,16 +113,6 @@ struct pci_dev;
  */
 extern unsigned int PCI_DMA_BUS_IS_PHYS;
 
-#ifdef CONFIG_PCI
-static inline void pci_dma_burst_advice(struct pci_dev *pdev,
-					enum pci_dma_burst_strategy *strat,
-					unsigned long *strategy_parameter)
-{
-	*strat = PCI_DMA_BURST_INFINITY;
-	*strategy_parameter = ~0UL;
-}
-#endif
-
 #ifdef CONFIG_PCI_DOMAINS
 #define pci_domain_nr(bus) ((struct pci_controller *)(bus)->sysdata)->index
 
diff --git a/arch/parisc/include/asm/pci.h b/arch/parisc/include/asm/pci.h
index 20df2b0..bf5e044 100644
--- a/arch/parisc/include/asm/pci.h
+++ b/arch/parisc/include/asm/pci.h
@@ -196,25 +196,6 @@ static inline void pcibios_register_hba(struct pci_hba_data *x)
 /* export the pci_ DMA API in terms of the dma_ one */
 #include <asm-generic/pci-dma-compat.h>
 
-#ifdef CONFIG_PCI
-static inline void pci_dma_burst_advice(struct pci_dev *pdev,
-					enum pci_dma_burst_strategy *strat,
-					unsigned long *strategy_parameter)
-{
-	unsigned long cacheline_size;
-	u8 byte;
-
-	pci_read_config_byte(pdev, PCI_CACHE_LINE_SIZE, &byte);
-	if (byte == 0)
-		cacheline_size = 1024;
-	else
-		cacheline_size = (int) byte * 4;
-
-	*strat = PCI_DMA_BURST_MULTIPLE;
-	*strategy_parameter = cacheline_size;
-}
-#endif
-
 static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 {
 	return channel ? 15 : 14;
diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index 4aef8d6..99dc432 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -71,36 +71,6 @@ extern struct dma_map_ops *get_pci_dma_ops(void);
  */
 #define PCI_DISABLE_MWI
 
-#ifdef CONFIG_PCI
-static inline void pci_dma_burst_advice(struct pci_dev *pdev,
-					enum pci_dma_burst_strategy *strat,
-					unsigned long *strategy_parameter)
-{
-	unsigned long cacheline_size;
-	u8 byte;
-
-	pci_read_config_byte(pdev, PCI_CACHE_LINE_SIZE, &byte);
-	if (byte == 0)
-		cacheline_size = 1024;
-	else
-		cacheline_size = (int) byte * 4;
-
-	*strat = PCI_DMA_BURST_MULTIPLE;
-	*strategy_parameter = cacheline_size;
-}
-#endif
-
-#else /* 32-bit */
-
-#ifdef CONFIG_PCI
-static inline void pci_dma_burst_advice(struct pci_dev *pdev,
-					enum pci_dma_burst_strategy *strat,
-					unsigned long *strategy_parameter)
-{
-	*strat = PCI_DMA_BURST_INFINITY;
-	*strategy_parameter = ~0UL;
-}
-#endif
 #endif /* CONFIG_PPC64 */
 
 extern int pci_domain_nr(struct pci_bus *bus);
diff --git a/arch/sh/include/asm/pci.h b/arch/sh/include/asm/pci.h
index 5b45115..e343dbd0 100644
--- a/arch/sh/include/asm/pci.h
+++ b/arch/sh/include/asm/pci.h
@@ -86,24 +86,6 @@ extern void pcibios_set_master(struct pci_dev *dev);
  * direct memory write.
  */
 #define PCI_DISABLE_MWI
-
-static inline void pci_dma_burst_advice(struct pci_dev *pdev,
-					enum pci_dma_burst_strategy *strat,
-					unsigned long *strategy_parameter)
-{
-	unsigned long cacheline_size;
-	u8 byte;
-
-	pci_read_config_byte(pdev, PCI_CACHE_LINE_SIZE, &byte);
-
-	if (byte == 0)
-		cacheline_size = L1_CACHE_BYTES;
-	else
-		cacheline_size = byte << 2;
-
-	*strat = PCI_DMA_BURST_MULTIPLE;
-	*strategy_parameter = cacheline_size;
-}
 #endif
 
 /* Board-specific fixup routines. */
diff --git a/arch/sparc/include/asm/pci_32.h b/arch/sparc/include/asm/pci_32.h
index 53e9b49..b7c092df 100644
--- a/arch/sparc/include/asm/pci_32.h
+++ b/arch/sparc/include/asm/pci_32.h
@@ -22,16 +22,6 @@
 
 struct pci_dev;
 
-#ifdef CONFIG_PCI
-static inline void pci_dma_burst_advice(struct pci_dev *pdev,
-					enum pci_dma_burst_strategy *strat,
-					unsigned long *strategy_parameter)
-{
-	*strat = PCI_DMA_BURST_INFINITY;
-	*strategy_parameter = ~0UL;
-}
-#endif
-
 #endif /* __KERNEL__ */
 
 #ifndef CONFIG_LEON_PCI
diff --git a/arch/sparc/include/asm/pci_64.h b/arch/sparc/include/asm/pci_64.h
index bd00a62..022d160 100644
--- a/arch/sparc/include/asm/pci_64.h
+++ b/arch/sparc/include/asm/pci_64.h
@@ -31,25 +31,6 @@
 #define PCI64_REQUIRED_MASK	(~(u64)0)
 #define PCI64_ADDR_BASE		0xfffc000000000000UL
 
-#ifdef CONFIG_PCI
-static inline void pci_dma_burst_advice(struct pci_dev *pdev,
-					enum pci_dma_burst_strategy *strat,
-					unsigned long *strategy_parameter)
-{
-	unsigned long cacheline_size;
-	u8 byte;
-
-	pci_read_config_byte(pdev, PCI_CACHE_LINE_SIZE, &byte);
-	if (byte == 0)
-		cacheline_size = 1024;
-	else
-		cacheline_size = (int) byte * 4;
-
-	*strat = PCI_DMA_BURST_BOUNDARY;
-	*strategy_parameter = cacheline_size;
-}
-#endif
-
 /* Return the index of the PCI controller for device PDEV. */
 
 int pci_domain_nr(struct pci_bus *bus);
diff --git a/arch/unicore32/include/asm/pci.h b/arch/unicore32/include/asm/pci.h
index 654407e..38b3f37 100644
--- a/arch/unicore32/include/asm/pci.h
+++ b/arch/unicore32/include/asm/pci.h
@@ -18,16 +18,6 @@
 #include <asm-generic/pci.h>
 #include <mach/hardware.h> /* for PCIBIOS_MIN_* */
 
-#ifdef CONFIG_PCI
-static inline void pci_dma_burst_advice(struct pci_dev *pdev,
-					enum pci_dma_burst_strategy *strat,
-					unsigned long *strategy_parameter)
-{
-	*strat = PCI_DMA_BURST_INFINITY;
-	*strategy_parameter = ~0UL;
-}
-#endif
-
 #define HAVE_PCI_MMAP
 extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 	enum pci_mmap_state mmap_state, int write_combine);
diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index 4e370a5..e51c229 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -80,13 +80,6 @@ extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 
 #ifdef CONFIG_PCI
 extern void early_quirks(void);
-static inline void pci_dma_burst_advice(struct pci_dev *pdev,
-					enum pci_dma_burst_strategy *strat,
-					unsigned long *strategy_parameter)
-{
-	*strat = PCI_DMA_BURST_INFINITY;
-	*strategy_parameter = ~0UL;
-}
 #else
 static inline void early_quirks(void) { }
 #endif
diff --git a/drivers/net/ethernet/sun/cassini.c b/drivers/net/ethernet/sun/cassini.c
index 3dc1f68..6ce9731 100644
--- a/drivers/net/ethernet/sun/cassini.c
+++ b/drivers/net/ethernet/sun/cassini.c
@@ -3058,7 +3058,6 @@ static void cas_init_mac(struct cas *cp)
 	/* setup core arbitration weight register */
 	writel(CAWR_RR_DIS, cp->regs + REG_CAWR);
 
-	/* XXX Use pci_dma_burst_advice() */
 #if !defined(CONFIG_SPARC64) && !defined(CONFIG_ALPHA)
 	/* set the infinite burst register for chips that don't have
 	 * pci issues.
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 353db8d..08fb4e3 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1197,15 +1197,6 @@ int pci_set_vga_state(struct pci_dev *pdev, bool decode,
 #define	pci_pool_alloc(pool, flags, handle) dma_pool_alloc(pool, flags, handle)
 #define	pci_pool_free(pool, vaddr, addr) dma_pool_free(pool, vaddr, addr)
 
-enum pci_dma_burst_strategy {
-	PCI_DMA_BURST_INFINITY,	/* make bursts as large as possible,
-				   strategy_parameter is N/A */
-	PCI_DMA_BURST_BOUNDARY, /* disconnect at every strategy_parameter
-				   byte boundaries */
-	PCI_DMA_BURST_MULTIPLE, /* disconnect at some multiple of
-				   strategy_parameter byte boundaries */
-};
-
 struct msix_entry {
 	u32	vector;	/* kernel uses to write allocated vector */
 	u16	entry;	/* driver uses to specify entry, OS writes */
@@ -1430,8 +1421,6 @@ static inline int pci_request_regions(struct pci_dev *dev, const char *res_name)
 { return -EIO; }
 static inline void pci_release_regions(struct pci_dev *dev) { }
 
-#define pci_dma_burst_advice(pdev, strat, strategy_parameter) do { } while (0)
-
 static inline void pci_block_cfg_access(struct pci_dev *dev) { }
 static inline int pci_block_cfg_access_in_atomic(struct pci_dev *dev)
 { return 0; }

