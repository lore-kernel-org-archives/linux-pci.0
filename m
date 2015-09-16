Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:13841 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753350AbbIPAjR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2015 20:39:17 -0400
From: Ray Jui <rjui@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Hauke Mehrtens <hauke@hauke-m.de>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>
Subject: [PATCH 7/8] PCI: iproc: Add outbound mapping support
Date: Tue, 15 Sep 2015 17:39:21 -0700
Message-ID: <1442363962-29805-8-git-send-email-rjui@broadcom.com>
In-Reply-To: <1442363962-29805-1-git-send-email-rjui@broadcom.com>
References: <1442363962-29805-1-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Certain iProc SoCs require the PCIe outbound mapping to be configured in
SW. This patch adds support for those chips

Signed-off-by: Ray Jui <rjui@broadcom.com>
---
 drivers/pci/host/pcie-iproc-platform.c |  27 ++++++++
 drivers/pci/host/pcie-iproc.c          | 113 +++++++++++++++++++++++++++++++++
 drivers/pci/host/pcie-iproc.h          |  17 +++++
 3 files changed, 157 insertions(+)

diff --git a/drivers/pci/host/pcie-iproc-platform.c b/drivers/pci/host/pcie-iproc-platform.c
index 9aedc8e..c9550dc 100644
--- a/drivers/pci/host/pcie-iproc-platform.c
+++ b/drivers/pci/host/pcie-iproc-platform.c
@@ -54,6 +54,33 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	if (of_property_read_bool(np, "brcm,pcie-ob")) {
+		u32 val;
+
+		ret = of_property_read_u32(np, "brcm,pcie-ob-axi-offset",
+					   &val);
+		if (ret) {
+			dev_err(pcie->dev,
+				"missing brcm,pcie-ob-axi-offset property\n");
+			return ret;
+		}
+		pcie->ob.axi_offset = val;
+
+		ret = of_property_read_u32(np, "brcm,pcie-ob-window-size",
+					   &val);
+		if (ret) {
+			dev_err(pcie->dev,
+				"missing brcm,pcie-ob-window-size property\n");
+			return ret;
+		}
+		pcie->ob.window_size = (resource_size_t)val * SZ_1M;
+
+		if (of_property_read_bool(np, "brcm,pcie-ob-oarr-size"))
+			pcie->ob.set_oarr_size = true;
+
+		pcie->need_ob_cfg = true;
+	}
+
 	/* PHY use is optional */
 	pcie->phy = devm_phy_get(&pdev->dev, "pcie-phy");
 	if (IS_ERR(pcie->phy)) {
diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index 62e8085..2ba3c4b 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -66,6 +66,18 @@
 #define PCIE_DL_ACTIVE_SHIFT         2
 #define PCIE_DL_ACTIVE               BIT(PCIE_DL_ACTIVE_SHIFT)
 
+#define OARR_VALID_SHIFT             0
+#define OARR_VALID                   BIT(OARR_VALID_SHIFT)
+#define OARR_SIZE_CFG_SHIFT          1
+#define OARR_SIZE_CFG                BIT(OARR_SIZE_CFG_SHIFT)
+
+#define OARR_LO(window)              (0xd20 + (window) * 8)
+#define OARR_HI(window)              (0xd24 + (window) * 8)
+#define OMAP_LO(window)              (0xd40 + (window) * 8)
+#define OMAP_HI(window)              (0xd44 + (window) * 8)
+
+#define MAX_NUM_OB_WINDOWS           2
+
 static inline struct iproc_pcie *iproc_data(struct pci_bus *bus)
 {
 	struct iproc_pcie *pcie;
@@ -212,6 +224,99 @@ static void iproc_pcie_enable(struct iproc_pcie *pcie)
 	writel(SYS_RC_INTX_MASK, pcie->base + SYS_RC_INTX_EN);
 }
 
+/**
+ * Some iProc SoCs require the SW to configure the outbound address mapping
+ *
+ * Outbound address translation:
+ *
+ * iproc_pcie_address = axi_address - axi_offset
+ * OARR = iproc_pcie_address
+ * OMAP = pci_addr
+ *
+ * axi_addr -> iproc_pcie_address -> OARR -> OMAP -> pci_address
+ */
+static int iproc_pcie_setup_ob(struct iproc_pcie *pcie, u64 axi_addr,
+			       u64 pci_addr, resource_size_t size)
+{
+	struct iproc_pcie_ob *ob = &pcie->ob;
+	unsigned i;
+	u64 max_size = (u64)ob->window_size * MAX_NUM_OB_WINDOWS;
+
+	if (size > max_size) {
+		dev_err(pcie->dev,
+			"res size 0x%llx exceeds max supported size 0x%llx\n",
+			(u64)size, max_size);
+		return -EINVAL;
+	}
+
+	if (size % ob->window_size) {
+		dev_err(pcie->dev,
+			"res size 0x%llx needs to be multiple of "
+			"window size 0x%llx\n", (u64)size, ob->window_size);
+		return -EINVAL;
+	}
+
+	if (axi_addr < ob->axi_offset) {
+		dev_err(pcie->dev,
+			"axi address %pap less than offset %pap\n",
+			&axi_addr, &ob->axi_offset);
+		return -EINVAL;
+	}
+
+	/*
+	 * Translate the AXI address to the internal address used by the iProc
+	 * PCIe core before programming the OARR
+	 */
+	axi_addr -= ob->axi_offset;
+
+	for (i = 0; i < MAX_NUM_OB_WINDOWS; i++) {
+		writel(lower_32_bits(axi_addr) | OARR_VALID |
+		       (ob->set_oarr_size ? 1 : 0), pcie->base + OARR_LO(i));
+		writel(upper_32_bits(axi_addr), pcie->base + OARR_HI(i));
+		writel(lower_32_bits(pci_addr), pcie->base + OMAP_LO(i));
+		writel(upper_32_bits(pci_addr), pcie->base + OMAP_HI(i));
+
+		size -= ob->window_size;
+		if (size == 0)
+			break;
+
+		axi_addr += ob->window_size;
+		pci_addr += ob->window_size;
+	}
+
+	return 0;
+}
+
+static int iproc_pcie_map_ranges(struct iproc_pcie *pcie,
+				 struct list_head *resources)
+{
+	struct resource_entry *window;
+	int ret;
+
+	resource_list_for_each_entry(window, resources) {
+		struct resource *res = window->res;
+		u64 res_type = resource_type(res);
+
+		switch (res_type) {
+		case IORESOURCE_IO:
+		case IORESOURCE_BUS:
+			break;
+		case IORESOURCE_MEM:
+			ret = iproc_pcie_setup_ob(pcie, res->start,
+						  res->start - window->offset,
+						  resource_size(res));
+			if (ret)
+				return ret;
+			break;
+		default:
+			dev_err(pcie->dev, "invalid resource %pR\n", res);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 {
 	int ret;
@@ -235,6 +340,14 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 
 	iproc_pcie_reset(pcie);
 
+	if (pcie->need_ob_cfg) {
+		ret = iproc_pcie_map_ranges(pcie, res);
+		if (ret) {
+			dev_err(pcie->dev, "map failed\n");
+			goto err_power_off_phy;
+		}
+	}
+
 #ifdef CONFIG_ARM
 	pcie->sysdata.private_data = pcie;
 	sysdata = &pcie->sysdata;
diff --git a/drivers/pci/host/pcie-iproc.h b/drivers/pci/host/pcie-iproc.h
index ecaad57..d3dc940 100644
--- a/drivers/pci/host/pcie-iproc.h
+++ b/drivers/pci/host/pcie-iproc.h
@@ -15,6 +15,19 @@
 #define _PCIE_IPROC_H
 
 /**
+ * iProc PCIe outbound mapping
+ * @set_oarr_size: indicates the OARR size bit needs to be set
+ * @axi_offset: offset from the AXI address to the internal address used by
+ * the iProc PCIe core
+ * @window_size: outbound window size
+ */
+struct iproc_pcie_ob {
+	bool set_oarr_size;
+	resource_size_t axi_offset;
+	resource_size_t window_size;
+};
+
+/**
  * iProc PCIe device
  * @dev: pointer to device data structure
  * @base: PCIe host controller I/O register base
@@ -23,6 +36,8 @@
  * @phy: optional PHY device that controls the Serdes
  * @irqs: interrupt IDs
  * @map_irq: function callback to map interrupts
+ * @need_ob_cfg: indidates SW needs to configure the outbound mapping window
+ * @ob: outbound mapping parameters
  */
 struct iproc_pcie {
 	struct device *dev;
@@ -33,6 +48,8 @@ struct iproc_pcie {
 	struct pci_bus *root_bus;
 	struct phy *phy;
 	int (*map_irq)(const struct pci_dev *, u8, u8);
+	bool need_ob_cfg;
+	struct iproc_pcie_ob ob;
 };
 
 int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res);
-- 
1.9.1

