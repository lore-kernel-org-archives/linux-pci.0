Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:35275 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829Ab3LKCaJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Dec 2013 21:30:09 -0500
Date: Wed, 11 Dec 2013 11:30:06 +0900
From: Simon Horman <horms@verge.net.au>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>,
	'Valentine Barshak' <valentine.barshak@cogentembedded.com>,
	'Wei Yongjun' <weiyj.lk@gmail.com>,
	'Wei Yongjun' <yongjun_wei@trendmicro.com.cn>,
	linux-pci@vger.kernel.org, 'Magnus Damm' <magnus.damm@gmail.com>,
	'Kuninori Morimoto' <kuninori.morimoto.gx@renesas.com>,
	linux-sh@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar: fix return value check in rcar_pci_probe()
Message-ID: <20131211023006.GN19992@verge.net.au>
References: <CAPgLHd-XTnQXdK7H2uLbGW1ftxNB_nHwzcNCoiCjpXsB5X3HnA@mail.gmail.com>
 <20131207225012.GC7901@google.com>
 <001001cef480$73896b20$5a9c4160$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <001001cef480$73896b20$5a9c4160$%han@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 09, 2013 at 10:46:17AM +0900, Jingoo Han wrote:
> On Sunday, December 08, 2013 7:50 AM, Bjorn Helgaas wrote:
> > On Tue, Nov 19, 2013 at 11:40:28AM +0800, Wei Yongjun wrote:
> > > From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> > >
> > > In case of error, the function devm_ioremap_resource() returns ERR_PTR()
> > > and never returns NULL. The NULL test in the return value check should
> > > be replaced with IS_ERR().
> > >
> > > Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> > 
> > Applied with Jingoo's reviewed-by to pci/host-rcar for v3.14, thanks!
> > 
> > For drivers/pci/host/*, I normally look for an ack from the responsible
> > person,  but this patch is trivial enough that I'm fine taking it without
> > that.  But for more significant changes, I don't have any notes about who
> > should own pci-rcar-gen2.c.  Valentine could be a candidate since he added
> > it in the first place?  Or Jingoo?
> 
> (+cc Simon Horman, Magnus Damm, Kuninori Morimoto, linux-sh mailing-list)
> 
> Hi Bjorn,
> 
> I think that Valentine could be a candidate, because he is an author.
> However, pci-rcar-gen2.c is working on Renesas SoC, so, it may be
> necessary to get ACK from Renesas people such as Simon Horman,
> Magnus Damm, and Kuninori Morimoto.
> 
> Simon Horman, Magnus Damm, and Kuninori Morimoto,
> Who is a proper person responsible for RCar Gen PCIe driver?
> (drivers/pci/host/pci-rcar-gen2.c)

Good question.

My feeling is that as it relates to Renesas ARM SoCs that
responsibility at least in part defaults to the Renesas ARM SoC
maintainers, Magnus and myself.

So I think it would be best if the following were CCed on any patches
to this driver:

Simon Horman <horms@verge.net.au>
Magnus Damm <magnus.damm@gmail.com>
linux-sh@vger.kernel.org

I would not be opposed for there being a MAINTAINERS file entry to that effect.

I will let Valentine volunteer himself if he wants to.

> 
> Best regards,
> Jingoo Han
> 
> > 
> > Bjorn
> > 
> > > ---
> > >  drivers/pci/host/pci-rcar-gen2.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
> > > index cbaa5c4..96d1182 100644
> > > --- a/drivers/pci/host/pci-rcar-gen2.c
> > > +++ b/drivers/pci/host/pci-rcar-gen2.c
> > > @@ -276,8 +276,8 @@ static int __init rcar_pci_probe(struct platform_device *pdev)
> > >
> > >  	cfg_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > >  	reg = devm_ioremap_resource(&pdev->dev, cfg_res);
> > > -	if (!reg)
> > > -		return -ENODEV;
> > > +	if (IS_ERR(reg))
> > > +		return PTR_ERR(reg);
> > >
> > >  	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > >  	if (!mem_res || !mem_res->start)
> > >
> 
