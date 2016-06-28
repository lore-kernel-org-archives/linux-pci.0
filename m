Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-sh@vger.kernel.or, linux-kernel@vger.kernel.org,
	"Date:Mon"@sa76r4.localdomain, 27@sa76r4.localdomain,
	Jun@sa76r4.localdomain, 2016@sa76r4.localdomain,
	"15:38:04"@sa76r4.localdomain, +0900@sa76r4.localdomain
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v3 11/19] sh: Add PCI host bridge driver for SH7751
Date: Tue, 28 Jun 2016 15:36:27 +0900
Message-Id: <1467095795-5082-12-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1467095795-5082-1-git-send-email-ysato@users.sourceforge.jp>
References: <1467095795-5082-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is an alternative SH7751 PCI driver.
Existing driver (arch/sh/drivers/pci/pci-sh7751) uses SH specific interface.
But this driver uses common PCI interface. It is more modern and generic.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 .../devicetree/bindings/pci/sh7751-pci.txt         |  51 ++++
 arch/sh/boards/Kconfig                             |   1 +
 arch/sh/drivers/Makefile                           |   2 +
 arch/sh/include/asm/io.h                           |   6 +
 drivers/pci/host/Kconfig                           |   7 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pci-sh7751.c                      | 326 +++++++++++++++++++++
 7 files changed, 394 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/sh7751-pci.txt
 create mode 100644 drivers/pci/host/pci-sh7751.c

diff --git a/Documentation/devicetree/bindings/pci/sh7751-pci.txt b/Documentation/devicetree/bindings/pci/sh7751-pci.txt
new file mode 100644
index 0000000..c3ec71a
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/sh7751-pci.txt
@@ -0,0 +1,51 @@
+* Renesas SH7751 PCI host interfaces
+
+Required properties:
+  - compatible: "renesas,sh7751-pci" is required.
+    And board specific compatible if fixup required.
+
+  - reg: base address and length of the PCI controller registers.
+  - #address-cells: set to <2>
+  - #size-cells: set to <1>
+  - bus-range: PCI bus numbers covered
+  - device_type: set to "pci"
+  - ranges: ranges for the PCI memory and I/O regions.
+  - interrupt-map-mask and interrupt-map: standard PCI properties
+	to define the mapping of the PCI interface to interrupt
+	numbers.
+
+Example:
+	pci: pci-controller@fe200000 {
+		compatible = "renesas,sh7751-pci", "iodata,landisk";
+		device_type = "pci";
+		bus-range = <0 0>;
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges = <0x02000000 0x00000000 0xfd000000 0xfd000000 0x00000000 0x01000000>,
+		         <0x01000000 0x00000000 0xfe240000 0x00000000 0x00000000 0x00040000>;
+		reg = <0xfe200000 0x0400>,
+		      <0x0c000000 0x04000000>,
+		      <0xff800000 0x0030>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0x1800 0 7>;
+		interrupt-map = <0x0000 0 1 &cpldintc evt2irq(0x2a0) 0
+		                 0x0000 0 2 &cpldintc evt2irq(0x2c0) 0
+		                 0x0000 0 3 &cpldintc evt2irq(0x2e0) 0
+		                 0x0000 0 4 &cpldintc evt2irq(0x300) 0
+
+		                 0x0800 0 1 &cpldintc evt2irq(0x2c0) 0
+		                 0x0800 0 2 &cpldintc evt2irq(0x2e0) 0
+		                 0x0800 0 3 &cpldintc evt2irq(0x300) 0
+		                 0x0800 0 4 &cpldintc evt2irq(0x2a0) 0
+
+		                 0x1000 0 1 &cpldintc evt2irq(0x2e0) 0
+		                 0x1000 0 2 &cpldintc evt2irq(0x300) 0
+		                 0x1000 0 3 &cpldintc evt2irq(0x2a0) 0
+		                 0x1000 0 4 &cpldintc evt2irq(0x2c0) 0
+
+		                 0x1800 0 1 &cpldintc evt2irq(0x300) 0
+		                 0x1800 0 2 &cpldintc evt2irq(0x2a0) 0
+		                 0x1800 0 3 &cpldintc evt2irq(0x2c0) 0
+		                 0x1800 0 4 &cpldintc evt2irq(0x2e0) 0>;
+	};
+};
diff --git a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
index b6ff9df..cfde921 100644
--- a/arch/sh/boards/Kconfig
+++ b/arch/sh/boards/Kconfig
@@ -14,6 +14,7 @@ config SH_DEVICE_TREE
 	select GENERIC_CALIBRATE_DELAY
 	select GENERIC_IOMAP
 	select COMMON_CLK
