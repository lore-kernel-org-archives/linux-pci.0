Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 1 Mar 2018 15:40:30 +0100
From: Niklas Cassel <niklas.cassel@axis.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: kishon@ti.com, Bjorn Helgaas <bhelgaas@google.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        John Keeping <john@metanate.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] PCI: endpoint: Handle 64-bit BARs properly
Message-ID: <20180301144030.GA2348@axis.com>
References: <20180227115908.14593-1-niklas.cassel@axis.com>
 <20180227115908.14593-2-niklas.cassel@axis.com>
 <20180228142148.GD21854@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180228142148.GD21854@e107981-ln.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 28, 2018 at 02:21:48PM +0000, Lorenzo Pieralisi wrote:
> On Tue, Feb 27, 2018 at 12:59:05PM +0100, Niklas Cassel wrote:
> > A 64-bit BAR uses the succeeding BAR for the upper bits, therefore
> > we cannot call pci_epc_set_bar() on a BAR that follows a 64-bit BAR.
> > 
> > If pci_epc_set_bar() is called with flag PCI_BASE_ADDRESS_MEM_TYPE_64,
> 
> PCI_BASE_ADDRESS_MEM_TYPE_64 is detected through a sizeof(dma_addr_t).
> 
> I thought we decided to describe the BARs not as dma_addr_t + size but
> as resources, which would allow you to have flags describing their
> actual size.
> 
> Current code has a fixed BAR size defined by the dma_addr_t type size
> and I do not think that's what we really want.

You suggested to Kishon that the bar member array should be refactored
to be an array of struct resources:

https://marc.info/?l=linux-pci&m=151851776921594&w=2

That refactoring would be a good thing,
but can't it be done after the merge of this patch?


I'm guessing that one of the reasons why you want this
refactoring is so that you can actually call pci_epc_set_bar()
on each array member, so that you don't need my patch:
> > +           if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64)
> > +                   bar++;

However, if we want to omit this, I think that other changes would be needed.

Let's say that resource[x] is 64-bit, then resource[x+1] must not have
(IORESOURCE_MEM or IORESOURCE_IO) set.

It is important that BAR[x+1] == 0, for a 64-bit BAR.

So either pci_epc_set_bar() or epc->ops->set_bar()
must know to not touch its BAR (or BAR mask) register
if neither of those flags are set.

It's probably easier to change pci_epc_set_bar(), rather than
changing all epc->ops->set_bar() implementations,
here is e.g. part of set_bar() for DesignWare:

static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no,
                              enum pci_barno bar,
                              dma_addr_t bar_phys, size_t size, int flags)
{
        int ret;
        struct dw_pcie_ep *ep = epc_get_drvdata(epc);
        struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
        enum dw_pcie_as_type as_type;
        u32 reg = PCI_BASE_ADDRESS_0 + (4 * bar);

        if (!(flags & PCI_BASE_ADDRESS_SPACE))
                as_type = DW_PCIE_AS_MEM;
        else
                as_type = DW_PCIE_AS_IO;


So I still see a point in having this patch, at least until
someone has refactored the code to use resource + modified pci_epc_set_bar().


> 
> How is (in HW I mean) actually the BAR size configured in a given EPF ?

For the DesignWare PCIe controller (assuming it has been synthesized with
Programmable Masks), to configure a BAR, you set the usual prefetch+type bits
in the standard PCI BAR register, but then the controller also has, for each
bar, a special BAR mask register, which dw_pcie_ep_set_bar() sets to (size-1),
this defines which bits that will be writable by the RC (and the RC can figure
out the size of the BAR by writing all 1's as usual).

For a 64-bit Memory Space BAR of size 16 GiB (prefetchable), you would set:
BAR[x]        = 0000 0000 0000 0000 0000 0000 0000 1100
BAR[x+1]      = 0000 0000 0000 0000 0000 0000 0000 0000

BAR_MASK[x]   = 1111 1111 1111 1111 1111 1111 1111 1111
BAR_MASK[x+1] = 0000 0000 0000 0000 0000 0000 0000 0011



I guess that instead of patch 3/3 in this patch series,
we could do:

--- a/drivers/pci/dwc/pcie-designware-ep.c
+++ b/drivers/pci/dwc/pcie-designware-ep.c
@@ -136,8 +136,15 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no,
                return ret;
 
        dw_pcie_dbi_ro_wr_en(pci);
-       dw_pcie_writel_dbi2(pci, reg, size - 1);
-       dw_pcie_writel_dbi(pci, reg, flags);
+       if (upper_32_bits(size)) {
+               dw_pcie_writel_dbi2(pci, reg, lower_32_bits(size - 1));
+               dw_pcie_writel_dbi(pci, reg, flags);
+               dw_pcie_writel_dbi2(pci, reg + 4, upper_32_bits(size - 1));
+               dw_pcie_writel_dbi(pci, reg + 4, 0);
+       } else {
+               dw_pcie_writel_dbi2(pci, reg, size - 1);
+               dw_pcie_writel_dbi(pci, reg, flags);
+       }
        dw_pcie_dbi_ro_wr_dis(pci);
 
        return 0;

However, since I don't have access to a 64-bit CPU with loads of RAM,
that has the DesignWare PCIe controller, that patch is completely untested.
But if everyone agrees, we could replace 3/3 of this series with that.


> 
> Thanks,
> Lorenzo
> 
> > it has to be up to the controller driver to write both BAR[x] and BAR[x+1]
> > (and BAR_mask[x] and BAR_mask[x+1]).
> > 
> > Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > index 64d8a17f8094..ecbf6a7750dc 100644
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
> > -- 
> > 2.14.2
> > 
