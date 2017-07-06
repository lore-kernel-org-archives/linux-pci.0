Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:37463 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbdGFI5A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jul 2017 04:57:00 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Murali Karicheri <m-karicheri2@ti.com>, linux-pci@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] PCI: pci-keystone-dw: remove some unused variables
Date: Thu,  6 Jul 2017 16:56:44 +0800
Message-Id: <1499331404-122436-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We got the following warning:

drivers/pci/dwc/pci-keystone-dw.c: In function
'ks_dw_pcie_msi_irq_mask':

drivers/pci/dwc/pci-keystone-dw.c:171:24: warning: variable 'ks_pcie'
set but not used [-Wunused-but-set-variable]

drivers/pci/dwc/pci-keystone-dw.c: In function
  'ks_dw_pcie_msi_irq_unmask':

drivers/pci/dwc/pci-keystone-dw.c:194:24: warning: variable 'ks_pcie'
  set but not used [-Wunused-but-set-variable

By looing into the code, ks_pcie and pci variables are never used.
Remove them to silent the compile warning.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/dwc/pci-keystone-dw.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/pci/dwc/pci-keystone-dw.c b/drivers/pci/dwc/pci-keystone-dw.c
index 8bc626e..df60f487 100644
--- a/drivers/pci/dwc/pci-keystone-dw.c
+++ b/drivers/pci/dwc/pci-keystone-dw.c
@@ -168,16 +168,12 @@ void ks_dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
 
 static void ks_dw_pcie_msi_irq_mask(struct irq_data *d)
 {
-	struct keystone_pcie *ks_pcie;
 	struct msi_desc *msi;
 	struct pcie_port *pp;
-	struct dw_pcie *pci;
 	u32 offset;
 
 	msi = irq_data_get_msi_desc(d);
 	pp = (struct pcie_port *) msi_desc_to_pci_sysdata(msi);
-	pci = to_dw_pcie_from_pp(pp);
-	ks_pcie = to_keystone_pcie(pci);
 	offset = d->irq - irq_linear_revmap(pp->irq_domain, 0);
 
 	/* Mask the end point if PVM implemented */
@@ -191,16 +187,12 @@ static void ks_dw_pcie_msi_irq_mask(struct irq_data *d)
 
 static void ks_dw_pcie_msi_irq_unmask(struct irq_data *d)
 {
-	struct keystone_pcie *ks_pcie;
 	struct msi_desc *msi;
 	struct pcie_port *pp;
-	struct dw_pcie *pci;
 	u32 offset;
 
 	msi = irq_data_get_msi_desc(d);
 	pp = (struct pcie_port *) msi_desc_to_pci_sysdata(msi);
-	pci = to_dw_pcie_from_pp(pp);
-	ks_pcie = to_keystone_pcie(pci);
 	offset = d->irq - irq_linear_revmap(pp->irq_domain, 0);
 
 	/* Mask the end point if PVM implemented */
-- 
1.9.1
