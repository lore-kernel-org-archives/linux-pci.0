Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34255 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390AbbIITpB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Sep 2015 15:45:01 -0400
Received: by wicfx3 with SMTP id fx3so3596869wic.1
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2015 12:45:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1441817460-174811-1-git-send-email-gabriele.paoloni@huawei.com>
References: <1441817460-174811-1-git-send-email-gabriele.paoloni@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 9 Sep 2015 14:44:39 -0500
Message-ID: <CAErSpo6d_65oCez7fUBLLpYAiA8F8vj5V4j3gkvMVMsNobpfrg@mail.gmail.com>
Subject: Re: [PATCH] PCI: designware: change dw_pcie_cfg_write() and dw_pcie_cfg_read()
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand Thakur <pratyush.anand@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Zhichang Yuan <yuanzhichang@hisilicon.com>,
	Zhudacai <zhudacai@hisilicon.com>,
	Zhang Jukuo <zhangjukuo@huawei.com>,
	qiuzhenfa <qiuzhenfa@hisilicon.com>,
	Liguozhu <liguozhu@hisilicon.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Gabriele,

On Wed, Sep 9, 2015 at 11:51 AM, Gabriele Paoloni
<gabriele.paoloni@huawei.com> wrote:
> From: gabriele paoloni <gabriele.paoloni@huawei.com>
>
> This patch changes the implementation of dw_pcie_cfg_read() and
> dw_pcie_cfg_write() to:
> - improve the function usage from the callers perspective;
> - make sure that the callers specify proper address offsets
>   according to the size of the field being read/written
> - fix a bug in pcie-spear13xx.c where the callers where passing
>   the wrong address as they missed to add the appropriate offset

Please split this into separate patches, so each patch does one thing,
i.e., separate the "where" usage change from the "return
PCIBIOS_BAD_REGISTER_NUMBER for bad offsets" change.

I think there was a separate patch for the pcie-spear13xx.c bug,
wasn't there?  At least, I don't see that fix in *this* patch.

