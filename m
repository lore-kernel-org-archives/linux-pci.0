Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:36921 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753039Ab3DVXKm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Apr 2013 19:10:42 -0400
Received: by mail-ie0-f172.google.com with SMTP id c12so12287ieb.31
        for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2013 16:10:41 -0700 (PDT)
Subject: [PATCH v4 04/22] PCI: Remove MSI/MSI-X cap check in
 pci_msi_check_device()
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Mon, 22 Apr 2013 17:10:40 -0600
Message-ID: <20130422231039.32621.1576.stgit@bhelgaas-glaptop>
In-Reply-To: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
References: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Gavin Shan <shangw@linux.vnet.ibm.com>

The function pci_msi_check_device() is called while enabling MSI
or MSI-X interrupts to make sure the PCI device can support MSI
or MSI-X capability.  This patch removes the check on MSI or MSI-X
capability in the function and lets the caller do the check.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/msi.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 99befbd..60a4b10 100644
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

