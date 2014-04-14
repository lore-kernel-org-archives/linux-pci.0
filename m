Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from am1ehsobe001.messaging.microsoft.com ([213.199.154.204]:18384
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750768AbaDNTfS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 14 Apr 2014 15:35:18 -0400
From: Rajat Jain <rajatjain@juniper.net>
To: Rajat Jain <rajatxjain@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Guenter Roeck <groeck@juniper.net>
Subject: RE: [PATCH v2] pci: Allow hotplug service drivers to operate in
 polling mode
Date: Mon, 14 Apr 2014 19:35:11 +0000
Message-ID: <cf4f3cfede2744a5931034aedfcdf4aa@DM2PR05MB671.namprd05.prod.outlook.com>
References: <5339FF7B.4020904@gmail.com>
In-Reply-To: <5339FF7B.4020904@gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Bjorn,

Just wondering if you got a chance to look at this one. This independent of my other patch (that makes polling, a per-port thing). 

Without this patch - today the hot-plug service cannot be used at all in polling mode IF the interrupts are broken (which I'd assume is the case when one would want to resort to use polling).

Thanks,

Rajat

> -----Original Message-----
> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
> owner@vger.kernel.org] On Behalf Of Rajat Jain
> Sent: Monday, March 31, 2014 4:51 PM
> To: Bjorn Helgaas; linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Rajat Jain; Guenter Roeck
> Subject: [PATCH v2] pci: Allow hotplug service drivers to operate in polling
> mode
> 
> Today the PCIe port bus driver disables the Hot-plug service if the port device
> does not have the capability to generate interrupts.
> However, a user must be able to use the "pciehp_poll_mode" parameter to
> use the pciehp in polling method in such a case. Today it is not possible.
> 
> This patch allows a hotplug service driver to decide whether or not it would
> like to continue in absense of interrupts.
> 
> Signed-off-by: Rajat Jain <rajatxjain@gmail.com>
> Signed-off-by: Rajat Jain <rajatjain@juniper.net>
> Signed-off-by: Guenter Roeck <groeck@juniper.net>
> ---
> v2: Drop the extra debug msg in pciehp
>     (and just retain the changes in portdrv_core.c)
> 
>  drivers/pci/pcie/portdrv_core.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 0b6e766..ba31deb 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -377,10 +377,13 @@ int pcie_port_device_register(struct pci_dev *dev)
>  	/*
>  	 * Initialize service irqs. Don't use service devices that
>  	 * require interrupts if there is no way to generate them.
> +	 * However, some drivers may have a polling mode (e.g
> pciehp_poll_mode)
> +	 * that can be used in absense of irqs. Allow them to determine
> +	 * if that is to be used.
>  	 */
>  	status = init_service_irqs(dev, irqs, capabilities);
>  	if (status) {
> -		capabilities &= PCIE_PORT_SERVICE_VC;
> +		capabilities &= PCIE_PORT_SERVICE_VC |
> PCIE_PORT_SERVICE_HP;
>  		if (!capabilities)
>  			goto error_disable;
>  	}
> --
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
> 


