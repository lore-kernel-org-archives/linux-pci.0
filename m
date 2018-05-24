Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 24 May 2018 13:08:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v6 04/12] PCI: Make pciehp_is_native() stricter
Message-ID: <20180524180837.GC95348@bhelgaas-glaptop.roam.corp.google.com>
References: <20180510182844.77349-1-mika.westerberg@linux.intel.com>
 <20180510182844.77349-5-mika.westerberg@linux.intel.com>
 <3307721.MagQsabiPK@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3307721.MagQsabiPK@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 15, 2018 at 11:17:14AM +0200, Rafael J. Wysocki wrote:
> On Thursday, May 10, 2018 8:28:36 PM CEST Mika Westerberg wrote:
> > Currently pciehp_is_native() returns true for any PCI device in a
> > hierarchy where _OSC says we can use pciehp. This is not correct because
> > there may be bridges without PCI_EXP_SLTCAP_HPC capability and those
> > should be managed by acpiphp instead.
> > 
> > Improve pciehp_is_native() to return true only if the given bridge is
> > actually expected to be handled by pciehp. In any other case return
> > false instead to let acpiphp handle those.
> > 
> > Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  drivers/pci/pci-acpi.c      | 28 ++++++++++++++++------------
> >  drivers/pci/pcie/portdrv.h  |  2 --
> >  include/linux/pci.h         |  2 ++
> >  include/linux/pci_hotplug.h |  4 ++--
> >  4 files changed, 20 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > index 1abdbf267c19..d3114f3a7ab8 100644
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -370,26 +370,30 @@ EXPORT_SYMBOL_GPL(pci_get_hp_params);
> >  
> >  /**
> >   * pciehp_is_native - Check whether a hotplug port is handled by the OS
> > - * @pdev: Hotplug port to check
> > + * @bridge: Hotplug port to check
> >   *
> > - * Walk up from @pdev to the host bridge, obtain its cached _OSC Control Field
> > - * and return the value of the "PCI Express Native Hot Plug control" bit.
> > - * On failure to obtain the _OSC Control Field return %false.
> > + * Returns true if the given @bridge is handled by the native PCIe hotplug
> > + * driver.
> >   */
> > -bool pciehp_is_native(struct pci_dev *pdev)
> > +bool pciehp_is_native(struct pci_dev *bridge)
> >  {
> > -	struct acpi_pci_root *root;
> > -	acpi_handle handle;
> > +	const struct pci_host_bridge *host;
> > +	u32 slot_cap;
> >  
> > -	handle = acpi_find_root_bridge_handle(pdev);
> > -	if (!handle)
> > +	if (!pciehp_available())
> > +		return false;
> > +	if (!bridge)
> >  		return false;
> 
> You could write this as 
> 
>     if (!pciehp_available() || !bridge)
>         return false;
> 
> Would be equivalent, but more concise IMO.

Why do we even need to bother checking "bridge" for NULL?

I don't believe in gratuitously checking for NULL because it can hide
higher-level bugs, i.e., if this is called with a NULL pointer, that's
likely a bug in the caller, and if we silently return "false", we'll
never discover the caller's bug.
