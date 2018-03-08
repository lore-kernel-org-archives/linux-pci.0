Return-Path: <SRS0=/KsV=F6=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=/KsV=F6=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Keith Busch <keith.busch@intel.com>, Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH v1 2/9] PCI/PM: Clear PCIe PME Status bit in core, not PCIe port driver
Date: Thu, 08 Mar 2018 10:13:39 +0100
Message-ID: <8601339.xFspzpXtrk@aspire.rjw.lan>
In-Reply-To: <20180308080331.GA5671@wunner.de>
References: <152040297576.240786.1532465558381209070.stgit@bhelgaas-glaptop.roam.corp.google.com> <152040321483.240786.16597888035806933750.stgit@bhelgaas-glaptop.roam.corp.google.com> <20180308080331.GA5671@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Thursday, March 8, 2018 9:03:31 AM CET Lukas Wunner wrote:
> On Wed, Mar 07, 2018 at 12:13:34AM -0600, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > fe31e69740ed ("PCI/PCIe: Clear Root PME Status bits early during system
> > resume") added a .resume_noirq() callback to the PCIe port driver to clear
> > the PME Status bit during resume to work around a BIOS issue.
> > 
> > The BIOS evidently enabled PME interrupts for ACPI-based runtime wakeups
> > but did not clear the PME Status bit during resume, which meant PMEs after
> > resume did not trigger interrupts because PME Status did not transition
> > from cleared to set.
> > 
> > The fix was in the PCIe port driver, so it worked when CONFIG_PCIEPORTBUS
> > was set.  But I think we *always* want the fix because the platform may use
> > PME interrupts even if Linux is built without the PCIe port driver.
> > 
> > Move the fix from the port driver to the PCI core so we can work around
> > this "PME doesn't work after waking from a sleep state" issue regardless of
> > CONFIG_PCIEPORTBUS.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/pci/pci-driver.c       |   14 ++++++++++++++
> >  drivers/pci/pcie/portdrv_pci.c |   15 ---------------
> >  2 files changed, 14 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > index 3bed6beda051..bf0704b75f79 100644
> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> > @@ -525,6 +525,18 @@ static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
> >  	pci_fixup_device(pci_fixup_resume_early, pci_dev);
> >  }
> >  
> > +static void pcie_resume_early(struct pci_dev *pci_dev)
> > +{
> > +	/*
> > +	 * Some BIOSes forget to clear Root PME Status bits after system wakeup
> > +	 * which breaks ACPI-based runtime wakeup on PCI Express, so clear those
> > +	 * bits now just in case (shouldn't hurt).
> > +	 */
> > +	if (pci_is_pcie(pci_dev) &&
> > +	    pci_pcie_type(pci_dev) == PCI_EXP_TYPE_ROOT_PORT)
> > +		pcie_clear_root_pme_status(pci_dev);
> > +}
> > +
> >  /*
> >   * Default "suspend" method for devices that have no driver provided suspend,
> >   * or not even a driver at all (second part).
> > @@ -873,6 +885,8 @@ static int pci_pm_resume_noirq(struct device *dev)
> >  	if (pci_has_legacy_pm_support(pci_dev))
> >  		return pci_legacy_resume_early(dev);
> >  
> > +	pcie_resume_early(pci_dev);
> 
> I'm wondering if it would be better to implement this as a PCI quirk:
> 
> DECLARE_PCI_FIXUP_CLASS_RESUME_EARLY(PCI_ANY_ID, PCI_ANY_ID,
> 				     PCI_CLASS_BRIDGE_PCI, 8, ...)
> 
> Then it would also be executed for the ->restore_noirq phase, not only
> ->resume_noirq.  And it could be constrained to only the affected PCI
> or DMI IDs.
> 
> However it would then also be executed on ->runtime_resume, I'm not
> sure if that's a problem or not.

While that may not be a problem strictly speaking (the root port resume
only takes place when the port itself has been suspended, so this should
not interfere with PME handling for the devices under it), but it also is
not necessary in that case, because the platform firmware doesn't mess up
with the root port's PM registers then.

Or if it does, the whole PCIe PM is managed by AML/SMM and we should not
even touch this register at all.
