Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58732 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751538AbbE2Wpg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 29 May 2015 18:45:36 -0400
Message-ID: <1432939534.5794.56.camel@redhat.com>
Subject: Re: [PATCH RFC 2/4] PCI: pciehp: Wait for hotplug command
 completion lazily
From: Alex Williamson <alex.williamson@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>, "Jan C. Nordholz" <jckn@gmx.net>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Rajat Jain <rajatxjain@gmail.com>, linux-pci@vger.kernel.org,
	Myron Stowe <myron.stowe@redhat.com>
Date: Fri, 29 May 2015 16:45:34 -0600
In-Reply-To: <20140614212126.15202.66060.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140614210740.15202.84719.stgit@bhelgaas-glaptop.roam.corp.google.com>
	 <20140614212126.15202.66060.stgit@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Sorry, I'm digging up and old patch here and this RFC was the only copy
I could find in my mailbox.

On Sat, 2014-06-14 at 15:21 -0600, Bjorn Helgaas wrote:
> Previously we issued a hotplug command and waited for it to complete.  But
> there's no need to wait until we're ready to issue the *next* command.  The
> next command will probably be much later, so the first one may have already
> completed and we may not have to actually wait at all.

I'm seeing a regression as a result of this patch.  Consider the
following function:

int pciehp_reset_slot(struct slot *slot, int probe)
{
	...
	pcie_write_cmd(ctrl, 0, ctrl_mask);
	...
	pci_reset_bridge_secondary_bus(ctrl->pcie->port);

Our command write is clearing bits that control whether the slot has
presence detection and link layer state change enabled.  These are the
things that we're trying to clear to prevent a secondary bus reset from
turning into a surprise hotplug.  If we don't wait for the command to
complete, what state are when in as we initiate the secondary bus reset?
On my system, it's like we never issued the write command at all, the
previous behavior where the hotplug controller detects the link down as
a surprise hotplug returns.  So I'm afraid we do need to wait until
we're ready to issue the *next* command, because it's our only
indication that the current command has completed.

I thought maybe we just need a separate flush command for cases like
this, but then I started looking at the cases where we use this
function:

pciehp_set_attention_status
pciehp_green_led_on
pciehp_green_led_off
pciehp_green_led_blink
pciehp_power_on_slot
pciehp_power_off_slot
pcie_enable_notification
pcie_disable_notification

The slot power ones concern me the same as the reset issue.  In the 'on'
case, we immediately call link enable, so the slot better have
acknowledged the power on command.  In the 'off' case, it seems pretty
bad to complete the 'off' function, but we don't know if the slot is
actually off yet.  For notifications, I can imagine that the caller of
those functions is going to want on or off at the completion of those
functions, not some in-between state.  Even in the case of the LED
functions, where do we want the error to occur, at the time the command
is issued, or maybe some time in the future when the next unrelated
command comes through.

So, rather than posting a new patch adding a flush everywhere that it
seems a little scary, should we consider scrapping this patch altogether
as unsafe?  We need to wait, not only to issue the next command, but to
have any sort of acknowledgment that the current command has completed.

> 
> Because of hardware errata, some controllers generate command completion
> events for some commands but not others.  In the case of Intel CF118 (see
> spec update reference), the controller indicates command completion only
> for Slot Control writes that change the value of the following bits:
> 
>   Power Controller Control
>   Power Indicator Control
>   Attention Indicator Control
>   Electromechanical Interlock Control
> 
> Changes to other bits, e.g., the interrupt enable bits, do not cause the
> Command Completed bit to be set.  Controllers from AMD and Nvidia are
> reported to have similar errata.
> 
> These errata cause timeouts when pcie_enable_notification() enables
> interrupts.  Previously that timeout occurred at boot-time.  With this
> change, the timeout occurs later, when we change the state of the slot
> power, indicators, or interlock.  This speeds up boot but causes a timeout
> at the first hotplug event on the slot.  Subsequent events don't timeout
> because only the first (boot-time) hotplug command updates Slot Control
> without touching the power/indicator/interlock controls.

It sounds like we need some sort of completion mask to handle devices
like this, instead of effectively removing the write-barrier for the
general case.  Thanks,

Alex

> 
> Link: http://www.intel.com/content/www/us/en/processors/xeon/xeon-e7-v2-spec-update.html
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/hotplug/pciehp_hpc.c |    7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 0e76e9d9d134..f44fdb5b0b08 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -165,6 +165,9 @@ static void pcie_write_cmd(struct controller *ctrl, u16 cmd, u16 mask)
>  
>  	mutex_lock(&ctrl->ctrl_lock);
>  
> +	/* Wait for any previous command that might still be in progress */
> +	pcie_wait_cmd(ctrl);
> +
>  	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
>  	if (slot_status & PCI_EXP_SLTSTA_CC) {
>  		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
> @@ -197,10 +200,6 @@ static void pcie_write_cmd(struct controller *ctrl, u16 cmd, u16 mask)
>  	pcie_capability_write_word(pdev, PCI_EXP_SLTCTL, slot_ctrl);
>  	ctrl->slot_ctrl = slot_ctrl;
>  
> -	/*
> -	 * Wait for command completion.
> -	 */
> -	pcie_wait_cmd(ctrl);
>  	mutex_unlock(&ctrl->ctrl_lock);
>  }
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



