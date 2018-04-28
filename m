Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:46507 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759307AbeD1B5J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Apr 2018 21:57:09 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 3/9] PCI: keystone-dw: Use pci_alloc_intx_irqd() helper to get irq domain for INTx
Date: Sat, 28 Apr 2018 09:49:20 +0800
Message-Id: <1524880160-100998-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1524880102-100856-1-git-send-email-shawn.lin@rock-chips.com>
References: <1524880102-100856-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Just avoid code duplication, but no functional change intended.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 drivers/pci/dwc/pci-keystone-dw.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/dwc/pci-keystone-dw.c b/drivers/pci/dwc/pci-keystone-dw.c
index 0682213..171198a 100644
--- a/drivers/pci/dwc/pci-keystone-dw.c
+++ b/drivers/pci/dwc/pci-keystone-dw.c
@@ -470,15 +470,11 @@ int __init ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie,
 	ks_pcie->app = *res;
 
 	/* Create legacy IRQ domain */
-	ks_pcie->legacy_irq_domain =
-			irq_domain_add_linear(ks_pcie->legacy_intc_np,
-					PCI_NUM_INTX,
+	ks_pcie->legacy_irq_domain = pci_alloc_intx_irqd(dev, ks_pcie, false,
 					&ks_dw_pcie_legacy_irq_domain_ops,
-					NULL);
-	if (!ks_pcie->legacy_irq_domain) {
-		dev_err(dev, "Failed to add irq domain for legacy irqs\n");
-		return -EINVAL;
-	}
+					ks_pcie->legacy_intc_np);
+	if (IS_ERR(ks_pcie->legacy_irq_domain))
+		return PTR_ERR(ks_pcie->legacy_irq_domain);
 
 	return dw_pcie_host_init(pp);
 }
-- 
1.9.1
