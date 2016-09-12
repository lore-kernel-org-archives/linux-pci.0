Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757497AbcILVJh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Sep 2016 17:09:37 -0400
Subject: [PATCH v2 5/8] PCI: pciehp: Don't re-read Slot Status when handling
 surprise event
To: Mayurkumar Patel <mayurkumar.patel@intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rajat Jain <rajatja@google.com>, MikaWesterberg@linux.intel.com,
        linux-pci@vger.kernel.org,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Luis Antonio Tarazona-Duarte
        <luis.antonio.tarazona-duarte@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        mika.westerberg@linux.intel.com
Date: Mon, 12 Sep 2016 16:09:28 -0500
Message-ID: <20160912210928.22258.74566.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160912210507.22258.63097.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160912210507.22258.63097.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Mayurkumar Patel <mayurkumar.patel@intel.com>

Previously we read Slot Status when handling a surprise event.  But Slot
Status might have changed since we identified the event, and the event_type
already tells us whether to enable or disable the slot, so there's no need
to read it again.

Remove handle_surprise_event() and queue the power work directly.

[bhelgaas: changelog]
Signed-off-by: Mayurkumar Patel <mayurkumar.patel@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Rajat Jain <rajatxjain@gmail.com>
---
 drivers/pci/hotplug/pciehp_ctrl.c |   18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 7ea3e61..a787684 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -302,20 +302,6 @@ static void handle_button_press_event(struct slot *p_slot)
 /*
  * Note: This function must be called with slot->lock held
  */
-static void handle_surprise_event(struct slot *p_slot)
-{
-	u8 getstatus;
-
-	pciehp_get_adapter_status(p_slot, &getstatus);
-	if (!getstatus)
-		pciehp_queue_power_work(p_slot, DISABLE_REQ);
-	else
-		pciehp_queue_power_work(p_slot, ENABLE_REQ);
-}
-
-/*
- * Note: This function must be called with slot->lock held
- */
 static void handle_link_event(struct slot *p_slot, u32 event)
 {
 	struct controller *ctrl = p_slot->ctrl;
@@ -378,14 +364,14 @@ static void interrupt_event_handler(struct work_struct *work)
 		pciehp_green_led_off(p_slot);
 		break;
 	case INT_PRESENCE_ON:
-		handle_surprise_event(p_slot);
+		pciehp_queue_power_work(p_slot, ENABLE_REQ);
 		break;
 	case INT_PRESENCE_OFF:
 		/*
 		 * Regardless of surprise capability, we need to
 		 * definitely remove a card that has been pulled out!
 		 */
-		handle_surprise_event(p_slot);
+		pciehp_queue_power_work(p_slot, DISABLE_REQ);
 		break;
 	case INT_LINK_UP:
 	case INT_LINK_DOWN:

