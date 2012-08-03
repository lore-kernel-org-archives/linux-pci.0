Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:34525 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752188Ab2HCQSL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 3 Aug 2012 12:18:11 -0400
Received: by lahd3 with SMTP id d3so469298lah.19
        for <linux-pci@vger.kernel.org>; Fri, 03 Aug 2012 09:18:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1343998156-1037-1-git-send-email-prarit@redhat.com>
References: <1343998156-1037-1-git-send-email-prarit@redhat.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 3 Aug 2012 10:17:48 -0600
Message-ID: <CAErSpo6sFdQSObsRLdyNPcrqhONMcjbjcbAR0xyGa-z0Pex-iQ@mail.gmail.com>
Subject: Re: [PATCH] pci, rename subordinate bus to secondary bus
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-pci@vger.kernel.org, Myron Stowe <mstowe@redhat.com>,
	Don Dutile <ddutile@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 3, 2012 at 6:49 AM, Prarit Bhargava <prarit@redhat.com> wrote:
> The PCI-to-PCI Bridge Architecture Specification defines a secondary
> interface (commonly known as a secondary bus) as "The PCI interface of the
> bridge that is connected to the PCI bus farthest from the CPU is referred
> to as the secondary PCI interface."
>
> The term subordinate bus number is used to define "the bus number of the
> highest numbered PCI bus segment which is behind (or subordinate to) the
> bridge".
>
> The current code tree mixes up these terms such that pci_dev->subordinate
> is really the secondary interface.  This gets confusing as other areas
> of the code use proper terminology for subordinate and secondary.
>
> This is a cleanup that renames pci_dev->subordinate to pci_dev->secondary,
> and cleans up some comments referring to the secondary and subordinate
> busses.

I think this or something similar might be worthwhile eventually, but
I'm not sure we're quite ready yet.  I hesitate because this feels
like one small piece of PCI namespace cleanup, and I think it would be
good to settle on a plan for a more extensive reorganization that we
could do all at once.  I don't think it's obvious yet what that would
look like.  This might be one part, collecting P2P bridge-related
things into one place (they're currently scattered around pci_dev and
pci_bus), giving busn_res a better name might be another,  etc.

Also, I think this specific change would affect all architectures, and
this patch only fixes x86.

When we're ready to do this, I wonder if it could be done completely
mechanically by Coccinelle?  If it could, that would be a nice way of
encapsulating the effort so the patch doesn't bit-rot.

