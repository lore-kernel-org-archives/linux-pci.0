Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148]:44785 "EHLO
	e23smtp06.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649AbbBQHOw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Feb 2015 02:14:52 -0500
Received: from /spool/local
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Tue, 17 Feb 2015 17:14:50 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 00BC12CE8054
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2015 18:14:48 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t1H7Ed9t45547572
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2015 18:14:47 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t1H7EEax027376
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2015 18:14:14 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: linux-pci@vger.kernel.org, benh@kernel.crashing.org,
	bhelgaas@google.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH RESEND v2 5/7] powerpc/powernv: Introduce pnv_pci_poll()
Date: Tue, 17 Feb 2015 18:13:21 +1100
Message-Id: <1424157203-691-6-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1424157203-691-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1424157203-691-1-git-send-email-gwshan@linux.vnet.ibm.com>
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
 arch/powerpc/platforms/powernv/pci.c         | 19 +++++++++++++++++++
 arch/powerpc/platforms/powernv/pci.h         |  1 +
 3 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index eeda6e1..81a9cb2 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -665,24 +665,6 @@ static int pnv_eeh_get_state(struct eeh_pe *pe, int *delay)
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
@@ -711,10 +693,7 @@ int pnv_eeh_phb_reset(struct pci_controller *hose, int option)
 
 	/* Issue reset and poll until it's completed */
 	rc = opal_pci_reset(phb->opal_id, scope, OPAL_ASSERT_RESET);
-	if (rc > 0)
-		rc = pnv_eeh_poll(phb->opal_id);
-
-	return (rc == OPAL_SUCCESS) ? 0 : -EIO;
+	return pnv_pci_poll(phb->opal_id, rc, NULL);
 }
 
 static int __pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
@@ -805,10 +784,7 @@ static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
 	phb = hose->private_data;
 	id |= (dev->bus->number << 24) | (dev->devfn << 16) | phb->opal_id;
 	rc = opal_pci_reset(id, scope, OPAL_ASSERT_RESET);
-	if (rc > 0)
-		pnv_eeh_poll(id);
-
-	return (rc == OPAL_SUCCESS) ? 0 : -EIO;
+	return pnv_pci_poll(id, rc, NULL);
 }
 
 static int pnv_pci_dev_reset_type(struct pci_dev *pdev, void *data)
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index c68d508..a0ffae2 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -44,6 +44,25 @@
 #define cfg_dbg(fmt...)	do { } while(0)
 //#define cfg_dbg(fmt...)	printk(fmt)
 
+int pnv_pci_poll(uint64_t id, int64_t rval, uint8_t *pval)
+{
+	while (rval > 0) {
+		rval = opal_pci_poll(id, pval);
+		if (rval == OPAL_SUCCESS && pval)
+			rval = opal_pci_poll(id, pval);
+
+		if (rval <= 0)
+			break;
+
+		if (system_state < SYSTEM_RUNNING)
+			udelay(1000 * rval);
+		else
+			msleep(rval);
+	}
+
+	return rval ? -EIO : 0;
+}
+
 #ifdef CONFIG_PCI_MSI
 static int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 {
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 18ae927..19f532b 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -194,6 +194,7 @@ struct pnv_phb {
 
 extern struct pci_ops pnv_pci_ops;
 
+int pnv_pci_poll(uint64_t id, int64_t rval, uint8_t *pval);
 void pnv_pci_dump_phb_diag_data(struct pci_controller *hose,
 				unsigned char *log_buff);
 int pnv_pci_cfg_read(struct device_node *dn,
-- 
1.8.3.2

