Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750954AbeEBNlv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 May 2018 09:41:51 -0400
Date: Wed, 2 May 2018 08:41:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5 3/9] PCI: pciehp: Clear Presence Detect and Data Link
 Layer Status Changed on resume
Message-ID: <20180502134148.GF11698@bhelgaas-glaptop.roam.corp.google.com>
References: <20180416103453.46232-1-mika.westerberg@linux.intel.com>
 <20180416103453.46232-4-mika.westerberg@linux.intel.com>
 <20180501215211.GD11698@bhelgaas-glaptop.roam.corp.google.com>
 <20180502115509.GF2355@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180502115509.GF2355@lahna.fi.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 02, 2018 at 02:55:09PM +0300, Mika Westerberg wrote:
> On Tue, May 01, 2018 at 04:52:11PM -0500, Bjorn Helgaas wrote:
> > Hi Mika,
> > 
> > On Mon, Apr 16, 2018 at 01:34:47PM +0300, Mika Westerberg wrote:
> > > After suspend/resume cycle the Presence Detect or Data Link Layer Status
> > > Changed bits might be set and if we don't clear them those events will
> > > not fire anymore and nothing happens for instance when a device is now
> > > hot-unplugged.
> > > 
> > > Fix this by clearing those bits in a newly introduced function
> > > pcie_reenable_notification(). This should be fine because immediately
> > > after we check if the adapter is still present by reading directly from
> > > the status register.
> > > 
> > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Cc: stable@vger.kernel.org
> > 
> > I want to understand why we need to handle this differently between
> > the boot-time probe path and the resume path.
> > 
> > This patch clears PCI_EXP_SLTSTA_PDC and PCI_EXP_SLTSTA_DLLSC in the
> > resume path:
> > 
> >   pciehp_resume
> >     pcie_reenable_notification
> >       # clear PDC DLLSC
> >       pcie_enable_notification
> >         # set DLLSCE ABPE/PDCE HPIE CCIE
> >     pciehp_get_adapter_status
> >       # read PCI_EXP_SLTSTA
> > 
> > We used to clear PCI_EXP_SLTSTA_PDC and PCI_EXP_SLTSTA_DLLSC in the
> > probe path:
> > 
> >   pciehp_probe
> >     pcie_init
> >       # clear PDC ABP PFD MRLSC CC DLSCC
> >     pcie_init_notification
> >       pciehp_request_irq
> >       pcie_enable_notification
> >         # set DLLSCE ABPE/PDCE HPIE CCIE
> >     pciehp_get_adapter_status
> >       # read PCI_EXP_SLTSTA
> >     pciehp_get_power_status
> > 
> > db63d40017a5 ("PCI: pciehp: Do not clear Presence Detect Changed
> > during initialization") changed the probe path so we don't clear
> > PCI_EXP_SLTSTA_PDC there anymore.  This was so we wouldn't miss a PDC
> > interrupt that happened before probe.
> > 
> > Why can't we handle probe and resume the same way?  They look quite
> > similar.
> > 
> > You say this patch should be fine because we read SLTSTA immediately
> > after clearing PDC and DLLSC.  But we also read SLTSTA in the probe
> > path, so I'm not sure why we need to clear PDC and DLLSC for resume
> > but not for probe.
> 
> On probe path we read status but here is what it does:
> 
> 	pcie_init_notification()
> 	...
>         pciehp_get_adapter_status(slot, &occupied);
> 	...
>         if (occupied && pciehp_force) {
>                 mutex_lock(&slot->hotplug_lock);
>                 pciehp_enable_slot(slot);
>                 mutex_unlock(&slot->hotplug_lock);
>         }
> 
> If you don't have "pciehp.pciehp_force=1" in your kernel command line
> you miss the fact that the card is already there. Obviously you can't
> expect ordinary users to pass random command line options to get their
> already connected device detected by Linux.

Yeah, definitely not, that's really ugly.

> So the reason why in probe we don't clear PDC is that once the interrupt
> is unmasked, you get an interrupt and the card gets detected properly.
> 
> On resume path we already check whether the card is there or not and
> handle it accordingly. However, if we don't clear PDC and DLLSC bits we
> will never get hotplug interrupt again.
> 
> Now, you ask why can't we handle probe and resume the same way? I think
> we can if we could get rid of that pciehp_force thing but it seems to
> fix an issue on some HP hardware. See 9e5858244926 ("pciehp: don't
> enable slot unless forced").

Ugh.  That's really ancient history.  I would *love* to get rid of
pciehp.pciehp_force.  There's not much detail in 9e5858244926, but
maybe with some digging we can figure out something.

I'd rather do the digging now and try to simplify this area instead of
adding another tweak.

Bjorn
