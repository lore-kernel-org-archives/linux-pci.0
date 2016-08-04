Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:52795 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966144AbcHDWJ1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Aug 2016 18:09:27 -0400
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Jon Derrick <jonathan.derrick@intel.com>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCH 2/2] vmd: Synchronize with RCU freeing msi irq descs
Date: Thu,  4 Aug 2016 16:09:09 -0600
Message-Id: <1470348549-10855-2-git-send-email-keith.busch@intel.com>
In-Reply-To: <1470348549-10855-1-git-send-email-keith.busch@intel.com>
References: <1470348549-10855-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch fixes a potential race when disabling MSI/MSI-x on a VMD domain
device. If the vmd interrupt service is running, it may see a disabled
irq. We can synchronize rcu just before freeing the msi descriptor. This
is safe since the irq_desc lock isn't held, and the descriptor is valid
even though it is disabled. After vmd_msi_free, though, the handler is
reinitialiazed to handle_bad_irq, so we can't let the vmd isr's list
iteration see the disabled irq after this.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 arch/x86/pci/vmd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/pci/vmd.c b/arch/x86/pci/vmd.c
index 2294907..e3c9b9e 100644
--- a/arch/x86/pci/vmd.c
+++ b/arch/x86/pci/vmd.c
@@ -213,6 +213,8 @@ static void vmd_msi_free(struct irq_domain *domain,
 	struct vmd_irq *vmdirq = irq_get_chip_data(virq);
 	unsigned long flags;
 
+	synchronize_rcu();
+
 	/* XXX: Potential optimization to rebalance */
 	raw_spin_lock_irqsave(&list_lock, flags);
 	vmdirq->irq->count--;
-- 
2.7.2

