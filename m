Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:1483 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932449AbcHCXcv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 3 Aug 2016 19:32:51 -0400
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Zhang <wzhang@fb.com>, Keith Busch <keith.busch@intel.com>
Subject: [PATCH] pciehp: Clear attention LED on device add
Date: Wed,  3 Aug 2016 17:29:45 -0600
Message-Id: <1470266985-28906-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch clears the LED attention status after a successful device
add. It is possible the attention LED was on from a previous power fault
or link failure, and a subsequent successful device inserted in the slot
should clear it.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/hotplug/pciehp_ctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 880978b..7ea3e61 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -120,6 +120,7 @@ static int board_added(struct slot *p_slot)
 	}
 
 	pciehp_green_led_on(p_slot);
+	pciehp_set_attention_status(p_slot, 0);
 	return 0;
 
 err_exit:
-- 
2.7.2

