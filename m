Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:58863 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752591Ab3JOJMK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Oct 2013 05:12:10 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MUP002PHDK8C080@mailout4.samsung.com> for
 linux-pci@vger.kernel.org; Tue, 15 Oct 2013 18:12:08 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Jason Cooper' <jason@lakedaemon.net>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	'Jason Cooper' <jason@lakedaemon.net>,
	'Andrew Lunn' <andrew@lunn.ch>,
	'Gregory Clement' <gregory.clement@free-electrons.com>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <000c01ceb816$19f0dd10$4dd29730$%han@samsung.com>
 <000101ceb826$8695b7f0$93c127d0$%han@samsung.com>
In-reply-to: <000101ceb826$8695b7f0$93c127d0$%han@samsung.com>
Subject: Re: [PATCH V3 3/3] PCI: mvebu: return NULL instead of ERR_PTR(ret)
Date: Tue, 15 Oct 2013 18:12:07 +0900
Message-id: <000001cec986$9f8ef570$deace050$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, September 23, 2013 3:31 PM, Jingoo Han wrote:
> 
> Return NULL instead of ERR_PTR(ret) in order to fix the following
> sparse warning:
> 
> drivers/pci/host/pci-mvebu.c:744:31: warning: incorrect type in return expression (different address
> spaces)
> drivers/pci/host/pci-mvebu.c:744:31:    expected void [noderef] <asn:2>*
> drivers/pci/host/pci-mvebu.c:744:31:    got void *
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

(+cc Andrew Lunn, Gregory Clement)

Hi Jason Cooper,

Would you apply this patch into your 'linux-mvebu.git' tree?
It was already Acked by Thomas Petazzoni.
Also, it is a trivial change to fix sparse warning.
Thank you.

Best regards,
Jingoo Han

> ---
>  drivers/pci/host/pci-mvebu.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> index 0bd3ba8..fb2474f 100644
> --- a/drivers/pci/host/pci-mvebu.c
> +++ b/drivers/pci/host/pci-mvebu.c
> @@ -741,7 +741,7 @@ static void __iomem *mvebu_pcie_map_registers(struct platform_device *pdev,
> 
>  	ret = of_address_to_resource(np, 0, &regs);
>  	if (ret)
> -		return ERR_PTR(ret);
> +		return NULL;
> 
>  	return devm_ioremap_resource(&pdev->dev, &regs);
>  }
> @@ -940,10 +940,9 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
>  			continue;
> 
>  		port->base = mvebu_pcie_map_registers(pdev, child, port);
> -		if (IS_ERR(port->base)) {
> +		if (!port->base) {
>  			dev_err(&pdev->dev, "PCIe%d.%d: cannot map registers\n",
>  				port->port, port->lane);
> -			port->base = NULL;
>  			clk_disable_unprepare(port->clk);
>  			continue;
>  		}
> --
> 1.7.10.4


