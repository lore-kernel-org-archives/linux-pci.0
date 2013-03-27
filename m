Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:44488 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754447Ab3C0I4O (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Mar 2013 04:56:14 -0400
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Wed, 27 Mar 2013 02:56:13 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com [9.17.195.226])
	by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 595223E4003E
	for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2013 02:55:59 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r2R8uAUx125406
	for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2013 02:56:10 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r2R8u9hw012663
	for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2013 02:56:09 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: [PATCH 3/4] PCI: Allow msix_capability_init() take MSIX cap struct
Date: Wed, 27 Mar 2013 16:56:03 +0800
Message-Id: <1364374564-19096-4-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1364374564-19096-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1364374564-19096-1-git-send-email-shangw@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch introduces additional parameter to msix_capability_init()
so that we can pass the address of MSI-X capability structure to
the function.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 drivers/pci/msi.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 7ba9461..a20cb0a 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -674,19 +674,20 @@ static void msix_program_entries(struct pci_dev *dev,
  * @dev: pointer to the pci_dev data structure of MSI-X device function
  * @entries: pointer to an array of struct msix_entry entries
  * @nvec: number of @entries
+ * @pos: address of MSI-X capability structure
  *
  * Setup the MSI-X capability structure of device function with a
  * single MSI-X irq. A return of zero indicates the successful setup of
  * requested MSI-X entries with allocated irqs or non-zero for otherwise.
  **/
 static int msix_capability_init(struct pci_dev *dev,
-				struct msix_entry *entries, int nvec)
+				struct msix_entry *entries,
+				int nvec, int pos)
 {
-	int pos, ret;
+	int ret;
 	u16 control;
 	void __iomem *base;
 
-	pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
 	pci_read_config_word(dev, pos + PCI_MSIX_FLAGS, &control);
 
 	/* Ensure MSI-X is disabled while it is set up */
@@ -980,7 +981,8 @@ int pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries, int nvec)
 		       "(MSI IRQ already assigned)\n");
 		return -EINVAL;
 	}
-	status = msix_capability_init(dev, entries, nvec);
+
+	status = msix_capability_init(dev, entries, nvec, pos);
 	return status;
 }
 EXPORT_SYMBOL(pci_enable_msix);
-- 
1.7.5.4

