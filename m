Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:41604 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751641AbdH1BR4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Aug 2017 21:17:56 -0400
Cc: bhelgaas@google.com, shawn.lin@rock-chips.com, heiko@sntech.de,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH RESEND] PCI: rockchip: Use gpiod_set_value_cansleep() to
 allow reset via expanders
To: Fabio Estevam <festevam@gmail.com>
References: <1503879957-30008-1-git-send-email-festevam@gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <02c4f70f-3285-ebf5-c2fe-8aee7c23b133@rock-chips.com>
Date: Mon, 28 Aug 2017 09:17:55 +0800
MIME-Version: 1.0
In-Reply-To: <1503879957-30008-1-git-send-email-festevam@gmail.com>
Content-Type: text/plain; charset=gbk; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2017/8/28 8:25, Fabio Estevam wrote:
> The reset GPIO can be connected to a I2C or SPI IO expander, which may
> sleep, so it is safer to use the gpiod_set_value_cansleep() variant
> instead.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
> Changes since v1:
> - Resending with Shawn Lin added on Cc.
> 
>   drivers/pci/host/pcie-rockchip.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Shawn Lin <shawn.lin@rock-chips.com>

> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index 2eccd53..124b280 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -537,7 +537,7 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>   	int err, i;
>   	u32 status;
>   
> -	gpiod_set_value(rockchip->ep_gpio, 0);
> +	gpiod_set_value_cansleep(rockchip->ep_gpio, 0);
>   
>   	err = reset_control_assert(rockchip->aclk_rst);
>   	if (err) {
> @@ -682,7 +682,7 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>   	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
>   			    PCIE_CLIENT_CONFIG);
>   
> -	gpiod_set_value(rockchip->ep_gpio, 1);
> +	gpiod_set_value_cansleep(rockchip->ep_gpio, 1);
>   
>   	/* 500ms timeout value should be enough for Gen1/2 training */
>   	err = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_BASIC_STATUS1,
> 
