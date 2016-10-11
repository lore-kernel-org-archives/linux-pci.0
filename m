Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751537AbcJKNu6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Oct 2016 09:50:58 -0400
Date: Tue, 11 Oct 2016 08:50:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, nsekhar@ti.com,
        Jingoo Han <jingoohan1@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI: designware: Fix compiler warning
Message-ID: <20161011135050.GA26715@localhost>
References: <1476190715-16884-1-git-send-email-kishon@ti.com>
 <1476190715-16884-2-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1476190715-16884-2-git-send-email-kishon@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Jingoo, Kukjin, Krzysztof, linux-samsung-soc]

On Tue, Oct 11, 2016 at 06:28:32PM +0530, Kishon Vijay Abraham I wrote:
> Fix the following compilation warning in dw_pcie_readl_unroll()
> and dw_pcie_writel_unroll() by just invoking dw_pcie_readl_rc() and
> dw_pcie_writel_rc() respectively instead of adding redundant code.
> 
> pcie-designware.c: In function 'dw_pcie_readl_unroll':
> pcie-designware.c:165:32: warning: passing argument 2 of
>  'pp->ops->readl_rc' makes integer from pointer without a cast
>  [-Wint-conversion]
>    return pp->ops->readl_rc(pp, pp->dbi_base + offset + reg);
>                                 ^
> pcie-designware.c:165:32: note: expected 'u32 {aka unsigned int}' but
>  argument is of type 'void *'
> pcie-designware.c: In function 'dw_pcie_writel_unroll':
> pcie-designware.c:176:31: warning: passing argument 3 of
>  'pp->ops->writel_rc' makes integer from pointer without a cast
>  [-Wint-conversion]
>    pp->ops->writel_rc(pp, val, pp->dbi_base + offset + reg);
>                                ^
> drivers/pci/host/pcie-designware.c:176:31: note: expected 'u32
>  {aka unsigned int}' but argument is of type 'void *'
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/host/pcie-designware.c |   10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 5ee8772..b8feea4 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -161,10 +161,7 @@ static inline u32 dw_pcie_readl_unroll(struct pcie_port *pp, u32 index, u32 reg)
>  {
>  	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
>  
> -	if (pp->ops->readl_rc)
> -		return pp->ops->readl_rc(pp, pp->dbi_base + offset + reg);

I think this was worse than just a compiler warning, wasn't it?  I
think I completely broke exynos (the only implementer of
pp->ops->readl_rc) because we passed "pp->dbi_base + offset + reg" to
exynos_pcie_readl_rc(), which then added pp->dbi_base again:

  val = readl(pp->dbi_base + reg);

I incorporated your patch to use dw_pcie_readl_rc() directly (thanks a
lot for noticing that!) into pci/host-designware.

Then I rebased all the branches that were based on pci/host-designware
and repushed everything:

  pci/host-designware
  pci/host-armada
  pci/host-artpec
  pci/host-dra7xx
  pci/host-exynos
  pci/host-hisi
  pci/host-imx6
  pci/host-keystone
  pci/host-layerscape
  pci/host-qcom
  pci/host-spear

> -	return readl(pp->dbi_base + offset + reg);
> +	return dw_pcie_readl_rc(pp, offset + reg);
>  }
>  
>  static inline void dw_pcie_writel_unroll(struct pcie_port *pp, u32 index,
> @@ -172,10 +169,7 @@ static inline void dw_pcie_writel_unroll(struct pcie_port *pp, u32 index,
>  {
>  	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
>  
> -	if (pp->ops->writel_rc)
> -		pp->ops->writel_rc(pp, val, pp->dbi_base + offset + reg);
> -	else
> -		writel(val, pp->dbi_base + offset + reg);
> +	dw_pcie_writel_rc(pp, offset + reg, val);
>  }
>  
>  static int dw_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
