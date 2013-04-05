Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:36545 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161461Ab3DECyl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Apr 2013 22:54:41 -0400
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Thu, 4 Apr 2013 20:54:41 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com [9.17.195.107])
	by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id E7B1C3E4003F
	for <linux-pci@vger.kernel.org>; Thu,  4 Apr 2013 20:54:25 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r352sbRk140116
	for <linux-pci@vger.kernel.org>; Thu, 4 Apr 2013 20:54:37 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r352sbYw032569
	for <linux-pci@vger.kernel.org>; Thu, 4 Apr 2013 20:54:37 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: [PATCH 2/4] PCI: Remove MSI/MSI-X cap check in pci_msi_check_device()
Date: Fri,  5 Apr 2013 10:54:31 +0800
Message-Id: <1365130473-7413-3-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1365130473-7413-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1365130473-7413-1-git-send-email-shangw@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The function pci_msi_check_device() is called while enabling MSI
or MSI-X interrupts to make sure the PCI device can support MSI
or MSI-X capability. The patch removes the check on MSI or MSI-X
capability in the function and lets the caller does the check.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 drivers/pci/msi.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 5fdc5d9..1ec1ba9 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -789,9 +789,6 @@ static int pci_msi_check_device(struct pci_dev *dev, int nvec, int type)
 	if (ret)
 		return ret;
 
-	if (!pci_find_capability(dev, type))
-		return -EINVAL;
-
 	return 0;
 }
 
@@ -942,7 +939,7 @@ int pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries, int nvec)
 	int status, nr_entries;
 	int i, j;
 
-	if (!entries)
+	if (!entries || !dev->msix_cap)
 		return -EINVAL;
 
 	status = pci_msi_check_device(dev, nvec, PCI_CAP_ID_MSIX);
-- 
1.7.5.4

