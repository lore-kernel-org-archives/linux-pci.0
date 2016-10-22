Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936000AbcJVOob (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 22 Oct 2016 10:44:31 -0400
Date: Sat, 22 Oct 2016 09:44:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH] pci: Don't set power fault if controller not present
Message-ID: <20161022144425.GH9007@localhost>
References: <1476214747-10428-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1476214747-10428-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Keith,

On Tue, Oct 11, 2016 at 03:39:07PM -0400, Keith Busch wrote:
> The pciehp control only clears the saved power fault detected if power
> controller control is present, but there is no requirement that the
> capability exist in order to observe power faults. This means a hot-added
> device in a slot that had experienced a power fault at some point would
> never be able to add a new device since the power fault detected would
> be on permanently.
> 
> This patch sets the sticky field only if there is a chance it can
> be cleared later.

I agree we should handle power_fault_detected consistently with
respect to POWER_CTRL().  We currently clear power_fault_detected in
pciehp_power_on_slot(), but we only call that if we have a power
controller.  But we set power_fault_detected in pciehp_isr() always,
resulting in this "sticky" situation.

I don't think it's 100% clear from the spec whether power faults can
be detected without a power controller.  All the "power fault"
references are in the context of a power controller, e.g., r3.0 sec
6.7.1.8, 7.8.10, 7.8.11.

But regardless, we're certainly doing the wrong thing right now.  If
we do have a power controller, it's fairly clear what we should do:

  - Power off the slot (even though the hardware is supposed to remove
    power automatically, sec 6.7.1.8 suggests that software should
    turn off the power),

  - Wait at least one second, per 6.7.1.8 (I think we do the power off
    and wait in the board_added() path, but not in the INT_POWER_FAULT
    path where we handle asynchronous events),

  - It looks like we currently turn on the attention indicator and
    turn off the power indicator (the INT_POWER_FAULT case in
    interrupt_event_handler()),

  - Wait for another slot event.

If we *don't* have a power controller, we currently set
power_fault_detected and log a message, but nothing else.

> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/pci/hotplug/pciehp_hpc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index b57fc6d..b083e1c 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -631,7 +631,8 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>  
>  	/* Check Power Fault Detected */
>  	if ((events & PCI_EXP_SLTSTA_PFD) && !ctrl->power_fault_detected) {
> -		ctrl->power_fault_detected = 1;
> +		if (POWER_CTRL(ctrl))
> +			ctrl->power_fault_detected = 1;
>  		ctrl_err(ctrl, "Slot(%s): Power fault\n", slot_name(slot));
>  		pciehp_queue_interrupt_event(slot, INT_POWER_FAULT);

I think this is correct as far as it goes, but I think we should do a
little more:

  - When there's no power controller, we can't do anything to resolve
    a power fault, so I think the ctrl_err() should be rate-limited,

  - We can't turn off the power, but we could turn on the attention
    indicator, e.g., by making the INT_POWER_FAULT case look like
    this:

      case INT_POWER_FAULT:
	set_slot_off(ctrl, p_slot);
	break;
