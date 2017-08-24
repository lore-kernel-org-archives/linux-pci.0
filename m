Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751197AbdHXQd0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Aug 2017 12:33:26 -0400
Date: Thu, 24 Aug 2017 11:33:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: bhelgaas@google.com, heiko@sntech.de, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: rockchip: Use gpiod_set_value_cansleep() to allow
 reset via expanders
Message-ID: <20170824163323.GG31858@bhelgaas-glaptop.roam.corp.google.com>
References: <1503187634-3823-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503187634-3823-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Aug 19, 2017 at 09:07:14PM -0300, Fabio Estevam wrote:
> The reset GPIO can be connected to a I2C or SPI IO expander, which may
> sleep, so it is safer to use the gpiod_set_value_cansleep() variant
> instead.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Waiting for Shawn's ack...

> ---
>  drivers/pci/host/pcie-rockchip.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index 2eccd53..124b280 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -537,7 +537,7 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  	int err, i;
>  	u32 status;
>  
> -	gpiod_set_value(rockchip->ep_gpio, 0);
> +	gpiod_set_value_cansleep(rockchip->ep_gpio, 0);
>  
>  	err = reset_control_assert(rockchip->aclk_rst);
>  	if (err) {
> @@ -682,7 +682,7 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
>  			    PCIE_CLIENT_CONFIG);
>  
> -	gpiod_set_value(rockchip->ep_gpio, 1);
> +	gpiod_set_value_cansleep(rockchip->ep_gpio, 1);
>  
>  	/* 500ms timeout value should be enough for Gen1/2 training */
>  	err = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_BASIC_STATUS1,
> -- 
> 2.7.4
> 
