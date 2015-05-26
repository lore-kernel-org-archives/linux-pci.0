Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:56813 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194AbbEZIKM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2015 04:10:12 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Jingoo Han <jingoohan1@gmail.com>
Cc: 'Zhou Wang' <wangzhou1@hisilicon.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	'Pratyush Anand' <pratyush.anand@gmail.com>,
	'Liviu Dudau' <liviu.dudau@arm.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	'Gabriele Paoloni' <gabriele.paoloni@huawei.com>,
	'Zhichang Yuan' <yuanzhichang@hisilicon.com>,
	zhudacai@hisilicon.com, 'Zhang Jukuo' <zhangjukuo@huawei.com>,
	qiuzhenfa@hisilicon.com, 'Liguozhu' <liguozhu@hisilicon.com>,
	'Kishon Vijay Abraham I' <kishon@ti.com>,
	'Richard Zhu' <Richard.Zhu@freescale.com>,
	'Lucas Stach' <l.stach@pengutronix.de>
Subject: Re: [RFC PATCH v1 1/3] PCI: designware: Add ARM64 support
Date: Tue, 26 May 2015 10:09:17 +0200
Message-ID: <3203781.NTEqUP6iLy@wuerfel>
In-Reply-To: <000001d096a9$27bf43f0$773dcbd0$@com>
References: <000001d096a9$27bf43f0$773dcbd0$@com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 25 May 2015 14:10:37 Jingoo Han wrote:
> 'pp->root_bus_nr' is initialized as '-1' at some soc-specific drivers
> However, 'sys->busnr' is set as '0, 1, 2 ...' by pcibios_init_hw()
> in arch/arm/kernel/bios32.c. '0, 1, 2 ...' means the number of
> each host controller.
> 
> So, without setting 'pp->root_bus_nr' as '0, 1, 2, ...',
> it makes the problem.
> 
> Thus, we need to come up with the way to resolve this.
> 
> 1. Setting 'pp->root_bus_nr' as '0, 1, 2 ..' by each soc-specific driver.
> 
> e.g)
> 
> ./drivers/pci/host/pci-exynos.c
> @@ -534,7 +534,7 @@ static int __init exynos_add_pcie_port(struct pcie_port *pp,
>                 }
>         }
>  
> -       pp->root_bus_nr = -1;
> +       pp->root_bus_nr++;
>         pp->ops = &exynos_pcie_host_ops;
> 
> ./drivers/pci/host/pci-imx6.c
> @@ -541,7 +541,7 @@ static int __init imx6_add_pcie_port(struct pcie_port *pp,
>                 }
>         }
>  
> -       pp->root_bus_nr = -1;
> +       pp->root_bus_nr++;
>         pp->ops = &imx6_pcie_host_ops;
>  
> ./drivers/pci/host/pci-keystone.c
> @@ -312,7 +312,7 @@ static int __init ks_add_pcie_port(struct keystone_pcie *ks_pcie,
>                         return ret;
>         }
>  
> -       pp->root_bus_nr = -1;
> +       pp->root_bus_nr++;
>         pp->ops = &keystone_pcie_host_ops;
> 
> ./drivers/pci/host/pci-layerscape.c
> @@ -101,7 +101,7 @@ static int ls_add_pcie_port(struct ls_pcie *pcie)
>         pp = &pcie->pp;
>         pp->dev = pcie->dev;
>         pp->dbi_base = pcie->dbi;
> -       pp->root_bus_nr = -1;
> +       pp->root_bus_nr++;
>         pp->ops = &ls_pcie_host_ops;
>  
> ./drivers/pci/host/pcie-spear13xx.c
> @@ -287,7 +287,7 @@ static int spear13xx_add_pcie_port(struct pcie_port *pp,
>                 return ret;
>         }
>  
> -       pp->root_bus_nr = -1;
> +       pp->root_bus_nr++;
>         pp->ops = &spear13xx_pcie_host_ops;
> 
> 
> 2. Setting 'pp->root_bus_nr' as '0, 1, 2 ..' by pcie-designware.c
> 
> I believe that someone will give better idea. 

Assigning the root bus number through hw_pci is a historic artifact
from drivers that probe multiple host bridges at the same time.
Some legacy ARM platforms still do that (specifically all the ones
that set nr_controllers to >1: dove, mv78xx0, orion5x, and iop),
but all modern platforms should probe each host bridge separately,
either from a platform driver probe function, or they only have
one and hardcode that fact in the ARM platform code.

For the drivers in drivers/pci/host, we give each host controller
its own PCI domain, which means we can have overlapping bus numbers
and do not need the heuristic to split the available 255 bus numbers
across the present host bridges.

	Arnd
