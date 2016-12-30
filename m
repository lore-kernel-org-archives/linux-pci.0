Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:60673 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753713AbcL3J4Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Dec 2016 04:56:25 -0500
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nsekhar@ti.com>, <kishon@ti.com>
Subject: [PATCH v2 2/3] PCI: dra7xx: Add support to force RC to work in GEN1 mode
Date: Fri, 30 Dec 2016 15:26:13 +0530
Message-ID: <1483091774-8332-3-git-send-email-kishon@ti.com>
In-Reply-To: <1483091774-8332-1-git-send-email-kishon@ti.com>
References: <1483091774-8332-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCIe in AM57x/DRA7x devices is by default
configured to work in GEN2 mode.  However there
may be situations when working in GEN1 mode is
desired. One example is limitation i925 (PCIe GEN2
mode not supported at junction temperatures < 0C).

Add support to force Root Complex to work in GEN1
mode if so desired, but don't force GEN1 mode on
any board just yet.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/pci-dra7xx.c |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/pci/controller/pci-dra7xx.c b/drivers/pci/controller/pci-dra7xx.c
index f6d0c63..587b18c 100644
--- a/drivers/pci/controller/pci-dra7xx.c
+++ b/drivers/pci/controller/pci-dra7xx.c
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/of_gpio.h>
+#include <linux/of_pci.h>
 #include <linux/pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
@@ -63,11 +64,14 @@
 #define	LINK_UP						BIT(16)
 #define	DRA7XX_CPU_TO_BUS_ADDR				0x0FFFFFFF
 
+#define EXP_CAP_ID_OFFSET				0x70
+
 struct dra7xx_pcie {
 	struct pcie_port	pp;
 	void __iomem		*base;		/* DT ti_conf */
 	int			phy_count;	/* DT phy-names count */
 	struct phy		**phy;
+	int			link_gen;
 };
 
 #define to_dra7xx_pcie(x)	container_of((x), struct dra7xx_pcie, pp)
@@ -96,12 +100,33 @@ static int dra7xx_pcie_establish_link(struct dra7xx_pcie *dra7xx)
 	struct pcie_port *pp = &dra7xx->pp;
 	struct device *dev = pp->dev;
 	u32 reg;
+	u32 exp_cap_off = EXP_CAP_ID_OFFSET;
 
 	if (dw_pcie_link_up(pp)) {
 		dev_err(dev, "link is already up\n");
 		return 0;
 	}
 
+	if (dra7xx->link_gen == 1) {
+		dw_pcie_cfg_read(pp->dbi_base + exp_cap_off + PCI_EXP_LNKCAP,
+				 4, &reg);
+		if ((reg & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
+			reg &= ~((u32)PCI_EXP_LNKCAP_SLS);
+			reg |= PCI_EXP_LNKCAP_SLS_2_5GB;
+			dw_pcie_cfg_write(pp->dbi_base + exp_cap_off +
+					  PCI_EXP_LNKCAP, 4, reg);
+		}
+
+		dw_pcie_cfg_read(pp->dbi_base + exp_cap_off + PCI_EXP_LNKCTL2,
+				 2, &reg);
+		if ((reg & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
+			reg &= ~((u32)PCI_EXP_LNKCAP_SLS);
+			reg |= PCI_EXP_LNKCAP_SLS_2_5GB;
+			dw_pcie_cfg_write(pp->dbi_base + exp_cap_off +
+					  PCI_EXP_LNKCTL2, 2, reg);
+		}
+	}
+
 	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD);
 	reg |= LTSSM_EN;
 	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD, reg);
@@ -397,6 +422,10 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	reg &= ~LTSSM_EN;
 	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD, reg);
 
+	dra7xx->link_gen = of_pci_get_max_link_speed(np);
+	if (dra7xx->link_gen < 0 || dra7xx->link_gen > 2)
+		dra7xx->link_gen = 2;
+
 	ret = dra7xx_add_pcie_port(dra7xx, pdev);
 	if (ret < 0)
 		goto err_gpio;
-- 
1.7.9.5

