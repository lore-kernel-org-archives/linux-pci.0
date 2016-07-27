Return-Path: <rui.y.wang@intel.com>
Return-Path: <rui.y.wang@intel.com>
From: Rui Wang <rui.y.wang@intel.com>
To: helgaas@kernel.org
Cc: tglx@linutronix.de,
	rjw@rjwysocki.net,
	tony.luck@intel.com,
	bhelgaas@google.com,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rui.y.wang@intel.com
Subject: Re: [PATCH 1/4] x86/ioapic: Support hot-removal of IOAPICs present during boot boot
Date: Wed, 27 Jul 2016 10:23:35 +0800
Message-Id: <1469586215-21578-1-git-send-email-rui.y.wang@intel.com>
In-Reply-To: <20160726201932.GD15037@localhost>
References: <20160726201932.GD15037@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Wed, July 27, 2016 4:20 AM Bjorn Helgaas wrote:
> On Wed, Jul 27, 2016 at 12:13:14AM +0800, Rui Wang wrote:
> > IOAPICs present during system boot aren't added to ioapic_list, thus
> > are unable to be hot-removed. Fix it by calling
> > acpi_ioapic_add() during root bus enumeration.
> >
> > Signed-off-by: Rui Wang <rui.y.wang@intel.com>
> > ---
> >  drivers/acpi/internal.h |  2 --
> >  drivers/acpi/ioapic.c   |  7 ++++---
> >  drivers/acpi/pci_root.c | 13 ++++++++++++-  drivers/pci/setup-bus.c |
> > 5 ++++-
> >  include/linux/acpi.h    |  6 ++++++
> >  5 files changed, 26 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h index
> > 27cc7fe..6d8e67e 100644
> > --- a/drivers/acpi/internal.h
> > +++ b/drivers/acpi/internal.h
> > @@ -40,10 +40,8 @@ int acpi_sysfs_init(void);  void
> > acpi_container_init(void);  void acpi_memory_hotplug_init(void);
> >  #ifdef	CONFIG_ACPI_HOTPLUG_IOAPIC
> > -int acpi_ioapic_add(struct acpi_pci_root *root);  int
> > acpi_ioapic_remove(struct acpi_pci_root *root);  #else -static inline
> > int acpi_ioapic_add(struct acpi_pci_root *root) { return 0; }
> 
> It would be nicer if the interface change and header file munging were in a
> separate patch so they wouldn't obscure the meat of the change, i.e., the
> addition of calls to acpi_ioapic_add().

Sure. I'll split it in a newer version.

> 
> >  static inline int acpi_ioapic_remove(struct acpi_pci_root *root) {
> > return 0; }  #endif  #ifdef CONFIG_ACPI_DOCK diff --git
> > a/drivers/acpi/ioapic.c b/drivers/acpi/ioapic.c index ccdc8db..0f272e2
> > 100644
> > --- a/drivers/acpi/ioapic.c
> > +++ b/drivers/acpi/ioapic.c
> > @@ -189,16 +189,17 @@ exit:
> >  	return AE_OK;
> >  }
> >
> > -int acpi_ioapic_add(struct acpi_pci_root *root)
> > +int acpi_ioapic_add(acpi_handle root_handle)
> >  {
> >  	acpi_status status, retval = AE_OK;
> >
> > -	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, root->device-
> >handle,
> > +	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, root_handle,
> >  				     UINT_MAX, handle_ioapic_add, NULL,
> > -				     root->device->handle, (void **)&retval);
> > +				     root_handle, (void **)&retval);
> >
> >  	return ACPI_SUCCESS(status) && ACPI_SUCCESS(retval) ? 0 : -
> ENODEV;
> > }
> > +EXPORT_SYMBOL_GPL(acpi_ioapic_add);
> 
> What loadable module needs to call this?  It shouldn't be exported unless
> there is such a module.

It's called from the ioapic driver which is built-in. I'll remove the export.

Thanks
Rui
