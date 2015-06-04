Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:37365 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664AbbFDGoz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jun 2015 02:44:55 -0400
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Thu, 4 Jun 2015 16:44:53 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, bhelgaas@google.com, aik@ozlabs.ru,
	panto@antoniou-consulting.com, robherring2@gmail.com,
	grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v5 32/42] powerpc/powernv: Introduce pnv_pci_poll()
Date: Thu,  4 Jun 2015 16:42:01 +1000
Message-Id: <1433400131-18429-33-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch obsoletes pnv_eeh_poll() with pnv_pci_poll():

   * The return value from last OPAL API is passed to the
     pnv_pci_poll() and handled there.
   * More information (e.g. PCI slot power status) is retrieved
     if the last argument is valid.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
v5:
  * Derived from PATCH[v4 13/21]
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 46 ++++++----------------------
 arch/powerpc/platforms/powernv/pci.c         | 21 +++++++++++++
 arch/powerpc/platforms/powernv/pci.h         |  1 +
 3 files changed, 31 insertions(+), 37 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 4eb53ed..7ee328b 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -743,28 +743,11 @@ static int pnv_eeh_get_state(struct eeh_pe *pe, int *delay)
 	return ret;
 }
 
-static s64 pnv_eeh_poll(uint64_t id)
-{
-	s64 rc = OPAL_HARDWARE;
-
-	while (1) {
-		rc = opal_pci_poll(id, NULL);
-		if (rc <= 0)
-			break;
-
-		if (system_state < SYSTEM_RUNNING)
-			udelay(1000 * rc);
-		else
-			msleep(rc);
-	}
-
-	return rc;
-}
-
 int pnv_eeh_phb_reset(struct pci_controller *hose, int option)
 {
 	struct pnv_phb *phb = hose->private_data;
 	s64 rc = OPAL_HARDWARE;
+	int ret;
 
 	pr_debug("%s: Reset PHB#%x, option=%d\n",
 		 __func__, hose->global_number, option);
@@ -779,8 +762,6 @@ int pnv_eeh_phb_reset(struct pci_controller *hose, int option)
 		rc = opal_pci_reset(phb->opal_id,
 				    OPAL_RESET_PHB_COMPLETE,
 				    OPAL_DEASSERT_RESET);
-	if (rc < 0)
-		goto out;
 
 	/*
 	 * Poll state of the PHB until the request is done
@@ -788,24 +769,22 @@ int pnv_eeh_phb_reset(struct pci_controller *hose, int option)
 	 * reset followed by hot reset on root bus. So we also
 	 * need the PCI bus settlement delay.
 	 */
-	rc = pnv_eeh_poll(phb->opal_id);
-	if (option == EEH_RESET_DEACTIVATE) {
+	ret = pnv_pci_poll(phb->opal_id, rc, NULL);
+	if (option == EEH_RESET_DEACTIVATE && !ret) {
 		if (system_state < SYSTEM_RUNNING)
 			udelay(1000 * EEH_PE_RST_SETTLE_TIME);
 		else
 			msleep(EEH_PE_RST_SETTLE_TIME);
 	}
-out:
-	if (rc != OPAL_SUCCESS)
-		return -EIO;
 
-	return 0;
+	return ret;
 }
 
 static int pnv_eeh_root_reset(struct pci_controller *hose, int option)
 {
 	struct pnv_phb *phb = hose->private_data;
 	s64 rc = OPAL_HARDWARE;
+	int ret;
 
 	pr_debug("%s: Reset PHB#%x, option=%d\n",
 		 __func__, hose->global_number, option);
@@ -827,18 +806,13 @@ static int pnv_eeh_root_reset(struct pci_controller *hose, int option)
 		rc = opal_pci_reset(phb->opal_id,
 				    OPAL_RESET_PCI_HOT,
 				    OPAL_DEASSERT_RESET);
-	if (rc < 0)
-		goto out;
 
 	/* Poll state of the PHB until the request is done */
-	rc = pnv_eeh_poll(phb->opal_id);
-	if (option == EEH_RESET_DEACTIVATE)
+	ret = pnv_pci_poll(phb->opal_id, rc, NULL);
+	if (option == EEH_RESET_DEACTIVATE && !ret)
 		msleep(EEH_PE_RST_SETTLE_TIME);
-out:
-	if (rc != OPAL_SUCCESS)
-		return -EIO;
 
-	return 0;
+	return ret;
 }
 
 static int __pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
@@ -928,10 +902,8 @@ static int pnv_eeh_bridge_reset(struct pci_dev *pdev, int option)
 	phb = hose->private_data;
 	id |= (pdev->bus->number << 24) | (pdev->devfn << 16) | phb->opal_id;
 	rc = opal_pci_reset(id, scope, OPAL_ASSERT_RESET);
-	if (rc > 0)
-		rc = pnv_eeh_poll(id);
 
-	return (rc == OPAL_SUCCESS) ? 0 : -EIO;
+	return pnv_pci_poll(id, rc, NULL);
 }
 
 static void pnv_eeh_wait_for_pending(struct pci_dn *pdn, int pos,
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 678eb24..bf5df04 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -44,6 +44,27 @@
 #define cfg_dbg(fmt...)	do { } while(0)
 //#define cfg_dbg(fmt...)	printk(fmt)
 
+int pnv_pci_poll(uint64_t id, int64_t rval, uint8_t *pval)
+{
+	while (rval > 0) {
+		if (system_state < SYSTEM_RUNNING)
+			udelay(1000 * rval);
+		else
+			msleep(rval);
+
+		rval = opal_pci_poll(id, pval);
+	}
+
+	/*
+	 * The caller expects to retrieve additional information
+	 * if the last argument is valid.
+	 */
+	if (rval == OPAL_SUCCESS && pval)
+		rval = opal_pci_poll(id, pval);
+
+	return rval ? -EIO : 0;
+}
+
 #ifdef CONFIG_PCI_MSI
 static int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 {
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index f68e036..510e781 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -214,6 +214,7 @@ extern int pnv_tce_xchg(struct iommu_table *tbl, long index,
 		unsigned long *hpa, enum dma_data_direction *direction);
 extern unsigned long pnv_tce_get(struct iommu_table *tbl, long index);
 
+int pnv_pci_poll(uint64_t id, int64_t rval, uint8_t *pval);
 void pnv_pci_dump_phb_diag_data(struct pci_controller *hose,
 				unsigned char *log_buff);
 int pnv_pci_cfg_read(struct pci_dn *pdn,
-- 
2.1.0

