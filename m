Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:43317 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751458AbcEQRWW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 17 May 2016 13:22:22 -0400
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Jon Derrick <jonathan.derrick@intel.com>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2] x86/vmd: Initialize list item in irq disable
Date: Tue, 17 May 2016 11:22:18 -0600
Message-Id: <1463505738-30666-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Multiple calls to disable an IRQ would have caused the driver to
dereference a poisoned list item. This re-initializes the list to
allow multiple requests to disable the irq.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
v1 -> v2:
  Used the patch with the correct macro

 arch/x86/pci/vmd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/pci/vmd.c b/arch/x86/pci/vmd.c
index b1662bf..3519a15 100644
--- a/arch/x86/pci/vmd.c
+++ b/arch/x86/pci/vmd.c
@@ -135,6 +135,7 @@ static void vmd_irq_disable(struct irq_data *data)
 
 	raw_spin_lock(&list_lock);
 	list_del_rcu(&vmdirq->node);
+	INIT_LIST_HEAD_RCU(&vmdirq->node);
 	raw_spin_unlock(&list_lock);
 }
 
-- 
2.7.2

