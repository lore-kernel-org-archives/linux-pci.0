Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:37208 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbbFDGnk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jun 2015 02:43:40 -0400
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Thu, 4 Jun 2015 16:43:38 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, bhelgaas@google.com, aik@ozlabs.ru,
	panto@antoniou-consulting.com, robherring2@gmail.com,
	grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v5 20/42] powerpc/powernv: Rename pnv_ioda_get_pe() to pnv_ioda_dev_to_pe()
Date: Thu,  4 Jun 2015 16:41:49 +1000
Message-Id: <1433400131-18429-21-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pnv_ioda_get_pe() indicates it's increasing refcount to the given
PE instance from the name. However, it gets the instance of the
PE, which contains the indicated PCI device. The patch renames it
to pnv_ioda_dev_to_pe() to reflect its purpose.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
v5:
  * Split from PATCH[v4 07/21]
  * Fixed "do not use assignment in if condition" from checkpatch.pl
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 0447534..e9165fa 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -702,7 +702,7 @@ static int pnv_ioda_get_pe_state(struct pnv_phb *phb, int pe_no)
  * but in the meantime, we need to protect them to avoid warnings
  */
 #ifdef CONFIG_PCI_MSI
-static struct pnv_ioda_pe *pnv_ioda_get_pe(struct pci_dev *dev)
+static struct pnv_ioda_pe *pnv_ioda_dev_to_pe(struct pci_dev *dev)
 {
 	struct pci_controller *hose = pci_bus_to_host(dev->bus);
 	struct pnv_phb *phb = hose->private_data;
@@ -2671,7 +2671,7 @@ int pnv_phb_to_cxl_mode(struct pci_dev *dev, uint64_t mode)
 	struct pnv_ioda_pe *pe;
 	int rc;
 
-	pe = pnv_ioda_get_pe(dev);
+	pe = pnv_ioda_dev_to_pe(dev);
 	if (!pe)
 		return -ENODEV;
 
@@ -2787,7 +2787,8 @@ int pnv_cxl_ioda_msi_setup(struct pci_dev *dev, unsigned int hwirq,
 	struct pnv_ioda_pe *pe;
 	int rc;
 
-	if (!(pe = pnv_ioda_get_pe(dev)))
+	pe = pnv_ioda_dev_to_pe(dev);
+	if (!pe)
 		return -ENODEV;
 
 	/* Assign XIVE to PE */
@@ -2809,7 +2810,7 @@ static int pnv_pci_ioda_msi_setup(struct pnv_phb *phb, struct pci_dev *dev,
 				  unsigned int hwirq, unsigned int virq,
 				  unsigned int is_64, struct msi_msg *msg)
 {
-	struct pnv_ioda_pe *pe = pnv_ioda_get_pe(dev);
+	struct pnv_ioda_pe *pe = pnv_ioda_dev_to_pe(dev);
 	unsigned int xive_num = hwirq - phb->msi_base;
 	__be32 data;
 	int rc;
-- 
2.1.0

