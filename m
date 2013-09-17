Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:27850 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841Ab3IQAwI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Sep 2013 20:52:08 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MT8009XQVQVLND0@mailout2.samsung.com> for
 linux-pci@vger.kernel.org; Tue, 17 Sep 2013 09:52:07 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	'Jason Cooper' <jason@lakedaemon.net>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <000201ceaf9b$098780b0$1c968210$%han@samsung.com>
 <000501ceaf9b$acaec690$060c53b0$%han@samsung.com>
 <20130916175706.3b43b3c4@skate>
In-reply-to: <20130916175706.3b43b3c4@skate>
Subject: Re: [PATCH 3/3] PCI: mvebu: add missing __iomem annotation
Date: Tue, 17 Sep 2013 09:52:06 +0900
Message-id: <000201ceb340$21d48de0$657da9a0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, September 17, 2013 12:57 AM, Thomas Petazzoni wrote:
> On Thu, 12 Sep 2013 18:37:18 +0900, Jingoo Han wrote:
> 
> >  	ret = of_address_to_resource(np, 0, &regs);
> >  	if (ret)
> > -		return ERR_PTR(ret);
> > +		return (void __iomem *)ERR_PTR(ret);
> 
> This doesn't look very pretty to tell the truth, but I don't quite see
> any other option. Just return NULL when of_address_to_resource() fails
> instead of trying to propagate the error? Make this entire function
> return an 'int' and have the iomem address returned through a pointer
> passed by address as argument to the function? Any other suggestion?
> 

Hi Thomas Petazzoni,
I appreciated your feedback. :-)

'Just returning NULL when of_address_to_resource() fails
instead of trying to propagate the error' looks better.

Then, how about the following?

--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -728,7 +728,7 @@ mvebu_pcie_map_registers(struct platform_device *pdev,

	ret = of_address_to_resource(np, 0, &regs);
	if (ret)
-		return ERR_PTR(ret);
+		return NULL;

	return devm_ioremap_resource(&pdev->dev, &regs);
 }
@@ -874,7 +874,7 @@ static int __init mvebu_pcie_probe(struct platform_device *pdev)
		}

		port->base = mvebu_pcie_map_registers(pdev, child, port);
-		if (IS_ERR(port->base)) {
+		if (!port->base) {
			dev_err(&pdev->dev, "PCIe%d.%d: cannot map registers\n",
  				port->port, port->lane);
			port->base = NULL;

Best regards,
Jingoo Han

