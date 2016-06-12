Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v2 12/17] sh: Add PCI host bridge driver for SH7751
Date: Sun, 12 Jun 2016 15:54:30 +0900
Message-Id: <1465714475-24111-13-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1465714475-24111-1-git-send-email-ysato@users.sourceforge.jp>
References: <1465714475-24111-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is alternative SH7751 PCI driver.
Existing driver (arch/sh/drivers/pci/pci-sh7751) use SH specific interface.
But this driver using common PCI interface. It more mordan and generic.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 .../devicetree/bindings/pci/sh7751-pci.txt         |  51 +++
 arch/sh/boards/Kconfig                             |   1 +
 drivers/pci/host/Kconfig                           |   7 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pci-sh7751.c                      | 443 +++++++++++++++++++++
 5 files changed, 503 insertions(+)
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
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 7a0780d..a8596db 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -231,4 +231,11 @@ config PCI_HOST_THUNDER_ECAM
 	help
 	  Say Y here if you want ECAM support for CN88XX-Pass-1.x Cavium Thunder SoCs.
 
+config PCI_SH7751
+	bool "Renesas SH7751 On-Chip PCI controller"
+	depends on OF && SUPERH
+	select PCI_HOST_COMMON
+	help
+	  Say Y here if you want PCI support on SH7751.
+
 endmenu
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index d85b5fa..91268cb 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -28,3 +28,4 @@ obj-$(CONFIG_PCI_HISI) += pcie-hisi.o
 obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
 obj-$(CONFIG_PCI_HOST_THUNDER_ECAM) += pci-thunder-ecam.o
 obj-$(CONFIG_PCI_HOST_THUNDER_PEM) += pci-thunder-pem.o
