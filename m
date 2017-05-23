Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1764518AbdEWTjz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 May 2017 15:39:55 -0400
Date: Tue, 23 May 2017 14:39:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH 1/4] PCI: rockchip: rename rockchip_cfg_atu to
 rockchip_pcie_cfg_atu
Message-ID: <20170523193953.GB7241@bhelgaas-glaptop.roam.corp.google.com>
References: <1493864691-102523-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1493864691-102523-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 04, 2017 at 10:24:48AM +0800, Shawn Lin wrote:
> Rename it in order to keep the name consistent with other
> functions' in pcie-rockchip.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied all four of these to pci/host-rockchip for v4.13, thanks!

I dropped some extra blank lines from patch 3.

> ---
> 
>  drivers/pci/host/pcie-rockchip.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index c8ca796..ac08b4c 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -1156,7 +1156,7 @@ static int rockchip_pcie_prog_ib_atu(struct rockchip_pcie *rockchip,
>  	return 0;
>  }
>  
> -static int rockchip_cfg_atu(struct rockchip_pcie *rockchip)
> +static int rockchip_pcie_cfg_atu(struct rockchip_pcie *rockchip)
>  {
>  	struct device *dev = rockchip->dev;
>  	int offset;
> @@ -1279,7 +1279,7 @@ static int __maybe_unused rockchip_pcie_resume_noirq(struct device *dev)
>  	if (err)
>  		return err;
>  
> -	err = rockchip_cfg_atu(rockchip);
> +	err = rockchip_pcie_cfg_atu(rockchip);
>  	if (err)
>  		return err;
>  
> @@ -1396,7 +1396,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	err = rockchip_cfg_atu(rockchip);
> +	err = rockchip_pcie_cfg_atu(rockchip);
>  	if (err)
>  		goto err_free_res;
>  
> -- 
> 1.9.1
> 
> 