+	select SYS_SUPPORTS_PCI
 	help
 	  Select Board Described by Device Tree to build a kernel that
 	  does not hard-code any board-specific knowledge but instead uses
diff --git a/arch/sh/drivers/Makefile b/arch/sh/drivers/Makefile
index e13f06b..382e86f 100644
--- a/arch/sh/drivers/Makefile
+++ b/arch/sh/drivers/Makefile
@@ -4,7 +4,9 @@
 
 obj-y		+= dma/
 
+ifndef CONFIG_SH_DEVICE_TREE
 obj-$(CONFIG_PCI)		+= pci/
+endif
 obj-$(CONFIG_SUPERHYWAY)	+= superhyway/
 obj-$(CONFIG_PUSH_SWITCH)	+= push-switch.o
 obj-$(CONFIG_HEARTBEAT)		+= heartbeat.o
diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index 3280a6b..df62a9f 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -387,6 +387,12 @@ static inline int iounmap_fixed(void __iomem *addr) { return -EINVAL; }
 int valid_phys_addr_range(phys_addr_t addr, size_t size);
 int valid_mmap_phys_addr_range(unsigned long pfn, size_t size);
 
+#define PCI_IOBASE	0xfe240000UL
+
+#define HAVE_ARCH_PIO_SIZE
+#define PIO_OFFSET	PCI_IOBASE
+#define PIO_MASK	0x3ffffUL
+#define PIO_RESERVED	0x40000UL
 #endif /* __KERNEL__ */
 
 #endif /* __ASM_SH_IO_H */
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 5d2374e..df60505 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -245,4 +245,11 @@ config PCIE_ARMADA_8K
 	  Designware hardware and therefore the driver re-uses the
 	  Designware core functions to implement the driver.
 
+config PCI_SH7751
+	bool "Renesas SH7751 On-Chip PCI controller"
+	depends on OF && SUPERH
+	select PCI_HOST_COMMON
+	help
+	  Say Y here if you want PCI support on SH7751.
+
 endmenu
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 9c8698e..4681e49 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -29,3 +29,4 @@ obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
 obj-$(CONFIG_PCI_HOST_THUNDER_ECAM) += pci-thunder-ecam.o
 obj-$(CONFIG_PCI_HOST_THUNDER_PEM) += pci-thunder-pem.o
 obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
