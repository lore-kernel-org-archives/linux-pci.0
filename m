Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:50063 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752536Ab3KYTks (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 25 Nov 2013 14:40:48 -0500
Received: by mail-ie0-f176.google.com with SMTP id at1so7791410iec.35
        for <linux-pci@vger.kernel.org>; Mon, 25 Nov 2013 11:40:47 -0800 (PST)
Date: Mon, 25 Nov 2013 12:40:44 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Rajat Jain <rajatjain@juniper.net>
Cc: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Rajat Jain <rajatjain.linux@gmail.com>,
	Guenter Roeck <groeck@juniper.net>
Subject: Re: pciehp LinkState
Message-ID: <20131125194044.GA9710@google.com>
References: <528D4739.80700@fold.natur.cuni.cz>
 <CAErSpo7LcyL+K5rg+aNaaNzLXKyxvfAgeOPidb_3LqU3B2LXzA@mail.gmail.com>
 <01b89ce965ed454fb9f0e0cf52ba622e@BLUPR05MB118.namprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <01b89ce965ed454fb9f0e0cf52ba622e@BLUPR05MB118.namprd05.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 25, 2013 at 07:00:01PM +0000, Rajat Jain wrote:
> Hello Martin,
> 
> > >
> > > Below is the overview since cold boot with no card inserted with all
> > those hotplug events. You see,
> > > pciehp never sets LinkState back to minus once the slot is empty:
> > >
> > > vostro ~ # grep LinkState
> > pciehp/3.12/cold_boot_no_card_in_slot/lspci_vvv_initial__inserted__eject
> > ed_but_not_realized__inserted__ejected.txt
> > >                         Changed: MRL- PresDet- LinkState-
> > >                         Changed: MRL- PresDet- LinkState+
> > >                         Changed: MRL- PresDet- LinkState+
> > >                         Changed: MRL- PresDet- LinkState+
> > >                         Changed: MRL- PresDet- LinkState+
> > 
> > I opened https://bugzilla.kernel.org/show_bug.cgi?id=65521 for this
> > issue.  I agree that pciehp should probably clear this bit.  Rajat
> > recently posted some patches [1] that add support for link state
> > changes.  I haven't look at them in detail yet, but I wouldn't be
> > surprised if they will fix this issue.  If you wanted to test them,
> > that would be awesome!
> > 
> > Bjorn
> > 
> > [1] http://lkml.kernel.org/r/528BE8B6.9080007@gmail.com
> > --
> 
> Yes, this issue should be fixed by the following 2 patches:
> 
> https://lkml.org/lkml/2013/11/19/542
> https://lkml.org/lkml/2013/11/19/543
> 
> The particular hunk you want to be looking at is this:
> 
> @@ -661,7 +669,7 @@ static irqreturn_t pcie_isr(int irq, void *dev_id)
>  
>  		detected &= (PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
>  			     PCI_EXP_SLTSTA_MRLSC | PCI_EXP_SLTSTA_PDC |
> -			     PCI_EXP_SLTSTA_CC);
> +			     PCI_EXP_SLTSTA_CC | PCI_EXP_SLTSTA_DLLSC);
>  		detected &= ~intr_loc;
>  		intr_loc |= detected;
>  		if (!intr_loc)
> 
> 
> Would you be please kind enough to test the patch out? No need to pass any module parameter (Just apply patch and build & boot normally like you would).

Martin, here are Rajat's patches (all four of them), in case it's easier
than collecting them from lkml.org.  The following applies to v3.12
with "patch -p1 < <MSG>".


-------------------------------------------------------------------------------
pciehp-make-check_link_active
-------------------------------------------------------------------------------
pciehp: Make check_link_active() non-static

From: Rajat Jain <rajatjain.linux@gmail.com>

check_link_active() functionality needs to be used by subsequent patches
(that introduce link state change based hotplug). Thus make the function
non-static, and rename it to pciehp_check_link_active() so as to be
consistent with other non-static functions.

