Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755138AbcJLNx2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:53:28 -0400
Subject: [PATCH v2 3/6] PCI: keystone: Pass keystone_pcie, not address,
 to IRQ functions
To: Murali Karicheri <m-karicheri2@ti.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:53:24 -0500
Message-ID: <20161012135324.29306.86483.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012134953.29306.24609.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012134953.29306.24609.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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
index ce97816..dae68a2 100644
--- a/drivers/pci/host/pci-keystone-dw.c
+++ b/drivers/pci/host/pci-keystone-dw.c
@@ -261,25 +261,26 @@ void ks_dw_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie, int offset)
 	writel(offset, ks_pcie->va_app_base + IRQ_EOI);
 }
 
-void ks_dw_pcie_enable_error_irq(void __iomem *reg_base)
+void ks_dw_pcie_enable_error_irq(struct keystone_pcie *ks_pcie)
 {
-	writel(ERR_IRQ_ALL, reg_base + ERR_IRQ_ENABLE_SET);
+	writel(ERR_IRQ_ALL, ks_pcie->va_app_base + ERR_IRQ_ENABLE_SET);
 }
 
-irqreturn_t ks_dw_pcie_handle_error_irq(struct device *dev,
-					void __iomem *reg_base)
+irqreturn_t ks_dw_pcie_handle_error_irq(struct keystone_pcie *ks_pcie)
 {
 	u32 status;
 
-	status = readl(reg_base + ERR_IRQ_STATUS_RAW) & ERR_IRQ_ALL;
+	status = readl(ks_pcie->va_app_base + ERR_IRQ_STATUS_RAW) &
+			    ERR_IRQ_ALL;
 	if (!status)
 		return IRQ_NONE;
 
 	if (status & ERR_FATAL_IRQ)
-		dev_err(dev, "fatal error (status %#010x)\n", status);
+		dev_err(ks_pcie->pp.dev, "fatal error (status %#010x)\n",
+			status);
 
 	/* Ack the IRQ; status bits are RW1C */
-	writel(status, reg_base + ERR_IRQ_STATUS);
+	writel(status, ks_pcie->va_app_base + ERR_IRQ_STATUS);
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/host/pci-keystone.c
index 9dfac0b..043c19a 100644
--- a/drivers/pci/host/pci-keystone.c
+++ b/drivers/pci/host/pci-keystone.c
@@ -237,7 +237,7 @@ static void ks_pcie_setup_interrupts(struct keystone_pcie *ks_pcie)
 	}
 
 	if (ks_pcie->error_irq > 0)
-		ks_dw_pcie_enable_error_irq(ks_pcie->va_app_base);
+		ks_dw_pcie_enable_error_irq(ks_pcie);
 }
 
 /*
@@ -305,8 +305,7 @@ static irqreturn_t pcie_err_irq_handler(int irq, void *priv)
 {
 	struct keystone_pcie *ks_pcie = priv;
 
-	return ks_dw_pcie_handle_error_irq(ks_pcie->pp.dev,
-					   ks_pcie->va_app_base);
+	return ks_dw_pcie_handle_error_irq(ks_pcie);
 }
 
 static int __init ks_add_pcie_port(struct keystone_pcie *ks_pcie,
diff --git a/drivers/pci/host/pci-keystone.h b/drivers/pci/host/pci-keystone.h
index a5b0cb2..fe2f741 100644
--- a/drivers/pci/host/pci-keystone.h
+++ b/drivers/pci/host/pci-keystone.h
@@ -45,9 +45,8 @@ phys_addr_t ks_dw_pcie_get_msi_addr(struct pcie_port *pp);
 /* Keystone specific PCI controller APIs */
 void ks_dw_pcie_enable_legacy_irqs(struct keystone_pcie *ks_pcie);
 void ks_dw_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie, int offset);
-void ks_dw_pcie_enable_error_irq(void __iomem *reg_base);
-irqreturn_t ks_dw_pcie_handle_error_irq(struct device *dev,
-					void __iomem *reg_base);
+void ks_dw_pcie_enable_error_irq(struct keystone_pcie *ks_pcie);
+irqreturn_t ks_dw_pcie_handle_error_irq(struct keystone_pcie *ks_pcie);
 int  ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie,
 			struct device_node *msi_intc_np);
 int ks_dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,

