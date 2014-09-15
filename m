Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0133.outbound.protection.outlook.com ([157.56.110.133]:39552
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756222AbaIOWet convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 15 Sep 2014 18:34:49 -0400
From: Rajat Jain <rajatjain@juniper.net>
To: Andreas Noever <andreas.noever@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Guenter Roeck <groeck@juniper.net>,
	"rajatxjain@gmail.com" <rajatxjain@gmail.com>,
	"Guenter Roeck" <linux@roeck-us.net>
Subject: RE: [PATCH] PCI: Prevent NULL dereference during pciehp probe
Date: Mon, 15 Sep 2014 22:20:41 +0000
Message-ID: <580c2c85f8424369910b69a8f871f82e@DM2PR05MB671.namprd05.prod.outlook.com>
References: <1402347812-8059-1-git-send-email-andreas.noever@gmail.com>
In-Reply-To: <1402347812-8059-1-git-send-email-andreas.noever@gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Bjorn,

I think this patch needs to be applied to all -stable branches (all the way back to 3.2).

I encounter this same issue on my platform that is running 3.14.y. 

Thanks,

Rajat

> -----Original Message-----
> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
> owner@vger.kernel.org] On Behalf Of Andreas Noever
> Sent: Monday, June 09, 2014 2:04 PM
> To: linux-kernel@vger.kernel.org; Bjorn Helgaas; linux-pci@vger.kernel.org
> Cc: Andreas Noever
> Subject: [PATCH] PCI: Prevent NULL dereference during pciehp probe
> 
> pciehp assumes that dev->subordinate exists. But we do not assign a bus if
> we run out of bus numbers during enumeration. This leads to a NULL
> dereference in init_slot (and other places).
> 
> Change pciehp_probe to return -ENODEV when no subordinate bus is
> present.
> 
> Signed-off-by: Andreas Noever <andreas.noever@gmail.com>
> ---
>  drivers/pci/hotplug/pciehp_core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/pciehp_core.c
> b/drivers/pci/hotplug/pciehp_core.c
> index 0e0a2ff..e5abcaf 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -255,6 +255,13 @@ static int pciehp_probe(struct pcie_device *dev)
>  	else if (pciehp_acpi_slot_detection_check(dev->port))
>  		goto err_out_none;
> 
> +	if (!dev->port->subordinate) {
> +		/* Can happen if we run out of bus numbers during probe */
> +		dev_err(&dev->device,
> +			"Hotplug bridge without secondary bus, ignoring\n");
> +		goto err_out_none;
> +	}
> +
>  	ctrl = pcie_init(dev);
>  	if (!ctrl) {
>  		dev_err(&dev->device, "Controller initialization failed\n");
> --
> 2.0.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
