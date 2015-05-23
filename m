Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 22 May 2015 20:40:37 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI / hotplug: Propagate the "ignore hotplug" setting to
 parent
Message-ID: <20150523014037.GL32152@google.com>
References: <2001450.KHHLaZsp3O@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2001450.KHHLaZsp3O@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 13, 2015 at 04:23:36PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Refine the mechanism introduced by commit f244d8b623da (ACPIPHP / radeon
> / nouveau: Fix VGA switcheroo problem related to hotplug) to propagate
> the ignore_hotplug setting of the device to its parent bridge in case
> hotplug notifications related to the graphics adapter switching are
> given for the bridge rather than for the device itself (the need to
> be ignored in both cases).
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=61891
> Link: https://bugs.freedesktop.org/show_bug.cgi?id=88927
> Reported-and-tested-by: tiagdtd-lava <tiagdtd-lava@yahoo.de>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Applied to pci/hotplug for v4.2, thanks!

I marked it for stable and added a note to connect it to b440bde74f04
("PCI: Add pci_ignore_hotplug() to ignore hotplug events for a device")

> ---
> 
> "Stable" material AFAICS.
> 
> ---
>  drivers/pci/pci.c   |   11 +++++++++++
>  include/linux/pci.h |    6 +-----
>  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> Index: linux-pm/drivers/pci/pci.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci.c
> +++ linux-pm/drivers/pci/pci.c
> @@ -4319,6 +4319,17 @@ bool pci_device_is_present(struct pci_de
>  }
>  EXPORT_SYMBOL_GPL(pci_device_is_present);
>  
> +void pci_ignore_hotplug(struct pci_dev *dev)
> +{
> +	struct pci_dev *bridge = dev->bus->self;
> +
> +	dev->ignore_hotplug = 1;
> +	/* Propagate the "ignore hotplug" setting to the parent bridge. */
> +	if (bridge)
> +		bridge->ignore_hotplug = 1;
> +}
> +EXPORT_SYMBOL_GPL(pci_ignore_hotplug);
> +
>  #define RESOURCE_ALIGNMENT_PARAM_SIZE COMMAND_LINE_SIZE
>  static char resource_alignment_param[RESOURCE_ALIGNMENT_PARAM_SIZE] = {0};
>  static DEFINE_SPINLOCK(resource_alignment_lock);
> Index: linux-pm/include/linux/pci.h
> ===================================================================
> --- linux-pm.orig/include/linux/pci.h
> +++ linux-pm/include/linux/pci.h
> @@ -1002,6 +1002,7 @@ int __must_check pci_assign_resource(str
>  int __must_check pci_reassign_resource(struct pci_dev *dev, int i, resource_size_t add_size, resource_size_t align);
>  int pci_select_bars(struct pci_dev *dev, unsigned long flags);
>  bool pci_device_is_present(struct pci_dev *pdev);
> +void pci_ignore_hotplug(struct pci_dev *dev);
>  
>  /* ROM control related routines */
>  int pci_enable_rom(struct pci_dev *pdev);
> @@ -1039,11 +1040,6 @@ bool pci_dev_run_wake(struct pci_dev *de
>  bool pci_check_pme_status(struct pci_dev *dev);
>  void pci_pme_wakeup_bus(struct pci_bus *bus);
>  
> -static inline void pci_ignore_hotplug(struct pci_dev *dev)
> -{
> -	dev->ignore_hotplug = 1;
> -}
> -
>  static inline int pci_enable_wake(struct pci_dev *dev, pci_power_t state,
>  				  bool enable)
>  {
> 
