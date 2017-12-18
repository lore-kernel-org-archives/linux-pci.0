Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 4.mo3.mail-out.ovh.net ([178.33.46.10]:54712 "EHLO
        4.mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938257AbdLRS20 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Dec 2017 13:28:26 -0500
Received: from player158.ha.ovh.net (b7.ovh.net [213.186.33.57])
        by mo3.mail-out.ovh.net (Postfix) with ESMTP id 1D5E21789F5
        for <linux-pci@vger.kernel.org>; Mon, 18 Dec 2017 19:19:00 +0100 (CET)
From: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
To: bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org
Cc: adouglas@cadence.com, stelford@cadence.com, dgary@cadence.com,
        kgopi@cadence.com, eandrews@cadence.com,
        thomas.petazzoni@free-electrons.com, sureshp@cadence.com,
        nsekhar@ti.com, linux-kernel@vger.kernel.org, robh@kernel.org,
        devicetree@vger.kernel.org,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Subject: [PATCH v2 9/9] PCI: cadence: Add EndPoint Controller driver for Cadence PCIe controller
Date: Mon, 18 Dec 2017 19:16:09 +0100
Message-Id: <29e81ceb112030032f42a467183106453a63123f.1513620412.git.cyrille.pitchen@free-electrons.com>
In-Reply-To: <cover.1513620412.git.cyrille.pitchen@free-electrons.com>
References: <cover.1513620412.git.cyrille.pitchen@free-electrons.com>
In-Reply-To: <cover.1513620412.git.cyrille.pitchen@free-electrons.com>
References: <cover.1513620412.git.cyrille.pitchen@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds support to the Cadence PCIe controller in endpoint mode.

drivers/pci/Makefile was previously patched so
drivers/pci/cadence/pcie-cadence-ep.o is linked after drivers/pci/endpoint
objects, otherwise the built-in pci-cadence-ep driver would be probed
before the PCI endpoint libraries would have been initialized, which would
result in a kernel crash: controllers_group would still be NULL when
devm_pci_epc_create() is called.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
---
 drivers/pci/cadence/Kconfig           |   9 +
 drivers/pci/cadence/Makefile          |   1 +
 drivers/pci/cadence/pcie-cadence-ep.c | 531 ++++++++++++++++++++++++++++++++++
 drivers/pci/cadence/pcie-cadence.c    |  27 ++
 drivers/pci/cadence/pcie-cadence.h    | 114 ++++++++
 5 files changed, 682 insertions(+)
 create mode 100644 drivers/pci/cadence/pcie-cadence-ep.c

diff --git a/drivers/pci/cadence/Kconfig b/drivers/pci/cadence/Kconfig
index 0d15b40861e9..70aa03b86e0d 100644
--- a/drivers/pci/cadence/Kconfig
+++ b/drivers/pci/cadence/Kconfig
@@ -21,4 +21,13 @@ config PCIE_CADENCE_HOST
 	  mode. This PCIe controller may be embedded into many different vendors
 	  SoCs.
 
+config PCIE_CADENCE_EP
+	bool "Cadence PCIe endpoint controller"
+	depends on PCI_ENDPOINT
+	select PCIE_CADENCE
+	help
+	  Say Y here if you want to support the Cadence PCIe  controller in
+	  endpoint mode. This PCIe controller may be embedded into many
+	  different vendors SoCs.
+
 endif # PCI_CADENCE
diff --git a/drivers/pci/cadence/Makefile b/drivers/pci/cadence/Makefile
index 589601a8ff89..719392b97998 100644
--- a/drivers/pci/cadence/Makefile
+++ b/drivers/pci/cadence/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence.o
 obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
+obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o
diff --git a/drivers/pci/cadence/pcie-cadence-ep.c b/drivers/pci/cadence/pcie-cadence-ep.c
new file mode 100644
index 000000000000..d940f5fb4ca0
--- /dev/null
+++ b/drivers/pci/cadence/pcie-cadence-ep.c
@@ -0,0 +1,531 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2017 Cadence
+// Cadence PCIe endpoint controller driver.
+// Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
+
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/pci-epc.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/sizes.h>
+
+#include "pcie-cadence.h"
+
+#define CDNS_PCIE_EP_MIN_APERTURE		128	/* 128 bytes */
+#define CDNS_PCIE_EP_IRQ_PCI_ADDR_NONE		0x1
+#define CDNS_PCIE_EP_IRQ_PCI_ADDR_LEGACY	0x3
+
+/**
+ * struct cdns_pcie_ep - private data for this PCIe endpoint controller driver
+ * @pcie: Cadence PCIe controller
+ * @max_regions: maximum number of regions supported by hardware
+ * @ob_region_map: bitmask of mapped outbound regions
+ * @ob_addr: base addresses in the AXI bus where the outbound regions start
+ * @irq_phys_addr: base address on the AXI bus where the MSI/legacy IRQ
+ *		   dedicated outbound regions is mapped.
+ * @irq_cpu_addr: base address in the CPU space where a write access triggers
+ *		  the sending of a memory write (MSI) / normal message (legacy
+ *		  IRQ) TLP through the PCIe bus.
+ * @irq_pci_addr: used to save the current mapping of the MSI/legacy IRQ
+ *		  dedicated outbound region.
+ * @irq_pending: bitmask of asserted legacy IRQs.
+ */
+struct cdns_pcie_ep {
+	struct cdns_pcie		pcie;
+	u32				max_regions;
+	unsigned long			ob_region_map;
+	phys_addr_t			*ob_addr;
+	phys_addr_t			irq_phys_addr;
+	void __iomem			*irq_cpu_addr;
+	u64				irq_pci_addr;
+	u8				irq_pending;
+};
+
+static int cdns_pcie_ep_write_header(struct pci_epc *epc, u8 fn,
+				     struct pci_epf_header *hdr)
+{
+	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
+	struct cdns_pcie *pcie = &ep->pcie;
+
+	cdns_pcie_ep_fn_writew(pcie, fn, PCI_DEVICE_ID, hdr->deviceid);
+	cdns_pcie_ep_fn_writeb(pcie, fn, PCI_REVISION_ID, hdr->revid);
+	cdns_pcie_ep_fn_writeb(pcie, fn, PCI_CLASS_PROG, hdr->progif_code);
+	cdns_pcie_ep_fn_writew(pcie, fn, PCI_CLASS_DEVICE,
+			       hdr->subclass_code | hdr->baseclass_code << 8);
+	cdns_pcie_ep_fn_writeb(pcie, fn, PCI_CACHE_LINE_SIZE,
+			       hdr->cache_line_size);
+	cdns_pcie_ep_fn_writew(pcie, fn, PCI_SUBSYSTEM_ID, hdr->subsys_id);
+	cdns_pcie_ep_fn_writeb(pcie, fn, PCI_INTERRUPT_PIN, hdr->interrupt_pin);
+
+	/*
+	 * Vendor ID can only be modified from function 0, all other functions
+	 * use the same vendor ID as function 0.
+	 * Besides, function 0 'enabled' bit is hard-wired to 1, only other
+	 * functions can be enabled/disabled by software.
+	 */
+	if (fn == 0) {
+		/* Update the vendor IDs. */
+		u32 id = CDNS_PCIE_LM_ID_VENDOR(hdr->vendorid) |
+			 CDNS_PCIE_LM_ID_SUBSYS(hdr->subsys_vendor_id);
+
+		cdns_pcie_writel(pcie, CDNS_PCIE_LM_ID, id);
+	} else {
+		/* Enable this endpoint function. */
+		u32 cfg = cdns_pcie_readl(pcie, CDNS_PCIE_LM_EP_FUNC_CFG);
+
+		cfg |= BIT(fn);
+		cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, cfg);
+	}
+
+	return 0;
+}
+
+static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn, enum pci_barno bar,
+				dma_addr_t bar_phys, size_t size, int flags)
+{
+	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
+	struct cdns_pcie *pcie = &ep->pcie;
+	u32 addr0, addr1, reg, cfg, b, aperture, ctrl;
+	u64 sz;
+
+	/* BAR size is 2^(aperture + 7) */
+	sz = max_t(size_t, size, CDNS_PCIE_EP_MIN_APERTURE);
+	sz = 1ULL << fls64(sz - 1);
+	aperture = ilog2(sz) - 7; /* 128B -> 0, 256B -> 1, 512B -> 2, ... */
+
+	if ((flags & PCI_BASE_ADDRESS_SPACE) == PCI_BASE_ADDRESS_SPACE_IO) {
+		ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_IO_32BITS;
+	} else {
+		bool is_prefetch = !!(flags & PCI_BASE_ADDRESS_MEM_PREFETCH);
+		bool is_64bits = sz > SZ_2G;
+
+		if (is_64bits && (bar & 1))
+			return -EINVAL;
+
+		if (is_64bits && is_prefetch)
+			ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS;
+		else if (is_prefetch)
+			ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS;
+		else if (is_64bits)
+			ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_64BITS;
+		else
+			ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_32BITS;
+	}
+
+	addr0 = lower_32_bits(bar_phys);
+	addr1 = upper_32_bits(bar_phys);
+	cdns_pcie_writel(pcie, CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar),
+			 addr0);
+	cdns_pcie_writel(pcie, CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar),
+			 addr1);
+
+	if (bar < BAR_4) {
+		reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG0(fn);
+		b = bar;
+	} else {
+		reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG1(fn);
+		b = bar - BAR_4;
+	}
+
+	cfg = cdns_pcie_readl(pcie, reg);
+	cfg &= ~(CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b) |
+		 CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b));
+	cfg |= (CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE(b, aperture) |
+		CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL(b, ctrl));
+	cdns_pcie_writel(pcie, reg, cfg);
+
+	return 0;
+}
+
+static void cdns_pcie_ep_clear_bar(struct pci_epc *epc, u8 fn,
+				   enum pci_barno bar)
+{
+	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
+	struct cdns_pcie *pcie = &ep->pcie;
+	u32 reg, cfg, b, ctrl;
+
+	if (bar < BAR_4) {
+		reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG0(fn);
+		b = bar;
+	} else {
+		reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG1(fn);
+		b = bar - BAR_4;
+	}
+
+	ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_DISABLED;
+	cfg = cdns_pcie_readl(pcie, reg);
+	cfg &= ~(CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b) |
+		 CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b));
+	cfg |= CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(ctrl);
+	cdns_pcie_writel(pcie, reg, cfg);
+
+	cdns_pcie_writel(pcie, CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar), 0);
+	cdns_pcie_writel(pcie, CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar), 0);
+}
+
+static int cdns_pcie_ep_map_addr(struct pci_epc *epc, u8 fn, phys_addr_t addr,
+				 u64 pci_addr, size_t size)
+{
+	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
+	struct cdns_pcie *pcie = &ep->pcie;
+	u32 r;
+
+	r = find_first_zero_bit(&ep->ob_region_map,
+				sizeof(ep->ob_region_map) * BITS_PER_LONG);
+	if (r >= ep->max_regions - 1) {
+		dev_err(&epc->dev, "no free outbound region\n");
+		return -EINVAL;
+	}
+
+	cdns_pcie_set_outbound_region(pcie, r, false, addr, pci_addr, size);
+
+	set_bit(r, &ep->ob_region_map);
+	ep->ob_addr[r] = addr;
+
+	return 0;
+}
+
+static void cdns_pcie_ep_unmap_addr(struct pci_epc *epc, u8 fn,
+				    phys_addr_t addr)
+{
+	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
+	struct cdns_pcie *pcie = &ep->pcie;
+	u32 r;
+
+	for (r = 0; r < ep->max_regions - 1; r++)
+		if (ep->ob_addr[r] == addr)
+			break;
+
+	if (r == ep->max_regions - 1)
+		return;
+
+	cdns_pcie_reset_outbound_region(pcie, r);
+
+	ep->ob_addr[r] = 0;
+	clear_bit(r, &ep->ob_region_map);
+}
+
+static int cdns_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 mmc)
+{
+	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
+	struct cdns_pcie *pcie = &ep->pcie;
+	u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
+	u16 flags;
+
+	/* Validate the ID of the MSI Capability structure. */
+	if (cdns_pcie_ep_fn_readb(pcie, fn, cap) != PCI_CAP_ID_MSI)
+		return -EINVAL;
+
+	/*
+	 * Set the Multiple Message Capable bitfield into the Message Control
+	 * register.
+	 */
+	flags = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_FLAGS);
+	flags = (flags & ~PCI_MSI_FLAGS_QMASK) | (mmc << 1);
+	flags |= PCI_MSI_FLAGS_64BIT;
+	flags &= ~PCI_MSI_FLAGS_MASKBIT;
+	cdns_pcie_ep_fn_writew(pcie, fn, cap + PCI_MSI_FLAGS, flags);
+
+	return 0;
+}
+
+static int cdns_pcie_ep_get_msi(struct pci_epc *epc, u8 fn)
+{
+	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
+	struct cdns_pcie *pcie = &ep->pcie;
+	u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
+	u16 flags, mmc, mme;
+
+	/* Validate the ID of the MSI Capability structure. */
+	if (cdns_pcie_ep_fn_readb(pcie, fn, cap) != PCI_CAP_ID_MSI)
+		return -EINVAL;
+
+	/* Validate that the MSI feature is actually enabled. */
+	flags = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_FLAGS);
+	if (!(flags & PCI_MSI_FLAGS_ENABLE))
+		return -EINVAL;
+
+	/*
+	 * Get the Multiple Message Enable bitfield from the Message Control
+	 * register.
+	 */
+	mmc = (flags & PCI_MSI_FLAGS_QMASK) >> 1;
+	mme = (flags & PCI_MSI_FLAGS_QSIZE) >> 4;
+
+	/*
+	 * The Multiple Message Enable value should always be equal to or less
+	 * than The Multiple Message Capable value.
+	 */
+	if (mme > mmc)
+		mme = mmc;
+
+	/*
+	 * There are up to 32 MSI: mme stores the number of enabled MSI as a
+	 * power of two. Hence mme can't be geater than 5 (2^5 == 32).
+	 */
+	if (mme > 5)
+		mme = 5;
+
+	return mme;
+}
+
+static void cdns_pcie_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn,
+				     u8 intx, bool is_asserted)
+{
+	struct cdns_pcie *pcie = &ep->pcie;
+	u32 r = ep->max_regions - 1;
+	u32 offset;
+	u16 status;
+	u8 msg_code;
+
+	intx &= 3;
+
+	/* Set the outbound region if needed. */
+	if (unlikely(ep->irq_pci_addr != CDNS_PCIE_EP_IRQ_PCI_ADDR_LEGACY)) {
+		/* Last region was reserved for IRQ writes. */
+		cdns_pcie_set_outbound_region_for_normal_msg(pcie, r,
+							     ep->irq_phys_addr);
+		ep->irq_pci_addr = CDNS_PCIE_EP_IRQ_PCI_ADDR_LEGACY;
+	}
+
+	if (is_asserted) {
+		ep->irq_pending |= BIT(intx);
+		msg_code = MSG_CODE_ASSERT_INTA + intx;
+	} else {
+		ep->irq_pending &= ~BIT(intx);
+		msg_code = MSG_CODE_DEASSERT_INTA + intx;
+	}
+
+	status = cdns_pcie_ep_fn_readw(pcie, fn, PCI_STATUS);
+	if (((status & PCI_STATUS_INTERRUPT) != 0) ^ (ep->irq_pending != 0)) {
+		status ^= PCI_STATUS_INTERRUPT;
+		cdns_pcie_ep_fn_writew(pcie, fn, PCI_STATUS, status);
+	}
+
+	offset = CDNS_PCIE_NORMAL_MSG_ROUTING(MSG_ROUTING_LOCAL) |
+		 CDNS_PCIE_NORMAL_MSG_CODE(msg_code) |
+		 CDNS_PCIE_MSG_NO_DATA;
+	writel(0, ep->irq_cpu_addr + offset);
+}
+
+static int cdns_pcie_ep_send_legacy_irq(struct cdns_pcie_ep *ep, u8 fn, u8 intx)
+{
+	u16 cmd;
+
+	cmd = cdns_pcie_ep_fn_readw(&ep->pcie, fn, PCI_COMMAND);
+	if (cmd & PCI_COMMAND_INTX_DISABLE)
+		return -EINVAL;
+
+	cdns_pcie_ep_assert_intx(ep, fn, intx, true);
+	/*
+	 * The mdelay() value was taken from dra7xx_pcie_raise_legacy_irq()
+	 * from drivers/pci/dwc/pci-dra7xx.c
+	 */
+	mdelay(1);
+	cdns_pcie_ep_assert_intx(ep, fn, intx, false);
+	return 0;
+}
+
+static int cdns_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn,
+				  enum pci_epc_irq_type type, u8 interrupt_num)
+{
+	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
+	struct cdns_pcie *pcie = &ep->pcie;
+	u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
+	u16 flags, mmc, mme, data, data_mask;
+	u8 msi_count;
+	u64 pci_addr, pci_addr_mask = 0xff;
+
+	/* Handle legacy IRQ. */
+	if (type == PCI_EPC_IRQ_LEGACY)
+		return cdns_pcie_ep_send_legacy_irq(ep, fn, 0);
+
+	/* Otherwise MSI. */
+	if (type != PCI_EPC_IRQ_MSI)
+		return -EINVAL;
+
+	/* Check whether the MSI feature has been enabled by the PCI host. */
+	flags = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_FLAGS);
+	if (!(flags & PCI_MSI_FLAGS_ENABLE))
+		return -EINVAL;
+
+	/* Get the number of enabled MSIs */
+	mmc = (flags & PCI_MSI_FLAGS_QMASK) >> 1;
+	mme = (flags & PCI_MSI_FLAGS_QSIZE) >> 4;
+
+	/*
+	 * The Multiple Message Enable value should always be equal to or less
+	 * than The Multiple Message Capable value.
+	 */
+	if (mme > mmc)
+		mme = mmc;
+
+	/*
+	 * There are up to 32 MSI: mme stores the number of enabled MSI as a
+	 * power of two. Hence mme can't be geater than 5 (2^5 == 32).
+	 */
+	if (mme > 5)
+		mme = 5;
+
+	msi_count = 1 << mme;
+	if (!interrupt_num || interrupt_num > msi_count)
+		return -EINVAL;
+
+	/* Compute the data value to be written. */
+	data_mask = msi_count - 1;
+	data = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_DATA_64);
+	data = (data & ~data_mask) | ((interrupt_num - 1) & data_mask);
+
+	/* Get the PCI address where to write the data into. */
+	pci_addr = cdns_pcie_ep_fn_readl(pcie, fn, cap + PCI_MSI_ADDRESS_HI);
+	pci_addr <<= 32;
+	pci_addr |= cdns_pcie_ep_fn_readl(pcie, fn, cap + PCI_MSI_ADDRESS_LO);
+	pci_addr &= GENMASK_ULL(63, 2);
+
+	/* Set the outbound region if needed. */
+	if (unlikely(ep->irq_pci_addr != pci_addr)) {
+		/* Last region was reserved for IRQ writes. */
+		cdns_pcie_set_outbound_region(pcie, ep->max_regions - 1,
+					      false,
+					      ep->irq_phys_addr,
+					      pci_addr & ~pci_addr_mask,
+					      pci_addr_mask + 1);
+		ep->irq_pci_addr = pci_addr;
+	}
+	writew(data, ep->irq_cpu_addr + (pci_addr & pci_addr_mask));
+
+	return 0;
+}
+
+static int cdns_pcie_ep_start(struct pci_epc *epc)
+{
+	struct pci_epf *epf;
+
+	/*
+	 * Already linked-up: don't call directly pci_epc_linkup() because we've
+	 * already locked the epc->lock.
+	 */
+	list_for_each_entry(epf, &epc->pci_epf, list)
+		pci_epf_linkup(epf);
+
+	return 0;
+}
+
+static const struct pci_epc_ops cdns_pcie_epc_ops = {
+	.write_header	= cdns_pcie_ep_write_header,
+	.set_bar	= cdns_pcie_ep_set_bar,
+	.clear_bar	= cdns_pcie_ep_clear_bar,
+	.map_addr	= cdns_pcie_ep_map_addr,
+	.unmap_addr	= cdns_pcie_ep_unmap_addr,
+	.set_msi	= cdns_pcie_ep_set_msi,
+	.get_msi	= cdns_pcie_ep_get_msi,
+	.raise_irq	= cdns_pcie_ep_raise_irq,
+	.start		= cdns_pcie_ep_start,
+};
+
+static const struct of_device_id cdns_pcie_ep_of_match[] = {
+	{ .compatible = "cdns,cdns-pcie-ep" },
+
+	{ },
+};
+
+static int cdns_pcie_ep_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct cdns_pcie_ep *ep;
+	struct cdns_pcie *pcie;
+	struct pci_epc *epc;
+	struct resource *res;
+	int ret;
+
+	ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
+	if (!ep)
+		return -ENOMEM;
+
+	pcie = &ep->pcie;
+	pcie->is_rc = false;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "reg");
+	pcie->reg_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(pcie->reg_base)) {
+		dev_err(dev, "missing \"reg\"\n");
+		return PTR_ERR(pcie->reg_base);
+	}
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mem");
+	if (!res) {
+		dev_err(dev, "missing \"mem\"\n");
+		return -EINVAL;
+	}
+	pcie->mem_res = res;
+
+	ep->max_regions = 32;
+	of_property_read_u32(np, "cdns,max-outbound-regions", &ep->max_regions);
+	ep->ob_addr = devm_kzalloc(dev, ep->max_regions * sizeof(*ep->ob_addr),
+				   GFP_KERNEL);
+	if (!ep->ob_addr)
+		return -ENOMEM;
+
+	pm_runtime_enable(dev);
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		dev_err(dev, "pm_runtime_get_sync() failed\n");
+		goto err_get_sync;
+	}
+
+	/* Disable all but function 0 (anyway BIT(0) is hardwired to 1). */
+	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, BIT(0));
+
+	epc = devm_pci_epc_create(dev, &cdns_pcie_epc_ops);
+	if (IS_ERR(epc)) {
+		dev_err(dev, "failed to create epc device\n");
+		ret = PTR_ERR(epc);
+		goto err_init;
+	}
+
+	epc_set_drvdata(epc, ep);
+
+	epc->max_functions = 1;
+	of_property_read_u8(np, "max-functions", &epc->max_functions);
+
+	ret = pci_epc_mem_init(epc, pcie->mem_res->start,
+			       resource_size(pcie->mem_res));
+	if (ret < 0) {
+		dev_err(dev, "failed to initialize the memory space\n");
+		goto err_init;
+	}
+
+	ep->irq_cpu_addr = pci_epc_mem_alloc_addr(epc, &ep->irq_phys_addr,
+						  SZ_128K);
+	if (!ep->irq_cpu_addr) {
+		dev_err(dev, "failed to reserve memory space for MSI\n");
+		ret = -ENOMEM;
+		goto free_epc_mem;
+	}
+	ep->irq_pci_addr = CDNS_PCIE_EP_IRQ_PCI_ADDR_NONE;
+
+	return 0;
+
+ free_epc_mem:
+	pci_epc_mem_exit(epc);
+
+ err_init:
+	pm_runtime_put_sync(dev);
+
+ err_get_sync:
+	pm_runtime_disable(dev);
+
+	return ret;
+}
+
+static struct platform_driver cdns_pcie_ep_driver = {
+	.driver = {
+		.name = "cdns-pcie-ep",
+		.of_match_table = cdns_pcie_ep_of_match,
+	},
+	.probe = cdns_pcie_ep_probe,
+};
+builtin_platform_driver(cdns_pcie_ep_driver);
diff --git a/drivers/pci/cadence/pcie-cadence.c b/drivers/pci/cadence/pcie-cadence.c
index 5c76e7f4c5f9..7b91147ce68e 100644
--- a/drivers/pci/cadence/pcie-cadence.c
+++ b/drivers/pci/cadence/pcie-cadence.c
@@ -55,6 +55,33 @@ void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u32 r, bool is_io,
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR1(r), addr1);
 }
 
