Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 19 Mar 2018 12:36:29 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: kishon@ti.com, Bjorn Helgaas <bhelgaas@google.com>,
        Sekhar Nori <nsekhar@ti.com>, John Keeping <john@metanate.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] PCI: endpoint: BAR width should not depend on
 sizeof dma_addr_t
Message-ID: <20180319123629.GA8830@e107981-ln.cambridge.arm.com>
References: <20180308133331.19464-1-niklas.cassel@axis.com>
 <20180308133331.19464-2-niklas.cassel@axis.com>
 <20180316180220.GA13505@red-moon>
 <20180317005513.GB22414@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180317005513.GB22414@axis.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Mar 17, 2018 at 01:55:13AM +0100, Niklas Cassel wrote:
> On Fri, Mar 16, 2018 at 06:02:20PM +0000, Lorenzo Pieralisi wrote:
> > On Thu, Mar 08, 2018 at 02:33:26PM +0100, Niklas Cassel wrote:
> > > If a BAR supports 64-bit width or not depends on the hardware,
> > > and should thus not depend on sizeof(dma_addr_t).
> > > 
> > > Since this driver is generic, default to always using BAR width
> > > of 32-bits. 64-bit BARs can easily be tested by replacing
> > > PCI_BASE_ADDRESS_MEM_TYPE_32 with PCI_BASE_ADDRESS_MEM_TYPE_64
> > > in bar_flags.
> > > 
> > > Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> > > ---
> > > Note to Lorenzo/Bjorn:
> > > It is not trivial to convert the bar_size + bar_flags +
> > > struct pci_epf->bar member array to an array of struct resources,
> > > since we need to be able to store the addresses returned
> > > by dma_alloc_coherent(), which is of type dma_addr_t.
> > > struct resource uses resource_size_t, which is defined as phys_addr_t.
> > > E.g. ARTPEC-7 uses 64-bit dma_addr_t, but only 32-bit phys_addr_t.
> > > 
> > >  drivers/pci/endpoint/functions/pci-epf-test.c | 15 +++++++++------
> > >  1 file changed, 9 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > index 800da09d9005..7c70433b11a7 100644
> > > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > @@ -71,6 +71,14 @@ struct pci_epf_test_data {
> > >  };
> > >  
> > >  static int bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
> > > +static int bar_flags[] = {
> > > +	PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_32,
> > > +	PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_32,
> > > +	PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_32,
> > > +	PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_32,
> > > +	PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_32,
> > > +	PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_32
> > > +};
> > 
> > Niklas,
> > 
> > I think you are almost there, I have one question though to address
> > that can even simplify the patchset.
> > 
> > If, according to your own commit logs (and my reading of the code), the
> > Cadence driver makes a decision on the BAR size just by checking the
> > corresponding region size (I would be happy to hear the reason
> > underpinning that choice, BTW), why can't we do the same for DWC (ie to
> > let the DWC driver decides whether a BAR should be 64 or 32 bits ?)
> 
> We could, but I think that would be a mistake.
> 
> The API that the user/"endpoint function" has available to configure
> the BARs:
> pci_epc_set_bar()
> 
> If the user, for some reason, wants to configure a BAR with a
> 64-bit width, even though the BAR size is less than 4 GB,
> I think that the API should allow that.

Yes, that's a good point, thanks a lot for the explanation.

Lorenzo

> This would not be possible if pci_epc_set_bar() would start to
> ignore PCI_BASE_ADDRESS_MEM_TYPE_64 from the flags parameter
> (and BAR width thus only being controlled by the size parameter).
> 
> int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, enum pci_barno bar,
> 	            dma_addr_t bar_phys, size_t size, int flags);
> 
> 
> 
> Best regards,
> Niklas
