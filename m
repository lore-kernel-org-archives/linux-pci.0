Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam02on0049.outbound.protection.outlook.com ([104.47.36.49]:26944
	"EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751750AbcBKFvA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 11 Feb 2016 00:51:00 -0500
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Bharat Kumar Gogada <bharatku@xilinx.com>,
	Paul Burton <paul.burton@imgtec.com>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC: Michal Simek <michals@xilinx.com>,
	Ravikiran Gummaluri <rgummal@xilinx.com>,
	Soren Brinkmann <sorenb@xilinx.com>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Russell Joyce <russell.joyce@york.ac.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Jingoo Han" <jingoohan1@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v3 2/6] PCI: xilinx: Unify INTx & MSI interrupt FIFO
 decode
Date: Thu, 11 Feb 2016 05:50:54 +0000
Message-ID: <8520D5D51A55D047800579B09414719825881B00@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1454602213-967-1-git-send-email-paul.burton@imgtec.com>
 <1454602213-967-3-git-send-email-paul.burton@imgtec.com>
 <8520D5D51A55D047800579B09414719825881ADE@XAP-PVEXMBX01.xlnx.xilinx.com>
In-Reply-To: <8520D5D51A55D047800579B09414719825881ADE@XAP-PVEXMBX01.xlnx.xilinx.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> > Subject: [PATCH v3 2/6] PCI: xilinx: Unify INTx & MSI interrupt FIFO
> > decode
> >
> > When decoding either an INTx or MSI interrupt, the driver has no way
> > to know which it will pull out of the interrupt FIFO. If both were
> > pending then this would lead to either the interrupt being handled
> > incorrectly (MSI interrupt treated as INTx) or not at all (INTx interrupt
> dropped by MSI path).
> > Unify the reading of the interrupt FIFO & act according to the type of
> > interrupt actually read.
> >
> > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> > Fixes: 8961def56845 ("PCI: xilinx: Add Xilinx AXI PCIe Host Bridge IP
> > driver")
> >
> > ---
> >
> > Changes in v3:
> > - Split out from Boston patchset.
> >
> > Changes in v2:
> > - Add Fixes tag.
> >
> >  drivers/pci/host/pcie-xilinx.c | 47
> > +++++++++++++-----------------------------
> >  1 file changed, 14 insertions(+), 33 deletions(-)
> >
> > diff --git a/drivers/pci/host/pcie-xilinx.c
> > b/drivers/pci/host/pcie-xilinx.c index
> > 1490bd1..afdfb09 100644
> > --- a/drivers/pci/host/pcie-xilinx.c
> > +++ b/drivers/pci/host/pcie-xilinx.c
> > @@ -397,7 +397,7 @@ static const struct irq_domain_ops
> intx_domain_ops
> > = {  static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)  {
> >  	struct xilinx_pcie_port *port = (struct xilinx_pcie_port *)data;
> > -	u32 val, mask, status, msi_data;
> > +	u32 val, mask, status;
> >
> >  	/* Read interrupt decode and mask registers */
> >  	val = pcie_read(port, XILINX_PCIE_REG_IDR); @@ -437,8 +437,8 @@
> > static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
> >  		xilinx_pcie_clear_err_interrupts(port);
> >  	}
> >
> > -	if (status & XILINX_PCIE_INTR_INTX) {
> > -		/* INTx interrupt received */
> > +	if (status & (XILINX_PCIE_INTR_INTX | XILINX_PCIE_INTR_MSI)) {
> > +		/* Interrupt received */
> >  		val = pcie_read(port, XILINX_PCIE_REG_RPIFR1);
> >
> >  		/* Check whether interrupt valid */ @@ -447,41 +447,22 @@
> static
> > irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
> >  			return IRQ_HANDLED;
> >  		}
> >
> > -		if (!(val & XILINX_PCIE_RPIFR1_MSI_INTR)) {
> > -			/* Clear interrupt FIFO register 1 */
> > -			pcie_write(port, XILINX_PCIE_RPIFR1_ALL_MASK,
> > -				   XILINX_PCIE_REG_RPIFR1);
> > -
> > -			/* Handle INTx Interrupt */
> > +		if (val & XILINX_PCIE_RPIFR1_MSI_INTR) {
> > +			irq = pcie_read(port, XILINX_PCIE_REG_RPIFR2) &
> > +				XILINX_PCIE_RPIFR2_MSG_DATA;
> > +		} else {
> >  			val = ((val & XILINX_PCIE_RPIFR1_INTR_MASK) >>
> >  				XILINX_PCIE_RPIFR1_INTR_SHIFT) + 1;
> > -			generic_handle_irq(irq_find_mapping(port-
> > >irq_domain,
> > -							    val));
> > +			irq = irq_find_mapping(port->irq_domain, val);
> >  		}
> > -	}
> >
> > -	if (status & XILINX_PCIE_INTR_MSI) {
> > -		/* MSI Interrupt */
> > -		val = pcie_read(port, XILINX_PCIE_REG_RPIFR1);
> > +		/* Clear interrupt FIFO register 1 */
> > +		pcie_write(port, XILINX_PCIE_RPIFR1_ALL_MASK,
> > +			   XILINX_PCIE_REG_RPIFR1);
> >
> > -		if (!(val & XILINX_PCIE_RPIFR1_INTR_VALID)) {
> > -			dev_warn(port->dev, "RP Intr FIFO1 read error\n");
> > -			return IRQ_HANDLED;
> > -		}
> > -
> > -		if (val & XILINX_PCIE_RPIFR1_MSI_INTR) {
> > -			msi_data = pcie_read(port,
> > XILINX_PCIE_REG_RPIFR2) &
> > -				   XILINX_PCIE_RPIFR2_MSG_DATA;
> > -
> > -			/* Clear interrupt FIFO register 1 */
> > -			pcie_write(port, XILINX_PCIE_RPIFR1_ALL_MASK,
> > -				   XILINX_PCIE_REG_RPIFR1);
> > -
> > -			if (IS_ENABLED(CONFIG_PCI_MSI)) {
> > -				/* Handle MSI Interrupt */
> > -				generic_handle_irq(msi_data);
> > -			}
> > -		}
> > +		if (IS_ENABLED(CONFIG_PCI_MSI) ||
> > +			!(val & XILINX_PCIE_RPIFR1_MSI_INTR))
> > +			generic_handle_irq(irq);
> >  	}
> >
> >  	if (status & XILINX_PCIE_INTR_SLV_UNSUPP)
> > --
> 
> Hi Paul,
> 
> Even with above condition you are still missing either MSI or legacy interrupt
> handling, when both MSI and legacy interrupts occurred.

It would be better if the condition when both legacy and MSI interrupts occurred can be handled separately, leaving the current individual interrupt cases as they are.

Bharat
