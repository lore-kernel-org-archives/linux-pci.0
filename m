Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:42827 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965241AbcHDWJd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Aug 2016 18:09:33 -0400
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Jon Derrick <jonathan.derrick@intel.com>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCH 1/2] vmd: Fix infinite loop executing irq's
Date: Thu,  4 Aug 2016 16:09:08 -0600
Message-Id: <1470348549-10855-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We can't initialize the list head on deletion as this causes the node
to point to itself, looping infinitely if the vmd IRQ handler happens
to be servicing that node.

The list initialization supposed to fix a bug from multiple calls to
disable the same IRQ. We can fix this instead just checking if the
previous pointer indicates it was already deleted.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 arch/x86/pci/vmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/vmd.c b/arch/x86/pci/vmd.c
index e88b417..2294907 100644
--- a/arch/x86/pci/vmd.c
+++ b/arch/x86/pci/vmd.c
@@ -136,8 +136,8 @@ static void vmd_irq_disable(struct irq_data *data)
 	data->chip->irq_mask(data);
 
 	raw_spin_lock_irqsave(&list_lock, flags);
-	list_del_rcu(&vmdirq->node);
-	INIT_LIST_HEAD_RCU(&vmdirq->node);
+	if (vmdirq->node.prev != LIST_POISON2)
+		list_del_rcu(&vmdirq->node);
 	raw_spin_unlock_irqrestore(&list_lock, flags);
 }
 
-- 
2.7.2

