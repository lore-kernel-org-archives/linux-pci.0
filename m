Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout3.hostsharing.net ([176.9.242.62]:44691 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbeIBOzQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 2 Sep 2018 10:55:16 -0400
Date: Sun, 2 Sep 2018 12:39:55 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org
Subject: Re: [PATCH 13/16] PCI/pciehp: Implement error handling callbacks
Message-ID: <20180902103955.563lmxzzq52eo26q@wunner.de>
References: <20180831212639.10196-1-keith.busch@intel.com>
 <20180831212639.10196-14-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180831212639.10196-14-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 31, 2018 at 03:26:36PM -0600, Keith Busch wrote:
> +	/*
> +	 * Shutdown notification to ignore hotplug events during error
> +	 * handling. We'll recheck the status when error handling completes.
> +	 *
> +	 * It is possible link event related to this error handling may have
> +	 * triggered a the hotplug interrupt ahead of this notification, but we
> +	 * can't do anything about that race.
> +	 */
> +	pcie_shutdown_notification(ctrl);

No, if you look at pciehp_remove() you'll notice that I call pci_hp_del()
before pcie_shutdown_notification().  The IRQ thread is needed to respond
to user requests to enable/disable the slot.  If you just release the IRQ,
the sysfs interface is still there but will no longer function while the
reset is handled.  Not good.

I think what you want to do instead is "down_write(&ctrl->reset_lock)",
see commit 5b3f7b7d062b ("PCI: pciehp: Avoid slot access during reset").
And possibly mask PDCE/DLLSCE like pciehp_reset_slot() does.


> +static void pciehp_slot_reset(struct pci_dev *dev)
[...]
> +	/*
> +	 * Cache presence detect change, but ignore other hotplug events that
> +	 * may occur during error handling. Ports that implement only in-band
> +	 * presence detection may inadvertently believe the device has changed,
> +	 * so those devices will have to be re-enumerated.
> +	 */
> +	pciehp_get_adapter_changed(ctrl->slot, &changed);
> +	pcie_clear_hotplug_events(ctrl);
> +	if (changed)
> +		pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);
> +	pcie_init_notification(ctrl);
> +}

Hm, can we be certain that error handling does not affect PDC?
Because pciehp_reset_slot() does mask it and Sinan once said that in-band
presence detect may cause presence to flap as well during reset:
https://lkml.org/lkml/2018/7/3/693

Thanks,

Lukas
