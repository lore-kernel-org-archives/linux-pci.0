Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751068AbdHOVh1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Aug 2017 17:37:27 -0400
Subject: [PATCH] PCI: keystone: Use PCI_NUM_INTX
From: Bjorn Helgaas <bhelgaas@google.com>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: linux-pci@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>
Date: Tue, 15 Aug 2017 16:37:24 -0500
Message-ID: <20170815213724.8111.96859.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Switch from using a custom MAX_LEGACY_IRQS macro to the generic
PCI_NUM_INTX definition for the number of INTx interrupts.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Murali Karicheri <m-karicheri2@ti.com>
---
 drivers/pci/dwc/pci-keystone-dw.c |    4 ++--
 drivers/pci/dwc/pci-keystone.h    |    1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/dwc/pci-keystone-dw.c b/drivers/pci/dwc/pci-keystone-dw.c
index df60f48716d9..3b0f206590f9 100644
--- a/drivers/pci/dwc/pci-keystone-dw.c
+++ b/drivers/pci/dwc/pci-keystone-dw.c
@@ -251,7 +251,7 @@ void ks_dw_pcie_enable_legacy_irqs(struct keystone_pcie *ks_pcie)
 {
 	int i;
 
-	for (i = 0; i < MAX_LEGACY_IRQS; i++)
+	for (i = 0; i < PCI_NUM_INTX; i++)
 		ks_dw_app_writel(ks_pcie, IRQ_ENABLE_SET + (i << 4), 0x1);
 }
 
@@ -557,7 +557,7 @@ int __init ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie,
 	/* Create legacy IRQ domain */
 	ks_pcie->legacy_irq_domain =
 			irq_domain_add_linear(ks_pcie->legacy_intc_np,
-					MAX_LEGACY_IRQS,
+					PCI_NUM_INTX,
 					&ks_dw_pcie_legacy_irq_domain_ops,
 					NULL);
 	if (!ks_pcie->legacy_irq_domain) {
diff --git a/drivers/pci/dwc/pci-keystone.h b/drivers/pci/dwc/pci-keystone.h
index 74c5825882df..69fc60129f45 100644
--- a/drivers/pci/dwc/pci-keystone.h
+++ b/drivers/pci/dwc/pci-keystone.h
@@ -12,7 +12,6 @@
  * published by the Free Software Foundation.
  */
 
-#define MAX_LEGACY_IRQS			4
 #define MAX_MSI_HOST_IRQS		8
 #define MAX_LEGACY_HOST_IRQS		4
 
