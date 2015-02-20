Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:47037 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753870AbbBTDfq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Feb 2015 22:35:46 -0500
Received: by mail-ob0-f175.google.com with SMTP id va2so21900704obc.6
        for <linux-pci@vger.kernel.org>; Thu, 19 Feb 2015 19:35:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1424367708-17149-1-git-send-email-matwey@sai.msu.ru>
References: <1424367708-17149-1-git-send-email-matwey@sai.msu.ru>
Date: Fri, 20 Feb 2015 09:05:45 +0530
Message-ID: <CAKohpokfNOGSxzJ9qGdsKTOt5BFcyeRiErKoXXvNNOTkkahL=Q@mail.gmail.com>
Subject: Re: [PATCH v3] pci: spear: Drop __initdata from spear13xx_pcie_driver
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc: Mohit KUMAR <mohit.kumar@st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Stanimir Varbanov <svarbanov@mm-sol.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 19 February 2015 at 23:11, Matwey V. Kornilov <matwey@sai.msu.ru> wrote:
> spear13xx_pcie_driver.driver is allocated in text.init section
> and then the pointer to it is passed futher. This patch is to avoid
> crashes like the following, when freed memory is used.
>
> Also, __init has been dropped from the probe() function referred from the struct
> and all called functions.
>
>  #0  __device_attach (drv=0xc0ed5608 <spear13xx_pcie_driver+20>, data=0xdb622610) at ../drivers/base/dd.c:409
>  #1  0xc07a4798 in bus_for_each_drv (bus=<optimized out>, start=<optimized out>, data=0xda0, fn=0xc07a6740 <__device_attach>)
>     at ../drivers/base/bus.c:463
>  #2  0xc07a6324 in device_attach (dev=0xdb622610) at ../drivers/base/dd.c:447
>  #3  0xc07a5814 in bus_probe_device (dev=0xdb622610) at ../drivers/base/bus.c:558
>  #4  0xc07a38d8 in device_add (dev=<optimized out>) at ../drivers/base/core.c:1058
>  #5  0xc08b6a5c in of_device_add (ofdev=<optimized out>) at ../drivers/of/device.c:66
>  #6  0xc08b742c in of_platform_device_create_pdata (np=<optimized out>, bus_id=0x0 <__vectors_start>, platform_data=0x0 <__vectors_start>,
>     parent=<optimized out>) at ../drivers/of/platform.c:241
>  #7  0xc08b7568 in of_platform_bus_create (bus=0xdfa46780, matches=0x0 <__vectors_start>, lookup=0x0 <__vectors_start>, parent=0xdb183410,
>     strict=true) at ../drivers/of/platform.c:414
>  #8  0xc08b79bc in of_platform_populate (root=0xc0ed5608 <spear13xx_pcie_driver+20>, matches=0xdb622610, lookup=0xda0,
>     parent=0xc07a6740 <__device_attach>) at ../drivers/of/platform.c:501
>  #9  0xbf000030 in am335x_child_probe (pdev=0xdb183400) at ../drivers/usb/musb/musb_am335x.c:12
>  #10 0xc07a83f0 in platform_drv_probe (_dev=0xdb183410) at ../drivers/base/platform.c:512
>  #11 0xc07a64e8 in really_probe (drv=<optimized out>, dev=<optimized out>) at ../drivers/base/dd.c:302
>  #12 driver_probe_device (drv=0xbf000234, dev=0xdb183410) at ../drivers/base/dd.c:399
>  #13 0xc07a6820 in __driver_attach (dev=0xdb183410, data=0xbf000234) at ../drivers/base/dd.c:477
>  #14 0xc07a46e8 in bus_for_each_dev (bus=<optimized out>, start=<optimized out>, data=0xda0, fn=0xc07a83a4 <platform_drv_probe>)
>     at ../drivers/base/bus.c:313
>  #15 0xc07a5ebc in driver_attach (drv=<optimized out>) at ../drivers/base/dd.c:496
>  #16 0xc07a5af0 in bus_add_driver (drv=0xbf000234) at ../drivers/base/bus.c:694
>  #17 0xc07a6fec in driver_register (drv=0xbf000234) at ../drivers/base/driver.c:167
>  #18 0xc0209c34 in do_one_initcall (fn=0xbf002000) at ../init/main.c:801
>  #19 0xc02e0494 in do_init_module (mod=<optimized out>) at ../kernel/module.c:3142
>  #20 load_module (info=0xdb6b1f54, uargs=<optimized out>, flags=<optimized out>) at ../kernel/module.c:3461
>  #21 0xc02e0a44 in SYSC_finit_module (flags=<optimized out>, uargs=<optimized out>, fd=<optimized out>) at ../kernel/module.c:3537
>  #22 SyS_finit_module (fd=7, uargs=-1225602132, flags=0) at ../kernel/module.c:3518
>  #23 0xc021a680 in ?? ()
>
> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
> ---
> Changes from v2:
>  - Drop __init from all probing functions to allow deferred probing.
> Changes from v1:
>  - Use platform_driver_probe instead of platform_driver_register to make linker happy.
>
>  drivers/pci/host/pcie-designware.c | 2 +-
>  drivers/pci/host/pcie-spear13xx.c  | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index df781cd..5b8a056 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -339,7 +339,7 @@ static const struct irq_domain_ops msi_domain_ops = {
>         .map = dw_pcie_msi_map,
>  };
>
> -int __init dw_pcie_host_init(struct pcie_port *pp)
> +int dw_pcie_host_init(struct pcie_port *pp)
>  {
>         struct device_node *np = pp->dev->of_node;
>         struct platform_device *pdev = to_platform_device(pp->dev);
> diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
> index 866465f..020d788 100644
> --- a/drivers/pci/host/pcie-spear13xx.c
> +++ b/drivers/pci/host/pcie-spear13xx.c
> @@ -269,7 +269,7 @@ static struct pcie_host_ops spear13xx_pcie_host_ops = {
>         .host_init = spear13xx_pcie_host_init,
>  };
>
> -static int __init spear13xx_add_pcie_port(struct pcie_port *pp,
> +static int spear13xx_add_pcie_port(struct pcie_port *pp,
>                                          struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> @@ -299,7 +299,7 @@ static int __init spear13xx_add_pcie_port(struct pcie_port *pp,
>         return 0;
>  }
>
> -static int __init spear13xx_pcie_probe(struct platform_device *pdev)
> +static int spear13xx_pcie_probe(struct platform_device *pdev)
>  {
>         struct spear13xx_pcie *spear13xx_pcie;
>         struct pcie_port *pp;
> @@ -370,7 +370,7 @@ static const struct of_device_id spear13xx_pcie_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, spear13xx_pcie_of_match);
>
> -static struct platform_driver spear13xx_pcie_driver __initdata = {
> +static struct platform_driver spear13xx_pcie_driver = {
>         .probe          = spear13xx_pcie_probe,
>         .driver = {
>                 .name   = "spear-pcie",

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
