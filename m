Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56499 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750794AbcCXW2i (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 24 Mar 2016 18:28:38 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
To: <bhelgaas@google.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH next v1 1/2] PCI: keystone: add pci error irq handler
Date: Thu, 24 Mar 2016 18:28:17 -0400
Message-ID: <1458858498-20559-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Keystone PCI hardware generates error interrupts at RC using platform
irq instead of standard msi/legacy irq. Add a simple error handler that
logs the fatal interrupt status to the console.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 v1 - fixed a compilation issue reported by kbuild test robot
    - rebased to linux-next master branch
    - Added ack from Rob Herring

 .../devicetree/bindings/pci/pci-keystone.txt       |  1 +
 drivers/pci/host/pci-keystone-dw.c                 | 46 ++++++++++++++++++++++
 drivers/pci/host/pci-keystone.c                    | 32 +++++++++++++++
 drivers/pci/host/pci-keystone.h                    |  6 +++
 4 files changed, 85 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/pci-keystone.txt b/Documentation/devicetree/bindings/pci/pci-keystone.txt
index 54eae29..d08a4d5 100644
--- a/Documentation/devicetree/bindings/pci/pci-keystone.txt
+++ b/Documentation/devicetree/bindings/pci/pci-keystone.txt
@@ -56,6 +56,7 @@ Optional properties:-
 	phy-names: name of the Generic Keystine SerDes phy for PCI
 	  - If boot loader already does PCI link establishment, then phys and
 	    phy-names shouldn't be present.
+	interrupts: platform interrupt for error interrupts.
 
 Designware DT Properties not applicable for Keystone PCI
 
diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/host/pci-keystone-dw.c
index 6153853..2a45fe8 100644
--- a/drivers/pci/host/pci-keystone-dw.c
+++ b/drivers/pci/host/pci-keystone-dw.c
@@ -53,6 +53,29 @@
 #define IRQ_STATUS			0x184
 #define MSI_IRQ_OFFSET			4
 
+/*
+ * error IRQ bits. Enable following errors
+ *  - ERR_AER  - ECRC error - BIT(5)
+ *  - ERR_AXI  - AXI tag lookup fatal error BIT(4)
+ *  - ERR_CORR - Correctable error BIT(3)
+ *  - ERR_NONFATAL - Non fatal error BIT(2)
+ *  - ERR_FATAL - Fatal error BIT(1)
+ *  - ERR_SYS - System error (fatal, nonfatal or correctable error)
+ */
+#define ERR_AER				BIT(5)
+#define ERR_AXI				BIT(4)
+#define ERR_CORR			BIT(3)
+#define ERR_NONFATAL			BIT(2)
+#define ERR_FATAL			BIT(1)
+#define ERR_SYS				BIT(0)
+#define ERR_IRQ_ALL			(ERR_AER | ERR_AXI | ERR_CORR | \
+					ERR_NONFATAL | ERR_FATAL | ERR_SYS)
+#define ERR_FATAL_IRQ			(ERR_FATAL | ERR_AXI)
+#define ERR_IRQ_STATUS_RAW		0x1c0
+#define ERR_IRQ_STATUS			0x1c4
+#define ERR_IRQ_ENABLE_SET		0x1c8
+#define ERR_IRQ_ENABLE_CLR		0x1cc
+
 /* Config space registers */
 #define DEBUG0				0x728
 
@@ -243,6 +266,29 @@ void ks_dw_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie, int offset)
 	writel(offset, ks_pcie->va_app_base + IRQ_EOI);
 }
 
+void ks_dw_pcie_enable_error_irq(void __iomem *reg_base)
+{
+	writel(ERR_IRQ_ALL, reg_base + ERR_IRQ_ENABLE_SET);
+}
+
+bool ks_dw_pcie_handle_error_irq(struct device *dev, void __iomem *reg_base)
+{
+	u32 status;
+	bool ret = false;
+
+	status = readl(reg_base + ERR_IRQ_STATUS_RAW) & ERR_IRQ_ALL;
+	if (status) {
+		/* The PCIESS interrupt status buts are "write 1 to clear" */
+		if (status & ERR_FATAL_IRQ)
+			dev_err(dev, "PCIE fatal error detected\n");
+
+		/* ack the irq event. */
+		writel(status, reg_base + ERR_IRQ_STATUS);
+		ret = true;
+	}
+	return ret;
+}
+
 static void ks_dw_pcie_ack_legacy_irq(struct irq_data *d)
 {
 }
diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/host/pci-keystone.c
index b71f55b..a2b3ff6 100644
--- a/drivers/pci/host/pci-keystone.c
+++ b/drivers/pci/host/pci-keystone.c
@@ -15,6 +15,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/interrupt.h>
 #include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/msi.h>
@@ -226,6 +227,10 @@ static void ks_pcie_setup_interrupts(struct keystone_pcie *ks_pcie)
 							 ks_pcie);
 		}
 	}
+
+	/* enable error interrupt */
+	if (ks_pcie->error_irq > 0)
+		ks_dw_pcie_enable_error_irq(ks_pcie->va_app_base);
 }
 
 /*
@@ -289,6 +294,16 @@ static struct pcie_host_ops keystone_pcie_host_ops = {
 	.scan_bus = ks_dw_pcie_v3_65_scan_bus,
 };
 
+static irqreturn_t pcie_err_irq_handler(int irq, void *priv)
+{
+	struct keystone_pcie *ks_pcie = priv;
+
+	if (ks_dw_pcie_handle_error_irq(ks_pcie->pp.dev, ks_pcie->va_app_base))
+		return IRQ_HANDLED;
+
+	return IRQ_NONE;
+}
+
 static int __init ks_add_pcie_port(struct keystone_pcie *ks_pcie,
 			 struct platform_device *pdev)
 {
@@ -309,6 +324,22 @@ static int __init ks_add_pcie_port(struct keystone_pcie *ks_pcie,
 			return ret;
 	}
 
+	/*
+	 * index 0 is the platform interrupt for error interrupt
+	 * from RC. As this is optional to define this, we will
+	 * just print a warning
+	 */
+	ks_pcie->error_irq = irq_of_parse_and_map(ks_pcie->np, 0);
+	if (ks_pcie->error_irq <= 0)
+		dev_warn(&pdev->dev, "No error irq defined\n");
+	else {
+		if (request_irq(ks_pcie->error_irq, pcie_err_irq_handler,
+				IRQF_SHARED, "pcie-error-irq", ks_pcie) < 0) {
+			dev_err(&pdev->dev, "failed to request error irq\n");
+			return ret;
+		}
+	}
+
 	pp->root_bus_nr = -1;
 	pp->ops = &keystone_pcie_host_ops;
 	ret = ks_dw_pcie_host_init(ks_pcie, ks_pcie->msi_intc_np);
@@ -376,6 +407,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	devm_release_mem_region(dev, res->start, resource_size(res));
 
 	pp->dev = dev;
+	ks_pcie->np = dev->of_node;
 	platform_set_drvdata(pdev, ks_pcie);
 	ks_pcie->clk = devm_clk_get(dev, "pcie");
 	if (IS_ERR(ks_pcie->clk)) {
diff --git a/drivers/pci/host/pci-keystone.h b/drivers/pci/host/pci-keystone.h
index f0944e8..2daa215 100644
--- a/drivers/pci/host/pci-keystone.h
+++ b/drivers/pci/host/pci-keystone.h
@@ -29,6 +29,10 @@ struct keystone_pcie {
 	int			msi_host_irqs[MAX_MSI_HOST_IRQS];
 	struct			device_node *msi_intc_np;
 	struct irq_domain	*legacy_irq_domain;
+	struct device_node	*np;
+
+	/* error interrupt */
+	int error_irq;
 
 	/* Application register space */
 	void __iomem		*va_app_base;
@@ -42,6 +46,8 @@ phys_addr_t ks_dw_pcie_get_msi_addr(struct pcie_port *pp);
 /* Keystone specific PCI controller APIs */
 void ks_dw_pcie_enable_legacy_irqs(struct keystone_pcie *ks_pcie);
 void ks_dw_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie, int offset);
+void ks_dw_pcie_enable_error_irq(void __iomem *reg_base);
+bool ks_dw_pcie_handle_error_irq(struct device *dev, void __iomem *reg_base);
 int  ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie,
 			struct device_node *msi_intc_np);
 int ks_dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
-- 
1.9.1

