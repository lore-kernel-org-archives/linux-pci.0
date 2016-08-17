Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54222 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752353AbcHQRMb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 17 Aug 2016 13:12:31 -0400
Date: Wed, 17 Aug 2016 12:12:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Patel, Mayurkumar" <mayurkumar.patel@intel.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
	"mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
	"Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
	"Busch, Keith" <keith.busch@intel.com>,
	"Tarazona-Duarte, Luis Antonio"
	<luis.antonio.tarazona-duarte@intel.com>
Subject: Re: [PATCH v1] PCI: pciehp: Fix presence detect change interrupt
 handling
Message-ID: <20160817171225.GA27353@localhost>
References: <92EBB4272BF81E4089A7126EC1E7B284665970B5@IRSMSX101.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <92EBB4272BF81E4089A7126EC1E7B284665970B5@IRSMSX101.ger.corp.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Mayurkumar,

On Wed, Aug 17, 2016 at 01:42:18PM +0000, Patel, Mayurkumar wrote:
> Currently, if very fast hotplug removal and insertion event comes
> as following
> 
> [  608.823412] pciehp 0000:00:1c.1:pcie04: Card not present on Slot(1)
> [  608.835249] pciehp 0000:00:1c.1:pcie04: Card present on Slot(1)
> 
> In this case following scenario happens,
> 
> While removal:
> pcie_isr() -> pciehp_queue_interrupt_event() -> triggers queue_work().
> work invokes interrupt_event_handler() -> case INT_PRESENCE_OFF
> and calls handle_surprise_event().
> 
> handle_surprise_event() again calls pciehp_get_adapter_status()
> and reads slot status which might have been changed
> already due to PCI_EXP_SLTSTA_PDC event for hotplug insertion
> has happened. So it queues, ENABLE_REQ for both removal
> and insertion interrupt based on latest slot status.
> 
> In this case, PCIe device can not be hot-add again because
> it was never removed due to which device can not get enabled.
> 
> handle_surprise_event() can be removed and pciehp_queue_power_work()
> can be directly triggered based on INT_PRESENCE_ON and INT_PRESENCE_OFF
> from the switch case exist in interrupt_event_hanlder().
> 
> The patch ensures the pciehp_queue_power_work() processes
> presence detect change for removal and insertion correctly.
> 
> Signed-off-by: Mayurkumar Patel <mayurkumar.patel@intel.com>
> ---
>  Resending the patch addressing to PCI Maintainer Bjorn Helgaas.
> 
>  drivers/pci/hotplug/pciehp_ctrl.c |   18 ++----------------
>  1 file changed, 2 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index 880978b..87c5bea 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -301,20 +301,6 @@ static void handle_button_press_event(struct slot *p_slot)
>  /*
>   * Note: This function must be called with slot->lock held
>   */
> -static void handle_surprise_event(struct slot *p_slot)
> -{
> -	u8 getstatus;
> -
> -	pciehp_get_adapter_status(p_slot, &getstatus);
> -	if (!getstatus)
> -		pciehp_queue_power_work(p_slot, DISABLE_REQ);
> -	else
> -		pciehp_queue_power_work(p_slot, ENABLE_REQ);
> -}
> -
> -/*
> - * Note: This function must be called with slot->lock held
> - */
>  static void handle_link_event(struct slot *p_slot, u32 event)
>  {
>  	struct controller *ctrl = p_slot->ctrl;
> @@ -377,14 +363,14 @@ static void interrupt_event_handler(struct work_struct *work)
>  		pciehp_green_led_off(p_slot);
>  		break;
>  	case INT_PRESENCE_ON:
> -		handle_surprise_event(p_slot);
> +		pciehp_queue_power_work(p_slot, ENABLE_REQ);
>  		break;
>  	case INT_PRESENCE_OFF:
>  		/*
>  		 * Regardless of surprise capability, we need to
>  		 * definitely remove a card that has been pulled out!
>  		 */
> -		handle_surprise_event(p_slot);
> +		pciehp_queue_power_work(p_slot, DISABLE_REQ);
>  		break;
>  	case INT_LINK_UP:
>  	case INT_LINK_DOWN:

Thanks a lot for this.  I think other people have seen the same issue.

Even with this fix, don't we have essentially the same problem one
layer back?  The first thing pcie_isr() does is read PCI_EXP_SLTSTA,
then few lines down, we call pciehp_get_adapter_status(), which reads
PCI_EXP_SLTSTA *again*.  So I think the window is smaller but still
there.

I think what we really should do is read the status registers
(PCI_EXP_SLTSTA and probably also PCI_EXP_LNKSTA) *once* in
pcie_isr(), before we write PCI_EXP_SLTSTA to clear the RW1C bits
there, and then queue up events based on those values, without
re-reading the registers.

What do you think?

Bjorn
