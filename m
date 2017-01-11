Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:24703 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965366AbdAKMHZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2017 07:07:25 -0500
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <nsekhar@ti.com>, <kishon@ti.com>
Subject: [PATCH 4/5] PCI: dwc: dra7xx: Enable MSI and legacy interrupts simultaneously
Date: Wed, 11 Jan 2017 17:36:54 +0530
Message-ID: <1484136415-20798-5-git-send-email-kishon@ti.com>
In-Reply-To: <1484136415-20798-1-git-send-email-kishon@ti.com>
References: <1484136415-20798-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci-dra7xx driver had a bug in that if CONFIG_PCI_MSI config is enabled,
it doesn't support legacy interrupt. Fix it here so that both MSI and
legacy interrupts can be enabled simultaneously and the interrupt mechanism
supported by the endpoint device will be used.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/dwc/pci-dra7xx.c |   32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
index 587b18c..af330d7 100644
--- a/drivers/pci/dwc/pci-dra7xx.c
+++ b/drivers/pci/dwc/pci-dra7xx.c
@@ -72,6 +72,7 @@ struct dra7xx_pcie {
 	int			phy_count;	/* DT phy-names count */
 	struct phy		**phy;
 	int			link_gen;
+	struct irq_domain	*irq_domain;
 };
 
 #define to_dra7xx_pcie(x)	container_of((x), struct dra7xx_pcie, pp)
@@ -142,14 +143,8 @@ static void dra7xx_pcie_enable_interrupts(struct dra7xx_pcie *dra7xx)
 			   PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MAIN, INTERRUPTS);
 	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI,
 			   ~LEG_EP_INTERRUPTS & ~MSI);
-
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		dra7xx_pcie_writel(dra7xx,
-				   PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MSI, MSI);
-	else
-		dra7xx_pcie_writel(dra7xx,
-				   PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MSI,
-				   LEG_EP_INTERRUPTS);
+	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MSI,
+			   MSI | LEG_EP_INTERRUPTS);
 }
 
 static void dra7xx_pcie_host_init(struct pcie_port *pp)
@@ -164,8 +159,7 @@ static void dra7xx_pcie_host_init(struct pcie_port *pp)
 	dw_pcie_setup_rc(pp);
 
 	dra7xx_pcie_establish_link(dra7xx);
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		dw_pcie_msi_init(pp);
+	dw_pcie_msi_init(pp);
 	dra7xx_pcie_enable_interrupts(dra7xx);
 }
 
@@ -190,6 +184,7 @@ static int dra7xx_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
 static int dra7xx_pcie_init_irq_domain(struct pcie_port *pp)
 {
 	struct device *dev = pp->dev;
+	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pp);
 	struct device_node *node = dev->of_node;
 	struct device_node *pcie_intc_node =  of_get_next_child(node, NULL);
 
@@ -198,9 +193,9 @@ static int dra7xx_pcie_init_irq_domain(struct pcie_port *pp)
 		return -ENODEV;
 	}
 
-	pp->irq_domain = irq_domain_add_linear(pcie_intc_node, 4,
-					       &intx_domain_ops, pp);
-	if (!pp->irq_domain) {
+	dra7xx->irq_domain = irq_domain_add_linear(pcie_intc_node, 4,
+						   &intx_domain_ops, pp);
+	if (!dra7xx->irq_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
 		return -ENODEV;
 	}
@@ -224,7 +219,8 @@ static irqreturn_t dra7xx_pcie_msi_irq_handler(int irq, void *arg)
 	case INTB:
 	case INTC:
 	case INTD:
-		generic_handle_irq(irq_find_mapping(pp->irq_domain, ffs(reg)));
+		generic_handle_irq(irq_find_mapping(dra7xx->irq_domain,
+						    ffs(reg)));
 		break;
 	}
 
@@ -310,11 +306,9 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
 		return ret;
 	}
 
-	if (!IS_ENABLED(CONFIG_PCI_MSI)) {
-		ret = dra7xx_pcie_init_irq_domain(pp);
-		if (ret < 0)
-			return ret;
-	}
+	ret = dra7xx_pcie_init_irq_domain(pp);
+	if (ret < 0)
+		return ret;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rc_dbics");
 	pp->dbi_base = devm_ioremap(dev, res->start, resource_size(res));
-- 
1.7.9.5

