Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56868 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754698AbbA0JWg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jan 2015 04:22:36 -0500
Message-ID: <1422350550.15206.8.camel@pengutronix.de>
Subject: Re: [PATCH] PCI: designware: reject MSI-X irqs
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jg1.han@samsung.com>, Mohit Kumar <mohit.kumar@st.com>,
	linux-pci@vger.kernel.org
Date: Tue, 27 Jan 2015 10:22:30 +0100
In-Reply-To: <20150126181236.GA4063@google.com>
References: <1422269684-11527-1-git-send-email-l.stach@pengutronix.de>
	 <20150126181236.GA4063@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Am Montag, den 26.01.2015, 12:12 -0600 schrieb Bjorn Helgaas:
> On Mon, Jan 26, 2015 at 11:54:44AM +0100, Lucas Stach wrote:
> > The DW PCIe MSI hardware does not support MSI-X irqs. Setting those up
> > failed as a side effect of a bug which was fixed by 91f8ae823f2b
> > (PCI: designware: Setup and clear exactly one MSI at a time).
> > 
> > Now that this bug is fixed MSI-X irqs need to be rejected explicitly,
> > otherwise devices trying to use them may end up with incorrectly working
> > interrupts.
> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> 
> Applied with Jingoo's ack to pci/host-designware for v3.20, thanks!
> 
I would be happier if this could still find its way into v3.19 if you
are going to send another fixes pull, as this is clearly a regression
even if it was already introduced with v3.18.

> > Cc: <stable@vger.kernel.org> # 3.18
> > ---
> >  drivers/pci/host/pcie-designware.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> > index df781cdf13c1..17ca98657a28 100644
> > --- a/drivers/pci/host/pcie-designware.c
> > +++ b/drivers/pci/host/pcie-designware.c
> > @@ -283,6 +283,9 @@ static int dw_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
> >  	struct msi_msg msg;
> >  	struct pcie_port *pp = sys_to_pcie(pdev->bus->sysdata);
> >  
> > +	if (desc->msi_attrib.is_msix)
> > +		return -EINVAL;
> > +
> >  	irq = assign_irq(1, desc, &pos);
> >  	if (irq < 0)
> >  		return irq;
> > -- 
> > 2.1.4
> > 


