Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout1.hostsharing.net ([83.223.95.100]:56151 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeG2N1T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 29 Jul 2018 09:27:19 -0400
Date: Sun, 29 Jul 2018 13:57:03 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Sinan Kaya <okaya@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Oza Pawandeep <poza@codeaurora.org>
Subject: Re: [PATCH v6 1/1] PCI: pciehp: Ignore link events when there is a
 fatal error pending
Message-ID: <20180729115703.GA2781@wunner.de>
References: <20180728091324.154795-1-okaya@kernel.org>
 <20180728091324.154795-2-okaya@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180728091324.154795-2-okaya@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jul 28, 2018 at 02:13:24AM -0700, Sinan Kaya wrote:
> We need to figure out how to gracefully return inside hotplug driver
> if link down happened and there is an error pending. Fatal error needs
> to be serviced by AER/DPC drivers. Hotplug driver is observing link
> events while AER/DPC drivers are performing link recovery today and
> are causing confusion for the hotplug statemachine.
> 
> 1. check if there is a fatal error pending in the device_status register
> of the PCI Express capability on the root port.
> 2. bail out from hotplug routine if this is the case.
> 3. otherwise, existing behavior.
> 
> If fatal error is pending and a fatal error service such as DPC or AER
> is running, it is the responsibility of the fatal error service to
> recover the link.
[snip]
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -612,10 +612,15 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>  	 * and cause the wrong event to queue.
>  	 */
>  	if (events & PCI_EXP_SLTSTA_DLLSC) {
> -		ctrl_info(ctrl, "Slot(%s): Link %s\n", slot_name(slot),
> -			  link ? "Up" : "Down");
> -		pciehp_queue_interrupt_event(slot, link ? INT_LINK_UP :
> -					     INT_LINK_DOWN);
> +		if (pci_fatal_error_pending(pdev, PCI_ERR_UNC_SURPDN))
> +			ctrl_info(ctrl, "Slot(%s): Ignoring Link %s event due to detected Fatal Error\n",
> +				  slot_name(slot), link ? "Up" : "Down");
> +		else {
> +			ctrl_info(ctrl, "Slot(%s): Link %s\n", slot_name(slot),
> +				  link ? "Up" : "Down");
> +			pciehp_queue_interrupt_event(slot, link ? INT_LINK_UP :
> +						     INT_LINK_DOWN);
> +		}

The above is still based on the event handling in v4.18, so the patch
doesn't apply to what's currently queued on Bjorn's pci/hotplug branch.

That said, a problem I see with the approach you're suggesting is that
recovery from the fatal error may fail in pcie_do_fatal_recovery().
The devices below the hotplug port will then have been removed but
internally in pciehp the slot will remain in ON_STATE and slot power
will remain enabled.  That feels wrong.

After re-reading all the e-mails we've exchanged since early July,
the approach Oza suggested in this e-mail seems the most sensible to me:
https://lkml.kernel.org/r/324f8cf2fe6f7bdc43ca8a646eea908d@codeaurora.org

He suggested skipping removal of devices in pcie_do_fatal_recovery()
for hotplug ports.

The rationale is that when a PCIe port raises a fatal error, that port
will normally not have the ability to remove its children from the
hierarchy unless it's a hotplug port.  Thus, if the port is a hotplug
port, pcie_do_fatal_recovery() should let pciehp handle removal of the
devices.  Only if it's not a hotplug port should pcie_do_fatal_recovery()
remove the devices.  My understanding is that after the error has been
cleared, the link should automatically come back up, is that correct?
pciehp will then bring up the slot on its own.

Thanks,

Lukas