+void cdns_pcie_set_outbound_region_for_normal_msg(struct cdns_pcie *pcie, u32 r,
+						  u64 cpu_addr)
+{
+	u32 addr0, addr1, desc0, desc1;
+
+	desc0 = CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_NORMAL_MSG;
+	desc1 = 0;
+	if (pcie->is_rc) {
+		desc0 |= CDNS_PCIE_AT_OB_REGION_DESC0_HARDCODED_RID |
+			 CDNS_PCIE_AT_OB_REGION_DESC0_DEVFN(0);
+		desc1 |= CDNS_PCIE_AT_OB_REGION_DESC1_BUS(pcie->bus);
+	}
+
+	/* Set the CPU address */
+	cpu_addr -= pcie->mem_res->start;
+	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(17) |
+		(lower_32_bits(cpu_addr) & GENMASK(31, 8));
+	addr1 = upper_32_bits(cpu_addr);
+
+	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_PCI_ADDR0(r), 0);
+	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_PCI_ADDR1(r), 0);
+	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC0(r), desc0);
+	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC1(r), desc1);
+	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR0(r), addr0);
+	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR1(r), addr1);
+}
+
 void cdns_pcie_reset_outbound_region(struct cdns_pcie *pcie, u32 r)
 {
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_PCI_ADDR0(r), 0);
diff --git a/drivers/pci/cadence/pcie-cadence.h b/drivers/pci/cadence/pcie-cadence.h
index 3a15b4016352..7e36c81f783d 100644
--- a/drivers/pci/cadence/pcie-cadence.h
+++ b/drivers/pci/cadence/pcie-cadence.h
@@ -32,6 +32,30 @@
 #define  CDNS_PCIE_LM_RP_RID_(rid) \
 	(((rid) << CDNS_PCIE_LM_RP_RID_SHIFT) & CDNS_PCIE_LM_RP_RID_MASK)
 
