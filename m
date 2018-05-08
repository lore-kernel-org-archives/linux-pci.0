Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:3399 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754828AbeEHQBD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 May 2018 12:01:03 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Scott Bauer <scott.bauer@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH] PCI/VMD: White list for fast interrupt handlers 
Date: Tue,  8 May 2018 10:00:22 -0600
Message-Id: <20180508160022.30954-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Devices with slow interrupt handlers are significantly harming performance
when their interrupt vector is shared with a fast device. This patch
creates a class code white list for devices with known fast interrupt
handlers, and all other devices will share a single vector so they don't
interfere with performance.

At the moment, only the NVM Express class code is on the list, but more
may be added if VMD users desire to use other low-latency devices in
these domains.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/host/vmd.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/vmd.c b/drivers/pci/host/vmd.c
index 930a8fa08bd6..f94f3e1d3470 100644
--- a/drivers/pci/host/vmd.c
+++ b/drivers/pci/host/vmd.c
@@ -175,9 +175,20 @@ static struct vmd_irq_list *vmd_next_irq(struct vmd_dev *vmd, struct msi_desc *d
 	int i, best = 1;
 	unsigned long flags;
 
-	if (pci_is_bridge(msi_desc_to_pci_dev(desc)) || vmd->msix_count == 1)
+	if (vmd->msix_count == 1)
 		return &vmd->irqs[0];
 
+	/*
+	 * White list for fast-interrupt handlers. All others will share the
+	 * "slow" interrupt vector.
+	 */
+	switch (msi_desc_to_pci_dev(desc)->class) {
+	case PCI_CLASS_STORAGE_EXPRESS:
+		break;
+	default:
+		return &vmd->irqs[0];
+	}
+
 	raw_spin_lock_irqsave(&list_lock, flags);
 	for (i = 1; i < vmd->msix_count; i++)
 		if (vmd->irqs[i].count < vmd->irqs[best].count)
-- 
2.14.3