Signed-off-by: Rajat Jain <rajatjain@juniper.net>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp.h     |    1 +
 drivers/pci/hotplug/pciehp_hpc.c |    6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 541bbe6d5343..fc322ed29c56 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -154,6 +154,7 @@ void pciehp_green_led_on(struct slot *slot);
 void pciehp_green_led_off(struct slot *slot);
 void pciehp_green_led_blink(struct slot *slot);
 int pciehp_check_link_status(struct controller *ctrl);
+bool pciehp_check_link_active(struct controller *ctrl);
 void pciehp_release_ctrl(struct controller *ctrl);
 int pciehp_reset_slot(struct slot *slot, int probe);
 
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 51f56ef4ab6f..3a5eee781bd6 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -241,7 +241,7 @@ static int pcie_write_cmd(struct controller *ctrl, u16 cmd, u16 mask)
 	return retval;
 }
 
-static bool check_link_active(struct controller *ctrl)
+bool pciehp_check_link_active(struct controller *ctrl)
 {
 	bool ret = false;
 	u16 lnk_status;
@@ -261,12 +261,12 @@ static void __pcie_wait_link_active(struct controller *ctrl, bool active)
 {
 	int timeout = 1000;
 
-	if (check_link_active(ctrl) == active)
+	if (pciehp_check_link_active(ctrl) == active)
 		return;
 	while (timeout > 0) {
 		msleep(10);
 		timeout -= 10;
-		if (check_link_active(ctrl) == active)
+		if (pciehp_check_link_active(ctrl) == active)
 			return;
 	}
 	ctrl_dbg(ctrl, "Data Link Layer Link Active not %s in 1000 msec\n",
-------------------------------------------------------------------------------
pciehp-use-link-change
-------------------------------------------------------------------------------
pciehp: Use link change notifications for hot-plug and, removal

From: Rajat Jain <rajatjain.linux@gmail.com>

A lot of systems do not have the fancy buttons and LEDs, and instead
want to rely only on the Link state change events to drive the hotplug
and removal state machinery.
(http://www.spinics.net/lists/hotplug/msg05802.html)

This patch adds support for that functionality. Here are the details
about the patch itself:

* Add "pciehp_use_link_events" module parameter to indicate link state
  changes to be used for hot-plug.

* Define and use interrupt events for linkup / linkdown.

* Introduce the functions to handle link-up and link-down events and
  queue the work in the slot->wq to be processed by pciehp_power_thread

* Many ports use inband mechanism such as receiver detection to find out
  whether an adapter is present. In such HP ports, when link goes down,
  adapter presence will also toggle. Thus don't bail out the removal
  process initiated by link down, if adapter is not found to be present.

* The current pciehp driver disabled the link in case of a hot-removal.
  Since for link change based hot-plug to work, we need that enabled,
  hence make sure to not disable the link permanently if link state
  based hot-plug is to be used.

* pciehp_reset_slot - reset of secondary bus may cause undesirable
  spurious link notifications. Thus disable these around the secondary
  bus reset.

Signed-off-by: Rajat Jain <rajatjain@juniper.net>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp.h      |    4 +
 drivers/pci/hotplug/pciehp_core.c |    3 +
 drivers/pci/hotplug/pciehp_ctrl.c |  132 +++++++++++++++++++++++++++++++++++++
 drivers/pci/hotplug/pciehp_hpc.c  |   56 +++++++++++-----
 4 files changed, 179 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index fc322ed29c56..64a6840c32a4 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -44,6 +44,7 @@ extern bool pciehp_poll_mode;
 extern int pciehp_poll_time;
 extern bool pciehp_debug;
 extern bool pciehp_force;
+extern bool pciehp_use_link_events;      /* Use link state events for hotplug */
 
 #define dbg(format, arg...)						\
 do {									\
@@ -110,6 +111,8 @@ struct controller {
 #define INT_BUTTON_PRESS		7
 #define INT_BUTTON_RELEASE		8
 #define INT_BUTTON_CANCEL		9
+#define INT_LINK_UP			10
+#define INT_LINK_DOWN			11
 
 #define STATIC_STATE			0
 #define BLINKINGON_STATE		1
@@ -133,6 +136,7 @@ u8 pciehp_handle_attention_button(struct slot *p_slot);
 u8 pciehp_handle_switch_change(struct slot *p_slot);
 u8 pciehp_handle_presence_change(struct slot *p_slot);
 u8 pciehp_handle_power_fault(struct slot *p_slot);
+u8 pciehp_handle_linkstate_change(struct slot *p_slot);
 int pciehp_configure_device(struct slot *p_slot);
 int pciehp_unconfigure_device(struct slot *p_slot);
 void pciehp_queue_pushbutton_work(struct work_struct *work);
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index f4a18f51a29c..5a2c43cb0ce8 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -42,6 +42,7 @@ bool pciehp_debug;
 bool pciehp_poll_mode;
 int pciehp_poll_time;
 bool pciehp_force;
+bool pciehp_use_link_events;
 
 #define DRIVER_VERSION	"0.4"
 #define DRIVER_AUTHOR	"Dan Zink <dan.zink@compaq.com>, Greg Kroah-Hartman <greg@kroah.com>, Dely Sy <dely.l.sy@intel.com>"
@@ -55,10 +56,12 @@ module_param(pciehp_debug, bool, 0644);
 module_param(pciehp_poll_mode, bool, 0644);
 module_param(pciehp_poll_time, int, 0644);
 module_param(pciehp_force, bool, 0644);
+module_param(pciehp_use_link_events, bool, 0644);
 MODULE_PARM_DESC(pciehp_debug, "Debugging mode enabled or not");
 MODULE_PARM_DESC(pciehp_poll_mode, "Using polling mechanism for hot-plug events or not");
 MODULE_PARM_DESC(pciehp_poll_time, "Polling mechanism frequency, in seconds");
 MODULE_PARM_DESC(pciehp_force, "Force pciehp, even if OSHP is missing");
+MODULE_PARM_DESC(pciehp_use_link_events, "Use link state change events to drive pciehp hot-plug");
 
 #define PCIE_MODULE_NAME "pciehp"
 
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 38f018679175..3899b526f3b5 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -150,6 +150,29 @@ u8 pciehp_handle_power_fault(struct slot *p_slot)
 	return 1;
 }
 
+u8 pciehp_handle_linkstate_change(struct slot *p_slot)
+{
+	u32 event_type;
+	struct controller *ctrl = p_slot->ctrl;
+
+	/* Link Status Change */
+	ctrl_dbg(ctrl, "Data Link Layer State change\n");
+
+	if (pciehp_check_link_active(ctrl)) {
+		ctrl_info(ctrl, "slot(%s): Link Up event\n",
+			  slot_name(p_slot));
+		event_type = INT_LINK_UP;
+	} else {
+		ctrl_info(ctrl, "slot(%s): Link Down event\n",
+			  slot_name(p_slot));
+		event_type = INT_LINK_DOWN;
+	}
+
+	queue_interrupt_event(p_slot, event_type);
+
+	return 1;
+}
+
 /* The following routines constitute the bulk of the
    hotplug controller logic
  */
@@ -442,6 +465,100 @@ static void handle_surprise_event(struct slot *p_slot)
 	queue_work(p_slot->wq, &info->work);
 }
 
+/*
+ * Note: This function must be called with slot->lock held
+ */
+static void handle_link_up_event(struct slot *p_slot)
+{
+	struct controller *ctrl = p_slot->ctrl;
+	struct power_work_info *info;
+
+	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	if (!info) {
+		ctrl_err(p_slot->ctrl, "%s: Cannot allocate memory\n",
+			 __func__);
+		return;
+	}
+	info->p_slot = p_slot;
+	INIT_WORK(&info->work, pciehp_power_thread);
+
+	switch (p_slot->state) {
+	case BLINKINGON_STATE:
+	case BLINKINGOFF_STATE:
+		cancel_delayed_work(&p_slot->work);
+		/* Fall through */
+	case STATIC_STATE:
+		p_slot->state = POWERON_STATE;
+		queue_work(p_slot->wq, &info->work);
+		break;
+	case POWERON_STATE:
+		ctrl_info(ctrl,
+			  "Link Up event ignored on slot(%s): already powering on\n",
+			  slot_name(p_slot));
+		kfree(info);
+		break;
+	case POWEROFF_STATE:
+		ctrl_info(ctrl,
+			  "Link Up event queued on slot(%s): currently getting powered off\n",
+			  slot_name(p_slot));
+		p_slot->state = POWERON_STATE;
+		queue_work(p_slot->wq, &info->work);
+		break;
+	default:
+		ctrl_err(ctrl, "Not a valid state on slot(%s)\n",
+			 slot_name(p_slot));
+		kfree(info);
+		break;
+	}
+}
+
+/*
+ * Note: This function must be called with slot->lock held
+ */
+static void handle_link_down_event(struct slot *p_slot)
+{
+	struct controller *ctrl = p_slot->ctrl;
+	struct power_work_info *info;
+
+	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	if (!info) {
+		ctrl_err(p_slot->ctrl, "%s: Cannot allocate memory\n",
+			 __func__);
+		return;
+	}
+	info->p_slot = p_slot;
+	INIT_WORK(&info->work, pciehp_power_thread);
+
+	switch (p_slot->state) {
+	case BLINKINGON_STATE:
+	case BLINKINGOFF_STATE:
+		cancel_delayed_work(&p_slot->work);
+		/* Fall through */
+	case STATIC_STATE:
+		p_slot->state = POWEROFF_STATE;
+		queue_work(p_slot->wq, &info->work);
+		break;
+	case POWEROFF_STATE:
+		ctrl_info(ctrl,
+			  "Link Down event ignored on slot(%s): already powering off\n",
+			  slot_name(p_slot));
+		kfree(info);
+		break;
+	case POWERON_STATE:
+		ctrl_info(ctrl,
+			  "Link Down event queued on slot(%s): currently getting powered on\n",
+			  slot_name(p_slot));
+		p_slot->state = POWEROFF_STATE;
+		queue_work(p_slot->wq, &info->work);
+		break;
+	default:
+		ctrl_err(ctrl, "Not a valid state on slot %s\n",
+			 slot_name(p_slot));
+		kfree(info);
+		break;
+	}
+}
+
 static void interrupt_event_handler(struct work_struct *work)
 {
 	struct event_info *info = container_of(work, struct event_info, work);
@@ -468,6 +585,12 @@ static void interrupt_event_handler(struct work_struct *work)
 		ctrl_dbg(ctrl, "Surprise Removal\n");
 		handle_surprise_event(p_slot);
 		break;
+	case INT_LINK_UP:
+		handle_link_up_event(p_slot);
+		break;
+	case INT_LINK_DOWN:
+		handle_link_down_event(p_slot);
+		break;
 	default:
 		break;
 	}
@@ -524,7 +647,14 @@ int pciehp_disable_slot(struct slot *p_slot)
 	if (!p_slot->ctrl)
 		return 1;
 
-	if (!HP_SUPR_RM(p_slot->ctrl)) {
+	/*
+	 * In certain scenarios, adapter may have already disappeared by this
+	 * time. E.g (1) Surprise Removal (2) Many ports use in-band
+	 * mechanisms to signal if adapter is present or not. Thus when a
+	 * link goes down, the device may have already gone away by the time
+	 * this code executes.
+	 */
+	if (!HP_SUPR_RM(p_slot->ctrl) && !pciehp_use_link_events) {
 		ret = pciehp_get_adapter_status(p_slot, &getstatus);
 		if (ret || !getstatus) {
 			ctrl_info(ctrl, "No adapter on slot(%s)\n",
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 3a5eee781bd6..90eb8c681596 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -620,13 +620,21 @@ int pciehp_power_off_slot(struct slot * slot)
 	u16 cmd_mask;
 	int retval;
 
-	/* Disable the link at first */
-	pciehp_link_disable(ctrl);
-	/* wait the link is down */
-	if (ctrl->link_active_reporting)
-		pcie_wait_link_not_active(ctrl);
-	else
-		msleep(1000);
+	if (!pciehp_use_link_events) {
+		/*
+		 * In case it is desired to use the link state events for
+		 * hot-plug, make sure to NOT disable the link permanently, or
+		 * else we might never get a link-up hotplug event again.
+		 */
+
+		/* Disable the link first */
+		pciehp_link_disable(ctrl);
+		/* wait until the link is down */
+		if (ctrl->link_active_reporting)
+			pcie_wait_link_not_active(ctrl);
+		else
+			msleep(1000);
+	}
 
 	slot_cmd = POWER_OFF;
 	cmd_mask = PCI_EXP_SLTCTL_PCC;
@@ -661,7 +669,7 @@ static irqreturn_t pcie_isr(int irq, void *dev_id)
 
 		detected &= (PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
 			     PCI_EXP_SLTSTA_MRLSC | PCI_EXP_SLTSTA_PDC |
-			     PCI_EXP_SLTSTA_CC);
+			     PCI_EXP_SLTSTA_CC | PCI_EXP_SLTSTA_DLLSC);
 		detected &= ~intr_loc;
 		intr_loc |= detected;
 		if (!intr_loc)
@@ -702,6 +710,10 @@ static irqreturn_t pcie_isr(int irq, void *dev_id)
 		ctrl->power_fault_detected = 1;
 		pciehp_handle_power_fault(slot);
 	}
+
+	if (intr_loc & PCI_EXP_SLTSTA_DLLSC)
+		pciehp_handle_linkstate_change(slot);
+
 	return IRQ_HANDLED;
 }
 
@@ -724,12 +736,15 @@ int pcie_enable_notification(struct controller *ctrl)
 		cmd |= PCI_EXP_SLTCTL_ABPE;
 	if (MRL_SENS(ctrl))
 		cmd |= PCI_EXP_SLTCTL_MRLSCE;
+	if (pciehp_use_link_events)
+		cmd |= PCI_EXP_SLTCTL_DLLSCE;
 	if (!pciehp_poll_mode)
 		cmd |= PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_CCIE;
 
 	mask = (PCI_EXP_SLTCTL_PDCE | PCI_EXP_SLTCTL_ABPE |
 		PCI_EXP_SLTCTL_MRLSCE | PCI_EXP_SLTCTL_PFDE |
-		PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_CCIE);
+		PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_CCIE |
+		PCI_EXP_SLTCTL_DLLSCE);
 
 	if (pcie_write_cmd(ctrl, cmd, mask)) {
 		ctrl_err(ctrl, "Cannot enable software notification\n");
@@ -751,28 +766,39 @@ static void pcie_disable_notification(struct controller *ctrl)
 
 /*
  * pciehp has a 1:1 bus:slot relationship so we ultimately want a secondary
- * bus reset of the bridge, but if the slot supports surprise removal we need
- * to disable presence detection around the bus reset and clear any spurious
+ * bus reset of the bridge, but if the slot supports surprise removal (or
+ * link state change based hotplug), we need to disable presence detection
+ * (or link state notifications) around the bus reset and clear any spurious
  * events after.
  */
 int pciehp_reset_slot(struct slot *slot, int probe)
 {
 	struct controller *ctrl = slot->ctrl;
+	u16 stat_mask = 0, ctrl_mask = 0;
 
 	if (probe)
 		return 0;
 
 	if (HP_SUPR_RM(ctrl)) {
-		pcie_write_cmd(ctrl, 0, PCI_EXP_SLTCTL_PDCE);
+		ctrl_mask |= PCI_EXP_SLTCTL_PDCE;
+		stat_mask |= PCI_EXP_SLTSTA_PDC;
+	}
+	if (pciehp_use_link_events) {
+		ctrl_mask |= PCI_EXP_SLTCTL_DLLSCE;
+		stat_mask |= PCI_EXP_SLTSTA_DLLSC;
+	}
+
+	if (ctrl_mask) {
+		pcie_write_cmd(ctrl, 0, ctrl_mask);
 		if (pciehp_poll_mode)
 			del_timer_sync(&ctrl->poll_timer);
 	}
 
 	pci_reset_bridge_secondary_bus(ctrl->pcie->port);
 
-	if (HP_SUPR_RM(ctrl)) {
-		pciehp_writew(ctrl, PCI_EXP_SLTSTA, PCI_EXP_SLTSTA_PDC);
-		pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_PDCE, PCI_EXP_SLTCTL_PDCE);
+	if (ctrl_mask) {
+		pciehp_writew(ctrl, PCI_EXP_SLTSTA, stat_mask);
+		pcie_write_cmd(ctrl, ctrl_mask, ctrl_mask);
 		if (pciehp_poll_mode)
 			int_poll_timeout(ctrl->poll_timer.data);
 	}
-------------------------------------------------------------------------------
pciehp-ensure-very-fast
-------------------------------------------------------------------------------
pciehp: Ensure very fast hotplug events are also processed.

From: Rajat Jain <rajatjain.linux@gmail.com>

Today, this is how all the hotplug and unplug events work:

Hotplug / Removal needs to be done
  => Set slot->state (protected by slot->lock) to either
    POWERON_STATE (for enabling) or POWEROFF_STATE (for disabling).
  => Submit the work item for pciehp_power_thread() to slot->wq.

Problem:
  There is a problem if the hotplug events can happen fast enough that
  they do not give SW enough time to add or remove the new devices.

  => Assume: Event for unplug comes (e.g. surprise removal). But
     before the pciehp_power_thread() work item was executed, the
     card was replaced by another card, causing surprise hotplug event.

  => What goes wrong:
    => The hot-removal event sets slot->state to POWEROFF_STATE, and
       schedules the pciehp_power_thread().
    => The hot-add event sets slot->state to POWERON_STATE, and
       schedules the pciehp_power_thread().
    => Now the pciehp_power_thread() is scheduled twice, and on both
       occasions it will find POWERON_STATE and will try to add the
       devices on the slot, and will fail complaining that the devices
       already exist.

  => Why this is a problem: If the device was replaced between the hot
     removal and hot-add, then we should unload the old driver and
     reload the new one. This does not happen today. The kernel or the
     driver is not even aware that the device was replaced.

     The problem is that the pciehp_power_thread() only looks at the
     slot->state which would only contain the *latest* state - not
     the actual event (add / remove) that was the intent of the IRQ
     handler who submitted the work.

What this patch does:

  => Hotplug events pass on an actual request (for addition or removal)
     to pciehp_power_thread() which is local to that work item
     submission.

  => pciehp_power_thread() does not need to look at slote->state and
     hence no locks needed in that.

  => Essentially this results in all the hotplug and unplug events
     "replayed" by pciehp_power_thread().

Signed-off-by: Rajat Jain <rajatjain@juniper.net>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp_ctrl.c |   32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 3899b526f3b5..83dbe0867c36 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -299,6 +299,9 @@ static int remove_board(struct slot *p_slot)
 struct power_work_info {
 	struct slot *p_slot;
 	struct work_struct work;
+	unsigned int req;
+#define DISABLE_REQ 0
+#define ENABLE_REQ  1
 };
 
 /**
@@ -314,10 +317,8 @@ static void pciehp_power_thread(struct work_struct *work)
 		container_of(work, struct power_work_info, work);
 	struct slot *p_slot = info->p_slot;
 
-	mutex_lock(&p_slot->lock);
-	switch (p_slot->state) {
-	case POWEROFF_STATE:
-		mutex_unlock(&p_slot->lock);
+	switch (info->req) {
+	case DISABLE_REQ:
 		ctrl_dbg(p_slot->ctrl,
 			 "Disabling domain:bus:device=%04x:%02x:00\n",
 			 pci_domain_nr(p_slot->ctrl->pcie->port->subordinate),
@@ -325,18 +326,22 @@ static void pciehp_power_thread(struct work_struct *work)
 		pciehp_disable_slot(p_slot);
 		mutex_lock(&p_slot->lock);
 		p_slot->state = STATIC_STATE;
-		break;
-	case POWERON_STATE:
 		mutex_unlock(&p_slot->lock);
+		break;
+	case ENABLE_REQ:
+		ctrl_dbg(p_slot->ctrl,
+			 "Enabling domain:bus:device=%04x:%02x:00\n",
+			 pci_domain_nr(p_slot->ctrl->pcie->port->subordinate),
+			 p_slot->ctrl->pcie->port->subordinate->number);
 		if (pciehp_enable_slot(p_slot) && PWR_LED(p_slot->ctrl))
 			pciehp_green_led_off(p_slot);
 		mutex_lock(&p_slot->lock);
 		p_slot->state = STATIC_STATE;
+		mutex_unlock(&p_slot->lock);
 		break;
 	default:
 		break;
 	}
-	mutex_unlock(&p_slot->lock);
 
 	kfree(info);
 }
@@ -359,9 +364,11 @@ void pciehp_queue_pushbutton_work(struct work_struct *work)
 	switch (p_slot->state) {
 	case BLINKINGOFF_STATE:
 		p_slot->state = POWEROFF_STATE;
+		info->req = DISABLE_REQ;
 		break;
 	case BLINKINGON_STATE:
 		p_slot->state = POWERON_STATE;
+		info->req = ENABLE_REQ;
 		break;
 	default:
 		kfree(info);
@@ -457,10 +464,13 @@ static void handle_surprise_event(struct slot *p_slot)
 	INIT_WORK(&info->work, pciehp_power_thread);
 
 	pciehp_get_adapter_status(p_slot, &getstatus);
-	if (!getstatus)
+	if (!getstatus) {
 		p_slot->state = POWEROFF_STATE;
-	else
+		info->req = DISABLE_REQ;
+	} else {
 		p_slot->state = POWERON_STATE;
+		info->req = ENABLE_REQ;
+	}
 
 	queue_work(p_slot->wq, &info->work);
 }
@@ -489,6 +499,7 @@ static void handle_link_up_event(struct slot *p_slot)
 		/* Fall through */
 	case STATIC_STATE:
 		p_slot->state = POWERON_STATE;
+		info->req = ENABLE_REQ;
 		queue_work(p_slot->wq, &info->work);
 		break;
 	case POWERON_STATE:
@@ -502,6 +513,7 @@ static void handle_link_up_event(struct slot *p_slot)
 			  "Link Up event queued on slot(%s): currently getting powered off\n",
 			  slot_name(p_slot));
 		p_slot->state = POWERON_STATE;
+		info->req = ENABLE_REQ;
 		queue_work(p_slot->wq, &info->work);
 		break;
 	default:
@@ -536,6 +548,7 @@ static void handle_link_down_event(struct slot *p_slot)
 		/* Fall through */
 	case STATIC_STATE:
 		p_slot->state = POWEROFF_STATE;
+		info->req = DISABLE_REQ;
 		queue_work(p_slot->wq, &info->work);
 		break;
 	case POWEROFF_STATE:
@@ -549,6 +562,7 @@ static void handle_link_down_event(struct slot *p_slot)
 			  "Link Down event queued on slot(%s): currently getting powered on\n",
 			  slot_name(p_slot));
 		p_slot->state = POWEROFF_STATE;
+		info->req = DISABLE_REQ;
 		queue_work(p_slot->wq, &info->work);
 		break;
 	default:
-------------------------------------------------------------------------------
pciehp-introduce-hotplug_lock
-------------------------------------------------------------------------------
pciehp: Introduce hotplug_lock to serialize HP events

From: Rajat Jain <rajatjain.linux@gmail.com>

Today it is there is no protection around pciehp_enable_slot() and
pciehp_disable_slot() to ensure that they complete before another
hot-plug operation can be done on that particular slot.

This patch introduces the slot->hotplug_lock to ensure that any
hotplug operations (add / remove) complete before another HP event
can begin processing on that particular slot.

Signed-off-by: Rajat Jain <rajatjain@juniper.net>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp.h      |    1 +
 drivers/pci/hotplug/pciehp_core.c |    7 ++++++-
 drivers/pci/hotplug/pciehp_ctrl.c |   17 +++++++++++++++--
 drivers/pci/hotplug/pciehp_hpc.c  |    1 +
 4 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 64a6840c32a4..fdf2038b53c8 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -78,6 +78,7 @@ struct slot {
 	struct hotplug_slot *hotplug_slot;
 	struct delayed_work work;	/* work for button event */
 	struct mutex lock;
+	struct mutex hotplug_lock;
 	struct workqueue_struct *wq;
 };
 
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 5a2c43cb0ce8..2175f7ab6f7e 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -281,8 +281,11 @@ static int pciehp_probe(struct pcie_device *dev)
 	slot = ctrl->slot;
 	pciehp_get_adapter_status(slot, &occupied);
 	pciehp_get_power_status(slot, &poweron);
-	if (occupied && pciehp_force)
+	if (occupied && pciehp_force) {
+		mutex_lock(&slot->hotplug_lock);
 		pciehp_enable_slot(slot);
+		mutex_unlock(&slot->hotplug_lock);
+	}
 	/* If empty slot's power status is on, turn power off */
 	if (!occupied && poweron && POWER_CTRL(ctrl))
 		pciehp_power_off_slot(slot);
@@ -326,10 +329,12 @@ static int pciehp_resume (struct pcie_device *dev)
 
 	/* Check if slot is occupied */
 	pciehp_get_adapter_status(slot, &status);
+	mutex_lock(&slot->hotplug_lock);
 	if (status)
 		pciehp_enable_slot(slot);
 	else
 		pciehp_disable_slot(slot);
+	mutex_unlock(&slot->hotplug_lock);
 	return 0;
 }
 #endif /* PM */
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 83dbe0867c36..8ad63a44b279 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -316,6 +316,7 @@ static void pciehp_power_thread(struct work_struct *work)
 	struct power_work_info *info =
 		container_of(work, struct power_work_info, work);
 	struct slot *p_slot = info->p_slot;
+	int ret;
 
 	switch (info->req) {
 	case DISABLE_REQ:
@@ -323,7 +324,9 @@ static void pciehp_power_thread(struct work_struct *work)
 			 "Disabling domain:bus:device=%04x:%02x:00\n",
 			 pci_domain_nr(p_slot->ctrl->pcie->port->subordinate),
 			 p_slot->ctrl->pcie->port->subordinate->number);
+		mutex_lock(&p_slot->hotplug_lock);
 		pciehp_disable_slot(p_slot);
+		mutex_unlock(&p_slot->hotplug_lock);
 		mutex_lock(&p_slot->lock);
 		p_slot->state = STATIC_STATE;
 		mutex_unlock(&p_slot->lock);
@@ -333,7 +336,10 @@ static void pciehp_power_thread(struct work_struct *work)
 			 "Enabling domain:bus:device=%04x:%02x:00\n",
 			 pci_domain_nr(p_slot->ctrl->pcie->port->subordinate),
 			 p_slot->ctrl->pcie->port->subordinate->number);
-		if (pciehp_enable_slot(p_slot) && PWR_LED(p_slot->ctrl))
+		mutex_lock(&p_slot->hotplug_lock);
+		ret = pciehp_enable_slot(p_slot);
+		mutex_unlock(&p_slot->hotplug_lock);
+		if (ret && PWR_LED(p_slot->ctrl))
 			pciehp_green_led_off(p_slot);
 		mutex_lock(&p_slot->lock);
 		p_slot->state = STATIC_STATE;
@@ -613,6 +619,9 @@ static void interrupt_event_handler(struct work_struct *work)
 	kfree(info);
 }
 
+/*
+ * Note: This function must be called with slot->hotplug_lock held
+ */
 int pciehp_enable_slot(struct slot *p_slot)
 {
 	u8 getstatus = 0;
@@ -651,7 +660,9 @@ int pciehp_enable_slot(struct slot *p_slot)
 	return rc;
 }
 
-
+/*
+ * Note: This function must be called with slot->hotplug_lock held
+ */
 int pciehp_disable_slot(struct slot *p_slot)
 {
 	u8 getstatus = 0;
@@ -710,7 +721,9 @@ int pciehp_sysfs_enable_slot(struct slot *p_slot)
 	case STATIC_STATE:
 		p_slot->state = POWERON_STATE;
 		mutex_unlock(&p_slot->lock);
+		mutex_lock(&p_slot->hotplug_lock);
 		retval = pciehp_enable_slot(p_slot);
+		mutex_unlock(&p_slot->hotplug_lock);
 		mutex_lock(&p_slot->lock);
 		p_slot->state = STATIC_STATE;
 		break;
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 90eb8c681596..740d883f1fd7 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -841,6 +841,7 @@ static int pcie_init_slot(struct controller *ctrl)
 
 	slot->ctrl = ctrl;
 	mutex_init(&slot->lock);
+	mutex_init(&slot->hotplug_lock);
 	INIT_DELAYED_WORK(&slot->work, pciehp_queue_pushbutton_work);
 	ctrl->slot = slot;
 	return 0;
