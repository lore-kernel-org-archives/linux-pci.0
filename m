Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:33065 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbaLVFs5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Dec 2014 00:48:57 -0500
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Mon, 22 Dec 2014 15:48:54 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3C3CE2BB005C
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2014 16:48:52 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sBM5mpFO37159046
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2014 16:48:52 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sBM5mo34012766
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2014 16:48:51 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, gwshan@linux.vnet.ibm.com
Cc: linux-pci@vger.kernel.org, Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH 1/2] PCI: Refresh offset/stride after NumVFs is written
Date: Mon, 22 Dec 2014 13:48:45 +0800
Message-Id: <1419227326-12083-2-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1419227326-12083-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1419227326-12083-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

According to SR-IOV SPEC sec 3.3.9, 3.3.10, the NumVFs setting change will
affect the offset and stride. Current implementation doesn't refresh the
offset/stride cached in pci_sriov structure.

This patch introduces a wrapper pci_iov_set_numvfs(), which refresh these two
value after NumVFs is written.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/pci/iov.c |   23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 4b3a4ea..ef0ceaa 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -31,6 +31,21 @@ static inline u8 virtfn_devfn(struct pci_dev *dev, int id)
 		dev->sriov->stride * id) & 0xff;
 }
 
+/**
+ * Per SRIOV SPEC section 3.3.10 and 3.3.11, VF Stride and VF offset may
+ * change when NumVFs changes.
+ *
+ * This function update the iov->offset and iov->stride when NumVFs is written.
+ */
+static inline void pci_iov_set_numvfs(struct pci_dev *dev, int nr_virtfn)
+{
+	struct pci_sriov *iov = dev->sriov;
+
+	pci_write_config_word(dev, iov->pos + PCI_SRIOV_NUM_VF, nr_virtfn);
+	pci_read_config_word(dev, iov->pos + PCI_SRIOV_VF_OFFSET, &iov->offset);
+	pci_read_config_word(dev, iov->pos + PCI_SRIOV_VF_STRIDE, &iov->stride);
+}
+
 static struct pci_bus *virtfn_add_bus(struct pci_bus *bus, int busnr)
 {
 	struct pci_bus *child;
@@ -243,7 +258,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 			return rc;
 	}
 
-	pci_write_config_word(dev, iov->pos + PCI_SRIOV_NUM_VF, nr_virtfn);
+	pci_iov_set_numvfs(dev, nr_virtfn);
 	iov->ctrl |= PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE;
 	pci_cfg_access_lock(dev);
 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
@@ -272,7 +287,7 @@ failed:
 	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
 	pci_cfg_access_lock(dev);
 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
-	pci_write_config_word(dev, iov->pos + PCI_SRIOV_NUM_VF, 0);
+	pci_iov_set_numvfs(dev, 0);
 	ssleep(1);
 	pci_cfg_access_unlock(dev);
 
@@ -303,7 +318,7 @@ static void sriov_disable(struct pci_dev *dev)
 		sysfs_remove_link(&dev->dev.kobj, "dep_link");
 
 	iov->num_VFs = 0;
-	pci_write_config_word(dev, iov->pos + PCI_SRIOV_NUM_VF, 0);
+	pci_iov_set_numvfs(dev, 0);
 }
 
 static int sriov_init(struct pci_dev *dev, int pos)
@@ -439,7 +454,7 @@ static void sriov_restore_state(struct pci_dev *dev)
 		pci_update_resource(dev, i);
 
 	pci_write_config_dword(dev, iov->pos + PCI_SRIOV_SYS_PGSIZE, iov->pgsz);
-	pci_write_config_word(dev, iov->pos + PCI_SRIOV_NUM_VF, iov->num_VFs);
+	pci_iov_set_numvfs(dev, iov->num_VFs);
 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
 	if (iov->ctrl & PCI_SRIOV_CTRL_VFE)
 		msleep(100);
-- 
1.7.9.5

