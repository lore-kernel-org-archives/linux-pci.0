Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:24913 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078Ab3KZFbq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Nov 2013 00:31:46 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MWU00MP1VCX3U40@mailout2.samsung.com> for
 linux-pci@vger.kernel.org; Tue, 26 Nov 2013 14:31:45 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Jason Gunthorpe' <jgunthorpe@obsidianresearch.com>,
	'Jason Cooper' <jason@lakedaemon.net>
Cc: 'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	'Ezequiel Garcia' <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	'Jingoo Han' <jg1.han@samsung.com>
References: <001001ceb816$5d1aecc0$1750c640$%han@samsung.com>
 <20131125200256.GA7316@obsidianresearch.com>
In-reply-to: <20131125200256.GA7316@obsidianresearch.com>
Subject: Re: PCI: mvebu: return NULL instead of ERR_PTR(ret)
Date: Tue, 26 Nov 2013 14:31:44 +0900
Message-id: <001101ceea68$cb486220$61d92660$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


On Tuesday, November 26, 2013 5:03 AM, Jason Gunthorpe wrote:
> On Sat, Nov 23, 2013 at 10:00:33PM -0500, Jason Cooper wrote:
> > And a small addendum: I currently have the following in mvebu/drivers
> >   058100a08be8 PCI: mvebu: return NULL instead of ERR_PTR(ret)
> 
> Folks, I took a quick look at this, and it looks suspicious (sorry, I
> can't seem to find the thread to followup post)
> 
> >    PCI: mvebu: return NULL instead of ERR_PTR(ret)
> >
> >    Return NULL instead of ERR_PTR(ret) in order to fix the following
> >    sparse warning:
> >
> >    drivers/pci/host/pci-mvebu.c:744:31: warning: incorrect type in return expression (different
> address
> >    spaces)
> >    drivers/pci/host/pci-mvebu.c:744:31:    expected void [noderef] <asn:2>*
> >    drivers/pci/host/pci-mvebu.c:744:31:    got void *
> >
> >    Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> >    Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> >    Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> >
> >--- a/drivers/pci/host/pci-mvebu.c
> >+++ b/drivers/pci/host/pci-mvebu.c
> >@@ -740,7 +740,7 @@ static void __iomem *mvebu_pcie_map_registers(struct platform_device *pdev,
> >
> >        ret = of_address_to_resource(np, 0, &regs);
> >        if (ret)
> >-               return ERR_PTR(ret);
> >+               return NULL;
> >
> >        return devm_ioremap_resource(&pdev->dev, &regs);
> 
> So we drop the ERR_PTR for that return but 'devm_ioremap_resource'
> returns ERR_PTR too:

Yes, you're right.
It makes the problem.
Thus, this commit "PCI: mvebu: return NULL instead of ERR_PTR(ret)"
should be reverted.


Previously, I sent the patch in order to fix sparse warning as below:
How about this?

static void __iomem *mvebu_pcie_map_registers(struct platform_device *pdev,
			struct device_node *np, struct mvebu_pcie_port *port)
{
	struct resource regs;
	int ret = 0;

	ret = of_address_to_resource(np, 0, &regs);
	if (ret)
-		return ERR_PTR(ret);
+		return (void __iomem *)ERR_PTR(ret);

	return devm_ioremap_resource(&pdev->dev, &regs);
}

static int mvebu_pcie_probe(struct platform_device *pdev)
{
		.....
		port->base = mvebu_pcie_map_registers(pdev, child, port);
		if (IS_ERR(port->base)) {
			dev_err(&pdev->dev, "PCIe%d.%d: cannot map registers\n",
				port->port, port->lane);
			port->base = NULL;
			clk_disable_unprepare(port->clk);
			continue;
		}


Best regards,
Jingoo Han

