Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:44926 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbeBHPdQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Feb 2018 10:33:16 -0500
Date: Thu, 8 Feb 2018 16:18:00 +0100
From: Niklas Cassel <niklas.cassel@axis.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        John Keeping <john@metanate.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] PCI: endpoint: Handle 64-bit BARs properly
Message-ID: <20180208151759.GB13618@axis.com>
References: <20180208123346.20784-1-niklas.cassel@axis.com>
 <20180208123346.20784-2-niklas.cassel@axis.com>
 <da5004d3-c3e8-d9fd-6698-3b12c3ab624a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <da5004d3-c3e8-d9fd-6698-3b12c3ab624a@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 08, 2018 at 06:17:32PM +0530, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Thursday 08 February 2018 06:03 PM, Niklas Cassel wrote:
> > A 64-bit BAR uses the succeeding BAR for the upper bits, therefore
> > we cannot call pci_epc_set_bar() on a BAR that follows a 64-bit BAR.
> > 
> > If pci_epc_set_bar() is called with flag PCI_BASE_ADDRESS_MEM_TYPE_64,
> 
> Not related to $patch. But I have a query on when PCI_BASE_ADDRESS_MEM_TYPE_64
> should be set. Whether if the size is > 4G or if the address can be mapped
> anywhere in the 64-bit PCIe address space or both?

Hello Kishon,

Since 32-bit BARs work fine on 64-bit CPUs,
and since 64-bit BARs work fine on 32 bit CPUs
(as long as we assign them an address <4G,
and their (combined) size is not too big),
perhaps the best way would be if pci-epf-test always defaults to 32-bit BARs,
and a module parameter says if we should test 64-bit BARs.

Just because a 64-bit BAR can be assigned an address >4G,
and have a size >4G, doesn't mean that we have to give it those properties.

This way we can have some testing of 64-bit BARs on 32-bit CPUs,
even though more extensive testing (e.g. having a BAR with a size >4G)
would require a 64-bit CPU.


Regards,
Niklas

> 
> Thanks
> Kishon
> > it has to be up to the controller driver to write both BAR[x] and BAR[x+1]
> > (and BAR_mask[x] and BAR_mask[x+1]).
> > 
> > Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > index 800da09d9005..eef85820f59e 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -382,6 +382,8 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
> >  			if (bar == test_reg_bar)
> >  				return ret;
> >  		}
> > +		if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64)
> > +			bar++;
> >  	}
> >  
> >  	return 0;
> > 
