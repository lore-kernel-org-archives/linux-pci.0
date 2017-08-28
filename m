Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751182AbdH1SRc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Aug 2017 14:17:32 -0400
Date: Mon, 28 Aug 2017 13:17:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: bhelgaas@google.com, shawn.lin@rock-chips.com, heiko@sntech.de,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH RESEND] PCI: rockchip: Use gpiod_set_value_cansleep() to
 allow reset via expanders
Message-ID: <20170828181730.GG8154@bhelgaas-glaptop.roam.corp.google.com>
References: <1503879957-30008-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503879957-30008-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Aug 27, 2017 at 09:25:57PM -0300, Fabio Estevam wrote:
> The reset GPIO can be connected to a I2C or SPI IO expander, which may
> sleep, so it is safer to use the gpiod_set_value_cansleep() variant
> instead.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied with Shawn's ack to pci/host-rockchip for v4.14, thanks!

> ---
> Changes since v1:
> - Resending with Shawn Lin added on Cc.
> 
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
