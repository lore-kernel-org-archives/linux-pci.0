Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2lp0207.outbound.protection.outlook.com ([207.46.163.207]:19744
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750757AbaCTClS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Mar 2014 22:41:18 -0400
From: "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
	"rjw@rjwysocki.net" <rjw@rjwysocki.net>,
	"roy.zang@freescale.com" <roy.zang@freescale.com>,
	"galak@codeaurora.org" <galak@codeaurora.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [2/2] fsl/pci: The new pci suspend/resume implementation
Date: Thu, 20 Mar 2014 02:25:38 +0000
Message-ID: <2b84971a86a34d4696afa8144fa99620@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1389081848-26506-2-git-send-email-dongsheng.wang@freescale.com>
 <20140319210041.GA14019@home.buserror.net>
In-Reply-To: <20140319210041.GA14019@home.buserror.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Scott,

I will send v2 patch to fix your comment. Thanks for your review. :)

> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Thursday, March 20, 2014 5:01 AM
> To: Wang Dongsheng-B40534
> Cc: bhelgaas@google.com; rjw@rjwysocki.net; roy.zang@freescale.com;
> galak@codeaurora.org; linux-pci@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> Subject: Re: [2/2] fsl/pci: The new pci suspend/resume implementation
> 
> On Tue, Jan 07, 2014 at 04:04:08PM +0800, Dongsheng Wang wrote:
> > From: Wang Dongsheng <dongsheng.wang@freescale.com>
> >
> > The new suspend/resume implementation, send pme turnoff message in
> > suspend, and send pme exit message in resume.
> >
> > Add a PME handler, to response PME & message interrupt.
> >
> > Change platform_driver->suspend/resume to syscore->suspend/resume.
> > pci-driver will call back EP device, to save EP state in
> > pci_pm_suspend_noirq, so we need to keep the link, until
> > pci_pm_suspend_noirq finish.
> >
> > Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> Is this patch OK to go in without patch 1/2?  It's not clear whether that was
> deemed incorrect (as in new patch coming) or unnecessary.
> 

Yes, I will abandon 1/2. And send this as a independent patch.

> It would also be good if you submit with the explanation from
> http://www.spinics.net/lists/linux-pci/msg27844.html in the commit message.
> 

Thanks.

> > -static int fsl_pci_probe(struct platform_device *pdev)
> > +#ifdef CONFIG_PM
> > +static irqreturn_t fsl_pci_pme_handle(int irq, void *dev_id)
> >  {
> > -	int ret;
> > -	struct device_node *node;
> > +	struct pci_controller *hose = dev_id;
> > +	struct ccsr_pci __iomem *pci = hose->private_data;
> > +	u32 dr;
> >
> > -	node = pdev->dev.of_node;
> > -	ret = fsl_add_bridge(pdev, fsl_pci_primary == node);
> > +	dr = in_be32(&pci->pex_pme_mes_dr);
> > +	if (dr)
> > +		out_be32(&pci->pex_pme_mes_dr, dr);
> > +	else
> > +		return IRQ_NONE;
> >
> > -	mpc85xx_pci_err_probe(pdev);
> > +	return IRQ_HANDLED;
> > +}
> 
> Why do you put some of the HANDLED path in the if statement, and some outside?
> 
> Just do:
> 
> if (!dr)
> 	return IRQ_NONE;
> 
> out_be32(...);
> return IRQ_HANDLED;
> 

Right. :)

> > +static int fsl_pci_pme_probe(struct pci_controller *hose) {
> > +	struct ccsr_pci __iomem *pci;
> > +	struct pci_dev *dev = hose->bus->self;
> > +	u16 pms;
> > +	int pme_irq;
> > +	int res;
> > +
> > +	/* PME Disable */
> > +	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pms);
> > +	pms &= ~PCI_PM_CTRL_PME_ENABLE;
> > +	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, pms);
> > +
> > +	pme_irq = irq_of_parse_and_map(hose->dn, 0);
> > +	if (!pme_irq) {
> > +		pr_warn("Failed to map PME interrupt.\n");
> 
> dev_err()
> 
> > +
> > +		return -ENXIO;
> > +	}
> > +
> > +	res = devm_request_irq(hose->parent, pme_irq,
> > +			fsl_pci_pme_handle,
> > +			IRQF_DISABLED | IRQF_SHARED,
> > +			"[PCI] PME", hose);
> 
> IRQF_DISABLED is a deprecated no-op.
> 
> > +	if (res < 0) {
> > +		pr_warn("Unable to requiest irq %d for PME\n", pme_irq);
> 
> dev_err() etc.
> 

Ok, I will use it.

Regards,
-Dongsheng

> -Scott
