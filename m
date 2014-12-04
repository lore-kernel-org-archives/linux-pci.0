Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp08.in.ibm.com ([122.248.162.8]:39096 "EHLO
	e28smtp08.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752550AbaLDFy6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Dec 2014 00:54:58 -0500
Received: from /spool/local
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Thu, 4 Dec 2014 11:24:55 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id 5AF7B394005C
	for <linux-pci@vger.kernel.org>; Thu,  4 Dec 2014 11:24:53 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sB45t6hW46006440
	for <linux-pci@vger.kernel.org>; Thu, 4 Dec 2014 11:25:06 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
	by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sB45spkp016967
	for <linux-pci@vger.kernel.org>; Thu, 4 Dec 2014 11:24:52 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
	mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 3/5] powerpc/powernv: Introduce pnv_pci_poll()
Date: Thu,  4 Dec 2014 16:54:46 +1100
Message-Id: <1417672488-27341-4-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1417672488-27341-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1417672488-27341-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We might not get some PCI slot information (e.g. power status)
immediately by OPAL API. Instead, opal_pci_poll() need to be called
for the required information.

The patch introduces pnv_pci_poll(), which bases on original
ioda_eeh_poll(), to cover the above case

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c | 28 ++--------------------------
 arch/powerpc/platforms/powernv/pci.c      | 19 +++++++++++++++++++
 arch/powerpc/platforms/powernv/pci.h      |  1 +
 3 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index cf38781..21fa033 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -490,24 +490,6 @@ static int ioda_eeh_get_state(struct eeh_pe *pe)
 	return ioda_eeh_get_pe_state(pe);
 }
 
-static s64 ioda_eeh_poll(uint64_t id)
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
 int ioda_eeh_phb_reset(struct pci_controller *hose, int option)
 {
 	struct pnv_phb *phb = hose->private_data;
@@ -536,10 +518,7 @@ int ioda_eeh_phb_reset(struct pci_controller *hose, int option)
 
 	/* Issue reset and poll until it's completed */
 	rc = opal_pci_reset(phb->opal_id, scope, OPAL_ASSERT_RESET);
-	if (rc > 0)
-		rc = ioda_eeh_poll(phb->opal_id);
-
-	return (rc == OPAL_SUCCESS) ? 0 : -EIO;
+	return pnv_pci_poll(phb->opal_id, rc, NULL);
 }
 
 static int __ioda_eeh_bridge_reset(struct pci_dev *dev, int option)
@@ -630,10 +609,7 @@ static int ioda_eeh_bridge_reset(struct pci_dev *dev, int option)
 	phb = hose->private_data;
 	id |= (dev->bus->number << 24) | (dev->devfn << 16) | phb->opal_id;
 	rc = opal_pci_reset(id, scope, OPAL_ASSERT_RESET);
-	if (rc > 0)
-		ioda_eeh_poll(id);
-
-	return (rc == OPAL_SUCCESS) ? 0 : -EIO;
+	return pnv_pci_poll(id, rc, NULL);
 }
 
 static int pnv_pci_dev_reset_type(struct pci_dev *pdev, void *data)
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 4b20f2c..6dc8ea9 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -45,6 +45,25 @@
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
index 6c02ff8..396fe02 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -217,6 +217,7 @@ extern struct pci_ops pnv_pci_ops;
 extern struct pnv_eeh_ops ioda_eeh_ops;
 #endif
 
+int pnv_pci_poll(uint64_t id, int64_t rval, uint8_t *pval);
 void pnv_pci_dump_phb_diag_data(struct pci_controller *hose,
 				unsigned char *log_buff);
 int pnv_pci_cfg_read(struct device_node *dn,
-- 
1.8.3.2

