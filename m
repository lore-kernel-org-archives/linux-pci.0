Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:42687 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbbEHD6L (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2015 23:58:11 -0400
Received: from /spool/local
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Fri, 8 May 2015 13:58:09 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t483sL8113566140
	for <linux-pci@vger.kernel.org>; Fri, 8 May 2015 13:54:29 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t483ruwh006343
	for <linux-pci@vger.kernel.org>; Fri, 8 May 2015 13:53:57 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, gwshan@linux.vnet.ibm.com
Cc: linux-pci@vger.kernel.org, Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V2] pci/iov: fix resource leak on destroying VF
Date: Fri,  8 May 2015 11:53:27 +0800
Message-Id: <1431057207-30775-1-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1428655984-26903-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1428655984-26903-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Beside pci_dev resources, VF has other resources between its PF, like
refcount to PF, sysfs link between them and the virtual bus. When a VF is
released in virtfn_remove(), those resources are released properly. But
in the hotplug case, they are not.

In hotplug case, VFs are removed by pci_stop_and_remove_bus_device()
instead of virtfn_remove(). This leads to some leak for resources.

This patch moves the resource release to pci_destroy_dev() to make sure
those resources are released when VF is destroyed.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/pci/iov.c    |   42 +++++++++++++++++++++++-------------------
 drivers/pci/pci.h    |   10 ++++++++++
 drivers/pci/remove.c |   31 +++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index ee0ebff..47daf2f 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -17,8 +17,6 @@
 #include <linux/pci-ats.h>
 #include "pci.h"
 
-#define VIRTFN_ID_LEN	16
-
 int pci_iov_virtfn_bus(struct pci_dev *dev, int vf_id)
 {
 	if (!dev->is_physfn)
@@ -94,7 +92,7 @@ static struct pci_bus *virtfn_add_bus(struct pci_bus *bus, int busnr)
 	return child;
 }
 
-static void virtfn_remove_bus(struct pci_bus *physbus, struct pci_bus *virtbus)
+void virtfn_remove_bus(struct pci_bus *physbus, struct pci_bus *virtbus)
 {
 	if (physbus != virtbus && list_empty(&virtbus->devices))
 		pci_remove_bus(virtbus);
@@ -185,9 +183,7 @@ failed:
 
 static void virtfn_remove(struct pci_dev *dev, int id, int reset)
 {
-	char buf[VIRTFN_ID_LEN];
 	struct pci_dev *virtfn;
-	struct pci_sriov *iov = dev->sriov;
 
 	virtfn = pci_get_domain_bus_and_slot(pci_domain_nr(dev->bus),
 					     pci_iov_virtfn_bus(dev, id),
@@ -200,24 +196,10 @@ static void virtfn_remove(struct pci_dev *dev, int id, int reset)
 		__pci_reset_function(virtfn);
 	}
 
-	sprintf(buf, "virtfn%u", id);
-	sysfs_remove_link(&dev->dev.kobj, buf);
-	/*
-	 * pci_stop_dev() could have been called for this virtfn already,
-	 * so the directory for the virtfn may have been removed before.
-	 * Double check to avoid spurious sysfs warnings.
-	 */
-	if (virtfn->dev.kobj.sd)
-		sysfs_remove_link(&virtfn->dev.kobj, "physfn");
-
-	mutex_lock(&iov->dev->sriov->lock);
 	pci_stop_and_remove_bus_device(virtfn);
-	virtfn_remove_bus(dev->bus, virtfn->bus);
-	mutex_unlock(&iov->dev->sriov->lock);
 
 	/* balance pci_get_domain_bus_and_slot() */
 	pci_dev_put(virtfn);
-	pci_dev_put(dev);
 }
 
 int __weak pcibios_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
@@ -760,3 +742,25 @@ int pci_sriov_get_totalvfs(struct pci_dev *dev)
 	return dev->sriov->total_VFs;
 }
 EXPORT_SYMBOL_GPL(pci_sriov_get_totalvfs);
+
+void pci_sriov_lock(struct pci_dev *dev)
+{
+	struct pci_sriov *iov;
+
+	if (!dev->is_physfn)
+		return;
+
+	iov = dev->sriov;
+	mutex_lock(&iov->dev->sriov->lock);
+}
+
+void pci_sriov_unlock(struct pci_dev *dev)
+{
+	struct pci_sriov *iov;
+
+	if (!dev->is_physfn)
+		return;
+
+	iov = dev->sriov;
+	mutex_unlock(&iov->dev->sriov->lock);
+}
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9bd762c2..a0323a2 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -260,6 +260,12 @@ static inline void pci_restore_ats_state(struct pci_dev *dev)
 #endif /* CONFIG_PCI_ATS */
 
 #ifdef CONFIG_PCI_IOV
+
+#define VIRTFN_ID_LEN	16
+void pci_sriov_lock(struct pci_dev *dev);
+void pci_sriov_unlock(struct pci_dev *dev);
+void virtfn_remove_bus(struct pci_bus *physbus, struct pci_bus *virtbus);
+
 int pci_iov_init(struct pci_dev *dev);
 void pci_iov_release(struct pci_dev *dev);
 int pci_iov_resource_bar(struct pci_dev *dev, int resno);
@@ -268,6 +274,10 @@ void pci_restore_iov_state(struct pci_dev *dev);
 int pci_iov_bus_range(struct pci_bus *bus);
 
 #else
+static inline void pci_sriov_lock(struct pci_dev *dev) { }
+static inline void pci_sriov_unlock(struct pci_dev *dev) { }
+static inline void virtfn_remove_bus(struct pci_bus *physbus,
+		struct pci_bus *virtbus) { }
 static inline int pci_iov_init(struct pci_dev *dev)
 {
 	return -ENODEV;
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 8a280e9..f2a07bf 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -41,6 +41,37 @@ static void pci_destroy_dev(struct pci_dev *dev)
 	list_del(&dev->bus_list);
 	up_write(&pci_bus_sem);
 
+#ifdef CONFIG_PCI_IOV
+	if (dev->is_virtfn) {
+		char buf[VIRTFN_ID_LEN];
+		int id;
+		struct pci_dev *pdev = dev->physfn;
+
+		for (id = 0; id < pci_sriov_get_totalvfs(pdev); id++) {
+			if ((dev->bus->number == pci_iov_virtfn_bus(pdev, id))
+			   && (dev->devfn == pci_iov_virtfn_devfn(pdev, id))) {
+				sprintf(buf, "virtfn%u", id);
+				sysfs_remove_link(&pdev->dev.kobj, buf);
+				break;
+			}
+		}
+		/*
+		 * pci_stop_dev() could have been called for this virtfn
+		 * already, so the directory for the virtfn may have been
+		 * removed before.  Double check to avoid spurious sysfs
+		 * warnings.
+		 */
+		if (dev->dev.kobj.sd)
+			sysfs_remove_link(&dev->dev.kobj, "physfn");
+
+		pci_sriov_lock(pdev);
+		virtfn_remove_bus(pdev->bus, dev->bus);
+		pci_sriov_unlock(pdev);
+
+		pci_dev_put(dev->physfn);
+	}
+#endif
+
 	pci_free_resources(dev);
 	put_device(&dev->dev);
 }
-- 
1.7.9.5

