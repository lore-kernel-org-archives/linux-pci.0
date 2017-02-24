Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:23185 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751115AbdBXGy4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Feb 2017 01:54:56 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ashok Raj <ashok.raj@intel.com>,
        james puthukattukaran <james.puthukattukaran@oracle.com>,
        Yinghai Lu <yinghai.lu@oracle.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH] PCI, pciehp: Reuse set_slot_off()
Date: Thu, 23 Feb 2017 22:54:35 -0800
Message-Id: <20170224065435.14954-1-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now set_slot_off() is used in board_added() err path.

We could reuse in remove_board.

Also need to move green_led and attention_status out it.
and make code more readable.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 drivers/pci/hotplug/pciehp_ctrl.c |   16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

Index: linux-2.6/drivers/pci/hotplug/pciehp_ctrl.c
===================================================================
--- linux-2.6.orig/drivers/pci/hotplug/pciehp_ctrl.c
+++ linux-2.6/drivers/pci/hotplug/pciehp_ctrl.c
@@ -71,9 +71,6 @@ static void set_slot_off(struct controll
 		 */
 		msleep(1000);
 	}
-
-	pciehp_green_led_off(pslot);
-	pciehp_set_attention_status(pslot, 1);
 }
 
 /**
@@ -126,6 +123,8 @@ static int board_added(struct slot *p_sl
 
 err_exit:
 	set_slot_off(ctrl, p_slot);
+	pciehp_green_led_off(p_slot);
+	pciehp_set_attention_status(p_slot, 1);
 	return retval;
 }
 
@@ -142,16 +141,7 @@ static int remove_board(struct slot *p_s
 	if (retval)
 		return retval;
 
-	if (POWER_CTRL(ctrl)) {
-		pciehp_power_off_slot(p_slot);
-
-		/*
-		 * After turning power off, we must wait for at least 1 second
-		 * before taking any action that relies on power having been
-		 * removed from the slot/adapter.
-		 */
-		msleep(1000);
-	}
+	set_slot_off(ctrl, p_slot);
 
 	/* turn off Green LED */
 	pciehp_green_led_off(p_slot);
