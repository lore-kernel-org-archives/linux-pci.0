Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:58966 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758672Ab3DDLjm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Apr 2013 07:39:42 -0400
Received: from /spool/local
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Thu, 4 Apr 2013 05:39:41 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 8BECC3E40040
	for <linux-pci@vger.kernel.org>; Thu,  4 Apr 2013 05:39:26 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r34Bdc7a331286
	for <linux-pci@vger.kernel.org>; Thu, 4 Apr 2013 05:39:38 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r34Bdbnc017989
	for <linux-pci@vger.kernel.org>; Thu, 4 Apr 2013 05:39:38 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: [PATCH 2/5] PCI: Use MSI/MSI-X cap cache in pci_msi_check_device()
Date: Thu,  4 Apr 2013 19:39:29 +0800
Message-Id: <1365075572-20763-3-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1365075572-20763-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1365075572-20763-1-git-send-email-shangw@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The function pci_msi_check_device() is called while enabling MSI
or MSI-X interrupts to make sure the PCI device can support MSI
or MSI-X capability. The patch changes the function for a bit to
use the cached MSI or MSI-X capability in pci_dev instead of polling
them from config space.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 drivers/pci/msi.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 3459bdf..5f51e10 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -772,6 +772,11 @@ static int pci_msi_check_device(struct pci_dev *dev, int nvec, int type)
 	if (!pci_msi_enable || !dev || dev->no_msi)
 		return -EINVAL;
 
+	/* Check if the PCI device has MSI or MSI-X capability */
+	if ((type == PCI_CAP_ID_MSI && !dev->msi_cap) ||
+	    (type == PCI_CAP_ID_MSIX && !dev->msix_cap))
+		return -EINVAL;
+
 	/*
 	 * You can't ask to have 0 or less MSIs configured.
 	 *  a) it's stupid ..
@@ -795,9 +800,6 @@ static int pci_msi_check_device(struct pci_dev *dev, int nvec, int type)
 	if (ret)
 		return ret;
 
-	if (!pci_find_capability(dev, type))
-		return -EINVAL;
-
 	return 0;
 }
 
-- 
1.7.5.4

