Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:28142 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727072AbeIDSnW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Sep 2018 14:43:22 -0400
Date: Tue, 4 Sep 2018 08:19:02 -0600
From: Keith Busch <keith.busch@intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org
Subject: Re: [PATCH 13/16] PCI/pciehp: Implement error handling callbacks
Message-ID: <20180904141902.GH9677@localhost.localdomain>
References: <20180831212639.10196-1-keith.busch@intel.com>
 <20180831212639.10196-14-keith.busch@intel.com>
 <20180902103955.563lmxzzq52eo26q@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180902103955.563lmxzzq52eo26q@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Sep 02, 2018 at 12:39:55PM +0200, Lukas Wunner wrote:
> On Fri, Aug 31, 2018 at 03:26:36PM -0600, Keith Busch wrote:
> > +	/*
> > +	 * Shutdown notification to ignore hotplug events during error
> > +	 * handling. We'll recheck the status when error handling completes.
> > +	 *
> > +	 * It is possible link event related to this error handling may have
> > +	 * triggered a the hotplug interrupt ahead of this notification, but we
> > +	 * can't do anything about that race.
> > +	 */
> > +	pcie_shutdown_notification(ctrl);
> 
> No, if you look at pciehp_remove() you'll notice that I call pci_hp_del()
> before pcie_shutdown_notification().  The IRQ thread is needed to respond
> to user requests to enable/disable the slot.  If you just release the IRQ,
> the sysfs interface is still there but will no longer function while the
> reset is handled.  Not good.
> 
> I think what you want to do instead is "down_write(&ctrl->reset_lock)",
> see commit 5b3f7b7d062b ("PCI: pciehp: Avoid slot access during reset").
> And possibly mask PDCE/DLLSCE like pciehp_reset_slot() does.
> 
> 
> > +static void pciehp_slot_reset(struct pci_dev *dev)
> [...]
> > +	/*
> > +	 * Cache presence detect change, but ignore other hotplug events that
> > +	 * may occur during error handling. Ports that implement only in-band
> > +	 * presence detection may inadvertently believe the device has changed,
> > +	 * so those devices will have to be re-enumerated.
> > +	 */
> > +	pciehp_get_adapter_changed(ctrl->slot, &changed);
> > +	pcie_clear_hotplug_events(ctrl);
> > +	if (changed)
> > +		pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);
> > +	pcie_init_notification(ctrl);
> > +}
> 
> Hm, can we be certain that error handling does not affect PDC?

No, I'm actually saying exactly the opposite in the code comments. The
error handling may affect PDC if the port doesn't have an out-of-band
presence detection capability.

> Because pciehp_reset_slot() does mask it and Sinan once said that in-band
> presence detect may cause presence to flap as well during reset:
> https://lkml.org/lkml/2018/7/3/693

Right, but how do you know which PDC is okay to ignore and which one
isn't? Hotplug events freqently trigger other error handling so we can't
just ignore hot plug during error handling. Link events should be safe
to ignore, though.
