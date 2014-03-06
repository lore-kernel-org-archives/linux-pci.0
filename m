Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:56545 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444AbaCFEMb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Mar 2014 23:12:31 -0500
Date: Thu, 6 Mar 2014 13:12:28 +0900
From: Simon Horman <horms@verge.net.au>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	Jingoo Han <jg1.han@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Ben Dooks <ben-linux@fluff.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, kernel@pengutronix.de
Subject: Re: [PATCH v2 3/6] PCI: rcar: use new OF interrupt mapping when
 possible
Message-ID: <20140306041228.GA28351@verge.net.au>
References: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de>
 <1394025951-32438-4-git-send-email-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1394025951-32438-4-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 05, 2014 at 02:25:48PM +0100, Lucas Stach wrote:
> This is the recommended method of doing the IRQ
> mapping. Still fall back to the old method in order
> to not break the just submitted board files.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Assuming that it does what it says on the wrapper:

Acked-by: Simon Horman <horms+renesas@verge.net.au>


> ---
> v2: pass in parent device to pci_common_init(), to
>     make DT parsing work.
> ---
>  drivers/pci/host/pci-rcar-gen2.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
> index ceec147baec3..3a0914163ad0 100644
> --- a/drivers/pci/host/pci-rcar-gen2.c
> +++ b/drivers/pci/host/pci-rcar-gen2.c
> @@ -15,6 +15,7 @@
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/of_pci.h>
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> @@ -160,8 +161,13 @@ static int __init rcar_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
>  {
>  	struct pci_sys_data *sys = dev->bus->sysdata;
>  	struct rcar_pci_priv *priv = sys->private_data;
> +	int irq;
> +
> +	irq = of_irq_parse_and_map_pci(dev, slot, pin);
> +	if (!irq)
> +		irq = priv->irq;
>  
> -	return priv->irq;
> +	return irq;
>  }
>  
>  /* PCI host controller setup */
> @@ -249,6 +255,8 @@ static int __init rcar_pci_add_controller(struct rcar_pci_priv *priv)
>  	void **private_data;
>  	int count;
>  
> +	pci_common_init_dev(priv->dev, &rcar_hw_pci);
> +
>  	if (rcar_hw_pci.nr_controllers < rcar_pci_count)
>  		goto add_priv;
>  
> @@ -322,8 +330,6 @@ static int __init rcar_pci_init(void)
>  	int retval;
>  
>  	retval = platform_driver_probe(&rcar_pci_driver, rcar_pci_probe);
> -	if (!retval)
> -		pci_common_init(&rcar_hw_pci);
>  
>  	/* Private data pointer array is not needed any more */
>  	kfree(rcar_hw_pci.private_data);
> -- 
> 1.9.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