+/* Endpoint Bus and Device Number Register */
+#define CDNS_PCIE_LM_EP_ID	(CDNS_PCIE_LM_BASE + 0x022c)
+#define  CDNS_PCIE_LM_EP_ID_DEV_MASK	GENMASK(4, 0)
+#define  CDNS_PCIE_LM_EP_ID_DEV_SHIFT	0
+#define  CDNS_PCIE_LM_EP_ID_BUS_MASK	GENMASK(15, 8)
+#define  CDNS_PCIE_LM_EP_ID_BUS_SHIFT	8
+
+/* Endpoint Function f BAR b Configuration Registers */
+#define CDNS_PCIE_LM_EP_FUNC_BAR_CFG0(fn) \
+	(CDNS_PCIE_LM_BASE + 0x0240 + (fn) * 0x0008)
+#define CDNS_PCIE_LM_EP_FUNC_BAR_CFG1(fn) \
+	(CDNS_PCIE_LM_BASE + 0x0244 + (fn) * 0x0008)
+#define  CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b) \
+	(GENMASK(4, 0) << ((b) * 8))
+#define  CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE(b, a) \
+	(((a) << ((b) * 8)) & CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b))
+#define  CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b) \
+	(GENMASK(7, 5) << ((b) * 8))
+#define  CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL(b, c) \
+	(((c) << ((b) * 8 + 5)) & CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b))
+
+/* Endpoint Function Configuration Register */
+#define CDNS_PCIE_LM_EP_FUNC_CFG	(CDNS_PCIE_LM_BASE + 0x02c0)
+
 /* Root Complex BAR Configuration Register */
 #define CDNS_PCIE_LM_RC_BAR_CFG	(CDNS_PCIE_LM_BASE + 0x0300)
 #define  CDNS_PCIE_LM_RC_BAR_CFG_BAR0_APERTURE_MASK	GENMASK(5, 0)
