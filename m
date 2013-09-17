Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:59095 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751846Ab3IQErD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Sep 2013 00:47:03 -0400
Date: Tue, 17 Sep 2013 06:47:00 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	'Jason Cooper' <jason@lakedaemon.net>
Subject: Re: [PATCH 3/3] PCI: mvebu: add missing __iomem annotation
Message-ID: <20130917064700.57964d15@skate>
In-Reply-To: <000201ceb340$21d48de0$657da9a0$%han@samsung.com>
References: <000201ceaf9b$098780b0$1c968210$%han@samsung.com>
	<000501ceaf9b$acaec690$060c53b0$%han@samsung.com>
	<20130916175706.3b43b3c4@skate>
	<000201ceb340$21d48de0$657da9a0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jingoo Han,

On Tue, 17 Sep 2013 09:52:06 +0900, Jingoo Han wrote:

> 'Just returning NULL when of_address_to_resource() fails
> instead of trying to propagate the error' looks better.
> 
> Then, how about the following?
> 
> --- a/drivers/pci/host/pci-mvebu.c
> +++ b/drivers/pci/host/pci-mvebu.c
> @@ -728,7 +728,7 @@ mvebu_pcie_map_registers(struct platform_device *pdev,
> 
> 	ret = of_address_to_resource(np, 0, &regs);
> 	if (ret)
> -		return ERR_PTR(ret);
> +		return NULL;
> 
> 	return devm_ioremap_resource(&pdev->dev, &regs);
>  }
> @@ -874,7 +874,7 @@ static int __init mvebu_pcie_probe(struct platform_device *pdev)
> 		}
> 
> 		port->base = mvebu_pcie_map_registers(pdev, child, port);
> -		if (IS_ERR(port->base)) {
> +		if (!port->base) {
> 			dev_err(&pdev->dev, "PCIe%d.%d: cannot map registers\n",
>   				port->port, port->lane);
> 			port->base = NULL;

Yes, I believe it makes more sense since we were anyway to using the
error code returned by of_address_to_ressource().

However, you can get rid of the port->base = NULL assignment in the if
() { ... } code now.

With that fixed, you can add my:

Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
