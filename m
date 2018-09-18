Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:7930 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbeISFeA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Sep 2018 01:34:00 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 08/12] PCI/AER: Use kfifo helper inserting locked elements
Date: Tue, 18 Sep 2018 17:58:44 -0600
Message-Id: <20180918235848.26694-9-keith.busch@intel.com>
In-Reply-To: <20180918235848.26694-1-keith.busch@intel.com>
References: <20180918235848.26694-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch uses the recommended kernel API for writing to a concurrently
accessed kfifo. No functional change here.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/aer.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 813b5dd6fe68..33bbcaa41f65 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1063,7 +1063,6 @@ static DECLARE_WORK(aer_recover_work, aer_recover_work_func);
 void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
 		       int severity, struct aer_capability_regs *aer_regs)
 {
-	unsigned long flags;
 	struct aer_recover_entry entry = {
 		.bus		= bus,
 		.devfn		= devfn,
@@ -1072,13 +1071,12 @@ void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
 		.regs		= aer_regs,
 	};
 
-	spin_lock_irqsave(&aer_recover_ring_lock, flags);
-	if (kfifo_put(&aer_recover_ring, entry))
+	if (kfifo_in_spinlocked(&aer_recover_ring, &entry, sizeof(entry),
+				 &aer_recover_ring_lock))
 		schedule_work(&aer_recover_work);
 	else
 		pr_err("AER recover: Buffer overflow when recovering AER for %04x:%02x:%02x:%x\n",
 		       domain, bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
-	spin_unlock_irqrestore(&aer_recover_ring_lock, flags);
 }
 EXPORT_SYMBOL_GPL(aer_recover_queue);
 #endif
-- 
2.14.4
