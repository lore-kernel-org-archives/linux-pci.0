Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:35965 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324AbaESDBT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 18 May 2014 23:01:19 -0400
Received: from /spool/local
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Mon, 19 May 2014 13:01:17 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: kvm@vger.kernel.org
Cc: alex.williamson@redhat.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 3/4] drivers/vfio/pci: Fix wrong MSI interrupt count
Date: Mon, 19 May 2014 13:01:09 +1000
Message-Id: <1400468470-11262-4-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1400468470-11262-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1400468470-11262-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

According PCI local bus specification, the register of Message
Control for MSI (offset: 2, length: 2) has bit#0 to enable or
disable MSI logic and it shouldn't be part contributing to the
calculation of MSI interrupt count. The patch fixes the issue.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/vfio/pci/vfio_pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 7ba0424..6b8cd07 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -196,8 +196,7 @@ static int vfio_pci_get_irq_count(struct vfio_pci_device *vdev, int irq_type)
 		if (pos) {
 			pci_read_config_word(vdev->pdev,
 					     pos + PCI_MSI_FLAGS, &flags);
-
-			return 1 << (flags & PCI_MSI_FLAGS_QMASK);
+			return 1 << ((flags & PCI_MSI_FLAGS_QMASK) >> 1);
 		}
 	} else if (irq_type == VFIO_PCI_MSIX_IRQ_INDEX) {
 		u8 pos;
-- 
1.8.3.2

