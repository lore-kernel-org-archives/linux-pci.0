Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49670 "EHLO
        devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752323AbcJKNHD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Oct 2016 09:07:03 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>
CC: <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kishon@ti.com>, <nsekhar@ti.com>
Subject: [PATCH 4/4] PCI: dra7xx: Enable MSI and legacy interrupts simultaneously
Date: Tue, 11 Oct 2016 18:28:35 +0530
Message-ID: <1476190715-16884-5-git-send-email-kishon@ti.com>
In-Reply-To: <1476190715-16884-1-git-send-email-kishon@ti.com>
References: <1476190715-16884-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

dra7xx driver had a bug in that if CONFIG_PCI_MSI config is enabled,
it doesn't support legacy interrupt. Fix it here so that both MSI and
legacy interrupts can be enabled simultaneously and one of them will
be used based on the connected device.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/host/pci-dra7xx.c |   32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index 2a669cb..1a68759 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -71,6 +71,7 @@ struct dra7xx_pcie {
 	int			phy_count;	/* DT phy-names count */
 	struct phy		**phy;
 	bool			is_gen1;
+	struct irq_domain	*irq_domain;
 };
 
 #define to_dra7xx_pcie(x)	container_of((x), struct dra7xx_pcie, pp)
@@ -142,13 +143,9 @@ static void dra7xx_pcie_enable_interrupts(struct dra7xx_pcie *dra7xx_pcie)
 	dra7xx_pcie_writel(dra7xx_pcie, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI,
 			   ~LEG_EP_INTERRUPTS & ~MSI);
 
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		dra7xx_pcie_writel(dra7xx_pcie,
-				   PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MSI, MSI);
-	else
-		dra7xx_pcie_writel(dra7xx_pcie,
-				   PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MSI,
-				   LEG_EP_INTERRUPTS);
+	dra7xx_pcie_writel(dra7xx_pcie,
+			   PCIECTRL_DRA7XX_CONF_IRQENABLE_SET_MSI,
+			   MSI | LEG_EP_INTERRUPTS);
 }
 
 static void dra7xx_pcie_host_init(struct pcie_port *pp)
@@ -163,8 +160,7 @@ static void dra7xx_pcie_host_init(struct pcie_port *pp)
 	dw_pcie_setup_rc(pp);
 
 	dra7xx_pcie_establish_link(dra7xx_pcie);
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		dw_pcie_msi_init(pp);
+	dw_pcie_msi_init(pp);
 	dra7xx_pcie_enable_interrupts(dra7xx_pcie);
 }
 
@@ -189,6 +185,7 @@ static int dra7xx_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
 static int dra7xx_pcie_init_irq_domain(struct pcie_port *pp)
 {
 	struct device *dev = pp->dev;
+	struct dra7xx_pcie *dra7xx_pcie = to_dra7xx_pcie(pp);
 	struct device_node *node = dev->of_node;
 	struct device_node *pcie_intc_node =  of_get_next_child(node, NULL);
 
@@ -197,9 +194,9 @@ static int dra7xx_pcie_init_irq_domain(struct pcie_port *pp)
 		return -ENODEV;
 	}
 
-	pp->irq_domain = irq_domain_add_linear(pcie_intc_node, 4,
-					       &intx_domain_ops, pp);
-	if (!pp->irq_domain) {
+	dra7xx_pcie->irq_domain = irq_domain_add_linear(pcie_intc_node, 4,
+							&intx_domain_ops, pp);
+	if (!dra7xx_pcie->irq_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
 		return -ENODEV;
 	}
@@ -224,7 +221,8 @@ static irqreturn_t dra7xx_pcie_msi_irq_handler(int irq, void *arg)
 	case INTB:
 	case INTC:
 	case INTD:
-		generic_handle_irq(irq_find_mapping(pp->irq_domain, ffs(reg)));
+		generic_handle_irq(irq_find_mapping(dra7xx_pcie->irq_domain,
+				   ffs(reg)));
 		break;
 	}
 
@@ -314,11 +312,9 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx_pcie,
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

