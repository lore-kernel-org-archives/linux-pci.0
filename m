Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from prv-mh.provo.novell.com ([137.65.248.74]:58599 "EHLO
        prv-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751732AbcKHHn6 (ORCPT
        <rfc822;groupwise-linux-pci@vger.kernel.org:4:1>);
        Tue, 8 Nov 2016 02:43:58 -0500
Message-Id: <5821904A020000780011CF55@prv-mh.provo.novell.com>
Date: Tue, 08 Nov 2016 00:43:54 -0700
From: "Jan Beulich" <JBeulich@suse.com>
To: "Bjorn Helgaas" <bhelgaas@google.com>
Cc: <tglx@linutronix.de>, <hch@lst.de>, <linux-pci@vger.kernel.org>
Subject: [PATCH] PCI/MSI: pci_irq_get_affinity() should cope with NULL
 affinity vector
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

msi_setup_entry() only logs a message when the affinity vector can't be
allocated, and hence pci_irq_get_affinity() indexing entry->affinity is
wrong without a prior check.

Fixes: ee8d41e53efe "pci/msi: Retrieve affinity for a vector"
Signed-off-by: Jan Beulich <jbeulich@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/msi.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- 4.9-rc4/drivers/pci/msi.c
+++ 4.9-rc4-PCI-MSI-no-affinity/drivers/pci/msi.c
@@ -1294,7 +1294,8 @@ const struct cpumask *pci_irq_get_affini
 	} else if (dev->msi_enabled) {
 		struct msi_desc *entry = first_pci_msi_entry(dev);
 
-		if (WARN_ON_ONCE(!entry || nr >= entry->nvec_used))
+		if (WARN_ON_ONCE(!entry || !entry->affinity ||
+				 nr >= entry->nvec_used))
 			return NULL;
 
 		return &entry->affinity[nr];



