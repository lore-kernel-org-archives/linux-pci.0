Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:35741 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758463AbaGXDwg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jul 2014 23:52:36 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N9700AF96RMBM50@mailout2.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 24 Jul 2014 12:52:34 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Lucas Stach' <l.stach@pengutronix.de>,
	'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, 'Richard Zhu' <r65037@freescale.com>,
	'Shawn Guo' <shawn.guo@freescale.com>, kernel@pengutronix.de,
	'Jingoo Han' <jg1.han@samsung.com>
References: <1406137217-11294-1-git-send-email-l.stach@pengutronix.de>
 <1406137217-11294-3-git-send-email-l.stach@pengutronix.de>
In-reply-to: <1406137217-11294-3-git-send-email-l.stach@pengutronix.de>
Subject: Re: [PATCH 2/3] PCI: imx6: prevent driver unbind
Date: Thu, 24 Jul 2014 12:52:34 +0900
Message-id: <001101cfa6f2$b39c86f0$1ad594d0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, July 24, 2014 2:40 AM, Lucas Stach wrote:
> 
> The current code is not prepared for the driver to be
> bound/unbound arbitrarily.
> 
> Prevent possible user visible issues by disabling the
> bind sysfs attributes.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/pci/host/pci-imx6.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index a568efaa331c..ceb1677884b2 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -600,6 +600,7 @@ static struct platform_driver imx6_pcie_driver = {
>  		.name	= "imx6q-pcie",
>  		.owner	= THIS_MODULE,
>  		.of_match_table = imx6_pcie_of_match,
> +		.suppress_bind_attrs = true,

pci-imx6.c already uses platform_driver_probe().
In platform_driver_probe(),suppress_bind_attrs is set as true as below,

./drivers/base/platform.c

int __init_or_module platform_driver_probe(struct platform_driver *drv,
		int (*probe)(struct platform_device *))
{
	int retval, code;

	/*
	 * Prevent driver from requesting probe deferral to avoid further
	 * futile probe attempts.
	 */
	drv->prevent_deferred_probe = true;

	/* make sure driver won't have bind/unbind attributes */
	drv->driver.suppress_bind_attrs = true;

So, it looks duplicated.
Is there any reason to do it twice?

Best regards,
Jingoo Han

>  	},
>  };
> 
> --
> 2.0.1

