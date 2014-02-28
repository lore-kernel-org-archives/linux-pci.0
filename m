Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35611 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974AbaB1Rag (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 28 Feb 2014 12:30:36 -0500
From: Lucas Stach <l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-pci@vger.kernel.org, Richard Zhu <r65037@freescale.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>, kernel@pengutronix.de
Subject: [PATCH 2/3] PCI: designware: make MSI isr shared irq aware
Date: Fri, 28 Feb 2014 18:30:32 +0100
Message-Id: <1393608633-18321-3-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1393608633-18321-1-git-send-email-l.stach@pengutronix.de>
References: <1393608633-18321-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On i.MX6 the host controller MSI irq is shared
with PCI legacy INTD. Make sure we don't bail too
early from the irq handler.

The issue is fairly theoretical as it would require
a system setup with a PCIe switch where one connected
device is using legacy INTD and another one using
MSI, but better fix it now.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/host/pci-exynos.c      | 4 +---
 drivers/pci/host/pcie-designware.c | 6 +++++-
 drivers/pci/host/pcie-designware.h | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index 3de6bfbbe8e9..b616d34922d8 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -415,9 +415,7 @@ static irqreturn_t exynos_pcie_msi_irq_handler(int irq, void *arg)
 {
 	struct pcie_port *pp = arg;
 
-	dw_handle_msi_irq(pp);
-
-	return IRQ_HANDLED;
+	return dw_handle_msi_irq(pp);
 }
 
 static void exynos_pcie_msi_init(struct pcie_port *pp)
diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 3e0c2af11528..f8c174a7d657 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -156,15 +156,17 @@ static struct irq_chip dw_msi_irq_chip = {
 };
 
 /* MSI int handler */
-void dw_handle_msi_irq(struct pcie_port *pp)
+irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
 {
 	unsigned long val;
 	int i, pos, irq;
+	irqreturn_t ret = IRQ_NONE;
 
 	for (i = 0; i < MAX_MSI_CTRLS; i++) {
 		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_STATUS + i * 12, 4,
 				(u32 *)&val);
 		if (val) {
+			ret = IRQ_HANDLED;
 			pos = 0;
 			while ((pos = find_next_bit(&val, 32, pos)) != 32) {
 				irq = irq_find_mapping(pp->irq_domain,
@@ -177,6 +179,8 @@ void dw_handle_msi_irq(struct pcie_port *pp)
 			}
 		}
 	}
+
+	return ret;
 }
 
 void dw_pcie_msi_init(struct pcie_port *pp)
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index 3063b3594d88..a169d22d517e 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -68,7 +68,7 @@ struct pcie_host_ops {
 
 int dw_pcie_cfg_read(void __iomem *addr, int where, int size, u32 *val);
 int dw_pcie_cfg_write(void __iomem *addr, int where, int size, u32 val);
-void dw_handle_msi_irq(struct pcie_port *pp);
+irqreturn_t dw_handle_msi_irq(struct pcie_port *pp);
 void dw_pcie_msi_init(struct pcie_port *pp);
 int dw_pcie_link_up(struct pcie_port *pp);
 void dw_pcie_setup_rc(struct pcie_port *pp);
-- 
1.8.5.3

