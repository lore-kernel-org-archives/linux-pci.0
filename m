Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:44489 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754463Ab3C0I4O (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Mar 2013 04:56:14 -0400
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Wed, 27 Mar 2013 02:56:13 -0600
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id D08466E8040
	for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2013 04:56:07 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r2R8uAOP26411224
	for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2013 04:56:10 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r2R8u8nR014422
	for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2013 04:56:09 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: [PATCH 2/4] PCI: Allow pci_msix_table_size() take MSIX cap struct
Date: Wed, 27 Mar 2013 16:56:02 +0800
Message-Id: <1364374564-19096-3-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1364374564-19096-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1364374564-19096-1-git-send-email-shangw@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch introduces additional parameter to pci_msix_table_size()
to allow it take the address of MSI-X capability structure. If that's
zero, we need figure out the address from PCI config space.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 drivers/pci/msi.c               |    9 +++++----
 drivers/pci/pcie/portdrv_core.c |    2 +-
 include/linux/pci.h             |    4 ++--
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 05e9604..7ba9461 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -917,13 +917,14 @@ EXPORT_SYMBOL(pci_disable_msi);
 /**
  * pci_msix_table_size - return the number of device's MSI-X table entries
  * @dev: pointer to the pci_dev data structure of MSI-X device function
+ * @pos: address of MSI-X capability structure
  */
-int pci_msix_table_size(struct pci_dev *dev)
+int pci_msix_table_size(struct pci_dev *dev, int pos)
 {
-	int pos;
 	u16 control;
 
-	pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
+	if (!pos)
+		pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
 	if (!pos)
 		return 0;
 
@@ -958,7 +959,7 @@ int pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries, int nvec)
 	if (status)
 		return status;
 
-	nr_entries = pci_msix_table_size(dev);
+	nr_entries = pci_msix_table_size(dev, pos);
 	if (nvec > nr_entries)
 		return nr_entries;
 
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 31063ac..d9600f3 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -79,7 +79,7 @@ static int pcie_port_enable_msix(struct pci_dev *dev, int *vectors, int mask)
 	u16 reg16;
 	u32 reg32;
 
-	nr_entries = pci_msix_table_size(dev);
+	nr_entries = pci_msix_table_size(dev, 0);
 	if (!nr_entries)
 		return -EINVAL;
 	if (nr_entries > PCIE_PORT_MAX_MSIX_ENTRIES)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2461033a..1b7e7dc 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1116,7 +1116,7 @@ static inline void pci_msi_shutdown(struct pci_dev *dev)
 static inline void pci_disable_msi(struct pci_dev *dev)
 { }
 
-static inline int pci_msix_table_size(struct pci_dev *dev)
+static inline int pci_msix_table_size(struct pci_dev *dev, int pos)
 {
 	return 0;
 }
@@ -1145,7 +1145,7 @@ extern int pci_enable_msi_block(struct pci_dev *dev, unsigned int nvec);
 extern int pci_enable_msi_block_auto(struct pci_dev *dev, unsigned int *maxvec);
 extern void pci_msi_shutdown(struct pci_dev *dev);
 extern void pci_disable_msi(struct pci_dev *dev);
-extern int pci_msix_table_size(struct pci_dev *dev);
+extern int pci_msix_table_size(struct pci_dev *dev, int pos);
 extern int pci_enable_msix(struct pci_dev *dev,
 	struct msix_entry *entries, int nvec);
 extern void pci_msix_shutdown(struct pci_dev *dev);
-- 
1.7.5.4

