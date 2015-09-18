Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:34686 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659AbbIRUxK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Sep 2015 16:53:10 -0400
Received: by igcpb10 with SMTP id pb10so44412699igc.1
        for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2015 13:53:09 -0700 (PDT)
Date: Fri, 18 Sep 2015 15:53:01 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: jingoohan1@gmail.com, pratyush.anand@gmail.com,
	linux-pci@vger.kernel.org, wangzhou1@hisilicon.com,
	yuanzhichang@hisilicon.com, zhudacai@hisilicon.com,
	zhangjukuo@huawei.com, qiuzhenfa@hisilicon.com,
	liguozhu@hisilicon.com
Subject: Re: [PATCH v3 2/3] PCI: designware: change dw_pcie_cfg_write() and
 dw_pcie_cfg_read()
Message-ID: <20150918205301.GM25767@google.com>
References: <1441964307-126942-1-git-send-email-gabriele.paoloni@huawei.com>
 <1441964307-126942-3-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1441964307-126942-3-git-send-email-gabriele.paoloni@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 11, 2015 at 05:38:26PM +0800, Gabriele Paoloni wrote:
> From: gabriele paoloni <gabriele.paoloni@huawei.com>
> 
> This patch changes the implementation of dw_pcie_cfg_read() and
> dw_pcie_cfg_write() to improve the function usage from the callers
> perspective.
> Currently the callers are obliged to pass the 32bit aligned address
> of the register that contains the field of the PCI header that they
> want to read/write; also they have to pass the offset of the field
> in that register. This is quite tricky to use as the callers are
> obliged to sum the PCI header base address to the field offset
> masked to retrieve the 32b aligned register address.
> 
> With the new API the callers have to pass the base address of the
> PCI header and the offset corresponding to the field they intend to
> read/write.
> 
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> ---
>  drivers/pci/host/pci-exynos.c      |  5 ++---
>  drivers/pci/host/pci-keystone-dw.c |  4 ++--
>  drivers/pci/host/pcie-designware.c | 28 ++++++++++++++--------------
>  drivers/pci/host/pcie-spear13xx.c  | 26 ++++++++++++--------------
>  4 files changed, 30 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
> index f9f468d..8b0e04b 100644
> --- a/drivers/pci/host/pci-exynos.c
> +++ b/drivers/pci/host/pci-exynos.c
> @@ -454,7 +454,7 @@ static int exynos_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
>  	int ret;
>  
>  	exynos_pcie_sideband_dbi_r_mode(pp, true);
> -	ret = dw_pcie_cfg_read(pp->dbi_base + (where & ~0x3), where, size, val);
> +	ret = dw_pcie_cfg_read(pp->dbi_base, where, size, val);
>  	exynos_pcie_sideband_dbi_r_mode(pp, false);
>  	return ret;
>  }

Is there really any value in keeping "addr" and "where" separate?
dw_pcie_cfg_write() clearly doesn't care; it just adds them together.  I
don't think dw_pcie_cfg_read() needs to care either: it could round the
address down to a 32-bit boundary and use the difference to compute the
mask and shift.

So I'm proposing something like this:

  int dw_pcie_cfg_read(void __iomem *addr, int size, u32 *val)
  int dw_pcie_cfg_write(void __iomem *addr, int size, u32 val)

>  int dw_pcie_cfg_read(void __iomem *addr, int where, int size, u32 *val)
>  {
> +	addr += (where & ~0x3);
>  	*val = readl(addr);
> +	where &= 3;
>  
>  	if (size == 1)
> -		*val = (*val >> (8 * (where & 3))) & 0xff;
> +		*val = (*val >> (8 * where)) & 0xff;
>  	else if (size == 2)
> -		*val = (*val >> (8 * (where & 3))) & 0xffff;
> +		*val = (*val >> (8 * where)) & 0xffff;
>  	else if (size != 4)
>  		return PCIBIOS_BAD_REGISTER_NUMBER;
>  
> @@ -96,12 +98,14 @@ int dw_pcie_cfg_read(void __iomem *addr, int where, int size, u32 *val)
>  
>  int dw_pcie_cfg_write(void __iomem *addr, int where, int size, u32 val)
>  {
> +	addr += where;
> +
>  	if (size == 4)
>  		writel(val, addr);
>  	else if (size == 2)
> -		writew(val, addr + (where & 2));
> +		writew(val, addr);
>  	else if (size == 1)
> -		writeb(val, addr + (where & 3));
> +		writeb(val, addr);
>  	else
>  		return PCIBIOS_BAD_REGISTER_NUMBER;
