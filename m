Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751998AbcIHT7R (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Sep 2016 15:59:17 -0400
Date: Thu, 8 Sep 2016 14:59:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Patel, Mayurkumar" <mayurkumar.patel@intel.com>
Cc: 'Rajat Jain' <rajatja@google.com>,
        "'bhelgaas@google.com'" <bhelgaas@google.com>,
        "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "'mika.westerberg@linux.intel.com'" <mika.westerberg@linux.intel.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        "Tarazona-Duarte, Luis Antonio"
        <luis.antonio.tarazona-duarte@intel.com>,
        'Rajat Jain' <rajatxjain@gmail.com>,
        'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/2] PCI: pciehp: Fix presence detect change interrupt
 handling
Message-ID: <20160908195912.GB9440@localhost>
References: <92EBB4272BF81E4089A7126EC1E7B28466598F18@IRSMSX101.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <92EBB4272BF81E4089A7126EC1E7B28466598F18@IRSMSX101.ger.corp.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 23, 2016 at 08:58:51AM +0000, Patel, Mayurkumar wrote:
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
> Acked-by: Rajat Jain <rajatxjain@gmail.com>

I applied this to pci/hotplug for v4.9, with the following changelog.


  PCI: pciehp: Fix presence detect change interrupt handling

  When a hotplug insertion happens immediately after a hotplug removal, we
  may not handle the removal correctly, which may cause the insertion to
  fail.

  If Presence Detect State (PCI_EXP_SLTSTA_PDS) has changed from "card
  present" to "empty", we must remove the kernel pci_dev, even if a device
  is inserted again.  With the previous code, that might not happen if the
  insertion happens soon after the removal.  Consider this path:

    # hotplug removal causes interrupt and clears PCI_EXP_SLTSTA_PDS

    pcie_isr
      pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &status)
      present = status & PCI_EXP_SLTSTA_PDS       # FALSE
      pciehp_queue_interrupt_event(INT_PRESENCE_OFF)
        queue_work(...)                           # interrupt_event_handler

    # hotplug insertion sets PCI_EXP_SLTSTA_PDS

    interrupt_event_handler
      handle_surprise_event
        pciehp_get_adapter_status
          pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &status)
          present = status & PCI_EXP_SLTSTA_PDS   # TRUE <----
        pciehp_queue_power_work(ENABLE_REQ)

  The first PCI_EXP_SLTSTA read sees that the slot was empty, so we queue up
  handle_surprise_event().  But handle_surprise_event() reads PCI_EXP_SLTSTA
  again, and by that time, the slot has a card in it again, so it tries to
  turn on the power and scan the slot.  The scan fails because we still have
  the old pci_dev for the device that was removed.

  In interrupt_event_handler(), we already know the event type
  (INT_PRESENCE_ON or INT_PRESENCE_OFF), so there's no need to read
  PCI_EXP_SLTSTA again in handle_surprise_event().  Remove
  handle_surprise_event() and queue the power work directly.


> ---
> Resending the patch with another patch which has pcie_isr() correct
> event handling proposal
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
> --
> 1.7.9.5
> 
> Intel Deutschland GmbH
> Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
> Tel: +49 89 99 8853-0, www.intel.de
> Managing Directors: Christin Eisenschmid, Christian Lamprechter
> Chairperson of the Supervisory Board: Nicole Lau
> Registered Office: Munich
> Commercial Register: Amtsgericht Muenchen HRB 186928
> 
