Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:44929 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbaLVFs7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Dec 2014 00:48:59 -0500
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Mon, 22 Dec 2014 15:48:57 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5F2872CE8071
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2014 16:48:54 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sBM5mrFD38273046
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2014 16:48:54 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sBM5mrvY012827
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2014 16:48:53 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, gwshan@linux.vnet.ibm.com
Cc: linux-pci@vger.kernel.org, Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH 2/2] PCI: Calculate the VF bus range on each possible NumVFs
Date: Mon, 22 Dec 2014 13:48:46 +0800
Message-Id: <1419227326-12083-3-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1419227326-12083-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1419227326-12083-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Per SRIOV SPEC section 3.3.10 and 3.3.11, VF Stride and VF Offset may change
when NumVFs changes. This will affect the bus range for VFs.

This patch iterates on each possible NumVFs and calculate the maximum bus
range for VFs.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/pci/iov.c |   31 +++++++++++++++++++++++++++----
 drivers/pci/pci.h |    1 +
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index ef0ceaa..ea3a82c 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -46,6 +46,30 @@ static inline void pci_iov_set_numvfs(struct pci_dev *dev, int nr_virtfn)
 	pci_read_config_word(dev, iov->pos + PCI_SRIOV_VF_STRIDE, &iov->stride);
 }
 
+/**
+ * Per SRIOV SPEC section 3.3.10 and 3.3.11, VF Stride and VF offset may
+ * change when NumVFs changes. Which will affect the bus range for VFs.
+ *
+ * This function iterate on all valide NumVFs and calculate the maximum bus
+ * range for VFs.
+ */
+static inline void pci_iov_max_bus_range(struct pci_dev *dev)
+{
+	struct pci_sriov *iov = dev->sriov;
+	int total = iov->total_VFs;
+	u8 max = 0;
+	u8 busnr;
+
+	for ( ; total >= 0; total--) {
+		pci_iov_set_numvfs(dev, total);
+		busnr = virtfn_bus(dev, iov->total_VFs - 1);
+		if (busnr > max)
+			max = busnr;
+	}
+
+	iov->max_bus_range = max;
+}
+
 static struct pci_bus *virtfn_add_bus(struct pci_bus *bus, int busnr)
 {
 	struct pci_bus *child;
@@ -415,6 +439,7 @@ found:
 
 	dev->sriov = iov;
 	dev->is_physfn = 1;
+	pci_iov_max_bus_range(dev);
 
 	return 0;
 
@@ -550,15 +575,13 @@ void pci_restore_iov_state(struct pci_dev *dev)
 int pci_iov_bus_range(struct pci_bus *bus)
 {
 	int max = 0;
-	u8 busnr;
 	struct pci_dev *dev;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		if (!dev->is_physfn)
 			continue;
-		busnr = virtfn_bus(dev, dev->sriov->total_VFs - 1);
-		if (busnr > max)
-			max = busnr;
+		if (dev->sriov->max_bus_range > max)
+			max = dev->sriov->max_bus_range;
 	}
 
 	return max ? max - bus->number : 0;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 8aff29a..94faf97 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -236,6 +236,7 @@ struct pci_sriov {
 	u16 stride;		/* following VF stride */
 	u32 pgsz;		/* page size for BAR alignment */
 	u8 link;		/* Function Dependency Link */
+	u8 max_bus_range;	/* Maximum bus range a VF could sit*/
 	u16 driver_max_VFs;	/* max num VFs driver supports */
 	struct pci_dev *dev;	/* lowest numbered PF */
 	struct pci_dev *self;	/* this PF */
-- 
1.7.9.5

