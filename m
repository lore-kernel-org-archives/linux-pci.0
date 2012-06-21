Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50762 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754588Ab2FUWLE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jun 2012 18:11:04 -0400
Received: by pbbrp8 with SMTP id rp8so2694753pbb.19
        for <linux-pci@vger.kernel.org>; Thu, 21 Jun 2012 15:11:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1340271423-4352-8-git-send-email-jiang.liu@huawei.com>
References: <1340271423-4352-1-git-send-email-jiang.liu@huawei.com>
	<1340271423-4352-8-git-send-email-jiang.liu@huawei.com>
Date: Thu, 21 Jun 2012 15:11:03 -0700
Message-ID: <CAE9FiQWo8LB90aQbnSRjWJVPVgHVrrB4UH_vb3Xoi4XyVo7iQg@mail.gmail.com>
Subject: Re: [PATCH v9 07/11] x86/PCI: update MMCFG information when
 hot-plugging PCI host bridges
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

On Thu, Jun 21, 2012 at 2:36 AM, Jiang Liu <jiang.liu@huawei.com> wrote:
> This patch enhances x86 arch specific code to update MMCFG information
> when PCI host bridge hotplug event happens.
>
> Signed-off-by: Jiang Liu <liuj97@gmail.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/x86/include/asm/pci_x86.h |    1 +
>  arch/x86/pci/acpi.c            |   71 ++++++++++++++++++++++++++++++++++++++++
>  arch/x86/pci/mmconfig_32.c     |    2 +-
>  arch/x86/pci/mmconfig_64.c     |    2 +-
>  4 files changed, 74 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
> index af5018f..b2652e9 100644
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
> index 2bb885a..f701179 100644
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
> @@ -13,6 +14,12 @@ struct pci_root_info {
>        unsigned int res_num;
>        struct resource *res;
>        struct pci_sysdata sd;
> +#ifdef CONFIG_PCI_MMCONFIG
> +       bool mcfg_added;
> +       u16 segment;
> +       u8 start_bus;
> +       u8 end_bus;
> +#endif
>  };
>
>  static bool pci_use_crs = true;
> @@ -119,6 +126,61 @@ void __init pci_acpi_crs_quirks(void)
>               pci_use_crs ? "nocrs" : "use_crs");
>  }
>
> +static int __devinit setup_mcfg_map(struct pci_root_info *info,
> +                                   u16 seg, u8 start, u8 end,
> +                                   phys_addr_t addr)
> +{
> +#ifdef CONFIG_PCI_MMCONFIG
> +       int result;
> +       struct device *dev = &info->bridge->dev;
> +
> +       info->start_bus = start;
> +       info->end_bus = end;
> +       info->mcfg_added = false;
> +
> +       /* return success if MMCFG is not in use */
> +       if (raw_pci_ext_ops && raw_pci_ext_ops != &pci_mmcfg)
> +               return 0;
> +
> +       if (!(pci_probe & PCI_PROBE_MMCONF)) {
> +               /* still could use raw_pci_ops for devices on segment 0 */
> +               if (seg)
> +                       dev_warn(dev,
> +                                "MMCONFIG is disabled, can't access extended "
> +                                "configuration space under this bridge.\n");
> +               return 0;
> +       }
that mean, user disable mmconf checking.
if it is with pci segment other than 0, that bridge can not be used
without MMCFG.

so should be:
> +               if (seg)
> +                        return -EXXX;
> +               dev_warn(dev,
> +                            "MMCONFIG is disabled, can't access extended "
> +                           "configuration space under this bridge.\n");
> +               return 0;

> +
> +       result = pci_mmconfig_insert(dev, seg, start, end, addr);
> +       if (result == 0) {
> +               /* enable MMCFG if it hasn't been enabled yet */
> +               if (raw_pci_ext_ops == NULL)
> +                       raw_pci_ext_ops = &pci_mmcfg;
> +               info->mcfg_added = true;
> +       } else if (result != -EEXIST && addr) {
> +               /*
> +                * Failure in adding MMCFG information is not fatal,
> +                * just can't access [extended] configuration space of
> +                * devices under this host bridge.
> +                */
> +               dev_warn(dev, "fail to add MMCONFIG information.\n");

need to check if seg is other 0.

> +       }
> +#endif
> +
> +       return 0;
> +}
> +
> +static void teardown_mcfg_map(struct pci_root_info *info)
> +{
> +#ifdef CONFIG_PCI_MMCONFIG
> +       if (info->mcfg_added) {
> +               pci_mmconfig_delete(info->segment, info->start_bus,
> +                                   info->end_bus);
> +               info->mcfg_added = false;
> +       }
> +#endif
> +}
> +
>  static acpi_status
>  resource_to_addr(struct acpi_resource *resource,
>                        struct acpi_resource_address64 *addr)
> @@ -331,8 +393,11 @@ static void __release_pci_root_info(struct pci_root_info *info)
>
>        free_pci_root_info_res(info);
>
> +       teardown_mcfg_map(info);
> +
>        kfree(info);
>  }
> +
>  static void release_pci_root_info(struct pci_host_bridge *bridge)
>  {
>        struct pci_root_info *info = bridge->release_data;
> @@ -438,6 +503,12 @@ struct pci_bus * __devinit pci_acpi_scan_root(struct acpi_pci_root *root)
>                        x86_pci_root_bus_resources(busnum, &resources);
>                }
>
> +               if (root->mcfg_addr)
> +                       setup_mcfg_map(info, root->segment,
> +                                      (u8) root->secondary.start,
> +                                      (u8) root->secondary.end,
> +                                      root->mcfg_addr);
> +

should check setup_mcfg_map return there. should skip the host bridge
if can not add MCFG for non 0 pci segment.

>                bus = pci_create_root_bus(NULL, busnum, &pci_root_ops, sd,
>                                          &resources);
>                if (bus) {
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
> --
> 1.7.1
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
