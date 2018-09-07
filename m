Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbeIHAqF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Sep 2018 20:46:05 -0400
Date: Fri, 7 Sep 2018 15:03:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv2 15/20] PCI/pciehp: Fix powerfault detection order
Message-ID: <20180907200332.GB250890@bhelgaas-glaptop.roam.corp.google.com>
References: <20180905203546.21921-1-keith.busch@intel.com>
 <20180905203546.21921-16-keith.busch@intel.com>
 <20180906193657.GH214747@bhelgaas-glaptop.roam.corp.google.com>
 <20180906195047.GD31024@localhost.localdomain>
 <20180907165352.GA250890@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180907165352.GA250890@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 07, 2018 at 11:53:52AM -0500, Bjorn Helgaas wrote:
> On Thu, Sep 06, 2018 at 01:50:47PM -0600, Keith Busch wrote:
> > On Thu, Sep 06, 2018 at 02:36:57PM -0500, Bjorn Helgaas wrote:
> > > On Wed, Sep 05, 2018 at 02:35:41PM -0600, Keith Busch wrote:
> > > > A device add in a power controller controlled slot will power on and
> > > > clear power fault slot events, but this was happening before the interrupt
> > > > handler attempted to set the sticky status and attention indicators. The
> > > > wrong status will be set if a hot-add and power fault are handled in
> > > > one interrupt. This patch fixes that by checking for power faults before
> > > > checking for new devices.
> > > 
> > > Can you clarify the part about "the interrupt handler attempting to set the
> > > sticky status and attention indicators"?  My first impression is that
> > > you're talking about bits in the Slot Status register, but that's
> > > obviously wrong because those bits are set by hardware (not the interrupt
> > > handler) and they're RW1C so software clears them by writing 1 to them.
> > 
> > The sticky status being the pciehp driver's "power_fault_detected"
> > field. We set it on the first observation of a slot's PFD and do not
> > clear it until we have a successful board_added event.
> > 
> > > Lukas suggests that this patch should be in v4.19.  Do you agree, and if
> > > so, can you help me justify it by describing the user-visible effect of
> > > this?  I'm not sure what "setting the wrong status" means to a user, e.g.,
> > > does this result in a non-functional device, an incorrect status LED on the
> > > slot, something else?  Does it fix a regression or something we merged for
> > > v4.19?
> > 
> > From a user point of view, it is possible the attention LED light could be
> > on after a successful hot add.
> 
> Great, thanks!  Also, it looks like the power LED will be off even though
> the power is actually on.
> 
>     pciehp_ist
>       if (events & (PDC | DLLSC))
>         pciehp_handle_presence_or_link_change
>           case OFF_STATE:
>             pciehp_enable_slot
>               __pciehp_enable_slot
>                 board_added
>                   pciehp_power_on_slot
>                     ctrl->power_fault_detected = 0
>                     pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_PWR_ON, PCI_EXP_SLTCTL_PCC)
>       if (PFD && !ctrl->power_fault_detected)
>         ctrl->power_fault_detected = 1
>         pciehp_set_attention_status(slot, 1)     # attention LED on
>         pciehp_green_led_off(slot)               # power LED off
> 
> 
> Tangent: how annoying that the spec refers to "Power Indicator" and
> "Attention Indicator", but (a) we call them the "green_led" and
> "attention_status", and (b) both can be on/off/blinking, but the interfaces
> are totally different.

I applied this to for-linus with the following changelog.  Let me know
if I didn't understand this correctly.  I changed the comment in
pciehp_power_on_slot() so it doesn't say "sticky" to avoid confusion
with the PCI spec concept of sticky register bits (ROS, RWS, RW1CS).


commit 342227b42fe849eb2edac38342702aff12a5491d
Author: Keith Busch <keith.busch@intel.com>
Date:   Wed Sep 5 14:35:41 2018 -0600

    PCI: pciehp: Fix hot-add vs powerfault detection order
    
    If both hot-add and power fault were observed in a single interrupt, we
    handled the hot-add first, then the power fault, in this path:
    
      pciehp_ist
        if (events & (PDC | DLLSC))
          pciehp_handle_presence_or_link_change
            case OFF_STATE:
              pciehp_enable_slot
                __pciehp_enable_slot
                  board_added
                    pciehp_power_on_slot
                      ctrl->power_fault_detected = 0
                      pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_PWR_ON, PCI_EXP_SLTCTL_PCC)
                    pciehp_green_led_on(p_slot)             # power LED on
                    pciehp_set_attention_status(p_slot, 0)  # attention LED off
        if ((events & PFD) && !ctrl->power_fault_detected)
          ctrl->power_fault_detected = 1
          pciehp_set_attention_status(1)                    # attention LED on
          pciehp_green_led_off(slot)                        # power LED off
    
    This left the attention indicator on (even though the hot-add succeeded)
    and the power indicator off (even though the slot power was on).
    
    Fix this by checking for power faults before checking for new devices.
    
    Fixes: 0e94916e6091 ("PCI: pciehp: Handle events synchronously")
    Signed-off-by: Keith Busch <keith.busch@intel.com>
    [bhelgaas: changelog]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Lukas Wunner <lukas@wunner.de>

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 7136e3430925..a938abdb41ce 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -496,7 +496,7 @@ int pciehp_power_on_slot(struct slot *slot)
 	u16 slot_status;
 	int retval;
 
-	/* Clear sticky power-fault bit from previous power failures */
+	/* Clear power-fault bit from previous power failures */
 	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
 	if (slot_status & PCI_EXP_SLTSTA_PFD)
 		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
@@ -646,6 +646,14 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 		pciehp_handle_button_press(slot);
 	}
 
+	/* Check Power Fault Detected */
+	if ((events & PCI_EXP_SLTSTA_PFD) && !ctrl->power_fault_detected) {
+		ctrl->power_fault_detected = 1;
+		ctrl_err(ctrl, "Slot(%s): Power fault\n", slot_name(slot));
+		pciehp_set_attention_status(slot, 1);
+		pciehp_green_led_off(slot);
+	}
+
 	/*
 	 * Disable requests have higher priority than Presence Detect Changed
 	 * or Data Link Layer State Changed events.
@@ -657,14 +665,6 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 		pciehp_handle_presence_or_link_change(slot, events);
 	up_read(&ctrl->reset_lock);
 
-	/* Check Power Fault Detected */
-	if ((events & PCI_EXP_SLTSTA_PFD) && !ctrl->power_fault_detected) {
-		ctrl->power_fault_detected = 1;
-		ctrl_err(ctrl, "Slot(%s): Power fault\n", slot_name(slot));
-		pciehp_set_attention_status(slot, 1);
-		pciehp_green_led_off(slot);
-	}
-
 	pci_config_pm_runtime_put(pdev);
 	wake_up(&ctrl->requester);
 	return IRQ_HANDLED;
