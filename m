Return-Path: <SRS0=Hrdq=DR=mediatek.com=honghui.zhang@kernel.org>
Return-Path: <SRS0=Hrdq=DR=mediatek.com=honghui.zhang@kernel.org>
Message-ID: <1513820234.25872.1.camel@mhfsdcap03>
Subject: Re: [PATCH] PCI: Mediatek: clear irq status after irq dispathed to
 avoid reentry
From: Honghui Zhang <honghui.zhang@mediatek.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <bhelgaas@google.com>, <matthias.bgg@gmail.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <yingjoe.chen@mediatek.com>,
	<eddie.huang@mediatek.com>, <ryder.lee@mediatek.com>,
	<youlin.pei@mediatek.com>, <hongkun.cao@mediatek.com>,
	<sean.wang@mediatek.com>, <xinping.qian@mediatek.com>,
	<yt.shen@mediatek.com>, <yong.wu@mediatek.com>, Lorenzo Pieralisi
	<lorenzo.pieralisi@arm.com>
Date: Thu, 21 Dec 2017 09:37:14 +0800
In-Reply-To: <20171221005240.GC30595@bhelgaas-glaptop.roam.corp.google.com>
References: <1513738334-26213-1-git-send-email-honghui.zhang@mediatek.com>
	 <20171221005240.GC30595@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2017-12-20 at 18:52 -0600, Bjorn Helgaas wrote:
> [+cc Lorenzo, please cc him on all drivers/{host,dwc,endpoint} material]
> 
> Please run "git log --oneline drivers/pci/host/pcie-mediatek.c" and
> make yours match.  Same capitalization, same sentence structure, etc.,
> e.g.,
> 
>   PCI: mediatek: Clear IRQ status ...
> 
> s/dispathed/dispatched/
> 
> s/irq/IRQ/ in the summary and all the English text below.

Thanks for your review and sorry for the mismatch, I will fix that in
next version.

> 
> On Wed, Dec 20, 2017 at 10:52:14AM +0800, honghui.zhang@mediatek.com wrote:
> > From: Honghui Zhang <honghui.zhang@mediatek.com>
> > 
> > There maybe a same irq reentry scenario after irq received in current
> > irq handle flow:
> > 	EP device		PCIe host driver	EP driver
> > 1. issue an irq
> > 			2. received irq
> > 			3. clear irq status
> > 			4. dispatch irq
> > 						5. clear irq source
> > The irq status was not successfully cleared at step 2 since the irq
> > source was not cleared yet. So the PCIe host driver may receive the
> > same irq after step 5. Then there's an irq reentry occurred.
> > Even worse, if the reentry irq was not an irq that EP driver expected,
> > it may not handle the irq. Then we may run into the dead loop from
> 
> By "dead loop" I assume you mean "infinite loop"?  I don't think it's
> a deadlock since nothing is waiting.
> 
Yes, it should be "infinite loop", I will update the commit message in
next version.

thanks.
> > step 2 to step 4.
> > Clear the irq status after irq have been dispatched to avoid the irq
> > reentry.
> > 
> > Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> > ---
> >  drivers/pci/host/pcie-mediatek.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
> > index db93efd..3248771 100644
> > --- a/drivers/pci/host/pcie-mediatek.c
> > +++ b/drivers/pci/host/pcie-mediatek.c
> > @@ -605,11 +605,11 @@ static irqreturn_t mtk_pcie_intr_handler(int irq, void *data)
> >  
> >  	while ((status = readl(port->base + PCIE_INT_STATUS)) & INTX_MASK) {
> >  		for_each_set_bit_from(bit, &status, PCI_NUM_INTX + INTX_SHIFT) {
> > -			/* Clear the INTx */
> > -			writel(1 << bit, port->base + PCIE_INT_STATUS);
> >  			virq = irq_find_mapping(port->irq_domain,
> >  						bit - INTX_SHIFT);
> >  			generic_handle_irq(virq);
> > +			/* Clear the INTx */
> > +			writel(1 << bit, port->base + PCIE_INT_STATUS);
> >  		}
> >  	}
> >  
> > @@ -619,10 +619,10 @@ static irqreturn_t mtk_pcie_intr_handler(int irq, void *data)
> >  
> >  			while ((imsi_status = readl(port->base + PCIE_IMSI_STATUS))) {
> >  				for_each_set_bit(bit, &imsi_status, MTK_MSI_IRQS_NUM) {
> > -					/* Clear the MSI */
> > -					writel(1 << bit, port->base + PCIE_IMSI_STATUS);
> >  					virq = irq_find_mapping(port->msi_domain, bit);
> >  					generic_handle_irq(virq);
> > +					/* Clear the MSI */
> > +					writel(1 << bit, port->base + PCIE_IMSI_STATUS);
> >  				}
> >  			}
> >  			/* Clear MSI interrupt status */
> > -- 
> > 2.6.4
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
