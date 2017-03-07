Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755860AbdCGTJ7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Mar 2017 14:09:59 -0500
Date: Tue, 7 Mar 2017 13:09:55 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [patch] PCI: dwc: uninitialized variable in dw_handle_msi_irq()
Message-ID: <20170307190955.GE21358@bhelgaas-glaptop.roam.corp.google.com>
References: <20170217232618.GC26717@mwanda>
 <933041dd-288f-4cde-c10f-5b0b3ab49f15@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <933041dd-288f-4cde-c10f-5b0b3ab49f15@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 22, 2017 at 03:08:07PM -0800, Joao Pinto wrote:
> Hi Dan,
> 
> Às 3:26 PM de 2/17/2017, Dan Carpenter escreveu:
> > The bug is that "val" is unsigned long but we only initialize 32 bits
> > of it.  Then we test "if (val)" and that might be true not because we
> > set the bits but because some were never initialized.
> > 
> > Fixes: f342d940ee0e ("PCI: exynos: Add support for MSI")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> > Static analysis.  Not tested.
> 
> What you are statiting makes perfect sense, since the register is indeed 32 bits
> and can have undesirable behavior in 64-bit systems for example.
> We have more examples like this for MSI related operations in pcie-designware.
> Could you please change them as well just?
> 
> For example, the irq variable declaration is also not consistent as you can see
> in these examples:
> 
>  static void dw_msi_setup_msg(struct pcie_port *pp, unsigned int irq, u32 pos)
> 
>  static int dw_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
>                            irq_hw_number_t hwirq)
> 
>  static void dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
> 
>  static void dw_pcie_msi_set_irq(struct pcie_port *pp, int irq)

Where are we with this?  It sounds like there's a real problem here,
and Dan's original patch fixes one case of it.  But if there are other
similar cases, we should fix them all at once.

Since this doesn't sound like an urgent bug fix (I don't see user
problem reports), I guess I'll wait for an updated patch?

> > diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-designware.c
> > index af8f6e92e885..5bfc377b83e4 100644
> > --- a/drivers/pci/dwc/pcie-designware.c
> > +++ b/drivers/pci/dwc/pcie-designware.c
> > @@ -257,17 +257,18 @@ static struct irq_chip dw_msi_irq_chip = {
> >  /* MSI int handler */
> >  irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
> >  {
> > -	unsigned long val;
> > +	u32 val;
> >  	int i, pos, irq;
> >  	irqreturn_t ret = IRQ_NONE;
> >  
> >  	for (i = 0; i < MAX_MSI_CTRLS; i++) {
> >  		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_STATUS + i * 12, 4,
> > -				(u32 *)&val);
> > +				    &val);
> >  		if (val) {
> >  			ret = IRQ_HANDLED;
> >  			pos = 0;
> > -			while ((pos = find_next_bit(&val, 32, pos)) != 32) {
> > +			while ((pos = find_next_bit((unsigned long *)&val, 32,
> > +						    pos)) != 32) {
> >  				irq = irq_find_mapping(pp->irq_domain,
> >  						i * 32 + pos);
> >  				dw_pcie_wr_own_conf(pp,
> > 
> 
