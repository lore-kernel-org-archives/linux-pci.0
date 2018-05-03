Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 3 May 2018 18:01:08 -0500
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
Message-ID: <20180503230108.GD15790@bhelgaas-glaptop.roam.corp.google.com>
References: <20180416103453.46232-1-mika.westerberg@linux.intel.com>
 <20180416103453.46232-4-mika.westerberg@linux.intel.com>
 <20180501215211.GD11698@bhelgaas-glaptop.roam.corp.google.com>
 <20180502115509.GF2355@lahna.fi.intel.com>
 <20180502134148.GF11698@bhelgaas-glaptop.roam.corp.google.com>
 <20180503104250.GJ2355@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180503104250.GJ2355@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 03, 2018 at 01:42:50PM +0300, Mika Westerberg wrote:
> On Wed, May 02, 2018 at 08:41:48AM -0500, Bjorn Helgaas wrote:
> > On Wed, May 02, 2018 at 02:55:09PM +0300, Mika Westerberg wrote:
> > > On Tue, May 01, 2018 at 04:52:11PM -0500, Bjorn Helgaas wrote:
> > > > Hi Mika,
> > > > 
> > > > On Mon, Apr 16, 2018 at 01:34:47PM +0300, Mika Westerberg wrote:
> > > > > After suspend/resume cycle the Presence Detect or Data Link Layer Status
> > > > > Changed bits might be set and if we don't clear them those events will
> > > > > not fire anymore and nothing happens for instance when a device is now
> > > > > hot-unplugged.
> > > > > 
> > > > > Fix this by clearing those bits in a newly introduced function
> > > > > pcie_reenable_notification(). This should be fine because immediately
> > > > > after we check if the adapter is still present by reading directly from
> > > > > the status register.
> > > > > 
> > > > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > > Cc: stable@vger.kernel.org
> > > > 
> > > > I want to understand why we need to handle this differently between
> > > > the boot-time probe path and the resume path.
> > > > 
> > > > This patch clears PCI_EXP_SLTSTA_PDC and PCI_EXP_SLTSTA_DLLSC in the
> > > > resume path:
> > > > 
> > > >   pciehp_resume
> > > >     pcie_reenable_notification
> > > >       # clear PDC DLLSC
> > > >       pcie_enable_notification
> > > >         # set DLLSCE ABPE/PDCE HPIE CCIE
> > > >     pciehp_get_adapter_status
> > > >       # read PCI_EXP_SLTSTA
> > > > 
> > > > We used to clear PCI_EXP_SLTSTA_PDC and PCI_EXP_SLTSTA_DLLSC in the
> > > > probe path:
> > > > 
> > > >   pciehp_probe
> > > >     pcie_init
> > > >       # clear PDC ABP PFD MRLSC CC DLSCC
> > > >     pcie_init_notification
> > > >       pciehp_request_irq
> > > >       pcie_enable_notification
> > > >         # set DLLSCE ABPE/PDCE HPIE CCIE
> > > >     pciehp_get_adapter_status
> > > >       # read PCI_EXP_SLTSTA
> > > >     pciehp_get_power_status
> > > > 
> > > > db63d40017a5 ("PCI: pciehp: Do not clear Presence Detect Changed
> > > > during initialization") changed the probe path so we don't clear
> > > > PCI_EXP_SLTSTA_PDC there anymore.  This was so we wouldn't miss a PDC
> > > > interrupt that happened before probe.
> > > > 
> > > > Why can't we handle probe and resume the same way?  They look quite
> > > > similar.
> > > > 
> > > > You say this patch should be fine because we read SLTSTA immediately
> > > > after clearing PDC and DLLSC.  But we also read SLTSTA in the probe
> > > > path, so I'm not sure why we need to clear PDC and DLLSC for resume
> > > > but not for probe.
> > > 
> > > On probe path we read status but here is what it does:
> > > 
> > > 	pcie_init_notification()
> > > 	...
> > >         pciehp_get_adapter_status(slot, &occupied);
> > > 	...
> > >         if (occupied && pciehp_force) {
> > >                 mutex_lock(&slot->hotplug_lock);
> > >                 pciehp_enable_slot(slot);
> > >                 mutex_unlock(&slot->hotplug_lock);
> > >         }
> > > 
> > > If you don't have "pciehp.pciehp_force=1" in your kernel command line
> > > you miss the fact that the card is already there. Obviously you can't
> > > expect ordinary users to pass random command line options to get their
> > > already connected device detected by Linux.
> > 
> > Yeah, definitely not, that's really ugly.
> > 
> > > So the reason why in probe we don't clear PDC is that once the interrupt
> > > is unmasked, you get an interrupt and the card gets detected properly.
> > > 
> > > On resume path we already check whether the card is there or not and
> > > handle it accordingly. However, if we don't clear PDC and DLLSC bits we
> > > will never get hotplug interrupt again.
> > > 
> > > Now, you ask why can't we handle probe and resume the same way? I think
> > > we can if we could get rid of that pciehp_force thing but it seems to
> > > fix an issue on some HP hardware. See 9e5858244926 ("pciehp: don't
> > > enable slot unless forced").
> > 
> > Ugh.  That's really ancient history.  I would *love* to get rid of
> > pciehp.pciehp_force.  There's not much detail in 9e5858244926, but
> > maybe with some digging we can figure out something.
> > 
> > I'd rather do the digging now and try to simplify this area instead of
> > adding another tweak.
> 
> I did some digging but unfortunately it is still not clear what issue
> 9e5858244926 is fixing. There is no bugzilla link and I was not able to
> find any discussion around this either.
> 
> However, I think currently pciehp_force=1 does not actually do what it
> was intended to do. Reason is that portdrv core already asks BIOS
> whether native PCIe is allowed and if not, it does not set
> PCIE_PORT_SERVICE_HP and that prevents the whole device to be created.
> So even if you specify pciehp_force=1 in the command line, it does not
> bypass the BIOS setting.
> 
> Furthermore we have had similar check in pciehp_resume() but it was
> removed with 87683e22c646 ("PCI: pciehp: Always implement resume,
> regardless of pciehp_force param") because it broke resume.
> 
> If I understand correctly you want me to change the driver so that I
> remove pciehp_force check from probe. Then I can revert db63d40017a5
> ("PCI: pciehp: Do not clear Presence Detect Changed during
> initialization") and that makes both probe path and resume path similar
> (when this patch is included). Is that correct? I can do that in the
> next version of the patch series.

If you think we can remove pciehp_force, that would be awesome.  This
should be a separate patch all by itself, of course, and include your
reasoning above.

I would also love to revert db63d40017a5 ("PCI: pciehp: Do not clear
Presence Detect Changed during initialization") because I'm not
convinced that trying to handle interrupts that happened before
binding the driver makes sense.  It *would* make sense to me to enable
interrupts, clear the "changed" status bits so future changes will
cause interrupts, and check the "state" status bits and act on them.

Bjorn