+obj-$(CONFIG_PCI_SH7751) += pci-sh7751.o
diff --git a/drivers/pci/host/pci-sh7751.c b/drivers/pci/host/pci-sh7751.c
new file mode 100644
index 0000000..d851fcf3
--- /dev/null
+++ b/drivers/pci/host/pci-sh7751.c
@@ -0,0 +1,326 @@
+/*
+ * SH7751 PCI driver
+ * Copyright (C) 2016 Yoshinori Sato
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_pci.h>
+#include <linux/of_platform.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include "../ecam.h"
+
+#define SH7751_PCICONF1            0x4           /* PCI Config Reg 1 */
+#define SH7751_PCICONF4            0x10          /* PCI Config Reg 4 */
+#define SH7751_PCICONF5            0x14          /* PCI Config Reg 5 */
+#define SH7751_PCICONF6            0x18          /* PCI Config Reg 6 */
+#define SH4_PCICR		0x100		/* PCI Control Register */
+  #define SH4_PCICR_PREFIX	  0xA5000000	/* CR prefix for write */
+  #define SH4_PCICR_FTO		  BIT(10)	/* TRDY/IRDY Enable */
+  #define SH4_PCICR_TRSB	  BIT(9)	/* Target Read Single */
+  #define SH4_PCICR_BSWP	  BIT(8)	/* Target Byte Swap */
+  #define SH4_PCICR_PLUP	  BIT(7)	/* Enable PCI Pullup */
+  #define SH4_PCICR_ARBM	  BIT(6)	/* PCI Arbitration Mode */
+#define SH4_PCICR_MD		  (BIT(4) | BIT(5))	/* MD9 and MD10 status */
+  #define SH4_PCICR_SERR	  BIT(3)	/* SERR output assert */
+  #define SH4_PCICR_INTA	  BIT(2)	/* INTA output assert */
+  #define SH4_PCICR_PRST	  BIT(1)	/* PCI Reset Assert */
+  #define SH4_PCICR_CFIN	  BIT(0)	/* Central Fun. Init Done */
+#define SH4_PCILSR0		0x104		/* PCI Local Space Register0 */
+#define SH4_PCILSR1		0x108		/* PCI Local Space Register1 */
+#define SH4_PCILAR0		0x10C		/* PCI Local Addr Register1 */
+#define SH4_PCILAR1		0x110		/* PCI Local Addr Register1 */
+#define SH4_PCIINTM		0x118		/* PCI Interrupt Mask */
+  #define SH4_PCIINTM_TTADIM	  BIT(14)	/* Target-target abort interrupt */
+  #define SH4_PCIINTM_TMTOIM	  BIT(9)	/* Target retry timeout */
+  #define SH4_PCIINTM_MDEIM	  BIT(8)	/* Master function disable error */
+  #define SH4_PCIINTM_APEDIM	  BIT(7)	/* Address parity error detection */
+  #define SH4_PCIINTM_SDIM	  BIT(6)	/* SERR detection */
+  #define SH4_PCIINTM_DPEITWM	  BIT(5)	/* Data parity error for target write */
+  #define SH4_PCIINTM_PEDITRM	  BIT(4)	/* PERR detection for target read */
+  #define SH4_PCIINTM_TADIMM	  BIT(3)	/* Target abort for master */
+  #define SH4_PCIINTM_MADIMM	  BIT(2)	/* Master abort for master */
+  #define SH4_PCIINTM_MWPDIM	  BIT(1)	/* Master write data parity error */
+  #define SH4_PCIINTM_MRDPEIM	  BIT(0)	/* Master read data parity error */
+#define SH4_PCIAINTM            0x134		/* Arbiter Int. Mask Register */
+#define SH4_PCIPAR		0x1C0		/* PIO Address Register */
+  #define SH4_PCIPAR_CFGEN	  0x80000000	/* Configuration Enable */
+  #define SH4_PCIPAR_BUSNO	  0x00FF0000	/* Config. Bus Number */
+  #define SH4_PCIPAR_DEVNO	  0x0000FF00	/* Config. Device Number */
+  #define SH4_PCIPAR_REGAD	  0x000000FC	/* Register Address Number */
+#define SH4_PCIPINT		0x1CC		/* Power Mgmnt Int. Register */
+  #define SH4_PCIPINT_D3	  0x00000002	/* D3 Pwr Mgmt. Interrupt */
+  #define SH4_PCIPINT_D0	  0x00000001	/* D0 Pwr Mgmt. Interrupt */
+#define SH4_PCICLKR		0x1D4		/* Clock Ctrl. Register */
+/* For definitions of BCR, MCR see ... */
+#define SH4_PCIBCR1		0x1E0		/* Memory BCR1 Register */
+  #define SH4_PCIMBR0		SH4_PCIBCR1
+#define SH4_PCIBCR2		0x1E4		/* Memory BCR2 Register */
+  #define SH4_PCIMBMR0		SH4_PCIBCR2
+#define SH4_PCIWCR1		0x1E8		/* Wait Control 1 Register */
+#define SH4_PCIWCR2		0x1EC		/* Wait Control 2 Register */
+#define SH4_PCIWCR3		0x1F0		/* Wait Control 3 Register */
+  #define SH4_PCIMBR2		SH4_PCIWCR3
+#define SH4_PCIMCR		0x1F4		/* Memory Control Register */
+#define SH4_PCIPDR		0x220		/* Port IO Data Register */
+
+/* Platform Specific Values */
+#define SH7751_VENDOR_ID             0x1054
+#define SH7751_DEVICE_ID             0x3505
+#define SH7751R_DEVICE_ID            0x350e
+
+/* Memory Control Registers */
+#define SH7751_BCR1                0x0000    /* Memory BCR1 Register */
+#define SH7751_BCR2                0x0004    /* Memory BCR2 Register */
+#define SH7751_BCR3                0x0050    /* Memory BCR3 Register */
+#define SH7751_WCR1                0x0008    /* Wait Control 1 Register */
+#define SH7751_WCR2                0x000C    /* Wait Control 2 Register */
+#define SH7751_WCR3                0x0010    /* Wait Control 3 Register */
+#define SH7751_MCR                 0x0014    /* Memory Control Register */
+
+#define pcic_writel(val, reg) iowrite32(val, pci_reg_base + (reg))
+#define pcic_readl(reg) ioread32(pci_reg_base + (reg))
+
+/*
+ * PCIC fixups
+ */
+
+#define PCIMCR_MRSET 0x40000000
+#define PCIMCR_RFSH  0x00000004
+
+static void __init landisk_fixup(void __iomem *pci_reg_base, void __iomem *bcr)
+{
+	unsigned long bcr1, mcr;
+
+	bcr1 = ioread32(bcr + SH7751_BCR1);
+	bcr1 |= 0x00080000;	/* Enable Bit 19 BREQEN, set PCIC to slave */
+	pcic_writel(bcr1, SH4_PCIBCR1);
+
+	mcr = ioread32(bcr + SH7751_MCR);
+	mcr &= (~PCIMCR_MRSET) & (~PCIMCR_RFSH);
+	pcic_writel(mcr, SH4_PCIMCR);
+
+	pcic_writel(0x0c000000, PCI_BASE_ADDRESS_1);
+	pcic_writel(0xd0000000, PCI_BASE_ADDRESS_2);
+	pcic_writel(0x0c000000, SH4_PCILAR0);
+	pcic_writel(0x00000000, SH4_PCILAR1);
+}
+
+static void __init r2dplus_fixup(void __iomem *pci_reg_base, void __iomem *bcr)
+{
+	unsigned long bcr1, mcr;
+
+	bcr1 = ioread32(bcr + SH7751_BCR1);
+	bcr1 |= 0x40080000;	/* Enable Bit 19 BREQEN, set PCIC to slave */
+	pcic_writel(bcr1, SH4_PCIBCR1);
+
+	/* Enable all interrupts, so we known what to fix */
+	pcic_writel(0x0000c3ff, SH4_PCIINTM);
+	pcic_writel(0x0000380f, SH4_PCIAINTM);
+
+	pcic_writel(0xfb900047, SH7751_PCICONF1);
+	pcic_writel(0xab000001, SH7751_PCICONF4);
+
+	mcr = ioread32(bcr + SH7751_MCR);
+	mcr &= (~PCIMCR_MRSET) & (~PCIMCR_RFSH);
+	pcic_writel(mcr, SH4_PCIMCR);
+
+	pcic_writel(0x0c000000, SH7751_PCICONF5);
+	pcic_writel(0xd0000000, SH7751_PCICONF6);
+	pcic_writel(0x0c000000, SH4_PCILAR0);
+	pcic_writel(0x00000000, SH4_PCILAR1);
+}
+
+/*
+ * Direct access to PCI hardware...
+ */
+#define CONFIG_CMD(bus, devfn, where) \
+	(0x80000000 | (bus->number << 16) | (devfn << 8) | (where & ~3))
+
+/*
+ * Functions for accessing PCI configuration space with type 1 accesses
+ */
+static void __iomem *sh7751_map_bus(struct pci_bus *bus,
+				   unsigned int devfn, int where)
+{
+	struct pci_config_window *cfg = bus->sysdata;
+	void __iomem *pci_reg_base = (void __iomem *)cfg->res.start;
+
+	pcic_writel(CONFIG_CMD(bus, devfn, where), SH4_PCIPAR);
+	return pci_reg_base + SH4_PCIPDR;
+}
+
+static const struct of_device_id fixup_of_match[] = {
+	{ .compatible = "iodata,landisk-pci", .data = landisk_fixup, },
+	{ .compatible = "renesas,r2dplus-pci", .data = r2dplus_fixup, },
+	{ },
+};
+
+static const struct of_device_id sh7751_pci_of_match[] = {
+	{ .compatible = "renesas,sh7751-pci", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sh7751_pci_of_match);
+
+static resource_size_t sh7751_align_resource(struct pci_dev *dev,
+					     const struct resource *res,
+					     resource_size_t start,
+					     resource_size_t size,
+					     resource_size_t align)
+{
+	if (res->flags & IORESOURCE_IO) {
+		if (start < PCIBIOS_MIN_IO + 0x1000)
+			start = PCIBIOS_MIN_IO + 0x1000;
+
+		/*
+		 * Put everything into 0x00-0xff region modulo 0x400.
+		 */
+		if (start & 0x300)
+			start = (start + 0x3ff) & ~0x3ff;
+	}
+
+	return start;
+}
+
+static void __init set_pci_bcr(void __iomem *pci_reg_base,
+			       void __iomem *bcr,
+			       unsigned int area)
+{
+	unsigned long word;
+
+	word = ioread32(bcr + SH7751_BCR1);
+	/* check BCR for SDRAM in area */
+	if (((word >> area) & 1) == 0) {
+		pr_info("PCI: Area %d is not configured for SDRAM. BCR1=0x%lx\n",
+			area, word);
+		return;
+	}
+	pcic_writel(word, SH4_PCIBCR1);
+
+	word = ioread16(bcr + SH7751_BCR2);
+	/* check BCR2 for 32bit SDRAM interface*/
+	if (((word >> (area << 1)) & 0x3) != 0x3) {
+		pr_info("PCI: Area %d is not 32 bit SDRAM. BCR2=0x%lx\n",
+			area, word);
+		return;
+	}
+	pcic_writel(word, SH4_PCIBCR2);
+}
+
+static __init int sh7751_cfg_init(struct device *dev,
+				  struct pci_config_window *cfg)
+{
+	cfg->priv = sh7751_align_resource;
+	return 0;
+}
+
+static struct pci_ecam_ops ecm_ops __initdata = {
+	.init	= sh7751_cfg_init,
+	.pci_ops = {
+		.read	= pci_generic_config_read32,
+		.write	= pci_generic_config_write32,
+		.map_bus	= sh7751_map_bus,
+	}
+};
+
+static __init int sh7751_pci_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	u32 id;
+	u32 reg, word;
+	void __iomem *pci_reg_base;
+	void __iomem *bcr;
+	const struct of_device_id *match;
+	void (*fixup_fn)(void __iomem *pci_reg_base, void __iomem *bcr);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pci_reg_base = ioremap(res->start, resource_size(res));
+	if (IS_ERR(pci_reg_base))
+		return PTR_ERR(pci_reg_base);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	bcr = ioremap(res->start, resource_size(res));
+	if (IS_ERR(bcr))
+		return PTR_ERR(bcr);
+
+	/* check for SH7751/SH7751R hardware */
+	id = pcic_readl(PCI_VENDOR_ID);
+	if (id != ((SH7751_DEVICE_ID << 16) | SH7751_VENDOR_ID) &&
+	    id != ((SH7751R_DEVICE_ID << 16) | SH7751_VENDOR_ID)) {
+		pr_warn("PCI: This is not an SH7751(R)\n");
+		return -ENODEV;
+	}
+	dev_info(&pdev->dev, "PCI core found at %pR\n",
+		pci_reg_base);
+
+	/* Set the BCRs to enable PCI access */
+	reg = ioread32(bcr);
+	reg |= 0x80000;
+	iowrite32(reg, bcr);
+
+	/* Turn the clocks back on (not done in reset)*/
+	pcic_writel(0, SH4_PCICLKR);
+	/* Clear Powerdown IRQs (not done in reset) */
+	word = SH4_PCIPINT_D3 | SH4_PCIPINT_D0;
+	pcic_writel(word, SH4_PCIPINT);
+
+	/* set the command/status bits to:
+	 * Wait Cycle Control + Parity Enable + Bus Master +
+	 * Mem space enable
+	 */
+	word = PCI_COMMAND_WAIT | PCI_COMMAND_PARITY |
+	       PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY;
+	pcic_writel(word, PCI_COMMAND);
+
+	/* define this host as the host bridge */
+	word = PCI_BASE_CLASS_BRIDGE << 24;
+	pcic_writel(word, PCI_CLASS_REVISION);
+
+	/* Set IO and Mem windows to local address
+	 * Make PCI and local address the same for easy 1 to 1 mapping
+	 */
+	word = memory_end - memory_start - 1;
+	pcic_writel(word, SH4_PCILSR0);
+	/* Set the values on window 0 PCI config registers */
+	word = P2SEGADDR(__pa(memory_start));
+	pcic_writel(word, SH4_PCILAR0);
+	pcic_writel(word, PCI_BASE_ADDRESS_1);
+
+	set_pci_bcr(pci_reg_base, bcr, (__pa(memory_start) >> 27) & 0x07);
+
+	/* configure the wait control registers */
+	word = ioread32(bcr + SH7751_WCR1);
+	pcic_writel(word, SH4_PCIWCR1);
+	word = ioread32(bcr + SH7751_WCR2);
+	pcic_writel(word, SH4_PCIWCR2);
+	word = ioread32(bcr + SH7751_WCR3);
+	pcic_writel(word, SH4_PCIWCR3);
+	word = ioread32(bcr + SH7751_MCR);
+	pcic_writel(word, SH4_PCIMCR);
+
+	match = of_match_node(fixup_of_match, pdev->dev.of_node);
+	if (match) {
+		fixup_fn = match->data;
+		fixup_fn(pci_reg_base, bcr);
+	}
+	/*
+	 * SH7751 init done, set central function init complete
+	 * use round robin mode to stop a device starving/overruning
+	 */
+	word = SH4_PCICR_PREFIX | SH4_PCICR_CFIN | SH4_PCICR_ARBM;
+	pcic_writel(word, SH4_PCICR);
+
+	return pci_host_common_probe(pdev, &ecm_ops);
+}
+
+static __refdata struct platform_driver sh7751_pci_driver = {
+	.driver = {
+		.name = "sh7751-pci",
+		.of_match_table = sh7751_pci_of_match,
+	},
+	.probe = sh7751_pci_probe,
+};
+builtin_platform_driver(sh7751_pci_driver);
-- 
2.7.0
