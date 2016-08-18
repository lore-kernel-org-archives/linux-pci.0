Return-Path: <mpatel6@imu.intel.com>
Return-Path: <mpatel6@imu.intel.com>
From: Mayurkumar Patel <mayurkumar.patel@intel.com>
To: helgaas@kernel.org, bhelgaas@google.com
Cc: rajatja@google.com, linux-pci@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com,
        rafael.j.wysocki@intel.com, luis.antonio.tarazona-duarte@intel.com,
        keith.busch@intel.com, mayurkumar.patel@intel.com
Subject: [PATCH v1 1/2] PCI: pciehp: Fix presence detect change interrupt handling
Date: Thu, 18 Aug 2016 23:07:58 +0200
Message-Id: <1471554479-42083-1-git-send-email-mayurkumar.patel@intel.com>
In-Reply-To: <92EBB4272BF81E4089A7126EC1E7B28466597350@IRSMSX101.ger.corp.intel.com>
References: <92EBB4272BF81E4089A7126EC1E7B28466597350@IRSMSX101.ger.corp.intel.com>
List-ID: <linux-pci.vger.kernel.org>

Currently, if very fast hotplug removal and insertion event comes
as following

[  608.823412] pciehp 0000:00:1c.1:pcie04: Card not present on Slot(1)
[  608.835249] pciehp 0000:00:1c.1:pcie04: Card present on Slot(1)

In this case following scenario happens,

While removal:
pcie_isr() -> pciehp_queue_interrupt_event() -> triggers queue_work().
work invokes interrupt_event_handler() -> case INT_PRESENCE_OFF
and calls handle_surprise_event().

handle_surprise_event() again calls pciehp_get_adapter_status()
and reads slot status which might have been changed
already due to PCI_EXP_SLTSTA_PDC event for hotplug insertion
has happened. So it queues, ENABLE_REQ for both removal
and insertion interrupt based on latest slot status.

In this case, PCIe device can not be hot-add again because
it was never removed due to which device can not get enabled.

handle_surprise_event() can be removed and pciehp_queue_power_work()
can be directly triggered based on INT_PRESENCE_ON and INT_PRESENCE_OFF
from the switch case exist in interrupt_event_hanlder().

The patch ensures the pciehp_queue_power_work() processes
presence detect change for removal and insertion correctly.

Signed-off-by: Mayurkumar Patel <mayurkumar.patel@intel.com>
Acked-by: Rajat Jain <rajatxjain@gmail.com>
---
 drivers/pci/hotplug/pciehp_ctrl.c |   18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 880978b..87c5bea 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -301,20 +301,6 @@ static void handle_button_press_event(struct slot *p_slot)
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
@@ -377,14 +363,14 @@ static void interrupt_event_handler(struct work_struct *work)
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
--
1.7.9.5
