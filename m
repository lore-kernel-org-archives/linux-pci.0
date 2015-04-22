Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	tiagdtd-lava <tiagdtd-lava@yahoo.de>
Subject: Re: [PATCH] PCI / hotplug: Propagate the "ignore hotplug" setting to parent
Date: Wed, 22 Apr 2015 04:02:02 +0200
Message-ID: <3299062.WsuX6ATqg0@vostro.rjw.lan>
In-Reply-To: <2145313.EW8TNIQHUl@vostro.rjw.lan>
References: <2001450.KHHLaZsp3O@vostro.rjw.lan> <CAJZ5v0jFzidqni=rFKJUzmsJ6pvN01iUyywB7HywWTjABYR_zA@mail.gmail.com> <2145313.EW8TNIQHUl@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, April 15, 2015 07:01:06 PM Rafael J. Wysocki wrote:
> On Wednesday, April 15, 2015 05:36:42 PM Rafael J. Wysocki wrote:
> > On Apr 15, 2015 3:16 PM, "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > >
> > > On Wed, Apr 15, 2015 at 2:55 PM, Bjorn Helgaas <bhelgaas@google.com>
> > wrote:
> > > > On Tue, Apr 14, 2015 at 8:03 PM, Rafael J. Wysocki <rjw@rjwysocki.net>
> > wrote:
> > > >> On Tuesday, April 14, 2015 12:28:12 PM Henrique de Moraes Holschuh
> > wrote:
> > > >>> On Mon, Apr 13, 2015, at 11:23, Rafael J. Wysocki wrote:
> > > >>> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >>> >
> > > >>> > Refine the mechanism introduced by commit f244d8b623da (ACPIPHP /
> > radeon
> > > >>> > / nouveau: Fix VGA switcheroo problem related to hotplug) to
> > propagate
> > > >>> > the ignore_hotplug setting of the device to its parent bridge in
> > case
> > > >>> > hotplug notifications related to the graphics adapter switching are
> > > >>> > given for the bridge rather than for the device itself (the need to
> > > >>> > be ignored in both cases).
> > > >>>
> > > >>> I do apologise if this is a stupid question, but is there any chance
> > the
> > > >>> bridge will be connected to other devices that do require hotplug
> > handling,
> > > >>> and not just to the GPU?
> > > >>
> > > >> The bridge is actually a downstream PCIe port holding the GPU, so no.
> > :-)
> > > >
> > > > When radeon/nouveau call pci_ignore_hotplug(), that's the case, but in
> > > > general all we know is that pci_ignore_hotplug() receives a PCI
> > > > device.  We don't know whether it's PCI or PCIe.  In the hotplug
> > > > topologies I'm familiar with, a bridge only leads to one hot-pluggable
> > > > slot, but I don't remember anything that would guarantee that.  For
> > > > PCIe, I think there can only be one slot, but for PCI I would think it
> > > > possible to have one bridge leading to several hotpluggable slots,
> > > > with the hotplug controller(s) being separate from the bridge.
> > >
> > > Realistically, the switcheroo people are the only users of
> > > pci_ignore_hotplug() today and if somebody wants the hotplug events to
> > > be ignored for him and perhaps not for someone else on the same
> > > bridge, then something is seriously broken about that system anyway.
> > 
> > There may be a problem if somebody *already* calls this function for the
> > parent bridge (which some callers do ISTR) in which case the setting will
> > be propagated unnecessarily.
> > 
> > That said, since all of the existing callers of pci_ignore_hotplug() appear
> > to need to set the flag for the parent too, IMO it's better to put that
> > logic into the interface instead of duplicating it in the callers. So, why
> > don't we add a second argument indicating whether or not to propagate the
> > setting?
> 
> My previous message didn't seem to reach the mailing lists, so above is a
> quote from it and below is a new version of the patch with the additional
> argument to pci_ignore_hotplug().

Do you have any comments on this one?


> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: PCI / hotplug: Propagate the "ignore hotplug" setting to parent
> 
> Refine the mechanism introduced by commit f244d8b623da (ACPIPHP / radeon
> / nouveau: Fix VGA switcheroo problem related to hotplug) to optionally
> propagate the ignore_hotplug setting of the device to its parent bridge
> in case hotplug notifications related to the graphics adapter switching
> are given for the bridge rather than for the device itself (the need to
> be ignored in both cases).
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=61891
> Link: https://bugs.freedesktop.org/show_bug.cgi?id=88927
> Reported-by: tiagdtd-lava <tiagdtd-lava@yahoo.de>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_drm.c |    2 +-
>  drivers/gpu/drm/radeon/radeon_drv.c   |    2 +-
>  drivers/pci/pci.c                     |   16 ++++++++++++++++
>  include/linux/pci.h                   |    6 +-----
>  4 files changed, 19 insertions(+), 7 deletions(-)
> 
> Index: linux-pm/drivers/pci/pci.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci.c
> +++ linux-pm/drivers/pci/pci.c
> @@ -4319,6 +4319,22 @@ bool pci_device_is_present(struct pci_de
>  }
>  EXPORT_SYMBOL_GPL(pci_device_is_present);
>  
> +/**
> + * pci_ignore_hotplug - Ignore subsequent hotplug notifies for this device.
> + * @dev: Target device.
> + * @propagate: Whether or not to ignore hotplug notifies for the parent bridge.
> + */
> +void pci_ignore_hotplug(struct pci_dev *dev, bool propagate)
> +{
> +	struct pci_dev *bridge = dev->bus->self;
> +
> +	dev->ignore_hotplug = 1;
> +	/* Propagate the "ignore hotplug" setting to the parent bridge. */
> +	if (bridge && propagate)
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
> +void pci_ignore_hotplug(struct pci_dev *dev, bool propagate);
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
> Index: linux-pm/drivers/gpu/drm/nouveau/nouveau_drm.c
> ===================================================================
> --- linux-pm.orig/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ linux-pm/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -731,7 +731,7 @@ nouveau_pmops_runtime_suspend(struct dev
>  	ret = nouveau_do_suspend(drm_dev, true);
>  	pci_save_state(pdev);
>  	pci_disable_device(pdev);
> -	pci_ignore_hotplug(pdev);
> +	pci_ignore_hotplug(pdev, true);
>  	pci_set_power_state(pdev, PCI_D3cold);
>  	drm_dev->switch_power_state = DRM_SWITCH_POWER_DYNAMIC_OFF;
>  	return ret;
> Index: linux-pm/drivers/gpu/drm/radeon/radeon_drv.c
> ===================================================================
> --- linux-pm.orig/drivers/gpu/drm/radeon/radeon_drv.c
> +++ linux-pm/drivers/gpu/drm/radeon/radeon_drv.c
> @@ -453,7 +453,7 @@ static int radeon_pmops_runtime_suspend(
>  	ret = radeon_suspend_kms(drm_dev, false, false);
>  	pci_save_state(pdev);
>  	pci_disable_device(pdev);
> -	pci_ignore_hotplug(pdev);
> +	pci_ignore_hotplug(pdev, true);
>  	pci_set_power_state(pdev, PCI_D3cold);
>  	drm_dev->switch_power_state = DRM_SWITCH_POWER_DYNAMIC_OFF;
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
