Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754337AbdAKSuN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Jan 2017 13:50:13 -0500
Date: Wed, 11 Jan 2017 12:50:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-pci@vger.kernel.org, helgaas@google.com, krzk@kernel.org,
        linux-kernel@vger.kernel.org, jingoohan1@gmail.com,
        javier@osg.samsung.com, kgene@kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI: exynos: replace to one register accessor from
 each accessors
Message-ID: <20170111185003.GG14532@bhelgaas-glaptop.roam.corp.google.com>
References: <20161219081614.5403-1-jh80.chung@samsung.com>
 <20161219081614.5403-2-jh80.chung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161219081614.5403-2-jh80.chung@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jaehoon,

On Mon, Dec 19, 2016 at 05:16:11PM +0900, Jaehoon Chung wrote:
> There is no reason to maintain *_blk/phy/elbi_* as register accessors.
> It can be replaced to one register accessor.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/pci/host/pci-exynos.c | 214 +++++++++++++++++++-----------------------
>  1 file changed, 97 insertions(+), 117 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
> index f1c544b..6dbfa2c 100644
> --- a/drivers/pci/host/pci-exynos.c
> +++ b/drivers/pci/host/pci-exynos.c
> @@ -102,197 +102,175 @@ struct exynos_pcie {
>  #define PCIE_PHY_TRSV3_PD_TSV		(0x1 << 7)
>  #define PCIE_PHY_TRSV3_LVCC		0x31c
>  
> -static void exynos_elb_writel(struct exynos_pcie *exynos_pcie, u32 val, u32 reg)
> +static void exynos_pcie_writel(void __iomem *base, u32 val, u32 reg)
>  {
> -	writel(val, exynos_pcie->elbi_base + reg);
> +	writel(val, base + reg);
>  }
>  
> -static u32 exynos_elb_readl(struct exynos_pcie *exynos_pcie, u32 reg)
> +static u32 exynos_pcie_readl(void __iomem *base, u32 reg)
>  {
> -	return readl(exynos_pcie->elbi_base + reg);
> +	return readl(base + reg);
>  }
>  
> -static void exynos_phy_writel(struct exynos_pcie *exynos_pcie, u32 val, u32 reg)
> -{
> -	writel(val, exynos_pcie->phy_base + reg);
> -}
> -
> -static u32 exynos_phy_readl(struct exynos_pcie *exynos_pcie, u32 reg)
> -{
> -	return readl(exynos_pcie->phy_base + reg);
> -}
> -
> -static void exynos_blk_writel(struct exynos_pcie *exynos_pcie, u32 val, u32 reg)
> -{
> -	writel(val, exynos_pcie->block_base + reg);
> -}
> -
> -static u32 exynos_blk_readl(struct exynos_pcie *exynos_pcie, u32 reg)
> -{
> -	return readl(exynos_pcie->block_base + reg);
> -}
> -
> -static void exynos_pcie_sideband_dbi_w_mode(struct exynos_pcie *exynos_pcie,
> -					    bool on)
> +static void exynos_pcie_sideband_dbi_w_mode(struct exynos_pcie *ep, bool on)

Replacing all the separate accessors with one that takes the base
pointer is OK, but please use the same name for all the "struct
exynos_pcie *" pointers in the whole file.

Before your patch, they were all called "exynos_pci"; after it some
are called "exynos_pci" and some are called "ep".

Bjorn