>  arch/x86/pci/fixup.c                      |    3 ++-
>  arch/x86/pci/sta2x11-fixup.c              |    4 ++--
>  drivers/acpi/pci_bind.c                   |   12 ++++++------
>  drivers/acpi/pci_root.c                   |    4 ++--
>  drivers/acpi/pci_slot.c                   |    6 +++---
>  drivers/infiniband/hw/mthca/mthca_reset.c |    2 +-
>  drivers/iommu/dmar.c                      |    6 +++---
>  drivers/iommu/intel-iommu.c               |   18 +++++++++---------
>  drivers/net/ethernet/broadcom/tg3.c       |   16 ++++++++--------
>  drivers/pci/bus.c                         |   14 +++++++-------
>  drivers/pci/hotplug-pci.c                 |    2 +-
>  drivers/pci/hotplug/acpiphp_glue.c        |   26 +++++++++++++-------------
>  drivers/pci/hotplug/cpcihp_generic.c      |    2 +-
>  drivers/pci/hotplug/cpcihp_zt5550.c       |    2 +-
>  drivers/pci/hotplug/cpqphp_core.c         |    2 +-
>  drivers/pci/hotplug/cpqphp_pci.c          |    2 +-
>  drivers/pci/hotplug/ibmphp_core.c         |    2 +-
>  drivers/pci/hotplug/pciehp_core.c         |    6 +++---
>  drivers/pci/hotplug/pciehp_ctrl.c         |    6 +++---
>  drivers/pci/hotplug/pciehp_hpc.c          |    4 ++--
>  drivers/pci/hotplug/pciehp_pci.c          |    4 ++--
>  drivers/pci/hotplug/pcihp_slot.c          |    6 +++---
>  drivers/pci/hotplug/rpadlpar_core.c       |    4 ++--
>  drivers/pci/hotplug/sgi_hotplug.c         |   14 +++++++-------
>  drivers/pci/hotplug/shpchp_core.c         |    6 +++---
>  drivers/pci/hotplug/shpchp_ctrl.c         |    4 ++--
>  drivers/pci/hotplug/shpchp_hpc.c          |    4 ++--
>  drivers/pci/hotplug/shpchp_pci.c          |    4 ++--
>  drivers/pci/hotplug/shpchp_sysfs.c        |    2 +-
>  drivers/pci/pci-acpi.c                    |    4 ++--
>  drivers/pci/pci-sysfs.c                   |   16 ++++++++--------
>  drivers/pci/pci.c                         |   10 +++++-----
>  drivers/pci/pci.h                         |    2 +-
>  drivers/pci/pcie/aer/aerdrv.c             |    4 ++--
>  drivers/pci/pcie/aer/aerdrv_core.c        |   11 ++++++-----
>  drivers/pci/pcie/aspm.c                   |   18 +++++++++---------
>  drivers/pci/pcie/pme.c                    |    8 ++++----
>  drivers/pci/pcie/portdrv_pci.c            |    6 +++---
>  drivers/pci/probe.c                       |    4 ++--
>  drivers/pci/quirks.c                      |   27 ++++++++++++---------------
>  drivers/pci/remove.c                      |   22 +++++++++++-----------
>  drivers/pci/setup-bus.c                   |   26 +++++++++++++-------------
>  drivers/pcmcia/cardbus.c                  |    6 +++---
>  drivers/pcmcia/yenta_socket.c             |   22 +++++++++++++---------
>  drivers/platform/x86/eeepc-laptop.c       |    2 +-
>  include/linux/pci.h                       |    2 +-
>  46 files changed, 190 insertions(+), 187 deletions(-)
>
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index af8a224..5b9198d 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -256,7 +256,8 @@ static void pcie_rootport_aspm_quirk(struct pci_dev *pdev)
>         struct pci_bus  *pbus;
>         struct pci_dev *dev;
>
> -       if ((pbus = pdev->subordinate) == NULL)
> +       pbus = pdev->secondary;
> +       if (!pbus)
>                 return;
>
>         /*
> diff --git a/arch/x86/pci/sta2x11-fixup.c b/arch/x86/pci/sta2x11-fixup.c
> index 9d8a509..73da22d 100644
> --- a/arch/x86/pci/sta2x11-fixup.c
> +++ b/arch/x86/pci/sta2x11-fixup.c
> @@ -64,8 +64,8 @@ static void sta2x11_new_instance(struct pci_dev *pdev)
>         instance = kzalloc(sizeof(*instance), GFP_ATOMIC);
>         if (!instance)
>                 return;
> -       /* This has a subordinate bridge, with 4 more-subordinate ones */
> -       instance->bus0 = pdev->subordinate->number + 1;
> +       /* This has a secondary bus, with 4 more-secondary ones */
> +       instance->bus0 = pdev->secondary->number + 1;
>
>         if (list_empty(&sta2x11_instance_list)) {
>                 int size = STA2X11_SWIOTLB_SIZE;
> diff --git a/drivers/acpi/pci_bind.c b/drivers/acpi/pci_bind.c
> index 2ef0409..9a3aa32 100644
> --- a/drivers/acpi/pci_bind.c
> +++ b/drivers/acpi/pci_bind.c
> @@ -46,10 +46,10 @@ static int acpi_pci_unbind(struct acpi_device *device)
>         device_set_run_wake(&dev->dev, false);
>         pci_acpi_remove_pm_notifier(device);
>
> -       if (!dev->subordinate)
> +       if (!dev->secondary)
>                 goto out;
>
> -       acpi_pci_irq_del_prt(dev->subordinate);
> +       acpi_pci_irq_del_prt(dev->secondary);
>
>         device->ops.bind = NULL;
>         device->ops.unbind = NULL;
> @@ -78,7 +78,7 @@ static int acpi_pci_bind(struct acpi_device *device)
>          * Install the 'bind' function to facilitate callbacks for
>          * children of the P2P bridge.
>          */
> -       if (dev->subordinate) {
> +       if (dev->secondary) {
>                 ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>                                   "Device %04x:%02x:%02x.%d is a PCI bridge\n",
>                                   pci_domain_nr(dev->bus), dev->bus->number,
> @@ -91,7 +91,7 @@ static int acpi_pci_bind(struct acpi_device *device)
>          * Evaluate and parse _PRT, if exists.  This code allows parsing of
>          * _PRT objects within the scope of non-bridge devices.  Note that
>          * _PRTs within the scope of a PCI bridge assume the bridge's
> -        * subordinate bus number.
> +        * secondary bus number.
>          *
>          * TBD: Can _PRTs exist within the scope of non-bridge PCI devices?
>          */
> @@ -99,8 +99,8 @@ static int acpi_pci_bind(struct acpi_device *device)
>         if (ACPI_FAILURE(status))
>                 goto out;
>
> -       if (dev->subordinate)
> -               bus = dev->subordinate;
> +       if (dev->secondary)
> +               bus = dev->secondary;
>         else
>                 bus = dev->bus;
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index ec54014..5522602 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -356,13 +356,13 @@ struct pci_dev *acpi_get_pci_dev(acpi_handle handle)
>                 if (!pdev || hnd == handle)
>                         break;
>
> -               pbus = pdev->subordinate;
> +               pbus = pdev->secondary;
>                 pci_dev_put(pdev);
>
>                 /*
>                  * This function may be called for a non-PCI device that has a
>                  * PCI parent (eg. a disk under a PCI SATA controller).  In that
> -                * case pdev->subordinate will be NULL for the parent.
> +                * case pdev->secondary will be NULL for the parent.
>                  */
>                 if (!pbus) {
>                         dev_dbg(&pdev->dev, "Not a PCI-to-PCI bridge\n");
> diff --git a/drivers/acpi/pci_slot.c b/drivers/acpi/pci_slot.c
> index e50e31a..416009c 100644
> --- a/drivers/acpi/pci_slot.c
> +++ b/drivers/acpi/pci_slot.c
> @@ -211,14 +211,14 @@ walk_p2p_bridge(acpi_handle handle, u32 lvl, void *context, void **rv)
>         function = adr & 0xffff;
>
>         dev = pci_get_slot(pci_bus, PCI_DEVFN(device, function));
> -       if (!dev || !dev->subordinate)
> +       if (!dev || !dev->secondary)
>                 goto out;
>
> -       child_context.pci_bus = dev->subordinate;
> +       child_context.pci_bus = dev->secondary;
>         child_context.user_function = user_function;
>         child_context.root_handle = parent_context->root_handle;
>
> -       dbg("p2p bridge walk, pci_bus = %x\n", dev->subordinate->number);
> +       dbg("p2p bridge walk, pci_bus = %x\n", dev->secondary->number);
>         status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, (u32)1,
>                                      user_function, NULL, &child_context, NULL);
>         if (ACPI_FAILURE(status))
> diff --git a/drivers/infiniband/hw/mthca/mthca_reset.c b/drivers/infiniband/hw/mthca/mthca_reset.c
> index 4fa3534..9923902 100644
> --- a/drivers/infiniband/hw/mthca/mthca_reset.c
> +++ b/drivers/infiniband/hw/mthca/mthca_reset.c
> @@ -73,7 +73,7 @@ int mthca_reset(struct mthca_dev *mdev)
>                                                 mdev->pdev->device + 2,
>                                                 bridge)) != NULL) {
>                         if (bridge->hdr_type    == PCI_HEADER_TYPE_BRIDGE &&
> -                           bridge->subordinate == mdev->pdev->bus) {
> +                           bridge->secondary == mdev->pdev->bus) {
>                                 mthca_dbg(mdev, "Found bridge: %s\n",
>                                           pci_name(bridge));
>                                 break;
> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> index 86e2f4a..3bee7ea 100644
> --- a/drivers/iommu/dmar.c
> +++ b/drivers/iommu/dmar.c
> @@ -93,7 +93,7 @@ static int __init dmar_parse_one_dev_scope(struct acpi_dmar_device_scope *scope,
>                 }
>                 path ++;
>                 count --;
> -               bus = pdev->subordinate;
> +               bus = pdev->secondary;
>         }
>         if (!pdev) {
>                 pr_warn("Device scope device [%04x:%02x:%02x.%02x] not found\n",
> @@ -102,8 +102,8 @@ static int __init dmar_parse_one_dev_scope(struct acpi_dmar_device_scope *scope,
>                 return 0;
>         }
>         if ((scope->entry_type == ACPI_DMAR_SCOPE_TYPE_ENDPOINT && \
> -                       pdev->subordinate) || (scope->entry_type == \
> -                       ACPI_DMAR_SCOPE_TYPE_BRIDGE && !pdev->subordinate)) {
> +                       pdev->secondary) || (scope->entry_type == \
> +                       ACPI_DMAR_SCOPE_TYPE_BRIDGE && !pdev->secondary)) {
>                 pci_dev_put(pdev);
>                 pr_warn("Device scope type does not match for %s\n",
>                         pci_name(pdev));
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 7469b53..e333f99 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -659,9 +659,9 @@ static struct intel_iommu *device_to_iommu(int segment, u8 bus, u8 devfn)
>                             drhd->devices[i]->devfn == devfn)
>                                 return drhd->iommu;
>                         if (drhd->devices[i] &&
> -                           drhd->devices[i]->subordinate &&
> -                           drhd->devices[i]->subordinate->number <= bus &&
> -                           drhd->devices[i]->subordinate->busn_res.end >= bus)
> +                           drhd->devices[i]->secondary &&
> +                           drhd->devices[i]->secondary->number <= bus &&
> +                           drhd->devices[i]->secondary->busn_res.end >= bus)
>                                 return drhd->iommu;
>                 }
>
> @@ -1700,8 +1700,8 @@ domain_context_mapping(struct dmar_domain *domain, struct pci_dev *pdev,
>         }
>         if (pci_is_pcie(tmp)) /* this is a PCIe-to-PCI bridge */
>                 return domain_context_mapping_one(domain,
> -                                       pci_domain_nr(tmp->subordinate),
> -                                       tmp->subordinate->number, 0,
> +                                       pci_domain_nr(tmp->secondary),
> +                                       tmp->secondary->number, 0,
>                                         translation);
>         else /* this is a legacy PCI bridge */
>                 return domain_context_mapping_one(domain,
> @@ -1739,7 +1739,7 @@ static int domain_context_mapped(struct pci_dev *pdev)
>                 parent = parent->bus->self;
>         }
>         if (pci_is_pcie(tmp))
> -               return device_context_mapped(iommu, tmp->subordinate->number,
> +               return device_context_mapped(iommu, tmp->secondary->number,
>                                              0);
>         else
>                 return device_context_mapped(iommu, tmp->bus->number,
> @@ -1977,7 +1977,7 @@ static struct dmar_domain *get_domain_for_dev(struct pci_dev *pdev, int gaw)
>         dev_tmp = pci_find_upstream_pcie_bridge(pdev);
>         if (dev_tmp) {
>                 if (pci_is_pcie(dev_tmp)) {
> -                       bus = dev_tmp->subordinate->number;
> +                       bus = dev_tmp->secondary->number;
>                         devfn = 0;
>                 } else {
>                         bus = dev_tmp->bus->number;
> @@ -3710,7 +3710,7 @@ static void iommu_detach_dependent_devices(struct intel_iommu *iommu,
>                 }
>                 if (pci_is_pcie(tmp)) /* this is a PCIe-to-PCI bridge */
>                         iommu_detach_dev(iommu,
> -                               tmp->subordinate->number, 0);
> +                               tmp->secondary->number, 0);
>                 else /* this is a legacy PCI bridge */
>                         iommu_detach_dev(iommu, tmp->bus->number,
>                                          tmp->devfn);
> @@ -4118,7 +4118,7 @@ static int intel_iommu_add_device(struct device *dev)
>                 if (pci_is_pcie(bridge))
>                         dma_pdev = pci_get_domain_bus_and_slot(
>                                                 pci_domain_nr(pdev->bus),
> -                                               bridge->subordinate->number, 0);
> +                                               bridge->secondary->number, 0);
>                 else
>                         dma_pdev = pci_dev_get(bridge);
>         } else
> diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
> index bf906c5..65608a5 100644
> --- a/drivers/net/ethernet/broadcom/tg3.c
> +++ b/drivers/net/ethernet/broadcom/tg3.c
> @@ -14396,8 +14396,8 @@ static int __devinit tg3_get_invariants(struct tg3 *tp)
>                                 if (bridge->revision > pci_id->rev)
>                                         continue;
>                         }
> -                       if (bridge->subordinate &&
> -                           (bridge->subordinate->number ==
> +                       if (bridge->secondary &&
> +                           (bridge->secondary->number ==
>                              tp->pdev->bus->number)) {
>                                 tg3_flag_set(tp, ICH_WORKAROUND);
>                                 pci_dev_put(bridge);
> @@ -14426,10 +14426,10 @@ static int __devinit tg3_get_invariants(struct tg3 *tp)
>                                 pci_id++;
>                                 continue;
>                         }
> -                       if (bridge->subordinate &&
> -                           (bridge->subordinate->number <=
> +                       if (bridge->secondary &&
> +                           (bridge->secondary->number <=
>                              tp->pdev->bus->number) &&
> -                           (bridge->subordinate->busn_res.end >=
> +                           (bridge->secondary->busn_res.end >=
>                              tp->pdev->bus->number)) {
>                                 tg3_flag_set(tp, 5701_DMA_BUG);
>                                 pci_dev_put(bridge);
> @@ -14454,10 +14454,10 @@ static int __devinit tg3_get_invariants(struct tg3 *tp)
>                         bridge = pci_get_device(PCI_VENDOR_ID_SERVERWORKS,
>                                                 PCI_DEVICE_ID_SERVERWORKS_EPB,
>                                                 bridge);
> -                       if (bridge && bridge->subordinate &&
> -                           (bridge->subordinate->number <=
> +                       if (bridge && bridge->secondary &&
> +                           (bridge->secondary->number <=
>                              tp->pdev->bus->number) &&
> -                           (bridge->subordinate->busn_res.end >=
> +                           (bridge->secondary->busn_res.end >=
>                              tp->pdev->bus->number)) {
>                                 tg3_flag_set(tp, 40BIT_DMA_BUG);
>                                 pci_dev_put(bridge);
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 4b0970b..9f31b97 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -231,9 +231,9 @@ void pci_bus_add_devices(const struct pci_bus *bus)
>         list_for_each_entry(dev, &bus->devices, bus_list) {
>                 BUG_ON(!dev->is_added);
>
> -               child = dev->subordinate;
> +               child = dev->secondary;
>                 /*
> -                * If there is an unattached subordinate bus, attach
> +                * If there is an unattached secondary bus, attach
>                  * it and then scan for unattached PCI devices.
>                  */
>                 if (!child)
> @@ -263,14 +263,14 @@ void pci_enable_bridges(struct pci_bus *bus)
>         int retval;
>
>         list_for_each_entry(dev, &bus->devices, bus_list) {
> -               if (dev->subordinate) {
> +               if (dev->secondary) {
>                         if (!pci_is_enabled(dev)) {
>                                 retval = pci_enable_device(dev);
>                                 if (retval)
>                                         dev_err(&dev->dev, "Error enabling bridge (%d), continuing\n", retval);
>                                 pci_set_master(dev);
>                         }
> -                       pci_enable_bridges(dev->subordinate);
> +                       pci_enable_bridges(dev->secondary);
>                 }
>         }
>  }
> @@ -309,10 +309,10 @@ void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
>                         continue;
>                 }
>                 dev = list_entry(next, struct pci_dev, bus_list);
> -               if (dev->subordinate) {
> +               if (dev->secondary) {
>                         /* this is a pci-pci bridge, do its devices next */
> -                       next = dev->subordinate->devices.next;
> -                       bus = dev->subordinate;
> +                       next = dev->secondary->devices.next;
> +                       bus = dev->secondary;
>                 } else
>                         next = dev->bus_list.next;
>
> diff --git a/drivers/pci/hotplug-pci.c b/drivers/pci/hotplug-pci.c
> index 6258dc2..c1e99ce 100644
> --- a/drivers/pci/hotplug-pci.c
> +++ b/drivers/pci/hotplug-pci.c
> @@ -21,7 +21,7 @@ int __ref pci_hp_add_bridge(struct pci_dev *dev)
>         }
>         for (pass = 0; pass < 2; pass++)
>                 busnr = pci_scan_bridge(parent, dev, busnr, pass);
> -       if (!dev->subordinate)
> +       if (!dev->secondary)
>                 return -1;
>
>         return 0;
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index ad6fd66..f8501a2 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -35,7 +35,7 @@
>   *  - The one in acpiphp_bridge has its refcount elevated by pci_get_slot()
>   *    when the bridge is scanned and it loses a refcount when the bridge
>   *    is removed.
> - *  - When a P2P bridge is present, we elevate the refcount on the subordinate
> + *  - When a P2P bridge is present, we elevate the refcount on the secondary
>   *    bus. It loses the refcount when the the driver unloads.
>   */
>
> @@ -416,14 +416,14 @@ static void add_p2p_bridge(acpi_handle *handle)
>         config_p2p_bridge_flags(bridge);
>
>         bridge->pci_dev = acpi_get_pci_dev(handle);
> -       bridge->pci_bus = bridge->pci_dev->subordinate;
> +       bridge->pci_bus = bridge->pci_dev->secondary;
>         if (!bridge->pci_bus) {
>                 err("This is not a PCI-to-PCI bridge!\n");
>                 goto err;
>         }
>
>         /*
> -        * Grab a ref to the subordinate PCI bus in case the bus is
> +        * Grab a ref to the secondary PCI bus in case the bus is
>          * removed via PCI core logical hotplug. The ref pins the bus
>          * (which we access during module unload).
>          */
> @@ -446,7 +446,7 @@ find_p2p_bridge(acpi_handle handle, u32 lvl, void *context, void **rv)
>         struct pci_dev *dev;
>
>         dev = acpi_get_pci_dev(handle);
> -       if (!dev || !dev->subordinate)
> +       if (!dev || !dev->secondary)
>                 goto out;
>
>         /* check if this bridge has ejectable slots */
> @@ -689,9 +689,9 @@ static unsigned char acpiphp_max_busnr(struct pci_bus *bus)
>         /*
>          * pci_bus_max_busnr will return the highest
>          * reserved busnr for all these children.
> -        * that is equivalent to the bus->subordinate
> +        * that is equivalent to the bus->secondary
>          * value.  We don't want to use the parent's
> -        * bus->subordinate value because it could have
> +        * bus->secondary value because it could have
>          * padding in it.
>          */
>         max = bus->busn_res.start;
> @@ -817,8 +817,8 @@ static int __ref enable_device(struct acpiphp_slot *slot)
>                         if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
>                             dev->hdr_type == PCI_HEADER_TYPE_CARDBUS) {
>                                 max = pci_scan_bridge(bus, dev, max, pass);
> -                               if (pass && dev->subordinate)
> -                                       pci_bus_size_bridges(dev->subordinate);
> +                               if (pass && dev->secondary)
> +                                       pci_bus_size_bridges(dev->secondary);
>                         }
>                 }
>         }
> @@ -873,8 +873,8 @@ static void disable_bridges(struct pci_bus *bus)
>  {
>         struct pci_dev *dev;
>         list_for_each_entry(dev, &bus->devices, bus_list) {
> -               if (dev->subordinate) {
> -                       disable_bridges(dev->subordinate);
> +               if (dev->secondary) {
> +                       disable_bridges(dev->secondary);
>                         pci_disable_device(dev);
>                 }
>         }
> @@ -932,8 +932,8 @@ static int disable_device(struct acpiphp_slot *slot)
>          */
>         while ((pdev = dev_in_slot(slot))) {
>                 pci_stop_bus_device(pdev);
> -               if (pdev->subordinate) {
> -                       disable_bridges(pdev->subordinate);
> +               if (pdev->secondary) {
> +                       disable_bridges(pdev->secondary);
>                         pci_disable_device(pdev);
>                 }
>                 __pci_remove_bus_device(pdev);
> @@ -1109,7 +1109,7 @@ static int acpiphp_configure_bridge (acpi_handle handle)
>                 bus = root->bus;
>         } else {
>                 struct pci_dev *pdev = acpi_get_pci_dev(handle);
> -               bus = pdev->subordinate;
> +               bus = pdev->secondary;
>                 pci_dev_put(pdev);
>         }
>
> diff --git a/drivers/pci/hotplug/cpcihp_generic.c b/drivers/pci/hotplug/cpcihp_generic.c
> index 81af764..ce32f3b 100644
> --- a/drivers/pci/hotplug/cpcihp_generic.c
> +++ b/drivers/pci/hotplug/cpcihp_generic.c
> @@ -165,7 +165,7 @@ static int __init cpcihp_generic_init(void)
>                 pci_dev_put(dev);
>                 return -EINVAL;
>         }
> -       bus = dev->subordinate;
> +       bus = dev->secondary;
>         pci_dev_put(dev);
>
>         memset(&generic_hpc, 0, sizeof (struct cpci_hp_controller));
> diff --git a/drivers/pci/hotplug/cpcihp_zt5550.c b/drivers/pci/hotplug/cpcihp_zt5550.c
> index 6bf8d2a..4a721e3 100644
> --- a/drivers/pci/hotplug/cpcihp_zt5550.c
> +++ b/drivers/pci/hotplug/cpcihp_zt5550.c
> @@ -243,7 +243,7 @@ static int zt5550_hc_init_one (struct pci_dev *pdev, const struct pci_device_id
>                 status = -ENODEV;
>                 goto init_register_error;
>         }
> -       bus0 = bus0_dev->subordinate;
> +       bus0 = bus0_dev->secondary;
>         pci_dev_put(bus0_dev);
>
>         status = cpci_hp_register_bus(bus0, 0x0a, 0x0f);
> diff --git a/drivers/pci/hotplug/cpqphp_core.c b/drivers/pci/hotplug/cpqphp_core.c
> index c8eaeb4..d55a73a 100644
> --- a/drivers/pci/hotplug/cpqphp_core.c
> +++ b/drivers/pci/hotplug/cpqphp_core.c
> @@ -835,7 +835,7 @@ static int cpqhpc_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>                 return err;
>         }
>
> -       bus = pdev->subordinate;
> +       bus = pdev->secondary;
>         if (!bus) {
>                 dev_notice(&pdev->dev, "the device is not a bridge, "
>                                 "skipping\n");
> diff --git a/drivers/pci/hotplug/cpqphp_pci.c b/drivers/pci/hotplug/cpqphp_pci.c
> index 09801c6..eab5606 100644
> --- a/drivers/pci/hotplug/cpqphp_pci.c
> +++ b/drivers/pci/hotplug/cpqphp_pci.c
> @@ -106,7 +106,7 @@ int cpqhp_configure_device (struct controller* ctrl, struct pci_func* func)
>
>         if (func->pci_dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
>                 pci_hp_add_bridge(func->pci_dev);
> -               child = func->pci_dev->subordinate;
> +               child = func->pci_dev->secondary;
>                 if (child)
>                         pci_bus_add_devices(child);
>         }
> diff --git a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
> index cbd72d8..c5de318 100644
> --- a/drivers/pci/hotplug/ibmphp_core.c
> +++ b/drivers/pci/hotplug/ibmphp_core.c
> @@ -805,7 +805,7 @@ static int ibm_configure_device(struct pci_func *func)
>         }
>         if (!(flag) && (func->dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)) {
>                 pci_hp_add_bridge(func->dev);
> -               child = func->dev->subordinate;
> +               child = func->dev->secondary;
>                 if (child)
>                         pci_bus_add_devices(child);
>         }
> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
> index 365c6b9..0659e05 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -128,10 +128,10 @@ static int init_slot(struct controller *ctrl)
>         snprintf(name, SLOT_NAME_SIZE, "%u", PSN(ctrl));
>
>         ctrl_dbg(ctrl, "Registering domain:bus:dev=%04x:%02x:00 sun=%x\n",
> -                pci_domain_nr(ctrl->pcie->port->subordinate),
> -                ctrl->pcie->port->subordinate->number, PSN(ctrl));
> +                pci_domain_nr(ctrl->pcie->port->secondary),
> +                ctrl->pcie->port->secondary->number, PSN(ctrl));
>         retval = pci_hp_register(hotplug,
> -                                ctrl->pcie->port->subordinate, 0, name);
> +                                ctrl->pcie->port->secondary, 0, name);
>         if (retval)
>                 ctrl_err(ctrl,
>                          "pci_hp_register failed with error %d\n", retval);
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index 27f4429..4ff1817 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -194,7 +194,7 @@ static int board_added(struct slot *p_slot)
>  {
>         int retval = 0;
>         struct controller *ctrl = p_slot->ctrl;
> -       struct pci_bus *parent = ctrl->pcie->port->subordinate;
> +       struct pci_bus *parent = ctrl->pcie->port->secondary;
>
>         if (POWER_CTRL(ctrl)) {
>                 /* Power on slot */
> @@ -297,8 +297,8 @@ static void pciehp_power_thread(struct work_struct *work)
>                 mutex_unlock(&p_slot->lock);
>                 ctrl_dbg(p_slot->ctrl,
>                          "Disabling domain:bus:device=%04x:%02x:00\n",
> -                        pci_domain_nr(p_slot->ctrl->pcie->port->subordinate),
> -                        p_slot->ctrl->pcie->port->subordinate->number);
> +                        pci_domain_nr(p_slot->ctrl->pcie->port->secondary),
> +                        p_slot->ctrl->pcie->port->secondary->number);
>                 pciehp_disable_slot(p_slot);
>                 mutex_lock(&p_slot->lock);
>                 p_slot->state = STATIC_STATE;
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 302451e..ee5baae 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -327,7 +327,7 @@ int pciehp_check_link_status(struct controller *ctrl)
>
>         /* wait 100ms before read pci conf, and try in 1s */
>         msleep(100);
> -       found = pci_bus_check_dev(ctrl->pcie->port->subordinate,
> +       found = pci_bus_check_dev(ctrl->pcie->port->secondary,
>                                         PCI_DEVFN(0, 0));
>
>         retval = pciehp_readw(ctrl, PCI_EXP_LNKSTA, &lnk_status);
> @@ -344,7 +344,7 @@ int pciehp_check_link_status(struct controller *ctrl)
>                 return retval;
>         }
>
> -       pcie_update_link_speed(ctrl->pcie->port->subordinate, lnk_status);
> +       pcie_update_link_speed(ctrl->pcie->port->secondary, lnk_status);
>
>         if (!found && !retval)
>                 retval = -1;
> diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
> index 09cecaf..2dd0a51 100644
> --- a/drivers/pci/hotplug/pciehp_pci.c
> +++ b/drivers/pci/hotplug/pciehp_pci.c
> @@ -38,7 +38,7 @@ int pciehp_configure_device(struct slot *p_slot)
>  {
>         struct pci_dev *dev;
>         struct pci_dev *bridge = p_slot->ctrl->pcie->port;
> -       struct pci_bus *parent = bridge->subordinate;
> +       struct pci_bus *parent = bridge->secondary;
>         int num, fn;
>         struct controller *ctrl = p_slot->ctrl;
>
> @@ -92,7 +92,7 @@ int pciehp_unconfigure_device(struct slot *p_slot)
>         int j;
>         u8 bctl = 0;
>         u8 presence = 0;
> -       struct pci_bus *parent = p_slot->ctrl->pcie->port->subordinate;
> +       struct pci_bus *parent = p_slot->ctrl->pcie->port->secondary;
>         u16 command;
>         struct controller *ctrl = p_slot->ctrl;
>
> diff --git a/drivers/pci/hotplug/pcihp_slot.c b/drivers/pci/hotplug/pcihp_slot.c
> index 8c05a18..4189a59 100644
> --- a/drivers/pci/hotplug/pcihp_slot.c
> +++ b/drivers/pci/hotplug/pcihp_slot.c
> @@ -119,7 +119,7 @@ static void program_hpp_type2(struct pci_dev *dev, struct hpp_type2 *hpp)
>         pci_write_config_word(dev, pos + PCI_EXP_DEVCTL, reg16);
>
>         /* Initialize Link Control Register */
> -       if (dev->subordinate) {
> +       if (dev->secondary) {
>                 pci_read_config_word(dev, pos + PCI_EXP_LNKCTL, &reg16);
>                 reg16 = (reg16 & hpp->pci_exp_lnkctl_and)
>                         | hpp->pci_exp_lnkctl_or;
> @@ -183,8 +183,8 @@ void pci_configure_slot(struct pci_dev *dev)
>         program_hpp_type1(dev, hpp.t1);
>         program_hpp_type0(dev, hpp.t0);
>
> -       if (dev->subordinate) {
> -               list_for_each_entry(cdev, &dev->subordinate->devices,
> +       if (dev->secondary) {
> +               list_for_each_entry(cdev, &dev->secondary->devices,
>                                     bus_list)
>                         pci_configure_slot(cdev);
>         }
> diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
> index 1e117c2..8e0a84e 100644
> --- a/drivers/pci/hotplug/rpadlpar_core.c
> +++ b/drivers/pci/hotplug/rpadlpar_core.c
> @@ -161,8 +161,8 @@ static void dlpar_pci_add_bus(struct device_node *dn)
>             dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
>                 of_scan_pci_bridge(dev);
>
> -       /* Map IO space for child bus, which may or may not succeed */
> -       pcibios_map_io_space(dev->subordinate);
> +       /* Map IO space for secondary bus, which may or may not succeed */
> +       pcibios_map_io_space(dev->secondary);
>
>         /* Finish adding it : resource allocation, adding devices, etc...
>          * Note that we need to perform the finish pass on the -parent-
> diff --git a/drivers/pci/hotplug/sgi_hotplug.c b/drivers/pci/hotplug/sgi_hotplug.c
> index f64ca92..ad52c37 100644
> --- a/drivers/pci/hotplug/sgi_hotplug.c
> +++ b/drivers/pci/hotplug/sgi_hotplug.c
> @@ -208,13 +208,13 @@ static struct hotplug_slot * sn_hp_destroy(void)
>
>  static void sn_bus_free_data(struct pci_dev *dev)
>  {
> -       struct pci_bus *subordinate_bus;
> +       struct pci_bus *secondary_bus;
>         struct pci_dev *child;
>
>         /* Recursively clean up sn_irq_info structs */
> -       if (dev->subordinate) {
> -               subordinate_bus = dev->subordinate;
> -               list_for_each_entry(child, &subordinate_bus->devices, bus_list)
> +       if (dev->secondary) {
> +               secondary_bus = dev->secondary;
> +               list_for_each_entry(child, &secondary_bus->devices, bus_list)
>                         sn_bus_free_data(child);
>         }
>         /*
> @@ -398,8 +398,8 @@ static int enable_slot(struct hotplug_slot *bss_hotplug_slot)
>                                 sn_io_slot_fixup(dev);
>                         if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
>                                 pci_hp_add_bridge(dev);
> -                               if (dev->subordinate) {
> -                                       new_bus = dev->subordinate;
> +                               if (dev->secondary) {
> +                                       new_bus = dev->secondary;
>                                         new_ppb = 1;
>                                 }
>                         }
> @@ -466,7 +466,7 @@ static int enable_slot(struct hotplug_slot *bss_hotplug_slot)
>
>         /* Call the driver for the new device */
>         pci_bus_add_devices(slot->pci_bus);
> -       /* Call the drivers for the new devices subordinate to PPB */
> +       /* Call the drivers for the new devices on the PPB secondary bus */
>         if (new_ppb)
>                 pci_bus_add_devices(new_bus);
>
> diff --git a/drivers/pci/hotplug/shpchp_core.c b/drivers/pci/hotplug/shpchp_core.c
> index b6de307..730b8e6 100644
> --- a/drivers/pci/hotplug/shpchp_core.c
> +++ b/drivers/pci/hotplug/shpchp_core.c
> @@ -125,7 +125,7 @@ static int init_slots(struct controller *ctrl)
>
>                 slot->hp_slot = i;
>                 slot->ctrl = ctrl;
> -               slot->bus = ctrl->pci_dev->subordinate->number;
> +               slot->bus = ctrl->pci_dev->secondary->number;
>                 slot->device = ctrl->slot_device_offset + i;
>                 slot->hpc_ops = ctrl->hpc_ops;
>                 slot->number = ctrl->first_slot + (ctrl->slot_num_inc * i);
> @@ -140,11 +140,11 @@ static int init_slots(struct controller *ctrl)
>
>                 ctrl_dbg(ctrl, "Registering domain:bus:dev=%04x:%02x:%02x "
>                          "hp_slot=%x sun=%x slot_device_offset=%x\n",
> -                        pci_domain_nr(ctrl->pci_dev->subordinate),
> +                        pci_domain_nr(ctrl->pci_dev->secondary),
>                          slot->bus, slot->device, slot->hp_slot, slot->number,
>                          ctrl->slot_device_offset);
>                 retval = pci_hp_register(slot->hotplug_slot,
> -                               ctrl->pci_dev->subordinate, slot->device, name);
> +                               ctrl->pci_dev->secondary, slot->device, name);
>                 if (retval) {
>                         ctrl_err(ctrl, "pci_hp_register failed with error %d\n",
>                                  retval);
> diff --git a/drivers/pci/hotplug/shpchp_ctrl.c b/drivers/pci/hotplug/shpchp_ctrl.c
> index f9b5a52..e5539a0 100644
> --- a/drivers/pci/hotplug/shpchp_ctrl.c
> +++ b/drivers/pci/hotplug/shpchp_ctrl.c
> @@ -246,7 +246,7 @@ static int board_added(struct slot *p_slot)
>         int rc = 0;
>         enum pci_bus_speed asp, bsp, msp;
>         struct controller *ctrl = p_slot->ctrl;
> -       struct pci_bus *parent = ctrl->pci_dev->subordinate;
> +       struct pci_bus *parent = ctrl->pci_dev->secondary;
>
>         hp_slot = p_slot->device - ctrl->slot_device_offset;
>
> @@ -286,7 +286,7 @@ static int board_added(struct slot *p_slot)
>         msp = ctrl->pci_dev->bus->max_bus_speed;
>
>         /* Check if there are other slots or devices on the same bus */
> -       if (!list_empty(&ctrl->pci_dev->subordinate->devices))
> +       if (!list_empty(&ctrl->pci_dev->secondary->devices))
>                 slots_not_empty = 1;
>
>         ctrl_dbg(ctrl, "%s: slots_not_empty %d, adapter_speed %d, bus_speed %d,"
> diff --git a/drivers/pci/hotplug/shpchp_hpc.c b/drivers/pci/hotplug/shpchp_hpc.c
> index 75ba231..a61fad0 100644
> --- a/drivers/pci/hotplug/shpchp_hpc.c
> +++ b/drivers/pci/hotplug/shpchp_hpc.c
> @@ -654,7 +654,7 @@ static int hpc_slot_disable(struct slot * slot)
>  static int shpc_get_cur_bus_speed(struct controller *ctrl)
>  {
>         int retval = 0;
> -       struct pci_bus *bus = ctrl->pci_dev->subordinate;
> +       struct pci_bus *bus = ctrl->pci_dev->secondary;
>         enum pci_bus_speed bus_speed = PCI_SPEED_UNKNOWN;
>         u16 sec_bus_reg = shpc_readw(ctrl, SEC_BUS_CONFIG);
>         u8 pi = shpc_readb(ctrl, PROG_INTERFACE);
> @@ -868,7 +868,7 @@ static irqreturn_t shpc_isr(int irq, void *dev_id)
>  static int shpc_get_max_bus_speed(struct controller *ctrl)
>  {
>         int retval = 0;
> -       struct pci_bus *bus = ctrl->pci_dev->subordinate;
> +       struct pci_bus *bus = ctrl->pci_dev->secondary;
>         enum pci_bus_speed bus_speed = PCI_SPEED_UNKNOWN;
>         u8 pi = shpc_readb(ctrl, PROG_INTERFACE);
>         u32 slot_avail1 = shpc_readl(ctrl, SLOT_AVAIL1);
> diff --git a/drivers/pci/hotplug/shpchp_pci.c b/drivers/pci/hotplug/shpchp_pci.c
> index c627ed9..33d416d 100644
> --- a/drivers/pci/hotplug/shpchp_pci.c
> +++ b/drivers/pci/hotplug/shpchp_pci.c
> @@ -39,7 +39,7 @@ int __ref shpchp_configure_device(struct slot *p_slot)
>         struct pci_dev *dev;
>         struct controller *ctrl = p_slot->ctrl;
>         struct pci_dev *bridge = ctrl->pci_dev;
> -       struct pci_bus *parent = bridge->subordinate;
> +       struct pci_bus *parent = bridge->secondary;
>         int num, fn;
>
>         dev = pci_get_slot(parent, PCI_DEVFN(p_slot->device, 0));
> @@ -87,7 +87,7 @@ int shpchp_unconfigure_device(struct slot *p_slot)
>         int rc = 0;
>         int j;
>         u8 bctl = 0;
> -       struct pci_bus *parent = p_slot->ctrl->pci_dev->subordinate;
> +       struct pci_bus *parent = p_slot->ctrl->pci_dev->secondary;
>         struct controller *ctrl = p_slot->ctrl;
>
>         ctrl_dbg(ctrl, "%s: domain:bus:dev = %04x:%02x:%02x\n",
> diff --git a/drivers/pci/hotplug/shpchp_sysfs.c b/drivers/pci/hotplug/shpchp_sysfs.c
> index eeb23ce..71251a2 100644
> --- a/drivers/pci/hotplug/shpchp_sysfs.c
> +++ b/drivers/pci/hotplug/shpchp_sysfs.c
> @@ -44,7 +44,7 @@ static ssize_t show_ctrl (struct device *dev, struct device_attribute *attr, cha
>         struct pci_bus *bus;
>
>         pdev = container_of (dev, struct pci_dev, dev);
> -       bus = pdev->subordinate;
> +       bus = pdev->secondary;
>
>         out += sprintf(buf, "Free resources: memory\n");
>         pci_bus_for_each_resource(bus, res, index) {
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index fbf7b26..a091c1e 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -63,8 +63,8 @@ static void pci_acpi_wake_dev(acpi_handle handle, u32 event, void *context)
>                 pm_runtime_resume(&pci_dev->dev);
>         }
>
> -       if (pci_dev->subordinate)
> -               pci_pme_wakeup_bus(pci_dev->subordinate);
> +       if (pci_dev->secondary)
> +               pci_pme_wakeup_bus(pci_dev->secondary);
>  }
>
>  /**
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 6869009..2294faf 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -155,7 +155,7 @@ resource_show(struct device * dev, struct device_attribute *attr, char * buf)
>         int max;
>         resource_size_t start, end;
>
> -       if (pci_dev->subordinate)
> +       if (pci_dev->secondary)
>                 max = DEVICE_COUNT_RESOURCE;
>         else
>                 max = PCI_BRIDGE_RESOURCES;
> @@ -245,11 +245,11 @@ msi_bus_show(struct device *dev, struct device_attribute *attr, char *buf)
>  {
>         struct pci_dev *pdev = to_pci_dev(dev);
>
> -       if (!pdev->subordinate)
> +       if (!pdev->secondary)
>                 return 0;
>
>         return sprintf (buf, "%u\n",
> -                       !(pdev->subordinate->bus_flags & PCI_BUS_FLAGS_NO_MSI));
> +                       !(pdev->secondary->bus_flags & PCI_BUS_FLAGS_NO_MSI));
>  }
>
>  static ssize_t
> @@ -267,17 +267,17 @@ msi_bus_store(struct device *dev, struct device_attribute *attr,
>         if (!capable(CAP_SYS_ADMIN))
>                 return -EPERM;
>
> -       /* Maybe pci devices without subordinate busses shouldn't even have this
> +       /* Maybe pci devices without secondary busses shouldn't even have this
>          * attribute in the first place?  */
> -       if (!pdev->subordinate)
> +       if (!pdev->secondary)
>                 return count;
>
>         /* Is the flag going to change, or keep the value it already had? */
> -       if (!(pdev->subordinate->bus_flags & PCI_BUS_FLAGS_NO_MSI) ^
> +       if (!(pdev->secondary->bus_flags & PCI_BUS_FLAGS_NO_MSI) ^
>             !!val) {
> -               pdev->subordinate->bus_flags ^= PCI_BUS_FLAGS_NO_MSI;
> +               pdev->secondary->bus_flags ^= PCI_BUS_FLAGS_NO_MSI;
>
> -               dev_warn(&pdev->dev, "forced subordinate bus to%s support MSI,"
> +               dev_warn(&pdev->dev, "forced secondary bus to%s support MSI,"
>                          " bad things could happen\n", val ? "" : " not");
>         }
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index f3ea977..8ee7a10 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -700,7 +700,7 @@ static void __pci_start_power_transition(struct pci_dev *dev, pci_power_t state)
>                          * D0uninitialized state, resume them to give
>                          * them a chance to suspend again
>                          */
> -                       pci_wakeup_bus(dev->subordinate);
> +                       pci_wakeup_bus(dev->secondary);
>                 }
>         }
>  }
> @@ -745,7 +745,7 @@ int __pci_complete_power_transition(struct pci_dev *dev, pci_power_t state)
>         ret = pci_platform_power_transition(dev, state);
>         /* Power off the bridge may power off the whole hierarchy */
>         if (!ret && state == PCI_D3cold)
> -               __pci_bus_set_current_state(dev->subordinate, PCI_D3cold);
> +               __pci_bus_set_current_state(dev->secondary, PCI_D3cold);
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(__pci_complete_power_transition);
> @@ -1589,8 +1589,8 @@ static void pci_pme_list_scan(struct work_struct *work)
>                                 bridge = pme_dev->dev->bus->self;
>                                 /*
>                                  * If bridge is in low power state, the
> -                                * configuration space of subordinate devices
> -                                * may be not accessible
> +                                * configuration space of devices on the
> +                                * secondary bus may be not accessible
>                                  */
>                                 if (bridge && bridge->current_state != PCI_D0)
>                                         continue;
> @@ -3302,7 +3302,7 @@ static int pci_parent_bus_reset(struct pci_dev *dev, int probe)
>         u16 ctrl;
>         struct pci_dev *pdev;
>
> -       if (pci_is_root_bus(dev->bus) || dev->subordinate || !dev->bus->self)
> +       if (pci_is_root_bus(dev->bus) || dev->secondary || !dev->bus->self)
>                 return -ENOTTY;
>
>         list_for_each_entry(pdev, &dev->bus->devices, bus_list)
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index bacbcba..9a35426 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -85,7 +85,7 @@ static inline void pci_wakeup_event(struct pci_dev *dev)
>
>  static inline bool pci_is_bridge(struct pci_dev *pci_dev)
>  {
> -       return !!(pci_dev->subordinate);
> +       return !!(pci_dev->secondary);
>  }
>
>  struct pci_vpd_ops {
> diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
> index 58ad791..a475d61 100644
> --- a/drivers/pci/pcie/aer/aerdrv.c
> +++ b/drivers/pci/pcie/aer/aerdrv.c
> @@ -107,9 +107,9 @@ static void set_downstream_devices_error_reporting(struct pci_dev *dev,
>  {
>         set_device_error_reporting(dev, &enable);
>
> -       if (!dev->subordinate)
> +       if (!dev->secondary)
>                 return;
> -       pci_walk_bus(dev->subordinate, set_device_error_reporting, &enable);
> +       pci_walk_bus(dev->secondary, set_device_error_reporting, &enable);
>  }
>
>  /**
> diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
> index 0ca0535..81f1eda 100644
> --- a/drivers/pci/pcie/aer/aerdrv_core.c
> +++ b/drivers/pci/pcie/aer/aerdrv_core.c
> @@ -226,7 +226,7 @@ static bool find_source_device(struct pci_dev *parent,
>         if (result)
>                 return true;
>
> -       pci_walk_bus(parent->subordinate, find_device_iter, e_info);
> +       pci_walk_bus(parent->secondary, find_device_iter, e_info);
>
>         if (!e_info->error_dev_num) {
>                 dev_printk(KERN_DEBUG, &parent->dev,
> @@ -352,12 +352,13 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
>                 /*
>                  * If the error is reported by a bridge, we think this error
>                  * is related to the downstream link of the bridge, so we
> -                * do error recovery on all subordinates of the bridge instead
> -                * of the bridge and clear the error status of the bridge.
> +                * do error recovery on all secondary busses of the bridge
> +                * instead of the bridge and clear the error status of the
> +                * bridge.
>                  */
>                 if (cb == report_error_detected)
>                         dev->error_state = state;
> -               pci_walk_bus(dev->subordinate, cb, &result_data);
> +               pci_walk_bus(dev->secondary, cb, &result_data);
>                 if (cb == report_resume) {
>                         pci_cleanup_aer_uncorrect_error_status(dev);
>                         dev->error_state = pci_channel_io_normal;
> @@ -453,7 +454,7 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
>         struct pcie_port_service_driver *driver;
>
>         if (dev->hdr_type & PCI_HEADER_TYPE_BRIDGE) {
> -               /* Reset this port for all subordinates */
> +               /* Reset this port for all secondary busses */
>                 udev = dev;
>         } else {
>                 /* Reset the upstream component (likely downstream port) */
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index b500840..a2ed860 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -128,7 +128,7 @@ static void pcie_set_clkpm_nocheck(struct pcie_link_state *link, int enable)
>         int pos;
>         u16 reg16;
>         struct pci_dev *child;
> -       struct pci_bus *linkbus = link->pdev->subordinate;
> +       struct pci_bus *linkbus = link->pdev->secondary;
>
>         list_for_each_entry(child, &linkbus->devices, bus_list) {
>                 pos = pci_pcie_cap(child);
> @@ -161,7 +161,7 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
>         u32 reg32;
>         u16 reg16;
>         struct pci_dev *child;
> -       struct pci_bus *linkbus = link->pdev->subordinate;
> +       struct pci_bus *linkbus = link->pdev->secondary;
>
>         /* All functions should have the same cap and state, take the worst */
>         list_for_each_entry(child, &linkbus->devices, bus_list) {
> @@ -194,7 +194,7 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
>         u16 reg16, parent_reg, child_reg[8];
>         unsigned long start_jiffies;
>         struct pci_dev *child, *parent = link->pdev;
> -       struct pci_bus *linkbus = parent->subordinate;
> +       struct pci_bus *linkbus = parent->secondary;
>         /*
>          * All functions of a slot should have the same Slot Clock
>          * Configuration, so just check one function
> @@ -360,7 +360,7 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
>  static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>  {
>         struct pci_dev *child, *parent = link->pdev;
> -       struct pci_bus *linkbus = parent->subordinate;
> +       struct pci_bus *linkbus = parent->secondary;
>         struct aspm_register_info upreg, dwreg;
>
>         if (blacklist) {
> @@ -457,7 +457,7 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
>  {
>         u32 upstream = 0, dwstream = 0;
>         struct pci_dev *child, *parent = link->pdev;
> -       struct pci_bus *linkbus = parent->subordinate;
> +       struct pci_bus *linkbus = parent->secondary;
>
>         /* Nothing to do if the link is already in the requested state */
>         state &= (link->aspm_capable & ~link->aspm_disable);
> @@ -512,7 +512,7 @@ static int pcie_aspm_sanity_check(struct pci_dev *pdev)
>          * Some functions in a slot might not all be PCIe functions,
>          * very strange. Disable ASPM for the whole slot
>          */
> -       list_for_each_entry(child, &pdev->subordinate->devices, bus_list) {
> +       list_for_each_entry(child, &pdev->secondary->devices, bus_list) {
>                 pos = pci_pcie_cap(child);
>                 if (!pos)
>                         return -EINVAL;
> @@ -595,7 +595,7 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
>                 return;
>
>         down_read(&pci_bus_sem);
> -       if (list_empty(&pdev->subordinate->devices))
> +       if (list_empty(&pdev->secondary->devices))
>                 goto out;
>
>         mutex_lock(&aspm_lock);
> @@ -643,7 +643,7 @@ static void pcie_update_aspm_capable(struct pcie_link_state *root)
>         }
>         list_for_each_entry(link, &link_list, sibling) {
>                 struct pci_dev *child;
> -               struct pci_bus *linkbus = link->pdev->subordinate;
> +               struct pci_bus *linkbus = link->pdev->secondary;
>                 if (link->root != root)
>                         continue;
>                 list_for_each_entry(child, &linkbus->devices, bus_list) {
> @@ -673,7 +673,7 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
>          * All PCIe functions are in one slot, remove one function will remove
>          * the whole slot, so just wait until we are the last function left.
>          */
> -       if (!list_is_last(&pdev->bus_list, &parent->subordinate->devices))
> +       if (!list_is_last(&pdev->bus_list, &parent->secondary->devices))
>                 goto out;
>
>         link = parent->link_state;
> diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
> index 001f1b7..6fa9852 100644
> --- a/drivers/pci/pcie/pme.c
> +++ b/drivers/pci/pcie/pme.c
> @@ -92,7 +92,7 @@ static bool pcie_pme_walk_bus(struct pci_bus *bus)
>                         ret = true;
>                 }
>
> -               if (dev->subordinate && pcie_pme_walk_bus(dev->subordinate))
> +               if (dev->secondary && pcie_pme_walk_bus(dev->secondary))
>                         ret = true;
>         }
>
> @@ -161,7 +161,7 @@ static void pcie_pme_handle_request(struct pci_dev *port, u16 req_id)
>                          * Specification, Rev. 2.0, Section 6.1.9).
>                          */
>                         down_read(&pci_bus_sem);
> -                       found = pcie_pme_walk_bus(port->subordinate);
> +                       found = pcie_pme_walk_bus(port->secondary);
>                         up_read(&pci_bus_sem);
>                 }
>                 goto out;
> @@ -328,8 +328,8 @@ static int pcie_pme_set_native(struct pci_dev *dev, void *ign)
>  static void pcie_pme_mark_devices(struct pci_dev *port)
>  {
>         pcie_pme_set_native(port, NULL);
> -       if (port->subordinate) {
> -               pci_walk_bus(port->subordinate, pcie_pme_set_native, NULL);
> +       if (port->secondary) {
> +               pci_walk_bus(port->secondary, pcie_pme_set_native, NULL);
>         } else {
>                 struct pci_bus *bus = port->bus;
>                 struct pci_dev *dev;
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index 3a7eefc..963dc8d 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -126,11 +126,11 @@ static int pcie_port_runtime_suspend(struct device *dev)
>         };
>
>         /*
> -        * If any subordinate device disable D3cold, we should not put
> +        * If any secondary bus device disables D3cold, we should not put
>          * the port into D3cold.  The D3cold delay of port should be
> -        * the max of that of all subordinate devices.
> +        * the max of that of all devices on the secondary bus.
>          */
> -       pci_walk_bus(pdev->subordinate, pci_dev_d3cold_info, &d3cold_info);
> +       pci_walk_bus(pdev->secondary, pci_dev_d3cold_info, &d3cold_info);
>         pdev->no_d3cold = d3cold_info.no_d3cold;
>         pdev->d3cold_delay = d3cold_info.d3cold_delay;
>         return 0;
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 6c143b4..96b069c 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -658,7 +658,7 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
>                 child->resource[i] = &bridge->resource[PCI_BRIDGE_RESOURCES+i];
>                 child->resource[i]->name = child->name;
>         }
> -       bridge->subordinate = child;
> +       bridge->secondary = child;
>
>         return child;
>  }
> @@ -1887,7 +1887,7 @@ EXPORT_SYMBOL(pci_scan_bus);
>  unsigned int __ref pci_rescan_bus_bridge_resize(struct pci_dev *bridge)
>  {
>         unsigned int max;
> -       struct pci_bus *bus = bridge->subordinate;
> +       struct pci_bus *bus = bridge->secondary;
>
>         max = pci_scan_child_bus(bus);
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 5155317..06680ca 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -713,7 +713,7 @@ static void __devinit quirk_xio2000a(struct pci_dev *dev)
>
>         dev_warn(&dev->dev, "TI XIO2000a quirk detected; "
>                 "secondary bus fast back-to-back transfers disabled\n");
> -       list_for_each_entry(pdev, &dev->subordinate->devices, bus_list) {
> +       list_for_each_entry(pdev, &dev->secondary->devices, bus_list) {
>                 pci_read_config_word(pdev, PCI_COMMAND, &command);
>                 if (command & PCI_COMMAND_FAST_BACK)
>                         pci_write_config_word(pdev, PCI_COMMAND, command & ~PCI_COMMAND_FAST_BACK);
> @@ -803,10 +803,10 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI, PCI_ANY_ID,                     quirk_ioapic_rmw);
>   */
>  static void __devinit quirk_amd_8131_mmrbc(struct pci_dev *dev)
>  {
> -       if (dev->subordinate && dev->revision <= 0x12) {
> +       if (dev->secondary && dev->revision <= 0x12) {
>                 dev_info(&dev->dev, "AMD8131 rev %x detected; "
>                         "disabling PCI-X MMRBC\n", dev->revision);
> -               dev->subordinate->bus_flags |= PCI_BUS_FLAGS_NO_MMRBC;
> +               dev->secondary->bus_flags |= PCI_BUS_FLAGS_NO_MMRBC;
>         }
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8131_BRIDGE, quirk_amd_8131_mmrbc);
> @@ -2148,10 +2148,9 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8380_0, quirk_disab
>  /* Disable MSI on chipsets that are known to not support it */
>  static void __devinit quirk_disable_msi(struct pci_dev *dev)
>  {
> -       if (dev->subordinate) {
> -               dev_warn(&dev->dev, "MSI quirk detected; "
> -                       "subordinate MSI disabled\n");
> -               dev->subordinate->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
> +       if (dev->secondary) {
> +               dev_warn(&dev->dev, "MSI quirk detected; secondary bus MSI disabled\n");
> +               dev->secondary->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
>         }
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8131_BRIDGE, quirk_disable_msi);
> @@ -2206,10 +2205,9 @@ static int msi_ht_cap_enabled(struct pci_dev *dev)
>  /* Check the hypertransport MSI mapping to know whether MSI is enabled or not */
>  static void quirk_msi_ht_cap(struct pci_dev *dev)
>  {
> -       if (dev->subordinate && !msi_ht_cap_enabled(dev)) {
> -               dev_warn(&dev->dev, "MSI quirk detected; "
> -                       "subordinate MSI disabled\n");
> -               dev->subordinate->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
> +       if (dev->secondary && !msi_ht_cap_enabled(dev)) {
> +               dev_warn(&dev->dev, "MSI quirk detected; secondary bus MSI disabled\n");
> +               dev->secondary->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
>         }
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_HT2000_PCIE,
> @@ -2222,7 +2220,7 @@ static void quirk_nvidia_ck804_msi_ht_cap(struct pci_dev *dev)
>  {
>         struct pci_dev *pdev;
>
> -       if (!dev->subordinate)
> +       if (!dev->secondary)
>                 return;
>
>         /* check HT MSI cap on this chipset and the root one.
> @@ -2232,9 +2230,8 @@ static void quirk_nvidia_ck804_msi_ht_cap(struct pci_dev *dev)
>         if (!pdev)
>                 return;
>         if (!msi_ht_cap_enabled(dev) && !msi_ht_cap_enabled(pdev)) {
> -               dev_warn(&dev->dev, "MSI quirk detected; "
> -                       "subordinate MSI disabled\n");
> -               dev->subordinate->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
> +               dev_warn(&dev->dev, "MSI quirk detected; secondary bus MSI disabled\n");
> +               dev->secondary->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
>         }
>         pci_dev_put(pdev);
>  }
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index 04a4861..7cadc71 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -84,7 +84,7 @@ static void __pci_remove_behind_bridge(struct pci_dev *dev);
>   * @dev: the device to remove
>   *
>   * Remove a PCI device from the device lists, informing the drivers
> - * that the device has been removed.  We also remove any subordinate
> + * that the device has been removed.  We also remove any secondary
>   * buses and children in a depth-first manner.
>   *
>   * For each device we remove, delete the device structure from the
> @@ -93,12 +93,12 @@ static void __pci_remove_behind_bridge(struct pci_dev *dev);
>   */
>  void __pci_remove_bus_device(struct pci_dev *dev)
>  {
> -       if (dev->subordinate) {
> -               struct pci_bus *b = dev->subordinate;
> +       if (dev->secondary) {
> +               struct pci_bus *b = dev->secondary;
>
>                 __pci_remove_behind_bridge(dev);
>                 pci_remove_bus(b);
> -               dev->subordinate = NULL;
> +               dev->secondary = NULL;
>         }
>
>         pci_destroy_dev(dev);
> @@ -115,8 +115,8 @@ static void __pci_remove_behind_bridge(struct pci_dev *dev)
>  {
>         struct list_head *l, *n;
>
> -       if (dev->subordinate)
> -               list_for_each_safe(l, n, &dev->subordinate->devices)
> +       if (dev->secondary)
> +               list_for_each_safe(l, n, &dev->secondary->devices)
>                         __pci_remove_bus_device(pci_dev_b(l));
>  }
>
> @@ -124,8 +124,8 @@ static void pci_stop_behind_bridge(struct pci_dev *dev)
>  {
>         struct list_head *l, *n;
>
> -       if (dev->subordinate)
> -               list_for_each_safe(l, n, &dev->subordinate->devices)
> +       if (dev->secondary)
> +               list_for_each_safe(l, n, &dev->secondary->devices)
>                         pci_stop_bus_device(pci_dev_b(l));
>  }
>
> @@ -167,13 +167,13 @@ static void pci_stop_bus_devices(struct pci_bus *bus)
>   * @dev: the device to stop
>   *
>   * Stop a PCI device (detach the driver, remove from the global list
> - * and so on). This also stop any subordinate buses and children in a
> + * and so on). This also stop any secondary buses and children in a
>   * depth-first manner.
>   */
>  void pci_stop_bus_device(struct pci_dev *dev)
>  {
> -       if (dev->subordinate)
> -               pci_stop_bus_devices(dev->subordinate);
> +       if (dev->secondary)
> +               pci_stop_bus_devices(dev->secondary);
>
>         pci_stop_dev(dev);
>  }
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index fb50613..06522da 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1013,7 +1013,7 @@ void __ref __pci_bus_size_bridges(struct pci_bus *bus,
>         resource_size_t additional_mem_size = 0, additional_io_size = 0;
>
>         list_for_each_entry(dev, &bus->devices, bus_list) {
> -               struct pci_bus *b = dev->subordinate;
> +               struct pci_bus *b = dev->secondary;
>                 if (!b)
>                         continue;
>
> @@ -1086,7 +1086,7 @@ static void __ref __pci_bus_assign_resources(const struct pci_bus *bus,
>         pbus_assign_resources_sorted(bus, realloc_head, fail_head);
>
>         list_for_each_entry(dev, &bus->devices, bus_list) {
> -               b = dev->subordinate;
> +               b = dev->secondary;
>                 if (!b)
>                         continue;
>
> @@ -1125,7 +1125,7 @@ static void __ref __pci_bridge_assign_resources(const struct pci_dev *bridge,
>         pdev_assign_resources_sorted((struct pci_dev *)bridge,
>                                          add_head, fail_head);
>
> -       b = bridge->subordinate;
> +       b = bridge->secondary;
>         if (!b)
>                 return;
>
> @@ -1204,7 +1204,7 @@ static void __ref pci_bus_release_bridge_resources(struct pci_bus *bus,
>         bool is_leaf_bridge = true;
>
>         list_for_each_entry(dev, &bus->devices, bus_list) {
> -               struct pci_bus *b = dev->subordinate;
> +               struct pci_bus *b = dev->secondary;
>                 if (!b)
>                         continue;
>
> @@ -1250,7 +1250,7 @@ static void pci_bus_dump_resources(struct pci_bus *bus)
>         pci_bus_dump_res(bus);
>
>         list_for_each_entry(dev, &bus->devices, bus_list) {
> -               b = dev->subordinate;
> +               b = dev->secondary;
>                 if (!b)
>                         continue;
>
> @@ -1265,7 +1265,7 @@ static int __init pci_bus_get_depth(struct pci_bus *bus)
>
>         list_for_each_entry(dev, &bus->devices, bus_list) {
>                 int ret;
> -               struct pci_bus *b = dev->subordinate;
> +               struct pci_bus *b = dev->secondary;
>                 if (!b)
>                         continue;
>
> @@ -1383,7 +1383,7 @@ again:
>         if (tried_times + 1 == pci_try_num)
>                 add_list = &realloc_head;
>         /* Depth first, calculate sizes and alignments of all
> -          subordinate buses. */
> +          secondary buses. */
>         list_for_each_entry(bus, &pci_root_buses, node)
>                 __pci_bus_size_bridges(bus, add_list);
>
> @@ -1432,7 +1432,7 @@ again:
>                 res->start = fail_res->start;
>                 res->end = fail_res->end;
>                 res->flags = fail_res->flags;
> -               if (fail_res->dev->subordinate)
> +               if (fail_res->dev->secondary)
>                         res->flags = 0;
>         }
>         free_list(&fail_head);
> @@ -1451,7 +1451,7 @@ enable_and_dump:
>
>  void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
>  {
> -       struct pci_bus *parent = bridge->subordinate;
> +       struct pci_bus *parent = bridge->secondary;
>         LIST_HEAD(add_list); /* list of resources that
>                                         want additional resources */
>         int tried_times = 0;
> @@ -1497,7 +1497,7 @@ again:
>                 res->start = fail_res->start;
>                 res->end = fail_res->end;
>                 res->flags = fail_res->flags;
> -               if (fail_res->dev->subordinate)
> +               if (fail_res->dev->secondary)
>                         res->flags = 0;
>         }
>         free_list(&fail_head);
> @@ -1519,7 +1519,7 @@ EXPORT_SYMBOL_GPL(pci_assign_unassigned_bridge_resources);
>   * Scan a PCI bus and child buses for new devices, adds them,
>   * and enables them.
>   *
> - * Returns the max number of subordinate bus discovered.
> + * Returns the max number of secondary busses discovered.
>   */
>  unsigned int __ref pci_rescan_bus(struct pci_bus *bus)
>  {
> @@ -1534,8 +1534,8 @@ unsigned int __ref pci_rescan_bus(struct pci_bus *bus)
>         list_for_each_entry(dev, &bus->devices, bus_list)
>                 if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
>                     dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
> -                       if (dev->subordinate)
> -                               __pci_bus_size_bridges(dev->subordinate,
> +                       if (dev->secondary)
> +                               __pci_bus_size_bridges(dev->secondary,
>                                                          &add_list);
>         up_read(&pci_bus_sem);
>         __pci_bus_assign_resources(bus, &add_list, NULL);
> diff --git a/drivers/pcmcia/cardbus.c b/drivers/pcmcia/cardbus.c
> index 24caeaf..2deff92 100644
> --- a/drivers/pcmcia/cardbus.c
> +++ b/drivers/pcmcia/cardbus.c
> @@ -52,8 +52,8 @@ static void cardbus_config_irq_and_cls(struct pci_bus *bus, int irq)
>                  */
>                 pci_set_cacheline_size(dev);
>
> -               if (dev->subordinate)
> -                       cardbus_config_irq_and_cls(dev->subordinate, irq);
> +               if (dev->secondary)
> +                       cardbus_config_irq_and_cls(dev->secondary, irq);
>         }
>  }
>
> @@ -66,7 +66,7 @@ static void cardbus_config_irq_and_cls(struct pci_bus *bus, int irq)
>   */
>  int __ref cb_alloc(struct pcmcia_socket *s)
>  {
> -       struct pci_bus *bus = s->cb_dev->subordinate;
> +       struct pci_bus *bus = s->cb_dev->secondary;
>         struct pci_dev *dev;
>         unsigned int max, pass;
>
> diff --git a/drivers/pcmcia/yenta_socket.c b/drivers/pcmcia/yenta_socket.c
> index 667678d..e269ad6 100644
> --- a/drivers/pcmcia/yenta_socket.c
> +++ b/drivers/pcmcia/yenta_socket.c
> @@ -703,7 +703,7 @@ static int yenta_allocate_res(struct yenta_socket *socket, int nr, unsigned type
>         if (type & IORESOURCE_IO)
>                 mask = ~3;
>
> -       res->name = dev->subordinate->name;
> +       res->name = dev->secondary->name;
>         res->flags = type;
>
>         region.start = config_readl(socket, addr_start) & mask;
> @@ -760,7 +760,7 @@ static void yenta_allocate_resources(struct yenta_socket *socket)
>         program += yenta_allocate_res(socket, 3, IORESOURCE_MEM,
>                            PCI_CB_MEMORY_BASE_1, PCI_CB_MEMORY_LIMIT_1);
>         if (program)
> -               pci_setup_cardbus(socket->dev->subordinate);
> +               pci_setup_cardbus(socket->dev->secondary);
>  }
>
>
> @@ -1047,10 +1047,14 @@ static void yenta_config_init(struct yenta_socket *socket)
>         config_writeb(socket, PCI_CACHE_LINE_SIZE, L1_CACHE_BYTES / 4);
>         config_writeb(socket, PCI_LATENCY_TIMER, 168);
>         config_writel(socket, PCI_PRIMARY_BUS,
> -               (176 << 24) |                      /* sec. latency timer */
> -               ((unsigned int)dev->subordinate->busn_res.end << 16) | /* subordinate bus */
> -               ((unsigned int)dev->subordinate->busn_res.start << 8) |  /* secondary bus */
> -               dev->subordinate->primary);                /* primary bus */
> +               /* sec. latency timer */
> +               (176 << 24) |
> +               /* subordinate bus */
> +               ((unsigned int)dev->secondary->busn_res.end << 16) |
> +               /* secondary bus */
> +               ((unsigned int)dev->secondary->busn_res.start << 8) |
> +               /* primary bus */
> +               dev->secondary->primary);
>
>         /*
>          * Set up the bridging state:
> @@ -1149,10 +1153,10 @@ static int __devinit yenta_probe(struct pci_dev *dev, const struct pci_device_id
>
>         /*
>          * If we failed to assign proper bus numbers for this cardbus
> -        * controller during PCI probe, its subordinate pci_bus is NULL.
> +        * controller during PCI probe, its secondary pci_bus is NULL.
>          * Bail out if so.
>          */
> -       if (!dev->subordinate) {
> +       if (!dev->secondary) {
>                 dev_printk(KERN_ERR, &dev->dev, "no bus associated! "
>                            "(try 'pci=assign-busses')\n");
>                 return -ENODEV;
> @@ -1257,7 +1261,7 @@ static int __devinit yenta_probe(struct pci_dev *dev, const struct pci_device_id
>         dev_printk(KERN_INFO, &dev->dev,
>                    "Socket status: %08x\n", cb_readl(socket, CB_SOCKET_STATE));
>
> -       yenta_fixup_parent_bridge(dev->subordinate);
> +       yenta_fixup_parent_bridge(dev->secondary);
>
>         /* Register it with the pcmcia layer.. */
>         ret = pcmcia_register_socket(&socket->socket);
> diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
> index dab91b4..70baae2 100644
> --- a/drivers/platform/x86/eeepc-laptop.c
> +++ b/drivers/platform/x86/eeepc-laptop.c
> @@ -606,7 +606,7 @@ static void eeepc_rfkill_hotplug(struct eeepc_laptop *eeepc, acpi_handle handle)
>                         goto out_unlock;
>                 }
>
> -               bus = port->subordinate;
> +               bus = port->secondary;
>
>                 if (!bus) {
>                         pr_warn("Unable to find PCI bus 1?\n");
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 5faa831..ad5cbfa 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -239,7 +239,7 @@ struct pci_ats;
>  struct pci_dev {
>         struct list_head bus_list;      /* node in per-bus list */
>         struct pci_bus  *bus;           /* bus this device is on */
> -       struct pci_bus  *subordinate;   /* bus this device bridges to */
> +       struct pci_bus  *secondary;     /* bus this device bridges to */
>
>         void            *sysdata;       /* hook for sys-specific extension */
>         struct proc_dir_entry *procent; /* device entry in /proc/bus/pci */
> --
> 1.7.9.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
