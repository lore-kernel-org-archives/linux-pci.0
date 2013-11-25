Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:54488 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756685Ab3KYUDC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 25 Nov 2013 15:03:02 -0500
Date: Mon, 25 Nov 2013 13:02:56 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Jason Cooper <jason@lakedaemon.net>,
	Jingoo Han <jg1.han@samsung.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: PCI: mvebu: return NULL instead of ERR_PTR(ret)
Message-ID: <20131125200256.GA7316@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <001001ceb816$5d1aecc0$1750c640$%han@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Nov 23, 2013 at 10:00:33PM -0500, Jason Cooper wrote:
> And a small addendum: I currently have the following in mvebu/drivers
>   058100a08be8 PCI: mvebu: return NULL instead of ERR_PTR(ret)

Folks, I took a quick look at this, and it looks suspicious (sorry, I
can't seem to find the thread to followup post)

>    PCI: mvebu: return NULL instead of ERR_PTR(ret)
>    
>    Return NULL instead of ERR_PTR(ret) in order to fix the following
>    sparse warning:
>    
>    drivers/pci/host/pci-mvebu.c:744:31: warning: incorrect type in return expression (different address
>    spaces)
>    drivers/pci/host/pci-mvebu.c:744:31:    expected void [noderef] <asn:2>*
>    drivers/pci/host/pci-mvebu.c:744:31:    got void *
>    
>    Signed-off-by: Jingoo Han <jg1.han@samsung.com>
>    Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>    Signed-off-by: Jason Cooper <jason@lakedaemon.net>
>
>--- a/drivers/pci/host/pci-mvebu.c
>+++ b/drivers/pci/host/pci-mvebu.c
>@@ -740,7 +740,7 @@ static void __iomem *mvebu_pcie_map_registers(struct platform_device *pdev,
> 
>        ret = of_address_to_resource(np, 0, &regs);
>        if (ret)
>-               return ERR_PTR(ret);
>+               return NULL;
> 
>        return devm_ioremap_resource(&pdev->dev, &regs);

So we drop the ERR_PTR for that return but 'devm_ioremap_resource'
returns ERR_PTR too:

/**
 * devm_ioremap_resource() - check, request region, and ioremap resource
 * @dev: generic device to handle the resource for
 * @res: resource to be handled
 *
 * Checks that a resource is a valid memory region, requests the memory region
 * and ioremaps it either as cacheable or as non-cacheable memory depending on
 * the resource's flags. All operations are managed and will be undone on
 * driver detach.
 *
 * Returns a pointer to the remapped memory or an ERR_PTR() encoded error code
 * on failure. Usage example:
 *
 *      res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 *      base = devm_ioremap_resource(&pdev->dev, res);
 *      if (IS_ERR(base))
 *              return PTR_ERR(base);

So this is clearly wrong:
 
> 		port->base = mvebu_pcie_map_registers(pdev, child, port);
>-		if (IS_ERR(port->base)) {
>+		if (!port->base) {
> 			dev_err(&pdev->dev,

NAK I guess?

This looks like a sparse problem, doesn't it complain for
devm_ioremap_resource too?

void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res)
{
[..]
                return ERR_PTR(-EBUSY);

Regards,
Jason
