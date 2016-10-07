Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941222AbcJGQkj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:40:39 -0400
Subject: [PATCH 2/6] PCI: keystone: Pass keystone_pcie, not address,
 to IRQ functions
To: Murali Karicheri <m-karicheri2@ti.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:40:35 -0500
Message-ID: <20161007164035.26090.37896.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007164026.26090.42844.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007164026.26090.42844.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Instead of passing the application register base to IRQ functions,
pass the struct keystone_pcie.  This will allow them to use register
accessors.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-keystone-dw.c |   15 ++++++++-------
 drivers/pci/host/pci-keystone.c    |    5 ++---
 drivers/pci/host/pci-keystone.h    |    5 ++---
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/host/pci-keystone-dw.c
index d09e3c6..5c67d54 100644
--- a/drivers/pci/host/pci-keystone-dw.c
+++ b/drivers/pci/host/pci-keystone-dw.c
@@ -259,25 +259,26 @@ void ks_dw_pcie_handle_legacy_irq(struct keystone_pcie *keystone, int offset)
 	writel(offset, keystone->va_app_base + IRQ_EOI);
 }
 
-void ks_dw_pcie_enable_error_irq(void __iomem *reg_base)
+void ks_dw_pcie_enable_error_irq(struct keystone_pcie *keystone)
 {
-	writel(ERR_IRQ_ALL, reg_base + ERR_IRQ_ENABLE_SET);
+	writel(ERR_IRQ_ALL, keystone->va_app_base + ERR_IRQ_ENABLE_SET);
 }
 
-irqreturn_t ks_dw_pcie_handle_error_irq(struct device *dev,
-					void __iomem *reg_base)
+irqreturn_t ks_dw_pcie_handle_error_irq(struct keystone_pcie *keystone)
 {
 	u32 status;
 
-	status = readl(reg_base + ERR_IRQ_STATUS_RAW) & ERR_IRQ_ALL;
+	status = readl(keystone->va_app_base + ERR_IRQ_STATUS_RAW) &
+			    ERR_IRQ_ALL;
 	if (!status)
 		return IRQ_NONE;
 
 	if (status & ERR_FATAL_IRQ)
-		dev_err(dev, "fatal error (status %#010x)\n", status);
+		dev_err(keystone->pp.dev, "fatal error (status %#010x)\n",
+			status);
 
 	/* Ack the IRQ; status bits are RW1C */
-	writel(status, reg_base + ERR_IRQ_STATUS);
+	writel(status, keystone->va_app_base + ERR_IRQ_STATUS);
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/host/pci-keystone.c
index 55b2be7..6b1cb14 100644
--- a/drivers/pci/host/pci-keystone.c
+++ b/drivers/pci/host/pci-keystone.c
@@ -234,7 +234,7 @@ static void ks_pcie_setup_interrupts(struct keystone_pcie *keystone)
 	}
 
 	if (keystone->error_irq > 0)
-		ks_dw_pcie_enable_error_irq(keystone->va_app_base);
+		ks_dw_pcie_enable_error_irq(keystone);
 }
 
 /*
@@ -302,8 +302,7 @@ static irqreturn_t pcie_err_irq_handler(int irq, void *priv)
 {
 	struct keystone_pcie *keystone = priv;
 
-	return ks_dw_pcie_handle_error_irq(keystone->pp.dev,
-					   keystone->va_app_base);
+	return ks_dw_pcie_handle_error_irq(keystone);
 }
 
 static int __init ks_add_pcie_port(struct keystone_pcie *keystone,
diff --git a/drivers/pci/host/pci-keystone.h b/drivers/pci/host/pci-keystone.h
index 379213c..2a81e05 100644
--- a/drivers/pci/host/pci-keystone.h
+++ b/drivers/pci/host/pci-keystone.h
@@ -45,9 +45,8 @@ phys_addr_t ks_dw_pcie_get_msi_addr(struct pcie_port *pp);
 /* Keystone specific PCI controller APIs */
 void ks_dw_pcie_enable_legacy_irqs(struct keystone_pcie *keystone);
 void ks_dw_pcie_handle_legacy_irq(struct keystone_pcie *keystone, int offset);
-void ks_dw_pcie_enable_error_irq(void __iomem *reg_base);
-irqreturn_t ks_dw_pcie_handle_error_irq(struct device *dev,
-					void __iomem *reg_base);
+void ks_dw_pcie_enable_error_irq(struct keystone_pcie *keystone);
+irqreturn_t ks_dw_pcie_handle_error_irq(struct keystone_pcie *keystone);
 int  ks_dw_pcie_host_init(struct keystone_pcie *keystone,
 			struct device_node *msi_intc_np);
 int ks_dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,

