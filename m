Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout1.hostsharing.net ([83.223.95.100]:40615 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729576AbeG1T6z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 28 Jul 2018 15:58:55 -0400
Date: Sat, 28 Jul 2018 20:31:30 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Alex_Gagniuc@Dellteam.com
Cc: mr.nuke.me@gmail.com, keith.busch@intel.com,
        linux-pci@vger.kernel.org, Austin.Bolen@dell.com,
        Stuart.Hayes@dell.com, Narendra.K@dell.com,
        Christopher.Arzola@dell.com, David.Chalfant@dell.com,
        Sinan Kaya <okaya@kernel.org>
Subject: Re: Should a PCIe Link Down event set the PCI_DEV_DISCONNECTED bit?
Message-ID: <20180728183130.GA21482@wunner.de>
References: <47727551-86ce-040a-2516-efa47ee3a76e@gmail.com>
 <20180727071813.GA6128@wunner.de>
 <f6aa0b881a824b4f82a29dad300aaaea@ausx13mps321.AMER.DELL.COM>
 <20180727170543.GA5326@wunner.de>
 <99604d46a7554eb38ee6c1579c53d835@ausx13mps321.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <99604d46a7554eb38ee6c1579c53d835@ausx13mps321.AMER.DELL.COM>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 27, 2018 at 05:51:04PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> I think PCI_DEV_DISCONNECTED is a documentation issue above all else. 
> The history I was given is that drivers would take a very long time to 
> tear down a device. Config space IO to an nonexistent device took a long 
> while to time out. Performance was one motivation -- and was not documented.

Often it is possible for the driver to detect surprise removal by
checking if mmio reads return "all ones".  But in some cases that's
a valid value to read from mmio and then this approach won't work.
Also, checking every mmio read may negatively impact performance.

Finally, if the card was quickly swapped and the link to the new
card is already up, you may be accessing that new card.  (mmio
accesses may then still return all ones if the BARs are blank,
but at least config space accesses should work.)

Once it has been determined that the device has been surprise removed,
that fact should be cached somewhere to short-circuit any further device
accesses.  PCI_DEV_DISCONNECTED can act as such a cache.


> Thanks for all the info. The fix that I was settling on is (pasted) 
> below. Though that seems to conflict a bit with what you are trying to 
> do. Now I'm a little conflicted If I should try to submit the below or not.
> 
> --- a/drivers/pci/hotplug/pciehp_pci.c
> +++ b/drivers/pci/hotplug/pciehp_pci.c
> @@ -74,6 +74,7 @@ int pciehp_unconfigure_device(struct slot *p_slot)
>          ctrl_dbg(ctrl, "%s: domain:bus:dev = %04x:%02x:00\n",
>                   __func__, pci_domain_nr(parent), parent->number);
>          pciehp_get_adapter_status(p_slot, &presence);
> +       presence = presence && pciehp_check_link_active(ctrl);

That approach won't work if the card was quickly swapped and the link
to the new card is already up when pciehp_unconfigure_device() runs.

FWIW, the below is what I had in mind (on top of Bjorn's pci/hotplug
branch).  Does this work for you?

-- >8 --
Subject: [PATCH] PCI: pciehp: Differentiate between surprise and safe removal

When removing PCI devices below a hotplug bridge, pciehp marks them as
disconnected if the card is no longer present in the slot or it quiesces
them if the card is still present (by disabling INTx interrupts, bus
mastering and SERR# reporting).

To detect whether the card is still present, pciehp checks the Presence
Detect State bit in the Slot Status register.  The problem with this
approach is that even if the card is present, the link to it may be
down, and it that case it would be better to mark the devices as
disconnected instead of trying to quiesce them.  Moreover, if the card
in the slot was quickly replaced by another one, the Presence Detect
State bit would be set, yet trying to quiesce the new card's devices
would be wrong and the correct thing to do is to mark the previous
card's devices as disconnected.

Instead of looking at the Presence Detect State bit, it is better to
differentiate whether the card was surprise removed versus safely
removed (via sysfs or an Attention Button press).  On surprise removal,
the devices should be marked as disconnected, whereas on safe removal it
is correct to quiesce the devices.

The knowledge whether a surprise removal or a safe removal is at hand
does exist further up in the call stack:  A surprise removal is
initiated by pciehp_handle_presence_or_link_change(), a safe removal by
pciehp_handle_disable_request().

Pass that information down to pciehp_unconfigure_device() and use it in
lieu of the Presence Detect State bit.  While there, add kernel-doc to
pciehp_unconfigure_device() and pciehp_configure_device().

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/pci/hotplug/pciehp.h      |  2 +-
 drivers/pci/hotplug/pciehp_ctrl.c | 22 +++++++++++++---------
 drivers/pci/hotplug/pciehp_pci.c  | 23 ++++++++++++++++++++---
 3 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 652c46d9b215..bce29ae769dd 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -195,7 +195,7 @@ void pciehp_handle_button_press(struct slot *slot);
 void pciehp_handle_disable_request(struct slot *slot);
 void pciehp_handle_presence_or_link_change(struct slot *slot, u32 events);
 int pciehp_configure_device(struct slot *p_slot);
-void pciehp_unconfigure_device(struct slot *p_slot);
+void pciehp_unconfigure_device(struct slot *p_slot, bool presence);
 void pciehp_queue_pushbutton_work(struct work_struct *work);
 struct controller *pcie_init(struct pcie_device *dev);
 int pcie_init_notification(struct controller *ctrl);
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index d7d55160b5f8..8836648e145f 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -40,6 +40,9 @@
    hotplug controller logic
  */
 
+#define SAFE_REMOVAL	 true
+#define SURPRISE_REMOVAL false
+
 static void set_slot_off(struct controller *ctrl, struct slot *pslot)
 {
 	/* turn off slot, turn on Amber LED, turn off Green LED if supported*/
@@ -115,12 +118,13 @@ static int board_added(struct slot *p_slot)
 /**
  * remove_board - Turns off slot and LEDs
  * @p_slot: slot where board is being removed
+ * @safe_removal: whether the board is safely removed (versus surprise removed)
  */
-static void remove_board(struct slot *p_slot)
+static void remove_board(struct slot *p_slot, bool safe_removal)
 {
 	struct controller *ctrl = p_slot->ctrl;
 
-	pciehp_unconfigure_device(p_slot);
+	pciehp_unconfigure_device(p_slot, safe_removal);
 
 	if (POWER_CTRL(ctrl)) {
 		pciehp_power_off_slot(p_slot);
@@ -138,7 +142,7 @@ static void remove_board(struct slot *p_slot)
 }
 
 static int pciehp_enable_slot(struct slot *slot);
-static int pciehp_disable_slot(struct slot *slot);
+static int pciehp_disable_slot(struct slot *slot, bool safe_removal);
 
 void pciehp_request(struct controller *ctrl, int action)
 {
@@ -230,7 +234,7 @@ void pciehp_handle_disable_request(struct slot *slot)
 	slot->state = POWEROFF_STATE;
 	mutex_unlock(&slot->lock);
 
-	ctrl->request_result = pciehp_disable_slot(slot);
+	ctrl->request_result = pciehp_disable_slot(slot, SAFE_REMOVAL);
 }
 
 void pciehp_handle_presence_or_link_change(struct slot *slot, u32 events)
@@ -257,7 +261,7 @@ void pciehp_handle_presence_or_link_change(struct slot *slot, u32 events)
 		if (events & PCI_EXP_SLTSTA_PDC)
 			ctrl_info(ctrl, "Slot(%s): Card not present\n",
 				  slot_name(slot));
-		pciehp_disable_slot(slot);
+		pciehp_disable_slot(slot, SURPRISE_REMOVAL);
 		break;
 	default:
 		mutex_unlock(&slot->lock);
@@ -343,7 +347,7 @@ static int pciehp_enable_slot(struct slot *slot)
 	return ret;
 }
 
-static int __pciehp_disable_slot(struct slot *p_slot)
+static int __pciehp_disable_slot(struct slot *p_slot, bool safe_removal)
 {
 	u8 getstatus = 0;
 	struct controller *ctrl = p_slot->ctrl;
@@ -357,17 +361,17 @@ static int __pciehp_disable_slot(struct slot *p_slot)
 		}
 	}
 
-	remove_board(p_slot);
+	remove_board(p_slot, safe_removal);
 	return 0;
 }
 
-static int pciehp_disable_slot(struct slot *slot)
+static int pciehp_disable_slot(struct slot *slot, bool safe_removal)
 {
 	struct controller *ctrl = slot->ctrl;
 	int ret;
 
 	pm_runtime_get_sync(&ctrl->pcie->port->dev);
-	ret = __pciehp_disable_slot(slot);
+	ret = __pciehp_disable_slot(slot, safe_removal);
 	pm_runtime_put(&ctrl->pcie->port->dev);
 
 	mutex_lock(&slot->lock);
diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index ec3f065bb1c0..079aac163484 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -34,6 +34,14 @@
 #include "../pci.h"
 #include "pciehp.h"
 
+/**
+ * pciehp_configure_device() - enumerate PCI devices below a hotplug bridge
+ * @p_slot: PCIe hotplug slot
+ *
+ * Enumerate PCI devices below a hotplug bridge and add them to the system.
+ * Return 0 on success, %-EEXIST if the devices are already enumerated or
+ * %-ENODEV if enumeration failed.
+ */
 int pciehp_configure_device(struct slot *p_slot)
 {
 	struct pci_dev *dev;
@@ -76,9 +84,19 @@ int pciehp_configure_device(struct slot *p_slot)
 	return ret;
 }
 
-void pciehp_unconfigure_device(struct slot *p_slot)
+/**
+ * pciehp_unconfigure_device() - remove PCI devices below a hotplug bridge
+ * @p_slot: PCIe hotplug slot
+ * @presence: whether the card is still present in the slot;
+ *	true for safe removal via sysfs or an Attention Button press,
+ *	false for surprise removal
+ *
+ * Unbind PCI devices below a hotplug bridge from their drivers and remove
+ * them from the system.  Safely removed devices are quiesced.  Surprise
+ * removed devices are marked as such to prevent further accesses.
+ */
+void pciehp_unconfigure_device(struct slot *p_slot, bool presence)
 {
-	u8 presence = 0;
 	struct pci_dev *dev, *temp;
 	struct pci_bus *parent = p_slot->ctrl->pcie->port->subordinate;
 	u16 command;
@@ -86,7 +104,6 @@ void pciehp_unconfigure_device(struct slot *p_slot)
 
 	ctrl_dbg(ctrl, "%s: domain:bus:dev = %04x:%02x:00\n",
 		 __func__, pci_domain_nr(parent), parent->number);
-	pciehp_get_adapter_status(p_slot, &presence);
 
 	pci_lock_rescan_remove();
 
-- 
2.18.0
