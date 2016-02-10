Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:33465 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbcBJGEI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 10 Feb 2016 01:04:08 -0500
Received: from localhost
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Wed, 10 Feb 2016 16:04:06 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 12B932CE8058
	for <linux-pci@vger.kernel.org>; Wed, 10 Feb 2016 17:03:56 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u1A63iXT36176058
	for <linux-pci@vger.kernel.org>; Wed, 10 Feb 2016 17:03:52 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u1A63MOC010691
	for <linux-pci@vger.kernel.org>; Wed, 10 Feb 2016 17:03:23 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, mpe@ellerman.id.au,
	aik@ozlabs.ru, ruscur@russell.cc,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH v14 1/9] PCI/IOV: Rename and export virtfn_{add, remove}
Date: Wed, 10 Feb 2016 17:02:49 +1100
Message-Id: <1455084177-15525-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1455084177-15525-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1455084177-15525-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Wei Yang <weiyang@linux.vnet.ibm.com>

During EEH recovery, hotplug is applied to the devices which don't
have drivers or their drivers don't support EEH. However, the hotplug,
which was implemented based on PCI bus, can't be applied to VF directly.
Instead, we unplug and plug individual PCI devices (VFs).

This renames virtn_{add,remove}() and exports them so they can be used
in PCI hotplug during EEH recovery.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/iov.c   | 10 +++++-----
 include/linux/pci.h |  8 ++++++++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 31f31d4..fa4f138 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -113,7 +113,7 @@ resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
 	return dev->sriov->barsz[resno - PCI_IOV_RESOURCES];
 }
 
-static int virtfn_add(struct pci_dev *dev, int id, int reset)
+int pci_iov_add_virtfn(struct pci_dev *dev, int id, int reset)
 {
 	int i;
 	int rc = -ENOMEM;
@@ -188,7 +188,7 @@ failed:
 	return rc;
 }
 
-static void virtfn_remove(struct pci_dev *dev, int id, int reset)
+void pci_iov_remove_virtfn(struct pci_dev *dev, int id, int reset)
 {
 	char buf[VIRTFN_ID_LEN];
 	struct pci_dev *virtfn;
@@ -321,7 +321,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 	}
 
 	for (i = 0; i < initial; i++) {
-		rc = virtfn_add(dev, i, 0);
+		rc = pci_iov_add_virtfn(dev, i, 0);
 		if (rc)
 			goto failed;
 	}
@@ -333,7 +333,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 
 failed:
 	while (i--)
-		virtfn_remove(dev, i, 0);
+		pci_iov_remove_virtfn(dev, i, 0);
 
 	pcibios_sriov_disable(dev);
 err_pcibios:
@@ -359,7 +359,7 @@ static void sriov_disable(struct pci_dev *dev)
 		return;
 
 	for (i = 0; i < iov->num_VFs; i++)
-		virtfn_remove(dev, i, 0);
+		pci_iov_remove_virtfn(dev, i, 0);
 
 	pcibios_sriov_disable(dev);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 27df4a6..3db5e30 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1738,6 +1738,8 @@ int pci_iov_virtfn_devfn(struct pci_dev *dev, int id);
 
 int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn);
 void pci_disable_sriov(struct pci_dev *dev);
+int pci_iov_add_virtfn(struct pci_dev *dev, int id, int reset);
+void pci_iov_remove_virtfn(struct pci_dev *dev, int id, int reset);
 int pci_num_vf(struct pci_dev *dev);
 int pci_vfs_assigned(struct pci_dev *dev);
 int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
@@ -1754,6 +1756,12 @@ static inline int pci_iov_virtfn_devfn(struct pci_dev *dev, int id)
 }
 static inline int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn)
 { return -ENODEV; }
+static inline int pci_iov_add_virtfn(struct pci_dev *dev, int id, int reset)
+{
+	return -ENOSYS;
+}
+static inline void pci_iov_remove_virtfn(struct pci_dev *dev,
+					 int id, int reset) { }
 static inline void pci_disable_sriov(struct pci_dev *dev) { }
 static inline int pci_num_vf(struct pci_dev *dev) { return 0; }
 static inline int pci_vfs_assigned(struct pci_dev *dev)
-- 
2.1.0