@@ -64,6 +88,13 @@
 
 
 /*
+ * Endpoint Function Registers (PCI configuration space for endpoint functions)
+ */
+#define CDNS_PCIE_EP_FUNC_BASE(fn)	(((fn) << 12) & GENMASK(19, 12))
+
+#define CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET	0x90
+
+/*
  * Root Port Registers (PCI configuration space for the root port function)
  */
 #define CDNS_PCIE_RP_BASE	0x00200000
@@ -140,6 +171,52 @@ enum cdns_pcie_rp_bar {
 	RP_NO_BAR
 };
 
+/* Endpoint Function BAR Inbound PCIe to AXI Address Translation Register */
+#define CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar) \
+	(CDNS_PCIE_AT_BASE + 0x0840 + (fn) * 0x0040 + (bar) * 0x0008)
+#define CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar) \
+	(CDNS_PCIE_AT_BASE + 0x0844 + (fn) * 0x0040 + (bar) * 0x0008)
+
+/* Normal/Vendor specific message access: offset inside some outbound region */
+#define CDNS_PCIE_NORMAL_MSG_ROUTING_MASK	GENMASK(7, 5)
+#define CDNS_PCIE_NORMAL_MSG_ROUTING(route) \
+	(((route) << 5) & CDNS_PCIE_NORMAL_MSG_ROUTING_MASK)
+#define CDNS_PCIE_NORMAL_MSG_CODE_MASK		GENMASK(15, 8)
+#define CDNS_PCIE_NORMAL_MSG_CODE(code) \
+	(((code) << 8) & CDNS_PCIE_NORMAL_MSG_CODE_MASK)
+#define CDNS_PCIE_MSG_NO_DATA			BIT(16)
+
+enum cdns_pcie_msg_code {
+	MSG_CODE_ASSERT_INTA	= 0x20,
+	MSG_CODE_ASSERT_INTB	= 0x21,
+	MSG_CODE_ASSERT_INTC	= 0x22,
+	MSG_CODE_ASSERT_INTD	= 0x23,
+	MSG_CODE_DEASSERT_INTA	= 0x24,
+	MSG_CODE_DEASSERT_INTB	= 0x25,
+	MSG_CODE_DEASSERT_INTC	= 0x26,
+	MSG_CODE_DEASSERT_INTD	= 0x27,
+};
+
+enum cdns_pcie_msg_routing {
+	/* Route to Root Complex */
+	MSG_ROUTING_TO_RC,
+
+	/* Use Address Routing */
+	MSG_ROUTING_BY_ADDR,
+
+	/* Use ID Routing */
+	MSG_ROUTING_BY_ID,
+
+	/* Route as Broadcast Message from Root Complex */
+	MSG_ROUTING_BCAST,
+
+	/* Local message; terminate at receiver (INTx messages) */
+	MSG_ROUTING_LOCAL,
+
+	/* Gather & route to Root Complex (PME_TO_Ack message) */
+	MSG_ROUTING_GATHER,
+};
+
 /**
  * struct cdns_pcie - private data for Cadence PCIe controller drivers
  * @reg_base: IO mapped register base
@@ -188,9 +265,46 @@ static inline void cdns_pcie_rp_writew(struct cdns_pcie *pcie,
 	writew(value, pcie->reg_base + CDNS_PCIE_RP_BASE + reg);
 }
 
+/* Endpoint Function register access */
+static inline void cdns_pcie_ep_fn_writeb(struct cdns_pcie *pcie, u8 fn,
+					  u32 reg, u8 value)
+{
+	writeb(value, pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg);
+}
+
+static inline void cdns_pcie_ep_fn_writew(struct cdns_pcie *pcie, u8 fn,
+					  u32 reg, u16 value)
+{
+	writew(value, pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg);
+}
+
+static inline void cdns_pcie_ep_fn_writel(struct cdns_pcie *pcie, u8 fn,
+					  u32 reg, u16 value)
+{
+	writel(value, pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg);
+}
+
+static inline u8 cdns_pcie_ep_fn_readb(struct cdns_pcie *pcie, u8 fn, u32 reg)
+{
+	return readb(pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg);
+}
+
+static inline u16 cdns_pcie_ep_fn_readw(struct cdns_pcie *pcie, u8 fn, u32 reg)
+{
+	return readw(pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg);
+}
+
+static inline u32 cdns_pcie_ep_fn_readl(struct cdns_pcie *pcie, u8 fn, u32 reg)
+{
+	return readl(pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg);
+}
+
 void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u32 r, bool is_io,
 				   u64 cpu_addr, u64 pci_addr, size_t size);
 
+void cdns_pcie_set_outbound_region_for_normal_msg(struct cdns_pcie *pcie, u32 r,
+						  u64 cpu_addr);
+
 void cdns_pcie_reset_outbound_region(struct cdns_pcie *pcie, u32 r);
 
 #endif /* _PCIE_CADENCE_H */
-- 
2.11.0
