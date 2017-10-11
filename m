Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:55470 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752614AbdJKWfE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2017 18:35:04 -0400
From: Jim Quinlan <jim2101024@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Jim Quinlan <jim2101024@gmail.com>
Subject: [PATCH 7/9] PCI: host: brcmstb: add MSI capability
Date: Wed, 11 Oct 2017 18:34:27 -0400
Message-Id: <1507761269-7017-8-git-send-email-jim2101024@gmail.com>
In-Reply-To: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
References: <1507761269-7017-1-git-send-email-jim2101024@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This commit adds MSI to the Broadcom STB PCIe host controller. It does
not add MSIX since that functionality is not in the HW.  The MSI
controller is physically located within the PCIe block, however, there
is no reason why the MSI controller could not be moved elsewhere in
the future.

Since the internal Brcmstb MSI controller is intertwined with the PCIe
controller, it is not its own platform device but rather part of the
PCIe platform device.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/host/Kconfig           |  12 ++
 drivers/pci/host/Makefile          |   1 +
 drivers/pci/host/pci-brcmstb-msi.c | 318 +++++++++++++++++++++++++++++++++++++
 drivers/pci/host/pci-brcmstb.c     |  72 +++++++--
 drivers/pci/host/pci-brcmstb.h     |  26 +++
 5 files changed, 419 insertions(+), 10 deletions(-)
 create mode 100644 drivers/pci/host/pci-brcmstb-msi.c

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index b9b4f11..54aa5d2 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -228,4 +228,16 @@ config PCI_BRCMSTB
 	default ARCH_BRCMSTB || BMIPS_GENERIC
 	help
 	  Adds support for Broadcom Settop Box PCIe host controller.
+	  To compile this driver as a module, choose m here.
+
+config PCI_BRCMSTB_MSI
+	bool "Broadcom Brcmstb PCIe MSI support"
+	depends on ARCH_BRCMSTB || BMIPS_GENERIC
+	depends on OF
+	depends on PCI_MSI
+	default PCI_BRCMSTB
+	help
+	  Say Y here if you want to enable MSI support for Broadcom's iProc
+	  PCIe controller
+
 endmenu
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index c283321..1026d6f 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_PCIE_TANGO_SMP8759) += pcie-tango.o
 obj-$(CONFIG_VMD) += vmd.o
 obj-$(CONFIG_PCI_BRCMSTB) += brcmstb-pci.o
 brcmstb-pci-objs := pci-brcmstb.o pci-brcmstb-dma.o
+obj-$(CONFIG_PCI_BRCMSTB_MSI) += pci-brcmstb-msi.o
 
 # The following drivers are for devices that use the generic ACPI
 # pci_root.c driver but don't support standard ECAM config access.
