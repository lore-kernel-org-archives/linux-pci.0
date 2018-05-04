Return-Path: <SRS0=h3bN=HX=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=h3bN=HX=linux.intel.com=mika.westerberg@kernel.org>
Date: Fri, 4 May 2018 11:02:41 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5 3/9] PCI: pciehp: Clear Presence Detect and Data Link
 Layer Status Changed on resume
Message-ID: <20180504080241.GJ17277@lahna.fi.intel.com>
References: <20180416103453.46232-1-mika.westerberg@linux.intel.com>
 <20180416103453.46232-4-mika.westerberg@linux.intel.com>
 <20180501215211.GD11698@bhelgaas-glaptop.roam.corp.google.com>
 <20180504071827.GA10888@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180504071827.GA10888@wunner.de>
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 04, 2018 at 09:18:27AM +0200, Lukas Wunner wrote:
> On Tue, May 01, 2018 at 04:52:11PM -0500, Bjorn Helgaas wrote:
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
> 
> The Slot Control register is already written during the ->resume_noirq
> phase via:
> 
>   pci_pm_resume_noirq
>     pci_pm_default_resume_early
>     pci_restore_state
>       pci_restore_pcie_state
> 
> >From that point on, slot events are enabled, but they're not received
> because interrupts are disabled until the ->resume_early phase commences.
> 
> My guess is that if the hotplug port uses edge-triggered MSI/MSI-X,
> an interrupt may have already been sent during ->resume_noirq, but
> was lost because interrupts were disabled.  Clearing the Slot Status
> register thus acknowledges any lost interrupts.
> 
> If this theory is correct, it should probably be included in the
> commit message and/or a code comment so that it's clear what's
> going on.

I think I can check this by printing out the Slot status register in
pci_restore_pcie_state(). If it turns out that the interrupt happens
after we have restored Slot control register, I'll update the changelog
accordingly.
