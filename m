Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yh0-f45.google.com ([209.85.213.45]:37030 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758780Ab3LGWkn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 7 Dec 2013 17:40:43 -0500
Received: by mail-yh0-f45.google.com with SMTP id v1so1598072yhn.32
        for <linux-pci@vger.kernel.org>; Sat, 07 Dec 2013 14:40:43 -0800 (PST)
Date: Sat, 7 Dec 2013 15:40:40 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Eric Brower <ebrower@nvidia.com>
Cc: thierry.reding@gmail.com, linux-pci@vger.kernel.org,
	swarren@wwwdotorg.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] PCI: Disable Gen2 for Tegra20 and Tegra30
Message-ID: <20131207224040.GB7901@google.com>
References: <1384815306-3149-1-git-send-email-ebrower@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384815306-3149-1-git-send-email-ebrower@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 18, 2013 at 02:55:06PM -0800, Eric Brower wrote:
> Tegra20 and Tegra30 do not support gen2 PCIe, so correct the
> register setting to disable it.
> 
> Signed-off-by: Eric Brower <ebrower@nvidia.com>

Applied with Thierry's ack to pci/host-tegra for v3.14, thanks!

Bjorn

> ---
>  drivers/pci/host/pci-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index 0afbbbc..b8ba2f7 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -805,7 +805,7 @@ static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
>  	afi_writel(pcie, value, AFI_PCIE_CONFIG);
>  
>  	value = afi_readl(pcie, AFI_FUSE);
> -	value &= ~AFI_FUSE_PCIE_T0_GEN2_DIS;
> +	value |= AFI_FUSE_PCIE_T0_GEN2_DIS;
>  	afi_writel(pcie, value, AFI_FUSE);
>  
>  	/* initialize internal PHY, enable up to 16 PCIE lanes */
> -- 
> 1.8.1.5
> 
