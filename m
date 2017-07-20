Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:26275 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934727AbdGTX2A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jul 2017 19:28:00 -0400
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Scott Bauer <scott.bauer@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 2/2] vmd: Assign vector zero to all bridges
Date: Thu, 20 Jul 2017 19:33:54 -0400
Message-Id: <1500593634-4558-2-git-send-email-keith.busch@intel.com>
In-Reply-To: <1500593634-4558-1-git-send-email-keith.busch@intel.com>
References: <1500593634-4558-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We don't want slower IRQ handlers impacting faster devices that happen
to be assigned the same VMD interrupt vector. The driver was trying to
separate such devices by checking if MSI-x wasn't used, but really we
just don't want to end devices to share with bridges. Most bridges may
use MSI currently, so that criteria happened to work, but newer ones may
use MSI-x, so this patch explicity checks the device type when choosing
a vector.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/host/vmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/vmd.c b/drivers/pci/host/vmd.c
index 8cddf30..031eef2 100644
--- a/drivers/pci/host/vmd.c
+++ b/drivers/pci/host/vmd.c
@@ -183,7 +183,7 @@ static struct vmd_irq_list *vmd_next_irq(struct vmd_dev *vmd, struct msi_desc *d
 	int i, best = 1;
 	unsigned long flags;
 
-	if (!desc->msi_attrib.is_msix || vmd->msix_count == 1)
+	if (pci_is_bridge(msi_desc_to_pci_dev(desc)) || vmd->msix_count == 1)
 		return &vmd->irqs[0];
 
 	raw_spin_lock_irqsave(&list_lock, flags);
-- 
2.5.5
