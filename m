Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:3357 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754655AbeDBThH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Apr 2018 15:37:07 -0400
Date: Mon, 2 Apr 2018 21:37:03 +0200
From: Niklas Cassel <nks@flawful.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Niklas Cassel <niklas.cassel@axis.com>,
        cyrille.pitchen@free-electrons.com,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 06/12] PCI: designware-ep: Make dw_pcie_ep_set_bar()
 handle 64-bit BARs properly
Message-ID: <20180402193703.GB23587@flawful.org>
References: <20180328115018.31921-1-niklas.cassel@axis.com>
 <20180328115018.31921-7-niklas.cassel@axis.com>
 <45971780-3a46-061d-bb76-2f450401c797@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45971780-3a46-061d-bb76-2f450401c797@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 29, 2018 at 03:17:11PM +0530, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Wednesday 28 March 2018 05:20 PM, Niklas Cassel wrote:
> > Since a 64-bit BAR consists of a BAR pair, we need to write to both
> > BARs in the BAR pair to setup the BAR properly.
> > 
> > Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> > ---
> >  drivers/pci/dwc/pcie-designware-ep.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
> > index 5a0bb53c795c..571b90f88d84 100644
> > --- a/drivers/pci/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/dwc/pcie-designware-ep.c
> > @@ -138,8 +138,15 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no,
> >  		return ret;
> >  
> >  	dw_pcie_dbi_ro_wr_en(pci);
> > -	dw_pcie_writel_dbi2(pci, reg, size - 1);
> > -	dw_pcie_writel_dbi(pci, reg, flags);
> > +	if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) {
> > +		dw_pcie_writel_dbi2(pci, reg, lower_32_bits(size - 1));
> > +		dw_pcie_writel_dbi(pci, reg, flags);
> > +		dw_pcie_writel_dbi2(pci, reg + 4, upper_32_bits(size - 1));
> > +		dw_pcie_writel_dbi(pci, reg + 4, 0);
> > +	} else {
> > +		dw_pcie_writel_dbi2(pci, reg, size - 1);
> > +		dw_pcie_writel_dbi(pci, reg, flags);
> > +	}
> 
> 
> I think this should work too?
> 	dw_pcie_writel_dbi2(pci, reg, lower_32_bits(size - 1));
> 	dw_pcie_writel_dbi(pci, reg, flags);
> 
> 	if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) {
> 		dw_pcie_writel_dbi2(pci, reg + 4, upper_32_bits(size - 1));
> 		dw_pcie_writel_dbi(pci, reg + 4, 0);
> 	}
> 

Hello Kishon,

I agree, your suggestion is more neat.


Kishon, please tell me if you insist that the long if-statement
in pci_epc_set_bar() should be split, since there are 5 different
conditions. Because imho, having 5 succeeding if-statements isn't
clearer than having 1 long if-statement.

If Kishon agrees with me, then the review comment in this mail
seems to be the only review comment.
And in that case, perhaps Lorenzo wouldn't mind fixing this up.
Or perhaps Lorenzo prefers if I reroll the whole patch series?

Kind regards,
Niklas
