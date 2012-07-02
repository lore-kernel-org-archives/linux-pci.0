Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:43181 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755467Ab2GBUwA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Jul 2012 16:52:00 -0400
Received: by vcbf11 with SMTP id f11so3787367vcb.19
        for <linux-pci@vger.kernel.org>; Mon, 02 Jul 2012 13:52:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120702134901.83708415.izumi.taku@jp.fujitsu.com>
References: <20120702134901.83708415.izumi.taku@jp.fujitsu.com>
Date: Mon, 2 Jul 2012 13:51:59 -0700
Message-ID: <CAE9FiQUb1rtLYAWZ=iMok+FGsJh7NcRGxGoD8eLLEOrKQsWsHw@mail.gmail.com>
Subject: Re: [PATCH] pci: reserve extra bus number resource for hotplug bridge
From: Yinghai Lu <yinghai@kernel.org>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jul 1, 2012 at 9:49 PM, Taku Izumi <izumi.taku@jp.fujitsu.com> wrote:
>
> Currently I/O ports and I/O memory resources are reserved for
> hotplug bridges and we can tune their size by using hpiosize
> and hpmemsize boot option.
>
> This patch extends feature so that we can reserve additional
> bus number resources for hotplug bridges and tune it by
> using "hpbussize" option.
>
> This patch also adds missing document for "hpiosize" and
> "hpmemsize" option.
>
> Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
> ---
>  Documentation/kernel-parameters.txt |   10 ++++++++++
>  drivers/pci/pci.c                   |    6 +++++-
>  drivers/pci/probe.c                 |    4 ++++
>  include/linux/pci.h                 |    1 +
>  4 files changed, 20 insertions(+), 1 deletion(-)
>
> Index: linux/drivers/pci/pci.c
> ===================================================================
> --- linux.orig/drivers/pci/pci.c
> +++ linux/drivers/pci/pci.c
> @@ -74,9 +74,11 @@ unsigned long pci_cardbus_mem_size = DEF
>
>  #define DEFAULT_HOTPLUG_IO_SIZE                (256)
>  #define DEFAULT_HOTPLUG_MEM_SIZE       (2*1024*1024)
> -/* pci=hpmemsize=nnM,hpiosize=nn can override this */
> +#define DEFAULT_HOTPLUG_BUS_SIZE       (0)
> +/* pci=hpmemsize=nnM,hpiosize=nn,hpbussize=n can override this */
>  unsigned long pci_hotplug_io_size  = DEFAULT_HOTPLUG_IO_SIZE;
>  unsigned long pci_hotplug_mem_size = DEFAULT_HOTPLUG_MEM_SIZE;
> +unsigned int pci_hotplug_bus_size = DEFAULT_HOTPLUG_BUS_SIZE;
>
>  enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_TUNE_OFF;
>
> @@ -3826,6 +3828,8 @@ static int __init pci_setup(char *str)
>                                 pci_hotplug_io_size = memparse(str + 9, &str);
>                         } else if (!strncmp(str, "hpmemsize=", 10)) {
>                                 pci_hotplug_mem_size = memparse(str + 10, &str);
> +                       } else if (!strncmp(str, "hpbussize=", 10)) {
> +                               pci_hotplug_bus_size = memparse(str + 10, &str);
>                         } else if (!strncmp(str, "pcie_bus_tune_off", 17)) {
>                                 pcie_bus_config = PCIE_BUS_TUNE_OFF;
>                         } else if (!strncmp(str, "pcie_bus_safe", 13)) {
> Index: linux/drivers/pci/probe.c
> ===================================================================
> --- linux.orig/drivers/pci/probe.c
> +++ linux/drivers/pci/probe.c
> @@ -865,6 +865,10 @@ int __devinit pci_scan_bridge(struct pci
>                 /*
>                  * Set the subordinate bus number to its real value.
>                  */
> +               if (dev->is_hotplug_bridge) {
> +                       if (max + pci_hotplug_bus_size < child->busn_res.end)
> +                               max += pci_hotplug_bus_size;
> +               }
>                 pci_bus_update_busn_res_end(child, max);
>                 pci_write_config_byte(dev, PCI_SUBORDINATE_BUS, max);
>         }
> Index: linux/include/linux/pci.h
> ===================================================================
> --- linux.orig/include/linux/pci.h
> +++ linux/include/linux/pci.h
> @@ -1517,6 +1517,7 @@ extern u8 pci_cache_line_size;
>
>  extern unsigned long pci_hotplug_io_size;
>  extern unsigned long pci_hotplug_mem_size;
> +extern unsigned int pci_hotplug_bus_size;
>
>  /* Architecture specific versions may override these (weak) */
>  int pcibios_add_platform_entries(struct pci_dev *dev);
> Index: linux/Documentation/kernel-parameters.txt
> ===================================================================
> --- linux.orig/Documentation/kernel-parameters.txt
> +++ linux/Documentation/kernel-parameters.txt
> @@ -2138,6 +2138,16 @@ bytes respectively. Such letter suffixes
>                 cbmemsize=nn[KMG]       The fixed amount of bus space which is
>                                 reserved for the CardBus bridge's memory
>                                 window. The default value is 64 megabytes.
> +               hpiosize        The fixed amount of bus space which is
> +                               reserved for hotplug bridge's IO window.
> +                               The default value is 256 bytes.
> +               hpmemsize       The fixed amount of bus space which is
> +                               reserved for hotplug bridge's memory window.
> +                               The default value is 2 megabytes.
> +               hpbussize       The fixed amount of bus space which is
> +                               reserved for hotplug bridge's additional bus
> +                               number resources.
> +                               The default value is 0.

at lease the patch should be split to two patches
1. one for hpiosize/hpmemsize paramater doc
2. one for new hpbussize

but we really should avoid adding those parameters if we can do that
automatically.

if you have test case, please check if busn_alloc branch would
increase the bus range automatically.

git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
for-pci-busn-alloc


Thanks

Yinghai
