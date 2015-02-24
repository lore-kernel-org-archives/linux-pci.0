Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:43735 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbbBXIdd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Feb 2015 03:33:33 -0500
Received: by pdev10 with SMTP id v10so31771333pde.10
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2015 00:33:33 -0800 (PST)
Subject: [PATCH v12 05/21] PCI: Refresh First VF Offset and VF Stride when
 updating NumVFs
To: Wei Yang <weiyang@linux.vnet.ibm.com>, benh@au1.ibm.com,
	gwshan@linux.vnet.ibm.com
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 24 Feb 2015 02:33:31 -0600
Message-ID: <20150224083331.32124.41731.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150224082939.32124.45744.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150224082939.32124.45744.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Wei Yang <weiyang@linux.vnet.ibm.com>

The First VF Offset and VF Stride fields depend on the NumVFs setting, so
refresh the cached fields in struct pci_sriov when updating NumVFs.  See
the SR-IOV spec r1.1, sec 3.3.9 and 3.3.10.

[bhelgaas: changelog, remove kernel-doc comment marker]
Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/iov.c |   23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 27b98c361823..a8752c2c2b53 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -31,6 +31,21 @@ static inline u8 virtfn_devfn(struct pci_dev *dev, int id)
 		dev->sriov->stride * id) & 0xff;
 }
 
+/*
+ * Per SR-IOV spec sec 3.3.10 and 3.3.11, First VF Offset and VF Stride may
+ * change when NumVFs changes.
+ *
+ * Update iov->offset and iov->stride when NumVFs is written.
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
@@ -253,7 +268,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 			return rc;
 	}
 
-	pci_write_config_word(dev, iov->pos + PCI_SRIOV_NUM_VF, nr_virtfn);
+	pci_iov_set_numvfs(dev, nr_virtfn);
 	iov->ctrl |= PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE;
 	pci_cfg_access_lock(dev);
 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
@@ -282,7 +297,7 @@ failed:
 	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
 	pci_cfg_access_lock(dev);
 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
-	pci_write_config_word(dev, iov->pos + PCI_SRIOV_NUM_VF, 0);
+	pci_iov_set_numvfs(dev, 0);
 	ssleep(1);
 	pci_cfg_access_unlock(dev);
 
@@ -313,7 +328,7 @@ static void sriov_disable(struct pci_dev *dev)
 		sysfs_remove_link(&dev->dev.kobj, "dep_link");
 
 	iov->num_VFs = 0;
-	pci_write_config_word(dev, iov->pos + PCI_SRIOV_NUM_VF, 0);
+	pci_iov_set_numvfs(dev, 0);
 }
 
 static int sriov_init(struct pci_dev *dev, int pos)
@@ -452,7 +467,7 @@ static void sriov_restore_state(struct pci_dev *dev)
 		pci_update_resource(dev, i);
 
 	pci_write_config_dword(dev, iov->pos + PCI_SRIOV_SYS_PGSIZE, iov->pgsz);
-	pci_write_config_word(dev, iov->pos + PCI_SRIOV_NUM_VF, iov->num_VFs);
+	pci_iov_set_numvfs(dev, iov->num_VFs);
 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
 	if (iov->ctrl & PCI_SRIOV_CTRL_VFE)
 		msleep(100);

