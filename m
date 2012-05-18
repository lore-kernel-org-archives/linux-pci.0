Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:44199 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754624Ab2ERQa6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 May 2012 12:30:58 -0400
Received: by lbbgm6 with SMTP id gm6so2190774lbb.19
        for <linux-pci@vger.kernel.org>; Fri, 18 May 2012 09:30:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1336186830-10765-6-git-send-email-jiang.liu@huawei.com>
References: <1336186830-10765-1-git-send-email-jiang.liu@huawei.com> <1336186830-10765-6-git-send-email-jiang.liu@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 18 May 2012 10:30:36 -0600
Message-ID: <CAErSpo7Kqw6DOJfuFhamp7Q7rve9wSBVJ42cJ-Vys9OcshfswQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] PCI, x86: introduce pci_mmconfig_insert()/delete()
 for PCI root bridge hotplug
To: Jiang Liu <liuj97@gmail.com>
Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 4, 2012 at 9:00 PM, Jiang Liu <liuj97@gmail.com> wrote:
> From: Jiang Liu <jiang.liu@huawei.com>
>
> Introduce pci_mmconfig_insert()/pci_mmconfig_delete(), which will be used to
> update MMCFG information when supporting PCI root bridge hotplug.
>
> Signed-off-by: Jiang Liu <liuj97@gmail.com>
> ---
>  arch/x86/include/asm/pci_x86.h |    2 +
>  arch/x86/pci/mmconfig-shared.c |  117 ++++++++++++++++++++++++++++++++++++----
>  2 files changed, 109 insertions(+), 10 deletions(-)
>
> diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
> index df898ce..3252c97 100644
> --- a/arch/x86/include/asm/pci_x86.h
> +++ b/arch/x86/include/asm/pci_x86.h
> @@ -137,6 +137,8 @@ extern int __init pci_mmcfg_arch_init(void);
>  extern void __init pci_mmcfg_arch_free(void);
>  extern int __devinit pci_mmcfg_arch_map(struct pci_mmcfg_region *cfg);
>  extern void pci_mmcfg_arch_unmap(struct pci_mmcfg_region *cfg);
> +extern int __devinit pci_mmconfig_insert(int seg, int start, int end, u64 addr);
> +extern int pci_mmconfig_delete(int seg, int start, int end);
>  extern struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int bus);
>
>  extern struct list_head pci_mmcfg_list;
> diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
> index 0ac97d5..a8da5d4 100644
> --- a/arch/x86/pci/mmconfig-shared.c
> +++ b/arch/x86/pci/mmconfig-shared.c
> @@ -27,6 +27,7 @@
>
>  /* Indicate if the mmcfg resources have been placed into the resource table. */
>  static int __initdata pci_mmcfg_resources_inserted;
> +static bool pci_mmcfg_arch_init_failed;
>  static DEFINE_MUTEX(pci_mmcfg_lock);
>
>  LIST_HEAD(pci_mmcfg_list);
> @@ -374,15 +375,20 @@ static void __init pci_mmcfg_insert_resources(void)
>  {
>        struct pci_mmcfg_region *cfg;
>
> +       /*
> +        * Insert resources for MMCFG items if the resource hasn't been
> +        * inserted by pci_mmconfig_insert() yet.
> +        */
>        list_for_each_entry(cfg, &pci_mmcfg_list, list)
> -               insert_resource(&iomem_resource, &cfg->res);
> +               if (!cfg->res.parent)
> +                       insert_resource(&iomem_resource, &cfg->res);
>
>        /* Mark that the resources have been inserted. */
>        pci_mmcfg_resources_inserted = 1;
>  }
>
> -static acpi_status __init check_mcfg_resource(struct acpi_resource *res,
> -                                             void *data)
> +static acpi_status __devinit check_mcfg_resource(struct acpi_resource *res,
> +                                                void *data)
>  {
>        struct resource *mcfg_res = data;
>        struct acpi_resource_address64 address;
> @@ -418,8 +424,8 @@ static acpi_status __init check_mcfg_resource(struct acpi_resource *res,
>        return AE_OK;
>  }
>
> -static acpi_status __init find_mboard_resource(acpi_handle handle, u32 lvl,
> -               void *context, void **rv)
> +static acpi_status __devinit find_mboard_resource(acpi_handle handle, u32 lvl,
> +                                                 void *context, void **rv)
>  {
>        struct resource *mcfg_res = context;
>
> @@ -432,7 +438,7 @@ static acpi_status __init find_mboard_resource(acpi_handle handle, u32 lvl,
>        return AE_OK;
>  }
>
> -static int __init is_acpi_reserved(u64 start, u64 end, unsigned not_used)
> +static int __devinit is_acpi_reserved(u64 start, u64 end, unsigned not_used)
>  {
>        struct resource mcfg_res;
>
> @@ -451,8 +457,9 @@ static int __init is_acpi_reserved(u64 start, u64 end, unsigned not_used)
>
>  typedef int (*check_reserved_t)(u64 start, u64 end, unsigned type);
>
> -static int __init is_mmconf_reserved(check_reserved_t is_reserved,
> -                                   struct pci_mmcfg_region *cfg, int with_e820)
> +static int __devinit is_mmconf_reserved(check_reserved_t is_reserved,
> +                                       struct pci_mmcfg_region *cfg,
> +                                       int with_e820)
>  {
>        u64 addr = cfg->res.start;
>        u64 size = resource_size(&cfg->res);
> @@ -633,14 +640,15 @@ static void __init __pci_mmcfg_init(int early)
>                }
>        }
>
> -       if (pci_mmcfg_arch_init())
> +       if (pci_mmcfg_arch_init()) {
>                pci_probe = (pci_probe & ~PCI_PROBE_MASK) | PCI_PROBE_MMCONF;
> -       else {
> +       } else {
>                /*
>                 * Signal not to attempt to insert mmcfg resources because
>                 * the architecture mmcfg setup could not initialize.
>                 */
>                pci_mmcfg_resources_inserted = 1;
> +               pci_mmcfg_arch_init_failed = true;
>        }
>  }
>
> @@ -681,3 +689,92 @@ static int __init pci_mmcfg_late_insert_resources(void)
>  * with other system resources.
>  */
>  late_initcall(pci_mmcfg_late_insert_resources);
> +
> +/* Add MMCFG information for hot-added host bridges at runtime */
> +int __devinit pci_mmconfig_insert(int segment, int start, int end, u64 addr)
> +{
> +       int rc = -EINVAL;
> +       struct pci_mmcfg_region *cfg = NULL;
> +
> +       if (segment < 0 || segment > USHRT_MAX ||
> +           start < 0 || start > 255 || end < start || end > 255)
> +               return rc;
> +
> +       if (pci_mmcfg_arch_init_failed)
> +               return -ENODEV;
> +
> +       mutex_lock(&pci_mmcfg_lock);
> +       cfg = pci_mmconfig_lookup(segment, start);
> +       if (cfg) {
> +               if (cfg->start_bus <= start && cfg->end_bus >= end) {
> +                       rc = -EEXIST;
> +               } else {
> +                       printk(KERN_WARNING PREFIX
> +                              "MMCONFIG for domain %04x [bus %02x-%02x] "
> +                              "conflicts with domain %04x [bus %02x-%02x]\n",
> +                              segment, start, end,
> +                              cfg->segment, cfg->start_bus, cfg->end_bus);

I think in your current series, pci_mmconfig_insert() is only called
with an address we got from _CBA.  In that case, I don't think it's a
real conflict if the MCFG happens to contain an entry that covers part
of the same area.  It's true that the PCI Firmware Spec, r3.0, sec
4.1.2, says the MCFG should not contain an entry for a segment group
where we have a _CBA, but I think if it *does* happen, we should just
silently ignore the MCFG and rely on the _CBA.  This is part of why I
think we shouldn't be scanning the whole MCFG up front -- we should
only be doing it as-needed, when we discover a host bridge.

> +               }
> +               goto out;
> +       }
> +       if (!addr)
> +               goto out;
> +
> +       cfg = pci_mmconfig_alloc(segment, start, end, addr);
> +       if (cfg == NULL) {
> +               rc = -ENOMEM;
> +       } else if (!pci_mmcfg_check_reserved(cfg, 0)) {
> +               printk(KERN_WARNING PREFIX
> +                      "MMCONFIG for domain %04x [bus %02x-%02x] "
> +                      "isn't reserved\n", segment, start, end);
> +       } else if (insert_resource(&iomem_resource, &cfg->res)) {
> +               rc = -EBUSY;
> +               printk(KERN_WARNING PREFIX
> +                      "failed to insert resource for domain "
> +                      "%04x [bus %02x-%02x]\n", segment, start, end);

Please use insert_resource_conflict() and when it fails, print the
resource you're trying to insert and the conflicting one.

> +       } else if (pci_mmcfg_arch_map(cfg)) {
> +               rc = -EBUSY;
> +               printk(KERN_WARNING PREFIX
> +                      "failed to map resource for domain "
> +                      "%04x [bus %02x-%02x]\n", segment, start, end);
> +       } else {
> +               list_add_sorted(cfg);
> +               cfg = NULL;
> +               rc = 0;
> +       }
> +
> +       if (cfg) {
> +               if (cfg->res.parent)
> +                       release_resource(&cfg->res);
> +               kfree(cfg);
> +       }
> +
> +out:
> +       mutex_unlock(&pci_mmcfg_lock);
> +
> +       return rc;
> +}
> +
> +/* Delete MMCFG information at runtime */
> +int pci_mmconfig_delete(int segment, int start, int end)
> +{
> +       struct pci_mmcfg_region *cfg;
> +
> +       mutex_lock(&pci_mmcfg_lock);
> +       list_for_each_entry_rcu(cfg, &pci_mmcfg_list, list) {
> +               if (cfg->segment == segment && cfg->start_bus == start &&
> +                   cfg->end_bus == end) {
> +                       list_del_rcu(&cfg->list);
> +                       synchronize_rcu();
> +                       pci_mmcfg_arch_unmap(cfg);
> +                       if (cfg->res.parent)
> +                               release_resource(&cfg->res);
> +                       mutex_unlock(&pci_mmcfg_lock);
> +                       kfree(cfg);
> +                       return 0;
> +               }
> +       }
> +       mutex_unlock(&pci_mmcfg_lock);
> +
> +       return -ENOENT;
> +}
> --
> 1.7.9.5
>
