Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752416AbeC1ThT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Mar 2018 15:37:19 -0400
Date: Wed, 28 Mar 2018 14:37:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alan Douglas <adouglas@cadence.com>
Cc: Niklas Cassel <niklas.cassel@axis.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "cyrille.pitchen@free-electrons.com"
        <cyrille.pitchen@free-electrons.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Cassel <niklass@axis.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v5 07/12] PCI: cadence: Set PCI_BASE_ADDRESS_MEM_TYPE_64
 if a 64-bit BAR was set-up
Message-ID: <20180328193717.GA97213@bhelgaas-glaptop.roam.corp.google.com>
References: <20180328115018.31921-1-niklas.cassel@axis.com>
 <20180328115018.31921-8-niklas.cassel@axis.com>
 <CO2PR07MB97221CD6D90F81C2D81D65BD8A30@CO2PR07MB972.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CO2PR07MB97221CD6D90F81C2D81D65BD8A30@CO2PR07MB972.namprd07.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Lorenzo]

On Wed, Mar 28, 2018 at 01:24:10PM +0000, Alan Douglas wrote:
> > On 28/03/2018 12:51, Niklas Cassel wrote:
> > cdns_pcie_ep_set_bar() does some round-up of the BAR size, which means that a 64-bit BAR can be set-up, even when the flag
> > PCI_BASE_ADDRESS_MEM_TYPE_64 isn't set.
> 
> > If a 64-bit BAR was set-up, set the flag PCI_BASE_ADDRESS_MEM_TYPE_64, so that the calling function can know what BAR width that was actually set-up.
> 
> > I'm not sure why cdns_pcie_ep_set_bar() doesn't obey the flag PCI_BASE_ADDRESS_MEM_TYPE_64, but I leave this for the MAINTAINER to fix, since there might be a reason why > this flag is ignored.
> Will investigate and fix this in future patch
> 
> > Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> > ---
> >  drivers/pci/cadence/pcie-cadence-ep.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/pci/cadence/pcie-cadence-ep.c b/drivers/pci/cadence/pcie-cadence-ep.c
> > index cef36cd6b710..2905e098678c 100644
> > --- a/drivers/pci/cadence/pcie-cadence-ep.c
> > +++ b/drivers/pci/cadence/pcie-cadence-ep.c
> > @@ -106,6 +106,9 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn,
> >  		if (is_64bits && (bar & 1))
> >  			return -EINVAL;
> >  
> > +		if (is_64bits && !(flags & PCI_BASE_ADDRESS_MEM_TYPE_64))
> > +			epf_bar->flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
> > +
> >  		if (is_64bits && is_prefetch)
> >  			ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS;
> >  		else if (is_prefetch)
> > --
> > 2.14.2
> Change looks good to me.

It will be helpful to Lorenzo if you spell this out, e.g.,

  Acked-by: Alan Douglas <adouglas@cadence.com>

Also, it looks like we need a MAINTAINERS update to add
drivers/pci/cadence/ to the "PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS"
filename patterns.
