Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139]:45859 "EHLO e9.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753515Ab3C0I4M (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 27 Mar 2013 04:56:12 -0400
Received: from /spool/local
	by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Wed, 27 Mar 2013 04:56:12 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 27BD4C9001D
	for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2013 04:56:10 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r2R8uAMH6357050
	for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2013 04:56:10 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r2R8u9LG013000
	for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2013 05:56:09 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: [PATCH 4/4] PCI: Retrieve MSI cap struct for once on setup
Date: Wed, 27 Mar 2013 16:56:04 +0800
Message-Id: <1364374564-19096-5-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1364374564-19096-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1364374564-19096-1-git-send-email-shangw@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch adjusts function msi_capability_init() and pci_enable_msi_block()
so that we needn't figure out the address of MSI capability structure
for multiple time in one function call path while enabling MSI.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 drivers/pci/msi.c |   19 ++++++++-----------
 1 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index a20cb0a..f6fa697 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -542,6 +542,7 @@ out_unroll:
  * msi_capability_init - configure device's MSI capability structure
  * @dev: pointer to the pci_dev data structure of MSI device function
  * @nvec: number of interrupts to allocate
+ * @pos: address of MSI capability structure
  *
  * Setup the MSI capability structure of the device with the requested
  * number of interrupts.  A return value of zero indicates the successful
@@ -549,14 +550,13 @@ out_unroll:
  * an error, and a positive return value indicates the number of interrupts
  * which could have been allocated.
  */
-static int msi_capability_init(struct pci_dev *dev, int nvec)
+static int msi_capability_init(struct pci_dev *dev, int nvec, int pos)
 {
 	struct msi_desc *entry;
-	int pos, ret;
+	int ret;
 	u16 control;
 	unsigned mask;
 
-	pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
 	msi_set_enable(dev, pos, 0);	/* Disable MSI during set up */
 
 	pci_read_config_word(dev, msi_control_reg(pos), &control);
@@ -823,18 +823,15 @@ int pci_enable_msi_block(struct pci_dev *dev, unsigned int nvec)
 	int pos, status, maxvec;
 	u16 msgctl;
 
-	pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
-	if (!pos)
-		return -EINVAL;
+	status = pci_msi_check_device(dev, nvec, PCI_CAP_ID_MSI, &pos);
+	if (status)
+		return status;
+
 	pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &msgctl);
 	maxvec = 1 << ((msgctl & PCI_MSI_FLAGS_QMASK) >> 1);
 	if (nvec > maxvec)
 		return maxvec;
 
-	status = pci_msi_check_device(dev, nvec, PCI_CAP_ID_MSI, &pos);
-	if (status)
-		return status;
-
 	WARN_ON(!!dev->msi_enabled);
 
 	/* Check whether driver already requested MSI-X irqs */
@@ -844,7 +841,7 @@ int pci_enable_msi_block(struct pci_dev *dev, unsigned int nvec)
 		return -EINVAL;
 	}
 
-	status = msi_capability_init(dev, nvec);
+	status = msi_capability_init(dev, nvec, pos);
 	return status;
 }
 EXPORT_SYMBOL(pci_enable_msi_block);
-- 
1.7.5.4

