Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:56599 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715Ab2GDEGy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jul 2012 00:06:54 -0400
Received: by vcbf11 with SMTP id f11so4656637vcb.19
        for <linux-pci@vger.kernel.org>; Tue, 03 Jul 2012 21:06:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120704121639.d3949763.izumi.taku@jp.fujitsu.com>
References: <20120702134901.83708415.izumi.taku@jp.fujitsu.com>
	<20120704121639.d3949763.izumi.taku@jp.fujitsu.com>
Date: Tue, 3 Jul 2012 21:06:53 -0700
Message-ID: <CAE9FiQXJF09N+2-YJsN7_QWjB8k+2f5BhEvFgaPiqyN+the59A@mail.gmail.com>
Subject: Re: [PATCH 2/2] pci: reserve extra bus resource for hotplug bridge
From: Yinghai Lu <yinghai@kernel.org>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 3, 2012 at 8:16 PM, Taku Izumi <izumi.taku@jp.fujitsu.com> wrote:
>
> Currently I/O ports and I/O memory resources are reserved for
> hotplug bridges and we can tune their size by using hpiosize
> and hpmemsize boot option.
>
> This patch extends feature so that we can reserve additional
> bus number resources for hotplug bridges and tune it by
> using "hpbussize" option.
>
> Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
> ---
>  Documentation/kernel-parameters.txt |    4 ++++
>  drivers/pci/pci.c                   |    6 +++++-
>  drivers/pci/probe.c                 |    4 ++++
>  include/linux/pci.h                 |    1 +
>  4 files changed, 14 insertions(+), 1 deletion(-)
>
> Index: linux/drivers/pci/pci.c
> ===================================================================
> --- linux.orig/drivers/pci/pci.c        2012-06-26 14:37:22.000000000 +0900
> +++ linux/drivers/pci/pci.c     2012-07-04 10:00:50.708002757 +0900
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
> @@ -4022,6 +4024,8 @@ static int __init pci_setup(char *str)
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
> --- linux.orig/drivers/pci/probe.c      2012-06-26 14:37:22.000000000 +0900
> +++ linux/drivers/pci/probe.c   2012-07-04 10:00:50.718002632 +0900
> @@ -867,6 +867,10 @@ int __devinit pci_scan_bridge(struct pci
>                 /*
>                  * Set the subordinate bus number to its real value.
>                  */
> +               if (dev->is_hotplug_bridge) {
> +                       if (max + pci_hotplug_bus_size < child->busn_res.end)
> +                               max += pci_hotplug_bus_size;
> +               }

again, that adding is not safe.

please drop this one now.

or you can prepare one against busn_alloc and I put new version in the
busn_alloc branch.

Thanks

Yinghai
