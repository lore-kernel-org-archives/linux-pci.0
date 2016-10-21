Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934096AbcJUQW4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Oct 2016 12:22:56 -0400
Date: Fri, 21 Oct 2016 11:22:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        linux-pci@vger.kernel.org,
        Gary Bisson <gary.bisson@boundarydevices.com>,
        kernel@pengutronix.de, patchwork-lst@pengutronix.de,
        Niklas Cassel <niklas.cassel@axis.com>,
        Carlos Palminha <CARLOS.PALMINHA@synopsys.com>,
        jose.abreu@synopsys.com, Jesper Nilsson <jespern@axis.com>,
        Joao Pinto <jpmpinto@gmail.com>
Subject: Re: [PATCH resend] PCI: designware: fix register access before host
 init
Message-ID: <20161021162251.GD9007@localhost>
References: <20161018082549.10905-1-l.stach@pengutronix.de>
 <20161021153142.GB9007@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161021153142.GB9007@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Joao, Niklas, Carlos, Jose, Jesper]

On Fri, Oct 21, 2016 at 10:31:42AM -0500, Bjorn Helgaas wrote:
> On Tue, Oct 18, 2016 at 10:25:49AM +0200, Lucas Stach wrote:
> > The function used to determine if iATU unroll is available will read
> > a RC register. This is not possible and will result in a system hang
> > if the RC is still in reset, so it is only safe to call this function
> > after host_init() has been called.
> 
> I'm sure Joao tested a0601a470537 somewhere, so I assume this hang only
> happens on certain systems?
> 
> I'm wondering if this is suggesting something that's currently done
> differently across the drivers but could be done more similarly.
> 
> > Fixes: a0601a470537 (PCI: designware: Add iATU Unroll feature)
> > Reported-by: Gary Bisson <gary.bisson@boundarydevices.com>
> > Tested-by: Gary Bisson <gary.bisson@boundarydevices.com>
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> >  drivers/pci/host/pcie-designware.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> > index 035f50c03281..74510508fafc 100644
> > --- a/drivers/pci/host/pcie-designware.c
> > +++ b/drivers/pci/host/pcie-designware.c
> > @@ -637,11 +637,11 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >  		}
> >  	}
> >  
> > -	pp->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pp);
> > -
> >  	if (pp->ops->host_init)
> >  		pp->ops->host_init(pp);
> >  
> > +	pp->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pp);
> > +

Niklas suggested this exact change earlier [1], but Joao pointed out the
problem with calling dw_pcie_iatu_unroll_enabled() after calling
pp->ops->host_init():

  dw_pcie_host_init
    pp->ops->host_init
      dw_pcie_setup_rc
        dw_pcie_prog_outbound_atu
          if (pp->iatu_unroll_enabled)
	    ...
    pp->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled()

We check iatu_unroll_enabled in dw_pcie_prog_outbound_atu() before it
has been set.

Niklas' second patch [2] looks like a better fix.  Can you guys take a
look and see if you agree?

[1] http://lkml.kernel.org/r/b53d5807-8199-5789-6184-e37324a1d79e@axis.com
[2] http://lkml.kernel.org/r/1476482095-26289-1-git-send-email-niklass@axis.com

> >  	pp->root_bus_nr = pp->busn->start;
> >  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> >  		bus = pci_scan_root_bus_msi(pp->dev, pp->root_bus_nr,
> > -- 
> > 2.9.3
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