+obj-$(CONFIG_PCI_SH7751) += pci-sh7751.o
diff --git a/drivers/pci/host/pci-sh7751.c b/drivers/pci/host/pci-sh7751.c
new file mode 100644
index 0000000..c029e5b
--- /dev/null
+++ b/drivers/pci/host/pci-sh7751.c
@@ -0,0 +1,443 @@
+/*
+ * SH7751 PCI driver
+ * Copyright (C) 2016 Yoshinori Sato
+ *
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
+#include "pci-host-common.h"
+
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
+#define SH4_PCIPAR		0x1C0		/* PIO Address Register */
+  #define SH4_PCIPAR_CFGEN	  0x80000000	/* Configuration Enable */
+  #define SH4_PCIPAR_BUSNO	  0x00FF0000	/* Config. Bus Number */
+  #define SH4_PCIPAR_DEVNO	  0x0000FF00	/* Config. Device Number */
+  #define SH4_PCIPAR_REGAD	  0x000000FC	/* Register Address Number */
+#define SH4_PCIMBR		0x1C4		/* Memory Base Address */
+  #define SH4_PCIMBR_MASK	  0xFF000000	/* Memory Space Mask */
+  #define SH4_PCIMBR_LOCK	  0x00000001	/* Lock Memory Space */
+#define SH4_PCIIOBR		0x1C8		/* I/O Base Address Register */
+  #define SH4_PCIIOBR_MASK	  0xFFFC0000	/* IO Space Mask */
+  #define SH4_PCIIOBR_LOCK	  0x00000001	/* Lock IO Space */
+#define SH4_PCIPINT		0x1CC		/* Power Mgmnt Int. Register */
+  #define SH4_PCIPINT_D3	  0x00000002	/* D3 Pwr Mgmt. Interrupt */
+  #define SH4_PCIPINT_D0	  0x00000001	/* D0 Pwr Mgmt. Interrupt */
+#define SH4_PCIPINTM		0x1D0		/* Power Mgmnt Mask Register */
+#define SH4_PCICLKR		0x1D4		/* Clock Ctrl. Register */
+  #define SH4_PCICLKR_PCSTP	  0x00000002	/* PCI Clock Stop */
+  #define SH4_PCICLKR_BCSTP	  0x00000001	/* BCLK Clock Stop */
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
+#define SH4_PCIBCR3		0x1f8		/* Memory BCR3 Register */
+#define SH4_PCIPCTR             0x200		/* Port Control Register */
+  #define SH4_PCIPCTR_P2EN	  0x000400000	/* Port 2 Enable */
+  #define SH4_PCIPCTR_P1EN	  0x000200000	/* Port 1 Enable */
+  #define SH4_PCIPCTR_P0EN	  0x000100000	/* Port 0 Enable */
+  #define SH4_PCIPCTR_P2UP	  0x000000020	/* Port2 Pull Up Enable */
+  #define SH4_PCIPCTR_P2IO	  0x000000010	/* Port2 Output Enable */
+  #define SH4_PCIPCTR_P1UP	  0x000000008	/* Port1 Pull Up Enable */
+  #define SH4_PCIPCTR_P1IO	  0x000000004	/* Port1 Output Enable */
+  #define SH4_PCIPCTR_P0UP	  0x000000002	/* Port0 Pull Up Enable */
+  #define SH4_PCIPCTR_P0IO	  0x000000001	/* Port0 Output Enable */
+#define SH4_PCIPDTR		0x204		/* Port Data Register */
+  #define SH4_PCIPDTR_PB5	  0x000000020	/* Port 5 Enable */
+  #define SH4_PCIPDTR_PB4	  0x000000010	/* Port 4 Enable */
+  #define SH4_PCIPDTR_PB3	  0x000000008	/* Port 3 Enable */
+  #define SH4_PCIPDTR_PB2	  0x000000004	/* Port 2 Enable */
+  #define SH4_PCIPDTR_PB1	  0x000000002	/* Port 1 Enable */
+  #define SH4_PCIPDTR_PB0	  0x000000001	/* Port 0 Enable */
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
+/* General Memory Config Addresses */
+#define SH7751_CS0_BASE_ADDR       0x0
+#define SH7751_MEM_REGION_SIZE     0x04000000
+#define SH7751_CS1_BASE_ADDR \
+	(SH7751_CS0_BASE_ADDR + SH7751_MEM_REGION_SIZE)
+#define SH7751_CS2_BASE_ADDR \
+	(SH7751_CS1_BASE_ADDR + SH7751_MEM_REGION_SIZE)
+#define SH7751_CS3_BASE_ADDR \
+	(SH7751_CS2_BASE_ADDR + SH7751_MEM_REGION_SIZE)
+#define SH7751_CS4_BASE_ADDR \
+	(SH7751_CS3_BASE_ADDR + SH7751_MEM_REGION_SIZE)
+#define SH7751_CS5_BASE_ADDR \
+	(SH7751_CS4_BASE_ADDR + SH7751_MEM_REGION_SIZE)
+#define SH7751_CS6_BASE_ADDR \
+	(SH7751_CS5_BASE_ADDR + SH7751_MEM_REGION_SIZE)
+
+#define pcic_writel(val, reg) __raw_writel(val, pci_reg_base + (reg))
+#define pcic_readl(reg) __raw_readl(pci_reg_base + (reg))
+
+unsigned long PCIBIOS_MIN_IO;
+unsigned long PCIBIOS_MIN_MEM;
+DEFINE_RAW_SPINLOCK(pci_config_lock);
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
+	bcr1 = __raw_readl(bcr + SH7751_BCR1);
+	bcr1 |= 0x00080000;	/* Enable Bit 19 BREQEN, set PCIC to slave */
+	pcic_writel(bcr1, SH4_PCIBCR1);
+
+	mcr = __raw_readl(bcr + SH7751_MCR);
+	mcr &= (~PCIMCR_MRSET) & (~PCIMCR_RFSH);
+	pcic_writel(mcr, SH4_PCIMCR);
+
+	pcic_writel(0x0c000000, PCI_BASE_ADDRESS_1);
+	pcic_writel(0xd0000000, PCI_BASE_ADDRESS_2);
+	pcic_writel(0x0c000000, SH4_PCILAR0);
+	pcic_writel(0x00000000, SH4_PCILAR1);
+}
+
+static __initconst const struct fixups {
+	char *compatible;
+	void (*fixup)(void __iomem *, void __iomem *);
+} fixup_list[] = {
+	{
+		.compatible = "iodata,landisk",
+		.fixup = landisk_fixup,
+	},
+};
+
+static __init void pcic_fixups(struct device_node *np,
+		       void __iomem *pcic, void __iomem *bcr)
+{
+	int i;
+	const struct fixups *f = fixup_list;
+
+	for (i = 0; i < ARRAY_SIZE(fixup_list); i++) {
+		if (of_device_is_compatible(np, f->compatible)) {
+			f->fixup(pcic, bcr);
+			break;
+		}
+	}
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
+static int sh4_pci_read(struct pci_bus *bus, unsigned int devfn,
+			   int where, int size, u32 *val)
+{
+	struct gen_pci *pci = bus->sysdata;
+	void __iomem *pci_reg_base;
+	unsigned long flags;
+	u32 data;
+
+	pci_reg_base = ioremap(pci->cfg.res.start,
+			       pci->cfg.res.end - pci->cfg.res.start);
+
+	/*
+	 * PCIPDR may only be accessed as 32 bit words,
+	 * so we must do byte alignment by hand
+	 */
+	raw_spin_lock_irqsave(&pci_config_lock, flags);
+	pcic_writel(CONFIG_CMD(bus, devfn, where), SH4_PCIPAR);
+	data = pcic_readl(SH4_PCIPDR);
+	raw_spin_unlock_irqrestore(&pci_config_lock, flags);
+
+	switch (size) {
+	case 1:
+		*val = (data >> ((where & 3) << 3)) & 0xff;
+		break;
+	case 2:
+		*val = (data >> ((where & 2) << 3)) & 0xffff;
+		break;
+	case 4:
+		*val = data;
+		break;
+	default:
+		return PCIBIOS_FUNC_NOT_SUPPORTED;
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+/*
+ * Since SH4 only does 32bit access we'll have to do a read,
+ * mask,write operation.
+ * We'll allow an odd byte offset, though it should be illegal.
+ */
+static int sh4_pci_write(struct pci_bus *bus, unsigned int devfn,
+			 int where, int size, u32 val)
+{
+	struct gen_pci *pci = bus->sysdata;
+	void __iomem *pci_reg_base;
+	unsigned long flags;
+	int shift;
+	u32 data;
+
+	pci_reg_base = ioremap(pci->cfg.res.start,
+			       pci->cfg.res.end - pci->cfg.res.start);
+
+	raw_spin_lock_irqsave(&pci_config_lock, flags);
+	pcic_writel(CONFIG_CMD(bus, devfn, where), SH4_PCIPAR);
+	data = pcic_readl(SH4_PCIPDR);
+	raw_spin_unlock_irqrestore(&pci_config_lock, flags);
+
+	switch (size) {
+	case 1:
+		shift = (where & 3) << 3;
+		data &= ~(0xff << shift);
+		data |= ((val & 0xff) << shift);
+		break;
+	case 2:
+		shift = (where & 2) << 3;
+		data &= ~(0xffff << shift);
+		data |= ((val & 0xffff) << shift);
+		break;
+	case 4:
+		data = val;
+		break;
+	default:
+		return PCIBIOS_FUNC_NOT_SUPPORTED;
+	}
+
+	pcic_writel(data, SH4_PCIPDR);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static struct gen_pci_cfg_bus_ops pci_sh7751_ops = {
+	.ops = {
+		.read	= sh4_pci_read,
+		.write	= sh4_pci_write,
+	},
+};
+
+/*
+ * Called after each bus is probed, but before its children
+ * are examined.
+ */
+void pcibios_fixup_bus(struct pci_bus *bus)
+{
+}
+
+/*
+ * We need to avoid collisions with `mirrored' VGA ports
+ * and other strange ISA hardware, so we always want the
+ * addresses to be allocated in the 0x000-0x0ff region
+ * modulo 0x400.
+ */
+resource_size_t pcibios_align_resource(void *data,
+				       const struct resource *res,
+				       resource_size_t size,
+				       resource_size_t align)
+{
+	resource_size_t start = res->start;
+
+	return start;
+}
+
+int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
+			enum pci_mmap_state mmap_state, int write_combine)
+{
+	/*
+	 * I/O space can be accessed via normal processor loads and stores on
+	 * this platform but for now we elect not to do this and portable
+	 * drivers should not do this anyway.
+	 */
+	if (mmap_state == pci_mmap_io)
+		return -EINVAL;
+
+	/*
+	 * Ignore write-combine; for now only return uncached mappings.
+	 */
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+
+	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
+			       vma->vm_end - vma->vm_start,
+			       vma->vm_page_prot);
+}
+
+static const struct of_device_id sh7751_pci_of_match[] = {
+	{ .compatible = "renesas,sh7751-pci", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sh7751_pci_of_match);
+
+static void __init set_pci_bcr(void __iomem *pci_reg_base,
+			       void __iomem *bcr,
+			       unsigned int area)
+{
+	unsigned long word;
+
+	word = __raw_readl(bcr + SH7751_BCR1);
+	/* check BCR for SDRAM in area */
+	if (((word >> area) & 1) == 0) {
+		pr_info("PCI: Area %d is not configured for SDRAM. BCR1=0x%lx\n",
+			area, word);
+		return;
+	}
+	pcic_writel(word, SH4_PCIBCR1);
+
+	word = __raw_readw(bcr + SH7751_BCR2);
+	/* check BCR2 for 32bit SDRAM interface*/
+	if (((word >> (area << 1)) & 0x3) != 0x3) {
+		pr_info("PCI: Area %d is not 32 bit SDRAM. BCR2=0x%lx\n",
+			area, word);
+		return;
+	}
+	pcic_writel(word, SH4_PCIBCR2);
+}
+
+static __init int sh7751_pci_probe(struct platform_device *pdev)
+{
+	struct resource *res, *wres;
+	u32 id;
+	u32 reg, word;
+	void __iomem *pci_reg_base;
+	void __iomem *bcr;
+	struct gen_pci *pci;
+
+	pci = devm_kzalloc(&pdev->dev, sizeof(*pci), GFP_KERNEL);
+	if (!pci)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pci_reg_base = ioremap(res->start, res->end - res->start);
+	if (IS_ERR(pci_reg_base))
+		return PTR_ERR(pci_reg_base);
+
+	wres = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (IS_ERR(wres))
+		return PTR_ERR(wres);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+	bcr = devm_ioremap_resource(&pdev->dev, res);
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
+	reg = __raw_readl(bcr);
+	reg |= 0x80000;
+	__raw_writel(reg, bcr);
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
+	word = wres->end - wres->start - 1;
+	pcic_writel(word, SH4_PCILSR0);
+	/* Set the values on window 0 PCI config registers */
+	word = P2SEGADDR(wres->start);
+	pcic_writel(word, SH4_PCILAR0);
+	pcic_writel(word, PCI_BASE_ADDRESS_1);
+
+	set_pci_bcr(pci_reg_base, bcr, (wres->start >> 27) & 0x07);
+
+	/* configure the wait control registers */
+	word = __raw_readl(bcr + SH7751_WCR1);
+	pcic_writel(word, SH4_PCIWCR1);
+	word = __raw_readl(bcr + SH7751_WCR2);
+	pcic_writel(word, SH4_PCIWCR2);
+	word = __raw_readl(bcr + SH7751_WCR3);
+	pcic_writel(word, SH4_PCIWCR3);
+	word = __raw_readl(bcr + SH7751_MCR);
+	pcic_writel(word, SH4_PCIMCR);
+
+	pcic_fixups(pdev->dev.of_node, pci_reg_base, bcr);
+
+	/*
+	 * SH7751 init done, set central function init complete
+	 * use round robin mode to stop a device starving/overruning
+	 */
+	word = SH4_PCICR_PREFIX | SH4_PCICR_CFIN | SH4_PCICR_ARBM;
+	pcic_writel(word, SH4_PCICR);
+
+	pci->cfg.ops = &pci_sh7751_ops;
+	return pci_host_common_probe(pdev, pci);
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
