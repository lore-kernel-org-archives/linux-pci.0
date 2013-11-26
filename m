Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:10266 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744Ab3KZM1X (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Nov 2013 07:27:23 -0500
Date: Tue, 26 Nov 2013 07:27:10 -0500
From: Jason Cooper <jason@lakedaemon.net>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Jason Gunthorpe' <jgunthorpe@obsidianresearch.com>,
	'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	'Ezequiel Garcia' <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: PCI: mvebu: return NULL instead of ERR_PTR(ret)
Message-ID: <20131126122710.GG2879@titan.lakedaemon.net>
References: <001001ceb816$5d1aecc0$1750c640$%han@samsung.com>
 <20131125200256.GA7316@obsidianresearch.com>
 <001101ceea68$cb486220$61d92660$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <001101ceea68$cb486220$61d92660$%han@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 26, 2013 at 02:31:44PM +0900, Jingoo Han wrote:
> 
> On Tuesday, November 26, 2013 5:03 AM, Jason Gunthorpe wrote:
> > On Sat, Nov 23, 2013 at 10:00:33PM -0500, Jason Cooper wrote:
> > > And a small addendum: I currently have the following in mvebu/drivers
> > >   058100a08be8 PCI: mvebu: return NULL instead of ERR_PTR(ret)
> > 
> > Folks, I took a quick look at this, and it looks suspicious (sorry, I
> > can't seem to find the thread to followup post)
> > 
> > >    PCI: mvebu: return NULL instead of ERR_PTR(ret)
> > >
> > >    Return NULL instead of ERR_PTR(ret) in order to fix the following
> > >    sparse warning:
> > >
> > >    drivers/pci/host/pci-mvebu.c:744:31: warning: incorrect type in return expression (different
> > address
> > >    spaces)
> > >    drivers/pci/host/pci-mvebu.c:744:31:    expected void [noderef] <asn:2>*
> > >    drivers/pci/host/pci-mvebu.c:744:31:    got void *
> > >
> > >    Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > >    Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > >    Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> > >
> > >--- a/drivers/pci/host/pci-mvebu.c
> > >+++ b/drivers/pci/host/pci-mvebu.c
> > >@@ -740,7 +740,7 @@ static void __iomem *mvebu_pcie_map_registers(struct platform_device *pdev,
> > >
> > >        ret = of_address_to_resource(np, 0, &regs);
> > >        if (ret)
> > >-               return ERR_PTR(ret);
> > >+               return NULL;
> > >
> > >        return devm_ioremap_resource(&pdev->dev, &regs);
> > 
> > So we drop the ERR_PTR for that return but 'devm_ioremap_resource'
> > returns ERR_PTR too:
> 
> Yes, you're right.
> It makes the problem.
> Thus, this commit "PCI: mvebu: return NULL instead of ERR_PTR(ret)"
> should be reverted.

It hasn't gone to mainline yet and I haven't sent a pull request for it
yet.  So I can just drop it.

Since we have the discussion on all three of those patches re-ignited,
I'll just drop the branch and Ack the resends for going through Bjorn.

thx,

Jason.
