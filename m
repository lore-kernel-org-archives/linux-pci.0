Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 8 Feb 2018 15:57:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Niklas Cassel <niklas.cassel@axis.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Niklas Cassel <niklass@axis.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        John Keeping <john@metanate.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] PCI: endpoint: Handle 64-bit BARs properly
Message-ID: <20180208215735.GD98765@bhelgaas-glaptop.roam.corp.google.com>
References: <20180208123346.20784-1-niklas.cassel@axis.com>
 <20180208123346.20784-2-niklas.cassel@axis.com>
 <da5004d3-c3e8-d9fd-6698-3b12c3ab624a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <da5004d3-c3e8-d9fd-6698-3b12c3ab624a@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
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
> Not related to $patch. But I have a query on when
> PCI_BASE_ADDRESS_MEM_TYPE_64 should be set. Whether if the size is >
> 4G or if the address can be mapped anywhere in the 64-bit PCIe
> address space or both?

In general, PCI_BASE_ADDRESS_MEM_TYPE_64 should be set if the BAR is
64 bits wide.  IORESOURCE_MEM_64 is similar.

It doesn't matter what the current value of the BAR is.

It's easy to look at the current address or size of a resource if we
need to know where it is or how big it is.  But if we lose track of
the width of the BAR register, we have no way to know whether it's
*capable* of holding a 64-bit value.

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
