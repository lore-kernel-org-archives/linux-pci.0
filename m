Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:43146 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753541Ab3I0T3w (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Sep 2013 15:29:52 -0400
Received: by mail-ie0-f171.google.com with SMTP id at1so4921597iec.2
        for <linux-pci@vger.kernel.org>; Fri, 27 Sep 2013 12:29:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <000c01ceb816$19f0dd10$4dd29730$%han@samsung.com>
References: <000c01ceb816$19f0dd10$4dd29730$%han@samsung.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 27 Sep 2013 13:29:31 -0600
Message-ID: <CAErSpo6Y-E4=_SHTYYtRrb=bbZ--Uc-GnEj5aL9QjBOhm89v4A@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] PCI: tegra: add missing __iomem annotation
To: Jingoo Han <jg1.han@samsung.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Stephen Warren <swarren@nvidia.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Sep 22, 2013 at 10:33 PM, Jingoo Han <jg1.han@samsung.com> wrote:
> Added missing __iomem annotation in order to fix the following
> sparse warnings:
>
> drivers/pci/host/pci-tegra.c:411:41: warning: incorrect type in return expression (different address spaces)
> drivers/pci/host/pci-tegra.c:411:41:    expected void [noderef] <asn:2>*
> drivers/pci/host/pci-tegra.c:411:41:    got void *addr
> drivers/pci/host/pci-tegra.c:419:25: warning: incorrect type in return expression (different address spaces)
> drivers/pci/host/pci-tegra.c:419:25:    expected void [noderef] <asn:2>*
> drivers/pci/host/pci-tegra.c:419:25:    got void *addr
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> Acked-by: Thierry Reding <treding@nvidia.com>

Applied to my pci/host-tegra branch for v3.13.  Thanks!

Bjorn

> ---
>  drivers/pci/host/pci-tegra.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 2e9888a..7c4f38d 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -408,7 +408,7 @@ static void __iomem *tegra_pcie_bus_map(struct tegra_pcie *pcie,
>
>         list_for_each_entry(bus, &pcie->busses, list)
>                 if (bus->nr == busnr)
> -                       return bus->area->addr;
> +                       return (void __iomem *)bus->area->addr;
>
>         bus = tegra_pcie_bus_alloc(pcie, busnr);
>         if (IS_ERR(bus))
> @@ -416,7 +416,7 @@ static void __iomem *tegra_pcie_bus_map(struct tegra_pcie *pcie,
>
>         list_add_tail(&bus->list, &pcie->busses);
>
> -       return bus->area->addr;
> +       return (void __iomem *)bus->area->addr;
>  }
>
>  static void __iomem *tegra_pcie_conf_address(struct pci_bus *bus,
> --
> 1.7.10.4
>
>
