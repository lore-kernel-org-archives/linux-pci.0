Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:59496 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757562Ab2ERQD1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 18 May 2012 12:03:27 -0400
Received: by lahd3 with SMTP id d3so2186949lah.19
        for <linux-pci@vger.kernel.org>; Fri, 18 May 2012 09:03:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1336186830-10765-7-git-send-email-jiang.liu@huawei.com>
References: <1336186830-10765-1-git-send-email-jiang.liu@huawei.com> <1336186830-10765-7-git-send-email-jiang.liu@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 18 May 2012 10:03:05 -0600
Message-ID: <CAErSpo5iiEqqhcMKj8gqfXZmqD2QaY4LBe7w9J2K-fgXbzO9Pg@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] PCI, ACPI, x86: update MMCFG information when
 hot-plugging PCI host bridges
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
> This patch enhances pci_root driver to update MMCFG information when
> hot-plugging PCI root bridges on x86 platforms.
>
> Signed-off-by: Jiang Liu <liuj97@gmail.com>
> ---
>  arch/x86/include/asm/pci_x86.h |    1 +
>  arch/x86/pci/acpi.c            |   57 ++++++++++++++++++++++++++++++++++++++++
>  arch/x86/pci/mmconfig_32.c     |    2 +-
>  arch/x86/pci/mmconfig_64.c     |    2 +-
>  drivers/acpi/pci_root.c        |   22 ++++++++++++++++
>  include/acpi/acnames.h         |    1 +
>  include/acpi/acpi_bus.h        |    1 +
>  include/linux/pci-acpi.h       |    4 +++
>  8 files changed, 88 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
> index 3252c97..5e1d9a6 100644
> --- a/arch/x86/include/asm/pci_x86.h
> +++ b/arch/x86/include/asm/pci_x86.h
> @@ -100,6 +100,7 @@ struct pci_raw_ops {
>  extern const struct pci_raw_ops *raw_pci_ops;
>  extern const struct pci_raw_ops *raw_pci_ext_ops;
>
> +extern const struct pci_raw_ops pci_mmcfg;
>  extern const struct pci_raw_ops pci_direct_conf1;
>  extern bool port_cf9_safe;
>
> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> index da0149d..80cc3fa 100644
> --- a/arch/x86/pci/acpi.c
> +++ b/arch/x86/pci/acpi.c
> @@ -4,6 +4,7 @@
>  #include <linux/irq.h>
>  #include <linux/dmi.h>
>  #include <linux/slab.h>
> +#include <linux/pci-acpi.h>
>  #include <asm/numa.h>
>  #include <asm/pci_x86.h>
>
> @@ -488,6 +489,62 @@ struct pci_bus * __devinit pci_acpi_scan_root(struct acpi_pci_root *root)
>        return bus;
>  }
>
> +int __devinit arch_acpi_pci_root_add(struct acpi_pci_root *root,
> +                                    unsigned long long base_addr)
> +{
> +       int result;
> +
> +       /* return success if MMCFG is not in use */
> +       if (raw_pci_ext_ops && raw_pci_ext_ops != &pci_mmcfg)
> +               return 0;
> +
> +       if (!(pci_probe & PCI_PROBE_MMCONF)) {
> +               /* still could use raw_pci_ops for devices on segment 0 */
> +               if (root->segment == 0)
> +                       return 0;
> +
> +               printk(KERN_ERR "MMCFG is disabled, "
> +                       "can't access CFG space for Bus %04x:%02x\n",
> +                       root->segment, (unsigned int)root->secondary.start);
> +               return -ENODEV;
> +       }
> +
> +       result = pci_mmconfig_insert(root->segment, root->secondary.start,
> +                                    root->secondary.end, base_addr);
> +       if (result == -EEXIST) {
> +               /* return success if MMCFG item already exists */
> +               result = 0;
> +       } else if (result == 0) {
> +               /* enable MMCFG if it hasn't been enabled yet */
> +               if (raw_pci_ext_ops == NULL)
> +                       raw_pci_ext_ops = &pci_mmcfg;
> +               root->mmconf_added = true;
> +       } else if (root->segment == 0 && raw_pci_ext_ops == NULL &&
> +                  raw_pci_ops != NULL) {
> +               /*
> +                * system doesn't support extended configuration space,
> +                * still could use raw_pci_ops with it
> +                */
> +               result = 0;
> +       } else {
> +               printk(KERN_ERR
> +                       "can't add MMCFG information for Bus %04x:%02x\n",
> +                       root->segment, (unsigned int)root->secondary.start);
> +       }
> +
> +       return result;
> +}
> +
> +void arch_acpi_pci_root_remove(struct acpi_pci_root *root)
> +{
> +       if (root->mmconf_added) {
> +               pci_mmconfig_delete(root->segment,
> +                                   root->secondary.start,
> +                                   root->secondary.end);
> +               root->mmconf_added = false;
> +       }
> +}
> +
>  int __init pci_acpi_init(void)
>  {
>        struct pci_dev *dev = NULL;
> diff --git a/arch/x86/pci/mmconfig_32.c b/arch/x86/pci/mmconfig_32.c
> index a22785d..db63ac2 100644
> --- a/arch/x86/pci/mmconfig_32.c
> +++ b/arch/x86/pci/mmconfig_32.c
> @@ -126,7 +126,7 @@ static int pci_mmcfg_write(unsigned int seg, unsigned int bus,
>        return 0;
>  }
>
> -static const struct pci_raw_ops pci_mmcfg = {
> +const struct pci_raw_ops pci_mmcfg = {
>        .read =         pci_mmcfg_read,
>        .write =        pci_mmcfg_write,
>  };
> diff --git a/arch/x86/pci/mmconfig_64.c b/arch/x86/pci/mmconfig_64.c
> index 4e05779..34c08dd 100644
> --- a/arch/x86/pci/mmconfig_64.c
> +++ b/arch/x86/pci/mmconfig_64.c
> @@ -90,7 +90,7 @@ static int pci_mmcfg_write(unsigned int seg, unsigned int bus,
>        return 0;
>  }
>
> -static const struct pci_raw_ops pci_mmcfg = {
> +const struct pci_raw_ops pci_mmcfg = {
>        .read =         pci_mmcfg_read,
>        .write =        pci_mmcfg_write,
>  };
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index b313125..8d3f821 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -448,6 +448,16 @@ out:
>  }
>  EXPORT_SYMBOL(acpi_pci_osc_control_set);
>
> +int __weak arch_acpi_pci_root_add(struct acpi_pci_root *root,
> +                                 unsigned long long base_addr)
> +{
> +       return 0;
> +}
> +
> +void __weak arch_acpi_pci_root_remove(struct acpi_pci_root *root)
> +{
> +}
> +
>  static int __devinit acpi_pci_root_add(struct acpi_device *device)
>  {
>        unsigned long long segment, bus;
> @@ -457,6 +467,7 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
>        acpi_handle handle;
>        struct acpi_device *child;
>        u32 flags, base_flags;
> +       unsigned long long base_addr;
>
>        root = kzalloc(sizeof(struct acpi_pci_root), GFP_KERNEL);
>        if (!root)
> @@ -504,6 +515,15 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
>        strcpy(acpi_device_class(device), ACPI_PCI_ROOT_CLASS);
>        device->driver_data = root;
>
> +       status = acpi_evaluate_integer(root->device->handle, METHOD_NAME__CBA,
> +                                      NULL, &base_addr);
> +       if (ACPI_FAILURE(status))
> +               base_addr = 0;

I think the MCFG lookup should happen here, since MCFG is a generic
ACPI table and is not arch-specific.  Maybe something like
"phys_addr_t acpi_mcfg_lookup(int domain, struct resource *bus_nr, int
*last_bus_nr)" that would return the bus 0-relative base address (like
what _CBA gives you) and the end of the bus number range from MCFG.

> +       if (arch_acpi_pci_root_add(root, base_addr)) {

This should be something like "pci_add_mmconfig(int domain, struct
resource *bus_nr, phys_addr_t  base)".  The bus_nr resource would be
the range from _CRS or a copy truncated to the end we found in MCFG.

> +               result = -ENODEV;

I don't think this is a fatal error.  If we don't have MMCONFIG space
for this host bridge, we can just fall back to the default pci_ops and
still use the host bridge.

> +               goto out_free;
> +       }
> +
>        /*
>         * All supported architectures that use ACPI have support for
>         * PCI domains, so we indicate this in _OSC support capabilities.
> @@ -629,6 +649,7 @@ out_del_root:
>        list_del_rcu(&root->node);
>        mutex_unlock(&acpi_pci_root_lock);
>        synchronize_rcu();
> +       arch_acpi_pci_root_remove(root);
>  out_free:
>        kfree(root);
>        return result;
> @@ -686,6 +707,7 @@ out:
>        list_del_rcu(&root->node);
>        mutex_unlock(&acpi_pci_root_lock);
>        synchronize_rcu();
> +       arch_acpi_pci_root_remove(root);
>        kfree(root);
>
>        return 0;
> diff --git a/include/acpi/acnames.h b/include/acpi/acnames.h
> index 38f5088..99bda75 100644
> --- a/include/acpi/acnames.h
> +++ b/include/acpi/acnames.h
> @@ -62,6 +62,7 @@
>  #define METHOD_NAME__AEI        "_AEI"
>  #define METHOD_NAME__PRW        "_PRW"
>  #define METHOD_NAME__SRS        "_SRS"
> +#define METHOD_NAME__CBA       "_CBA"
>
>  /* Method names - these methods must appear at the namespace root */
>
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 333d38c..4171277 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -371,6 +371,7 @@ struct acpi_pci_root {
>        u32 osc_support_set;    /* _OSC state of support bits */
>        u32 osc_control_set;    /* _OSC state of control bits */
>        bool hot_added;
> +       bool mmconf_added;
>  };
>
>  /* helper */
> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> index 4462350..d017dc0 100644
> --- a/include/linux/pci-acpi.h
> +++ b/include/linux/pci-acpi.h
> @@ -18,6 +18,10 @@ extern acpi_status pci_acpi_add_pm_notifier(struct acpi_device *dev,
>                                             struct pci_dev *pci_dev);
>  extern acpi_status pci_acpi_remove_pm_notifier(struct acpi_device *dev);
>
> +int arch_acpi_pci_root_add(struct acpi_pci_root *root,
> +                          unsigned long long base_addr);
> +void arch_acpi_pci_root_remove(struct acpi_pci_root *root);
> +
>  static inline acpi_handle acpi_find_root_bridge_handle(struct pci_dev *pdev)
>  {
>        struct pci_bus *pbus = pdev->bus;
> --
> 1.7.9.5
>
