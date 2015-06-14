Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yh0-f45.google.com ([209.85.213.45]:33335 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339AbbFNTSY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 14 Jun 2015 15:18:24 -0400
MIME-Version: 1.0
In-Reply-To: <1433320542-49576-3-git-send-email-wangzhou1@hisilicon.com>
References: <1433320542-49576-1-git-send-email-wangzhou1@hisilicon.com>
	<1433320542-49576-3-git-send-email-wangzhou1@hisilicon.com>
Date: Mon, 15 Jun 2015 00:48:23 +0530
Message-ID: <CAHM4w1nfaUMgY4PfhG4Aar962=m8XndHeHJG1yP04KjL=67xaQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] PCI: designware: Add ARM64 support
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Zhou Wang <wangzhou1@hisilicon.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Arnd Bergmann <arnd@arndb.de>, fabrice.gasnier@st.com,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Zhichang Yuan <yuanzhichang@hisilicon.com>,
	zhudacai@hisilicon.com, Zhang Jukuo <zhangjukuo@huawei.com>,
	qiuzhenfa@hisilicon.com, Liguozhu <liguozhu@hisilicon.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Zhou Wang,

Thanks for unifying arm and arm64 code.

On Wed, Jun 3, 2015 at 2:05 PM, Zhou Wang <wangzhou1@hisilicon.com> wrote:
>
> This patch tries to unify ARM32 and ARM64 PCIe in designware driver. Delete
> function dw_pcie_setup, dw_pcie_scan_bus, dw_pcie_map_irq and struct hw_pci,
> move related operations to dw_pcie_host_init. Also set pp->root_bus_nr = 0 in
> each PCIe host driver which is based on pcie-designware.
>
> I am not very clear about I/O resource management:

Following discussion may help to understand it, specially in the
context of designware.

http://marc.info/?l=linux-pci&m=138621989417562&w=2


> >       if (global_io_offset < SZ_1M && pp->io_size > 0) {
> >               pci_ioremap_io(global_io_offset, pp->io_base);
> >               global_io_offset += SZ_64K;
> >               pci_add_resource_offset(&res, &pp->io,
> >                                       global_io_offset - pp->io_bus_addr);
> >       }
> so just move steps in dw_pcie_setup to dw_pcie_host_init.
>
> I have compiled the driver with multi_v7_defconfig. However, I don't have
> ARM32 PCIe related board to do test. It will be appreciated if someone could
> help to test it.
>
> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> Tested-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  drivers/pci/host/pci-dra7xx.c      |   1 +
>  drivers/pci/host/pci-exynos.c      |   2 +-
>  drivers/pci/host/pci-imx6.c        |   2 +-
>  drivers/pci/host/pci-keystone.c    |   2 +-
>  drivers/pci/host/pci-layerscape.c  |   2 +-
>  drivers/pci/host/pcie-designware.c | 128 +++++++++++++++----------------------
>  drivers/pci/host/pcie-spear13xx.c  |   2 +-
>  7 files changed, 56 insertions(+), 83 deletions(-)
>

[...]

> diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
> index 4a6e62f..5c7a9c4 100644
> --- a/drivers/pci/host/pci-layerscape.c
> +++ b/drivers/pci/host/pci-layerscape.c
> @@ -101,7 +101,7 @@ static int ls_add_pcie_port(struct ls_pcie *pcie)
>         pp = &pcie->pp;
>         pp->dev = pcie->dev;
>         pp->dbi_base = pcie->dbi;
> -       pp->root_bus_nr = -1;
> +       pp->root_bus_nr = 0;

similar change for pcie-spear13xx.c should be needed as well.

>         pp->ops = &ls_pcie_host_ops;
>
>         ret = dw_pcie_host_init(pp);
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 2e9f84f..b3f0ac7 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c

[...]

> -#ifdef CONFIG_PCI_MSI
> -       dw_pcie_msi_chip.dev = pp->dev;
> -       dw_pci.msi_ctrl = &dw_pcie_msi_chip;
> +#ifdef CONFIG_ARM
> +       /*
> +        * FIXME: we should really be able to use
> +        * of_pci_get_host_bridge_resources on arm32 as well,
> +        * but the conversion needs some more testing
> +        */
> +       if (global_io_offset < SZ_1M && pp->io_size > 0) {
> +               pci_ioremap_io(global_io_offset, pp->io_base);
> +               global_io_offset += SZ_64K;
> +               pci_add_resource_offset(&res, &pp->io,
> +                                       global_io_offset - pp->io_bus_addr);
> +       }
> +       pci_add_resource_offset(&res, &pp->mem,
> +                               pp->mem.start - pp->mem_bus_addr);
> +       pci_add_resource(&res, &pp->busn);
> +#else
> +       ret = of_pci_get_host_bridge_resources(np, 0, 0xff, &res, &pp->io_base);
> +       if (ret)
> +               return ret;
> +#endif
> +
> +       bus = pci_create_root_bus(pp->dev, pp->root_bus_nr, &dw_pcie_ops,
> +                             pp, &res);
> +       if (!bus)
> +               return -ENOMEM;
> +
> +#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
> +       bus->msi = container_of(&pp->irq_domain, struct msi_controller, domain);
> +#else
> +       bus->msi = &dw_pcie_msi_chip;
>  #endif
>
> -       dw_pci.nr_controllers = 1;
> -       dw_pci.private_data = (void **)&pp;
> +       pci_scan_child_bus(bus);
> +       if (pp->ops->scan_bus)
> +               pp->ops->scan_bus(pp);
>
> -       pci_common_init_dev(pp->dev, &dw_pci);
> +#ifdef CONFIG_ARM
> +       /* support old dtbs that incorrectly describe IRQs */
> +       pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
> +#endif
> +
> +       pci_assign_unassigned_bus_resources(bus);
> +       pci_bus_add_devices(bus);

As James and Lorenzo has suggested, of_pci_get_host_bridge_resources should
work for ARM as well. I would suggest to move that just after cfg
resource parsing and
then to remove following piece of code.
for_each_of_pci_range(&parser, &range) {
...
}
ret = of_pci_parse_bus_range(np, &pp->busn);

Then you can have a loop like

         list_for_each_entry(entry, &res, node) {
                 struct resource *res_temp = entry->res;
                 if (resource_type(res_temp) == IORESOURCE_IO) {
                 } else if (resource_type(res_temp) == IORESOURCE_MEM) {
                }
         }

where you can fill, xx_size, xx_bus_addr, xx_mod_base etc.
You can also remove global_io_offset variable.

~Pratyush
