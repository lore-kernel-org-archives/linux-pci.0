Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750826AbeBVUJC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Feb 2018 15:09:02 -0500
Date: Thu, 22 Feb 2018 14:09:01 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tal Gilboa <talgi@mellanox.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Tariq Toukan <tariqt@mellanox.com>
Subject: Re: [PATCH next V1 7/7] net/mlx5e: Use generic PCI function for BW
 calculation
Message-ID: <20180222200901.GC16519@bhelgaas-glaptop.roam.corp.google.com>
References: <1516030541-6626-1-git-send-email-talgi@mellanox.com>
 <1516030541-6626-8-git-send-email-talgi@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1516030541-6626-8-git-send-email-talgi@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 15, 2018 at 05:35:41PM +0200, Tal Gilboa wrote:
> Newly introduced pcie_get_link_limits() function calculates
> maximum available BW through the PCI chain. We can use this
> value for mlx5e_get_pci_bw() instead of calculating ourselves.
> 
> Signed-off-by: Tal Gilboa <talgi@mellanox.com>
> Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index d2b057a..d1d7427 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -3971,27 +3971,16 @@ static int mlx5e_get_pci_bw(struct mlx5_core_dev *mdev, u32 *pci_bw)
>  	enum pcie_link_width width;
>  	enum pci_bus_speed speed;
>  	int err = 0;
> +	int bw;
>  
> -	err = pcie_get_minimum_link(mdev->pdev, &speed, &width);
> +	err = pcie_get_link_limits(mdev->pdev, &speed, &width, &bw);

Why don't you refactor this a little so it calls
pcie_print_link_status() like mlx5 and mlx4?

I think this is the only call of pcie_get_link_limits() outside
drivers/pci, and it seems like a little overkill here since you really
don't need "speed" here.

But I don't understand what's going on with mlx5e_get_max_linkspeed().
It doesn't look like that is actually looking at the PCIe link speed,
so maybe there's something special going on there.

>  	if (err)
>  		return err;
>  
>  	if (speed == PCI_SPEED_UNKNOWN || width == PCIE_LNK_WIDTH_UNKNOWN)
>  		return -EINVAL;
>  
> -	switch (speed) {
> -	case PCIE_SPEED_2_5GT:
> -		*pci_bw = 2500 * width;
> -		break;
> -	case PCIE_SPEED_5_0GT:
> -		*pci_bw = 5000 * width;
> -		break;
> -	case PCIE_SPEED_8_0GT:
> -		*pci_bw = 8000 * width;
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> +	*pci_bw = bw;
>  
>  	return 0;
>  }
> -- 
> 1.8.3.1
> 
