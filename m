Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750725AbdHBVnG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Aug 2017 17:43:06 -0400
Date: Wed, 2 Aug 2017 16:43:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: bhelgaas@google.com, thomas.petazzoni@free-electrons.com,
        jason@lakedaemon.net, linux-pci@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH] PCI: mvebu: Remove unneeded gpiod NULL check
Message-ID: <20170802214302.GK20308@bhelgaas-glaptop.roam.corp.google.com>
References: <1500239773-15632-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1500239773-15632-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jul 16, 2017 at 06:16:13PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> The gpiod API checks for NULL descriptors, so there is no need to
> duplicate the check in the driver.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied with Thomas' ack to pci/host-mvebu for v4.14, thanks!

> ---
>  drivers/pci/host/pci-mvebu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> index f353a6e..fa227d8 100644
> --- a/drivers/pci/host/pci-mvebu.c
> +++ b/drivers/pci/host/pci-mvebu.c
> @@ -1186,8 +1186,7 @@ static int mvebu_pcie_powerup(struct mvebu_pcie_port *port)
>   */
>  static void mvebu_pcie_powerdown(struct mvebu_pcie_port *port)
>  {
> -	if (port->reset_gpio)
> -		gpiod_set_value_cansleep(port->reset_gpio, 1);
> +	gpiod_set_value_cansleep(port->reset_gpio, 1);
>  
>  	clk_disable_unprepare(port->clk);
>  }
> -- 
> 2.7.4
> 
