Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34661 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549Ab2FSSe4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jun 2012 14:34:56 -0400
Received: by pbbrp8 with SMTP id rp8so10004785pbb.19
        for <linux-pci@vger.kernel.org>; Tue, 19 Jun 2012 11:34:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1340111732-6276-7-git-send-email-jiang.liu@huawei.com>
References: <1340111732-6276-1-git-send-email-jiang.liu@huawei.com>
	<1340111732-6276-7-git-send-email-jiang.liu@huawei.com>
Date: Tue, 19 Jun 2012 11:34:56 -0700
Message-ID: <CAE9FiQWAPb7S9kBrebnf6nn2KmCL2ohUbukycJPGQLB=11+_pA@mail.gmail.com>
Subject: Re: [PATCH v8 06/12] PCI/ACPI: provide MCFG address for PCI host bridges
From: Yinghai Lu <yinghai@kernel.org>
To: Jiang Liu <jiang.liu@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org,
	Jiang Liu <liuj97@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 19, 2012 at 6:15 AM, Jiang Liu <jiang.liu@huawei.com> wrote:
> This patch provide MCFG address for PCI host bridges, which will
> be used to support host bridge hotplug.  It gets MCFG address
> by evaluating _CBA method if available, or by scanning the ACPI
> MCFG table.
>
> Signed-off-by: Jiang Liu <liuj97@gmail.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>
> v8: add acpi_pci_cache_mcfg() for better readable code and fix a condition
>    compilation issue
>
> ---
>  arch/x86/pci/mmconfig-shared.c |    4 ++
>  drivers/acpi/pci_root.c        |   12 ++++++++
>  drivers/pci/pci-acpi.c         |   60 ++++++++++++++++++++++++++++++++++++++++
>  include/acpi/acnames.h         |    1 +
>  include/acpi/acpi_bus.h        |    3 ++
>  include/linux/pci-acpi.h       |    5 +++
>  6 files changed, 85 insertions(+), 0 deletions(-)
>
> diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
> index 7d1c6bc..94ed360 100644
> --- a/arch/x86/pci/mmconfig-shared.c
> +++ b/arch/x86/pci/mmconfig-shared.c
> @@ -19,6 +19,7 @@
>  #include <linux/slab.h>
>  #include <linux/mutex.h>
>  #include <linux/rculist.h>
> +#include <linux/pci-acpi.h>
>  #include <asm/e820.h>
>  #include <asm/pci_x86.h>
>  #include <asm/acpi.h>
> @@ -675,6 +676,9 @@ static void __init __pci_mmcfg_init(int early)
>                pci_mmcfg_resources_inserted = 1;
>                pci_mmcfg_arch_init_failed = true;
>        }
> +
> +       if (!early && !known_bridge)
> +               acpi_pci_cache_mcfg();
>  }
>
>  void __init pci_mmcfg_early_init(void)
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 7aff631..3ce6a28 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -458,6 +458,7 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
>        acpi_handle handle;
>        struct acpi_device *child;
>        u32 flags, base_flags;
> +       int end_bus = -1;
>
>        root = kzalloc(sizeof(struct acpi_pci_root), GFP_KERNEL);
>        if (!root)
> @@ -505,6 +506,17 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
>        strcpy(acpi_device_class(device), ACPI_PCI_ROOT_CLASS);
>        device->driver_data = root;
>
> +       root->mcfg_addr = acpi_pci_root_get_mcfg_addr(device->handle,
> +               root->segment, (u8) root->secondary.start, &end_bus);
> +
> +       /*
> +        * End bus number for MCFG may be less than root's subordinary
> +        * bus number with buggy BIOS implementation.
> +        */
> +       if (end_bus < 0 || end_bus > root->secondary.end)
> +               end_bus = root->secondary.end;
> +       root->mcfg_end_bus = (u8) end_bus;
> +
>        /*
>         * All supported architectures that use ACPI have support for
>         * PCI domains, so we indicate this in _OSC support capabilities.
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 61e2fef..0c6e0bb 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -162,6 +162,66 @@ acpi_status pci_acpi_remove_pm_notifier(struct acpi_device *dev)
>        return remove_pm_notifier(dev, pci_acpi_wake_dev);
>  }
>
> +/* acpi_table_parse() is marked as __init, so cache MCFG info at boot time */
> +static int pci_acpi_mcfg_entries;
> +static struct acpi_mcfg_allocation *pci_acpi_mcfg_array;
> +
> +static int __init pci_cache_mcfg(struct acpi_table_header *header)
> +{
> +       u32 sz;
> +       void *ptr;
> +
> +       if (!header || (header->length <= sizeof(struct acpi_table_mcfg)))
> +               return -EINVAL;
> +
> +       sz = (header->length - sizeof(struct acpi_table_mcfg));
> +       pci_acpi_mcfg_array = kmalloc(sz, GFP_KERNEL);
> +       if (!pci_acpi_mcfg_array)
> +               return -ENOMEM;
> +
> +       ptr = (void *)header + sizeof(struct acpi_table_mcfg);
> +       memcpy(pci_acpi_mcfg_array, ptr, sz);
> +       pci_acpi_mcfg_entries = sz / sizeof (struct acpi_mcfg_allocation);
> +
> +       return 0;
> +}

thought you were agreeing to go through choice 2 without caching MCFG anymore.

Can you just drop that caching MCFG and only handle _CBA here?

Thanks

Yinghai
