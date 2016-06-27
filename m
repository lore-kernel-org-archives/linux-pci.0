Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f67.google.com ([209.85.213.67]:33910 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764AbcF0Ehv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jun 2016 00:37:51 -0400
MIME-Version: 1.0
In-Reply-To: <BEF013ED77979042B16A827A9AC75AF820FA4C5E@SZXEMI502-MBS.china.huawei.com>
References: <BEF013ED77979042B16A827A9AC75AF820FA4C5E@SZXEMI502-MBS.china.huawei.com>
From: Pratyush Anand <pratyush.anand@gmail.com>
Date: Mon, 27 Jun 2016 10:07:49 +0530
Message-ID: <CAHM4w1=g7nQ81tipzJa_3nVo-3_4ZMpRkKRrOFX9wyc+ZoThMw@mail.gmail.com>
Subject: Re: [PATCH] Decouple CFG and IO in Designware PCIe Driver
To: "dongbo (E)" <dongbo4@huawei.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linuxarm <linuxarm@huawei.com>,
	Zhanweitao <zhanweitao@hisilicon.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 22, 2016 at 1:54 PM, dongbo (E) <dongbo4@huawei.com> wrote:
> From: Dong Bo <dongbo4@huawei.com>
>
> In designware PCIe driver, the iatu0 is used for both CFG and IO accesses.
> When PCIe sends CFGs to peripherals (e.g. lspci),
> iatu0 frequently switches between CFG and IO alternatively.
>
> If the LIMIT of MEMORY is a value between CFGs BASE_ADDR and IOs LIMIT,
> this probably results in a MEMORY beging matched to be an IO by mistake.
>
> Considering the following configurations:
> MEMORY          ->      BASE_ADDR: 0xb4100000, LIMIT: 0xb4100FFF, TYPE=mem
> CFG             ->      BASE_ADDR: 0xb4000000, LIMIT: 0xb4000FFF, TYPE=cfg
> IO              ->      BASE_ADDR: 0xFFFFFFFF, LIMIT: 0xFFFFFFFE, TYPE=io
> Suppose PCIe has just completed a CFG access, to switch back to IO, it set the BASE_ADDR to 0xFFFFFFFF, LIMIT 0xFFFFFFFE and TYPE to io.
> When another CFG access come,
> PCIe first set BASE_ADDR to 0xb4000000 to switch to CFG.
> At this moment, a MEMORY access shows up, due to `0xb4000000 <= MEMORY BASE_ADDR <= MEMORY LIMIE <= 0xFFFFFFF, it matches with iatu0.
> And it is treated as an IO access by mistake, then sent to perpheral.
>

Hummm...This portion of driver has always been buggy.

> This patch fixes the problem by decoupling CFG and IO, reassigning iatu2 to IO.

But, we can not just assign IOs to iatu2.
IIRC then, there are atleast two platforms which have only 2
viewports, therefore they can not program iatu2.

Jingoo,Bjorn: IMHO, we should modify this portion of code, since more
number of platforms has 4+ viewports. Probably, we can take following
approach:

(1) Pass number of viewports through DT. If we have *atleast*  3
viewports then assign separate viewports to memory and IO,  and share
one with CFG0 and CFG1.
(2) If we can have *atleast*  4 then, we may have separate for CFG0
and CFG1 as well.

(3) If we have *only* 2 then,  either we let them work as they work
today with bug, or may be we restrict them from using IO transactions.
So assign one to memory and share other for CFG0 and CFG1.

Please let me know your opnion.

~Pratyush

>
> Signed-off-by: Dong Bo <dongbo4@huawei.com>
> ---
>  drivers/pci/host/pcie-designware.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index aafd766..1a40305 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -51,6 +51,7 @@
>  #define PCIE_ATU_VIEWPORT              0x900
>  #define PCIE_ATU_REGION_INBOUND                (0x1 << 31)
>  #define PCIE_ATU_REGION_OUTBOUND       (0x0 << 31)
> +#define PCIE_ATU_REGION_INDEX2         (0x2 << 0)
>  #define PCIE_ATU_REGION_INDEX1         (0x1 << 0)
>  #define PCIE_ATU_REGION_INDEX0         (0x0 << 0)
>  #define PCIE_ATU_CR1                   0x904
> @@ -603,9 +604,6 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>                                   type, cpu_addr,
>                                   busdev, cfg_size);
>         ret = dw_pcie_cfg_read(va_cfg_base + where, size, val);
> -       dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
> -                                 PCIE_ATU_TYPE_IO, pp->io_base,
> -                                 pp->io_bus_addr, pp->io_size);
>
>         return ret;
>  }
> @@ -640,9 +638,6 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>                                   type, cpu_addr,
>                                   busdev, cfg_size);
>         ret = dw_pcie_cfg_write(va_cfg_base + where, size, val);
> -       dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
> -                                 PCIE_ATU_TYPE_IO, pp->io_base,
> -                                 pp->io_bus_addr, pp->io_size);
>
>         return ret;
>  }
> @@ -778,10 +773,15 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>          * uses its own address translation component rather than ATU, so
>          * we should not program the ATU here.
>          */
> -       if (!pp->ops->rd_other_conf)
> +       if (!pp->ops->rd_other_conf) {
>                 dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
>                                           PCIE_ATU_TYPE_MEM, pp->mem_base,
>                                           pp->mem_bus_addr, pp->mem_size);
> +               dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX2,
> +                                       PCIE_ATU_TYPE_IO, pp->io_base,
> +                                       pp->io_bus_addr, pp->io_size);
> +
> +       }
>
>         dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
>
> --
> 1.9.1
>
