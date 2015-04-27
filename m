Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:58729 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752869AbbD0GjW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 27 Apr 2015 02:39:22 -0400
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Mon, 27 Apr 2015 16:39:21 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 1CF962BB0055
	for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2015 16:39:19 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t3R6dBx322937766
	for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2015 16:39:19 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t3R6cj2g016175
	for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2015 16:38:45 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, benh@kernel.crashing.org,
	bhelgaas@google.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v3 14/21] powerpc/powernv: Introduce pnv_pci_poll()
Date: Mon, 27 Apr 2015 16:37:46 +1000
Message-Id: <1430116673-22500-15-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1430116673-22500-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1430116673-22500-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We might not get some PCI slot information (e.g. power status)
immediately by OPAL API. Instead, opal_pci_poll() need to be called
for the required information.

The patch introduces pnv_pci_poll(), which bases on original
pnv_eeh_poll(), to cover the above case

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 28 ++--------------------------
 arch/powerpc/platforms/powernv/pci.c         | 16 ++++++++++++++++
 arch/powerpc/platforms/powernv/pci.h         |  1 +
 3 files changed, 19 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 58e4dcf..9253b9e 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -742,24 +742,6 @@ static int pnv_eeh_get_state(struct eeh_pe *pe, int *delay)
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
@@ -788,10 +770,7 @@ int pnv_eeh_phb_reset(struct pci_controller *hose, int option)
 
 	/* Issue reset and poll until it's completed */
 	rc = opal_pci_reset(phb->opal_id, scope, OPAL_ASSERT_RESET);
-	if (rc > 0)
-		rc = pnv_eeh_poll(phb->opal_id);
-
-	return (rc == OPAL_SUCCESS) ? 0 : -EIO;
+	return pnv_pci_poll(phb->opal_id, rc, NULL);
 }
 
 static int __pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
@@ -882,10 +861,7 @@ static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
 	phb = hose->private_data;
 	id |= (dev->bus->number << 24) | (dev->devfn << 16) | phb->opal_id;
 	rc = opal_pci_reset(id, scope, OPAL_ASSERT_RESET);
-	if (rc > 0)
-		rc = pnv_eeh_poll(id);
-
-	return (rc == OPAL_SUCCESS) ? 0 : -EIO;
+	return pnv_pci_poll(id, rc, NULL);
 }
 
 static int pnv_pci_dev_reset_type(struct pci_dev *pdev, void *data)
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index bca2aeb..a2da9a3 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -44,6 +44,22 @@
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
+		if (rval == OPAL_SUCCESS && pval)
+			rval = opal_pci_poll(id, pval);
+	}
+
+	return rval ? -EIO : 0;
+}
+
 #ifdef CONFIG_PCI_MSI
 static int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 {
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 8b10f01..82c5539 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -202,6 +202,7 @@ struct pnv_phb {
 
 extern struct pci_ops pnv_pci_ops;
 
+int pnv_pci_poll(uint64_t id, int64_t rval, uint8_t *pval);
 void pnv_pci_dump_phb_diag_data(struct pci_controller *hose,
 				unsigned char *log_buff);
 int pnv_pci_cfg_read(struct pci_dn *pdn,
-- 
2.1.0