diff --git a/drivers/pci/host/pci-brcmstb-msi.c b/drivers/pci/host/pci-brcmstb-msi.c
new file mode 100644
index 0000000..c805e2f
--- /dev/null
+++ b/drivers/pci/host/pci-brcmstb-msi.c
@@ -0,0 +1,318 @@
+/*
+ * Copyright (C) 2015-2017 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ */
+#include <linux/bitops.h>
+#include <linux/compiler.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/msi.h>
+#include <linux/of_irq.h>
+#include <linux/of_pci.h>
+#include <linux/of_platform.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+
+#include "pci-brcmstb.h"
+
+#define PCIE_MISC_MSI_DATA_CONFIG			0x404c
+#define PCIE_MSI_INTR2_BASE				0x4500
+#define PCIE_MISC_MSI_BAR_CONFIG_LO			0x4044
+#define PCIE_MISC_MSI_BAR_CONFIG_HI			0x4048
+
+/* Offsets from PCIE_INTR2_CPU_BASE and PCIE_MSI_INTR2_BASE */
+#define STATUS				0x0
+#define SET				0x4
+#define CLR				0x8
+#define MASK_STATUS			0xc
+#define MASK_SET			0x10
+#define MASK_CLR			0x14
+
+struct brcm_msi {
+	struct irq_domain *msi_domain;
+	struct irq_domain *inner_domain;
+	struct mutex lock; /* guards the alloc/free operations */
+	u64 target_addr;
+	int irq;
+	/* intr_base is the base pointer for interrupt status/set/clr regs */
+	void __iomem *intr_base;
+	/* intr_legacy_mask indicates how many bits are MSI interrupts */
+	u32 intr_legacy_mask;
+	/* intr_legacy_offset indicates bit position of MSI_01. It is
+	 * to map the register bit position to a hwirq that starts at 0.
+	 */
+	u32 intr_legacy_offset;
+	/* used indicates which MSI interrupts have been alloc'd */
+	unsigned long used;
+
+	void __iomem *base;
+	struct device *dev;
+	struct device_node *dn;
+	unsigned int rev;
+};
+
+static struct irq_chip brcm_msi_irq_chip = {
+	.name = "Brcm_MSI",
+	.irq_mask = pci_msi_mask_irq,
+	.irq_unmask = pci_msi_unmask_irq,
+};
+
+static struct msi_domain_info brcm_msi_domain_info = {
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		   MSI_FLAG_PCI_MSIX),
+	.chip	= &brcm_msi_irq_chip,
+};
+
+static void brcm_pcie_msi_isr(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct brcm_msi *msi;
+	unsigned long status, virq;
+	u32 mask, bit, hwirq;
+
+	chained_irq_enter(chip, desc);
+	msi = irq_desc_get_handler_data(desc);
+	mask = msi->intr_legacy_mask;
+
+	while ((status = bcm_readl(msi->intr_base + STATUS) & mask)) {
+		for_each_set_bit(bit, &status, BRCM_INT_PCI_MSI_NR) {
+			/* clear the interrupt */
+			bcm_writel(1 << bit, msi->intr_base + CLR);
+
+			/* Account for legacy interrupt offset */
+			hwirq = bit - msi->intr_legacy_offset;
+
+			virq = irq_find_mapping(msi->inner_domain, hwirq);
+			if (virq) {
+				if (msi->used & (1 << hwirq))
+					generic_handle_irq(virq);
+				else
+					dev_info(msi->dev, "unhandled MSI %d\n",
+						 hwirq);
+			} else {
+				/* Unknown MSI, just clear it */
+				dev_dbg(msi->dev, "unexpected MSI\n");
+			}
+		}
+	}
+	chained_irq_exit(chip, desc);
+}
+
+static void brcm_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	struct brcm_msi *msi = irq_data_get_irq_chip_data(data);
+	u32 temp;
+
+	msg->address_lo = lower_32_bits(msi->target_addr);
+	msg->address_hi = upper_32_bits(msi->target_addr);
+	temp = bcm_readl(msi->base + PCIE_MISC_MSI_DATA_CONFIG);
+	msg->data = ((temp >> 16) & (temp & 0xffff)) | data->hwirq;
+}
+
+static int brcm_msi_set_affinity(struct irq_data *irq_data,
+				 const struct cpumask *mask, bool force)
+{
+	return -EINVAL;
+}
+
+static struct irq_chip brcm_msi_bottom_irq_chip = {
+	.name			= "Brcm MSI",
+	.irq_compose_msi_msg	= brcm_compose_msi_msg,
+	.irq_set_affinity	= brcm_msi_set_affinity,
+};
+
+static int brcm_msi_alloc(struct brcm_msi *msi)
+{
+	int bit, hwirq;
+
+	mutex_lock(&msi->lock);
+	bit = ~msi->used ? ffz(msi->used) : -1;
+
+	if (bit >= 0 && bit < BRCM_INT_PCI_MSI_NR) {
+		msi->used |= (1 << bit);
+		hwirq = bit - msi->intr_legacy_offset;
+	} else {
+		hwirq = -ENOSPC;
+	}
+
+	mutex_unlock(&msi->lock);
+	return hwirq;
+}
+
+static void brcm_msi_free(struct brcm_msi *msi, unsigned long hwirq)
+{
+	mutex_lock(&msi->lock);
+	msi->used &= ~(1 << (hwirq + msi->intr_legacy_offset));
+	mutex_unlock(&msi->lock);
+}
+
+static int brcm_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				 unsigned int nr_irqs, void *args)
+{
+	struct brcm_msi *msi = domain->host_data;
+	int hwirq;
+
+	hwirq = brcm_msi_alloc(msi);
+
+	if (hwirq < 0)
+		return hwirq;
+
+	irq_domain_set_info(domain, virq, (irq_hw_number_t)hwirq,
+			    &brcm_msi_bottom_irq_chip, domain->host_data,
+			    handle_simple_irq, NULL, NULL);
+	return 0;
+}
+
+static void brcm_irq_domain_free(struct irq_domain *domain,
+				 unsigned int virq, unsigned int nr_irqs)
+{
+	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
+	struct brcm_msi *msi = irq_data_get_irq_chip_data(d);
+
+	brcm_msi_free(msi, d->hwirq);
+}
+
+void brcm_msi_set_regs(struct brcm_msi *msi)
+{
+	u32 data_val, msi_lo, msi_hi;
+
+	if (msi->rev >= BRCM_PCIE_HW_REV_33) {
+		/* ffe0 -- least sig 5 bits are 0 indicating 32 msgs
+		 * 6540 -- this is our arbitrary unique data value
+		 */
+		data_val = 0xffe06540;
+	} else {
+		/* fff8 -- least sig 3 bits are 0 indicating 8 msgs
+		 * 6540 -- this is our arbitrary unique data value
+		 */
+		data_val = 0xfff86540;
+	}
+
+	/* Make sure we are not masking MSIs.  Note that MSIs can be masked,
+	 * but that occurs on the PCIe EP device
+	 */
+	bcm_writel(0xffffffff & msi->intr_legacy_mask,
+		   msi->intr_base + MASK_CLR);
+
+	msi_lo = lower_32_bits(msi->target_addr);
+	msi_hi = upper_32_bits(msi->target_addr);
+	/* The 0 bit of PCIE_MISC_MSI_BAR_CONFIG_LO is repurposed to MSI
+	 * enable, which we set to 1.
+	 */
+	bcm_writel(msi_lo | 1, msi->base + PCIE_MISC_MSI_BAR_CONFIG_LO);
+	bcm_writel(msi_hi, msi->base + PCIE_MISC_MSI_BAR_CONFIG_HI);
+	bcm_writel(data_val, msi->base + PCIE_MISC_MSI_DATA_CONFIG);
+}
+EXPORT_SYMBOL(brcm_msi_set_regs);
+
+static const struct irq_domain_ops msi_domain_ops = {
+	.alloc	= brcm_irq_domain_alloc,
+	.free	= brcm_irq_domain_free,
+};
+
+static int brcm_allocate_domains(struct brcm_msi *msi)
+{
+	struct fwnode_handle *fwnode = of_node_to_fwnode(msi->dn);
+
+	msi->inner_domain = irq_domain_add_linear(NULL, BRCM_INT_PCI_MSI_NR,
+						  &msi_domain_ops, msi);
+	if (!msi->inner_domain) {
+		dev_err(msi->dev, "failed to create IRQ domain\n");
+		return -ENOMEM;
+	}
+
+	msi->msi_domain = pci_msi_create_irq_domain(fwnode,
+						    &brcm_msi_domain_info,
+						    msi->inner_domain);
+	if (!msi->msi_domain) {
+		dev_err(msi->dev, "failed to create MSI domain\n");
+		irq_domain_remove(msi->inner_domain);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void brcm_free_domains(struct brcm_msi *msi)
+{
+	irq_domain_remove(msi->msi_domain);
+	irq_domain_remove(msi->inner_domain);
+}
+
+void brcm_msi_remove(struct brcm_msi *msi)
+{
+	if (!msi)
+		return;
+	irq_set_chained_handler(msi->irq, NULL);
+	irq_set_handler_data(msi->irq, NULL);
+	brcm_free_domains(msi);
+}
+EXPORT_SYMBOL(brcm_msi_remove);
+
+int brcm_msi_probe(struct platform_device *pdev, struct brcm_info *info)
+{
+	struct brcm_msi *msi;
+	int irq, ret;
+
+	irq = irq_of_parse_and_map(pdev->dev.of_node, 1);
+	if (irq <= 0) {
+		dev_err(&pdev->dev, "cannot map msi intr\n");
+		return -ENODEV;
+	}
+
+	msi = devm_kzalloc(&pdev->dev, sizeof(struct brcm_msi), GFP_KERNEL);
+	if (!msi)
+		return -ENOMEM;
+
+	msi->dev = &pdev->dev;
+	msi->base = info->base;
+	msi->rev =  info->rev;
+	msi->dn = pdev->dev.of_node;
+	msi->target_addr = info->msi_target_addr;
+	msi->irq = irq;
+
+	ret = brcm_allocate_domains(msi);
+	if (ret)
+		return ret;
+
+	irq_set_chained_handler_and_data(msi->irq, brcm_pcie_msi_isr, msi);
+
+	if (msi->rev >= BRCM_PCIE_HW_REV_33) {
+		msi->intr_base = msi->base + PCIE_MSI_INTR2_BASE;
+		/* This version of PCIe hw has only 32 intr bits
+		 * starting at bit position 0.
+		 */
+		msi->intr_legacy_mask = 0xffffffff;
+		msi->intr_legacy_offset = 0x0;
+		msi->used = 0x0;
+
+	} else {
+		msi->intr_base = msi->base + PCIE_INTR2_CPU_BASE;
+		/* This version of PCIe hw has only 8 intr bits starting
+		 * at bit position 24.
+		 */
+		msi->intr_legacy_mask = 0xff000000;
+		msi->intr_legacy_offset = 24;
+		msi->used = 0x00ffffff;
+	}
+
+	brcm_msi_set_regs(msi);
+	info->msi = msi;
+
+	return 0;
+}
+EXPORT_SYMBOL(brcm_msi_probe);
diff --git a/drivers/pci/host/pci-brcmstb.c b/drivers/pci/host/pci-brcmstb.c
index 03c0da9..7a8ad43 100644
--- a/drivers/pci/host/pci-brcmstb.c
+++ b/drivers/pci/host/pci-brcmstb.c
@@ -22,6 +22,7 @@
 #include <linux/list.h>
 #include <linux/log2.h>
 #include <linux/module.h>
+#include <linux/msi.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_pci.h>
@@ -327,10 +328,13 @@ struct brcm_pcie {
 	int			num_out_wins;
 	bool			ssc;
 	int			gen;
+	u64			msi_target_addr;
 	struct brcm_window	out_wins[BRCM_NUM_PCI_OUT_WINS];
 	struct list_head	resources;
 	struct device		*dev;
 	struct list_head	pwr_supplies;
+	struct brcm_msi		*msi;
+	bool			msi_internal;
 	unsigned int		rev;
 	unsigned int		num;
 	bool			bridge_setup_done;
@@ -781,6 +785,7 @@ static void brcm_pcie_setup_prep(struct brcm_pcie *pcie)
 	void __iomem *base = pcie->base;
 	unsigned int scb_size_val;
 	u64 rc_bar2_size = 0, rc_bar2_offset = 0, total_mem_size = 0;
+	u64 msi_target_addr;
 	u32 tmp, burst;
 	int i;
 
@@ -824,14 +829,17 @@ static void brcm_pcie_setup_prep(struct brcm_pcie *pcie)
 	/* The PCI host controller by design must set the inbound
 	 * viewport to be a contiguous arrangement of all of the
 	 * system's memory.  In addition, its size mut be a power of
-	 * two.  To further complicate matters, the viewport must
-	 * start on a pci-address that is aligned on a multiple of its
-	 * size.  If a portion of the viewport does not represent
-	 * system memory -- e.g. 3GB of memory requires a 4GB viewport
-	 * -- we can map the outbound memory in or after 3GB and even
-	 * though the viewport will overlap the outbound memory the
-	 * controller will know to send outbound memory downstream and
-	 * everything else upstream.
+	 * two.  Further, the MSI target address must NOT be placed
+	 * inside this region, as the decoding logic will consider its
+	 * address to be inbound memory traffic.  To further
+	 * complicate matters, the viewport must start on a
+	 * pci-address that is aligned on a multiple of its size.
+	 * If a portion of the viewport does not represent system
+	 * memory -- e.g. 3GB of memory requires a 4GB viewport --
+	 * we can map the outbound memory in or after 3GB and even
+	 * though the viewport will overlap the outbound memory
+	 * the controller will know to send outbound memory downstream
+	 * and everything else upstream.
 	 */
 	rc_bar2_size = roundup_pow_of_two_64(total_mem_size);
 
@@ -846,6 +854,14 @@ static void brcm_pcie_setup_prep(struct brcm_pcie *pcie)
 		if (total_mem_size <= 0xc0000000ULL &&
 		    rc_bar2_size <= 0x100000000ULL) {
 			rc_bar2_offset = 0;
+			/* If the viewport is less then 4GB we can fit
+			 * the MSI target address under 4GB. Otherwise
+			 * put it right below 64GB.
+			 */
+			msi_target_addr =
+				(rc_bar2_size == 0x100000000ULL)
+				? BRCM_MSI_TARGET_ADDR_GT_4GB
+				: BRCM_MSI_TARGET_ADDR_LT_4GB;
 		} else {
 			/* The system memory is 4GB or larger so we
 			 * cannot start the inbound region at location
@@ -854,15 +870,24 @@ static void brcm_pcie_setup_prep(struct brcm_pcie *pcie)
 			 * start it at the 1x multiple of its size
 			 */
 			rc_bar2_offset = rc_bar2_size;
-		}
 
+			/* Since we are starting the viewport at 4GB or
+			 * higher, put the MSI target address below 4GB
+			 */
+			msi_target_addr = BRCM_MSI_TARGET_ADDR_LT_4GB;
+		}
 	} else {
 		/* Set simple configuration based on memory sizes
 		 * only.  We always start the viewport at address 0,
 		 * and set the MSI target address accordingly.
 		 */
 		rc_bar2_offset = 0;
+
+		msi_target_addr = (rc_bar2_size >= 0x100000000ULL)
+			? BRCM_MSI_TARGET_ADDR_GT_4GB
+			: BRCM_MSI_TARGET_ADDR_LT_4GB;
 	}
+	pcie->msi_target_addr = msi_target_addr;
 
 	tmp = lower_32_bits(rc_bar2_offset);
 	tmp = INSERT_FIELD(tmp, PCIE_MISC_RC_BAR2_CONFIG_LO, SIZE,
@@ -1071,6 +1096,9 @@ static int brcm_pcie_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	if (pcie->msi && pcie->msi_internal)
+		brcm_msi_set_regs(pcie->msi);
+
 	pcie->suspended = false;
 
 	return 0;
@@ -1134,6 +1162,7 @@ static void __attribute__((__section__("pci_fixup_early")))
 
 static void _brcm_pcie_remove(struct brcm_pcie *pcie)
 {
+	brcm_msi_remove(pcie->msi);
 	turn_off(pcie);
 	clk_disable_unprepare(pcie->clk);
 	clk_put(pcie->clk);
@@ -1143,7 +1172,7 @@ static void _brcm_pcie_remove(struct brcm_pcie *pcie)
 
 static int brcm_pcie_probe(struct platform_device *pdev)
 {
-	struct device_node *dn = pdev->dev.of_node;
+	struct device_node *dn = pdev->dev.of_node, *msi_dn;
 	const struct of_device_id *of_id;
 	const struct pcie_cfg_data *data;
 	int i, ret;
@@ -1259,6 +1288,29 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		goto fail;
 
+	msi_dn = of_parse_phandle(pcie->dn, "msi-parent", 0);
+	/* Use the internal MSI if no msi-parent property */
+	if (!msi_dn)
+		msi_dn = pcie->dn;
+
+	if (IS_ENABLED(CONFIG_PCI_MSI) && pci_msi_enabled()
+	    && msi_dn == pcie->dn) {
+		struct brcm_info info;
+
+		info.rev = pcie->rev;
+		info.msi_target_addr = pcie->msi_target_addr;
+		info.base = pcie->base;
+
+		ret = brcm_msi_probe(pdev, &info);
+		if (ret)
+			dev_err(pcie->dev,
+				"probe of internal MSI failed: %d)", ret);
+		else
+			pcie->msi_internal = true;
+
+		pcie->msi = info.msi;
+	}
+
 	list_splice_init(&pcie->resources, &bridge->windows);
 	bridge->dev.parent = &pdev->dev;
 	bridge->busnr = 0;
diff --git a/drivers/pci/host/pci-brcmstb.h b/drivers/pci/host/pci-brcmstb.h
index 4851be8..f48e368 100644
--- a/drivers/pci/host/pci-brcmstb.h
+++ b/drivers/pci/host/pci-brcmstb.h
@@ -21,11 +21,37 @@
 /* Broadcom PCIE Offsets */
 #define PCIE_INTR2_CPU_BASE		0x4300
 
+struct brcm_msi;
+struct brcm_info;
+struct platform_device;
+
 dma_addr_t brcm_to_pci(dma_addr_t addr);
 dma_addr_t brcm_to_cpu(dma_addr_t addr);
 
 extern struct notifier_block brcmstb_platform_nb;
 
+#ifdef CONFIG_PCI_BRCMSTB_MSI
+int brcm_msi_probe(struct platform_device *pdev, struct brcm_info *info);
+void brcm_msi_set_regs(struct brcm_msi *chip);
+void brcm_msi_remove(struct brcm_msi *chip);
+#else
+static inline int brcm_msi_probe(struct platform_device *pdev,
+				 struct brcm_info *info)
+{
+	return -ENODEV;
+}
+
+static inline void brcm_msi_set_regs(struct brcm_msi *chip) {}
+static inline void brcm_msi_remove(struct brcm_msi *chip) {}
+#endif /* CONFIG_PCI_BRCMSTB_MSI */
+
+struct brcm_info {
+	int rev;
+	u64 msi_target_addr;
+	void __iomem *base;
+	struct brcm_msi *msi;
+};
+
 #define BRCMSTB_ERROR_CODE	(~(dma_addr_t)0x0)
 
 #if defined(CONFIG_MIPS)
-- 
1.9.0.138.g2de3478