> This patch is a follow up from the discussion in:
> http://www.spinics.net/lists/linux-pci/msg44351.html
>
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> ---
>  drivers/pci/host/pci-exynos.c      |  5 ++--
>  drivers/pci/host/pci-keystone-dw.c |  4 +--
>  drivers/pci/host/pcie-designware.c | 51 ++++++++++++++++++++++----------------
>  3 files changed, 34 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
> index f9f468d..8b0e04b 100644
> --- a/drivers/pci/host/pci-exynos.c
> +++ b/drivers/pci/host/pci-exynos.c
> @@ -454,7 +454,7 @@ static int exynos_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
>         int ret;
>
>         exynos_pcie_sideband_dbi_r_mode(pp, true);
> -       ret = dw_pcie_cfg_read(pp->dbi_base + (where & ~0x3), where, size, val);
> +       ret = dw_pcie_cfg_read(pp->dbi_base, where, size, val);
>         exynos_pcie_sideband_dbi_r_mode(pp, false);
>         return ret;
>  }
> @@ -465,8 +465,7 @@ static int exynos_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
>         int ret;
>
>         exynos_pcie_sideband_dbi_w_mode(pp, true);
> -       ret = dw_pcie_cfg_write(pp->dbi_base + (where & ~0x3),
> -                       where, size, val);
> +       ret = dw_pcie_cfg_write(pp->dbi_base, where, size, val);
>         exynos_pcie_sideband_dbi_w_mode(pp, false);
>         return ret;
>  }
> diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/host/pci-keystone-dw.c
> index f34892e..2b391f4 100644
> --- a/drivers/pci/host/pci-keystone-dw.c
> +++ b/drivers/pci/host/pci-keystone-dw.c
> @@ -403,7 +403,7 @@ int ks_dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>
>         addr = ks_pcie_cfg_setup(ks_pcie, bus_num, devfn);
>
> -       return dw_pcie_cfg_read(addr + (where & ~0x3), where, size, val);
> +       return dw_pcie_cfg_read(addr, where, size, val);
>  }
>
>  int ks_dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
> @@ -415,7 +415,7 @@ int ks_dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>
>         addr = ks_pcie_cfg_setup(ks_pcie, bus_num, devfn);
>
> -       return dw_pcie_cfg_write(addr + (where & ~0x3), where, size, val);
> +       return dw_pcie_cfg_write(addr, where, size, val);
>  }
>
>  /**
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 69486be..b53aa38 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -82,13 +82,20 @@ static inline struct pcie_port *sys_to_pcie(struct pci_sys_data *sys)
>
>  int dw_pcie_cfg_read(void __iomem *addr, int where, int size, u32 *val)
>  {
> +       addr += (where & ~0x3);
>         *val = readl(addr);
> -
> -       if (size == 1)
> -               *val = (*val >> (8 * (where & 3))) & 0xff;
> -       else if (size == 2)
> -               *val = (*val >> (8 * (where & 3))) & 0xffff;
> -       else if (size != 4)
> +       where &= 3;
> +
> +       if (size == 1) {
> +               *val = (*val >> (8 * where)) & 0xff;
> +       } else if (size == 2) {
> +               if (where & 1)
> +                       return PCIBIOS_BAD_REGISTER_NUMBER;
> +               *val = (*val >> (8 * where)) & 0xffff;
> +       } else if (size == 4) {
> +               if (where & 3)
> +                       return PCIBIOS_BAD_REGISTER_NUMBER;
> +       } else
>                 return PCIBIOS_BAD_REGISTER_NUMBER;
>
>         return PCIBIOS_SUCCESSFUL;
> @@ -96,12 +103,18 @@ int dw_pcie_cfg_read(void __iomem *addr, int where, int size, u32 *val)
>
>  int dw_pcie_cfg_write(void __iomem *addr, int where, int size, u32 val)
>  {
> -       if (size == 4)
> +       addr += where;
> +
> +       if (size == 4) {
> +               if ((uintptr_t)addr & 3)
> +                       return PCIBIOS_BAD_REGISTER_NUMBER;
>                 writel(val, addr);
> -       else if (size == 2)
> -               writew(val, addr + (where & 2));
> -       else if (size == 1)
> -               writeb(val, addr + (where & 3));
> +       } else if (size == 2) {
> +               if ((uintptr_t)addr & 1)
> +                       return PCIBIOS_BAD_REGISTER_NUMBER;
> +               writew(val, addr);
> +       } else if (size == 1)
> +               writeb(val, addr);
>         else
>                 return PCIBIOS_BAD_REGISTER_NUMBER;
>
> @@ -132,8 +145,7 @@ static int dw_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
>         if (pp->ops->rd_own_conf)
>                 ret = pp->ops->rd_own_conf(pp, where, size, val);
>         else
> -               ret = dw_pcie_cfg_read(pp->dbi_base + (where & ~0x3), where,
> -                               size, val);
> +               ret = dw_pcie_cfg_read(pp->dbi_base, where, size, val);
>
>         return ret;
>  }
> @@ -146,8 +158,7 @@ static int dw_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
>         if (pp->ops->wr_own_conf)
>                 ret = pp->ops->wr_own_conf(pp, where, size, val);
>         else
> -               ret = dw_pcie_cfg_write(pp->dbi_base + (where & ~0x3), where,
> -                               size, val);
> +               ret = dw_pcie_cfg_write(pp->dbi_base, where, size, val);
>
>         return ret;
>  }
> @@ -541,13 +552,12 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>                 u32 devfn, int where, int size, u32 *val)
>  {
>         int ret, type;
> -       u32 address, busdev, cfg_size;
> +       u32 busdev, cfg_size;
>         u64 cpu_addr;
>         void __iomem *va_cfg_base;
>
>         busdev = PCIE_ATU_BUS(bus->number) | PCIE_ATU_DEV(PCI_SLOT(devfn)) |
>                  PCIE_ATU_FUNC(PCI_FUNC(devfn));
> -       address = where & ~0x3;
>
>         if (bus->parent->number == pp->root_bus_nr) {
>                 type = PCIE_ATU_TYPE_CFG0;
> @@ -564,7 +574,7 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>         dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
>                                   type, cpu_addr,
>                                   busdev, cfg_size);
> -       ret = dw_pcie_cfg_read(va_cfg_base + address, where, size, val);
> +       ret = dw_pcie_cfg_read(va_cfg_base, where, size, val);
>         dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
>                                   PCIE_ATU_TYPE_IO, pp->io_mod_base,
>                                   pp->io_bus_addr, pp->io_size);
> @@ -576,13 +586,12 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>                 u32 devfn, int where, int size, u32 val)
>  {
>         int ret, type;
> -       u32 address, busdev, cfg_size;
> +       u32 busdev, cfg_size;
>         u64 cpu_addr;
>         void __iomem *va_cfg_base;
>
>         busdev = PCIE_ATU_BUS(bus->number) | PCIE_ATU_DEV(PCI_SLOT(devfn)) |
>                  PCIE_ATU_FUNC(PCI_FUNC(devfn));
> -       address = where & ~0x3;
>
>         if (bus->parent->number == pp->root_bus_nr) {
>                 type = PCIE_ATU_TYPE_CFG0;
> @@ -599,7 +608,7 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>         dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
>                                   type, cpu_addr,
>                                   busdev, cfg_size);
> -       ret = dw_pcie_cfg_write(va_cfg_base + address, where, size, val);
> +       ret = dw_pcie_cfg_write(va_cfg_base, where, size, val);
>         dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
>                                   PCIE_ATU_TYPE_IO, pp->io_mod_base,
>                                   pp->io_bus_addr, pp->io_size);
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
