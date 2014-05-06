Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:14810 "EHLO
	relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S934579AbaEFKq1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 6 May 2014 06:46:27 -0400
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
CC: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	LAKML <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v7 01/10] PCI: host: rcar: Add Renesas R-Car PCIe driver
Date: Tue, 6 May 2014 10:46:22 +0000
Message-ID: <0b36805160b7426faa481d5603bebb6c@HKXPR06MB168.apcprd06.prod.outlook.com>
References: <1396261856-22465-1-git-send-email-phil.edworthy@renesas.com>
 <1396261856-22465-2-git-send-email-phil.edworthy@renesas.com>
 <20140424191901.GE29593@google.com>
 <9b8bedae9d604383ac7ec22fd0f62fdb@HKXPR06MB168.apcprd06.prod.outlook.com>
 <CAErSpo6Autto4n4A4wHtXQNJzD3RKevkVcLZHUods-2-eiRDYQ@mail.gmail.com>
 <20140428203501.GA3016@obsidianresearch.com>
 <ac795ce3bb6349708e2e96686e19d24f@HKXPR06MB168.apcprd06.prod.outlook.com>
 <20140430154345.GA1705@obsidianresearch.com>
 <b9160c7a49304270b5070dcf49482723@HKXPR06MB168.apcprd06.prod.outlook.com>
 <20140501165003.GC3296@obsidianresearch.com>
In-Reply-To: <20140501165003.GC3296@obsidianresearch.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jason,

On 01 May 2014 17:50, Jason wrote:
> On Thu, May 01, 2014 at 09:50:56AM +0000, Phil Edworthy wrote:
> 
> > > The logic should be:
> > >  if (bus == primary)
> > >     do io access to host bridge
> > >  else if (bus == secondary)
> > >     issue type 0 TLP on the wire
> > >  else if (bus > secondary && bus <= subordinate)
> > >     issue type 1 TLP on the wire
> > >  else
> > >     fail, invalid bus number
> > > Where the three values come from the register in the PCI host bridge's
> > > configuration space, and are kept in sync with the programming from
> > > the Linux PCI core.
> > >
> > > It is just a happy hapenstance that root_bus_nr equals the value the
> > > PCI core programmed into secondary - that is not guarenteed, you must
> > > use the primary value directly.
> 
> > For type0 TLPs, we are not checking that root_bus_nr equals the
> > value the PCI core programmed into secondary, we are checking that
> > the (root_bus_nr == bus->parent->number). The only way this wouldn't
> > work is if root_bus_nr was not the root bus number.
> 
> Okay, that isn't as sketchy, but that process still ignores the
> subordinate bus number and the failure case as required by PCI.
> 
> The goal here is to have the stuff below the drivers implement the PCI
> spec so that the core code can assume everything below is
> conformant. Drivers should not introduce gratuitous differences 'just
> because'
> 
> There is no reason drivers should be using PCI core structures to make
> decisions when the spec says those decisions are driven by config
> space fields.
> 
> This way the PCI core code doesn't have to be aware of any weird
> non-standard edge cases.. Such as not failing bus numbers beyond the
> subordinate bus number.
> 
> > Since the Synopsys DW driver also saves off sys->busnr and later
> > uses this to determine if accesses are for the host bridge, I guess
> > that means it won't always work either, right? Or is it ok because
> > the DW driver saves sys->busnr in its .scan function?
> 
> Sounds like it is making the same mistake, and nobody noticed. This is
> another reason why it is important to implement correctly so people
> copying copy the right stuff :)
> 
> > When would the PCI core change the root bus number to something
> > other than set in sys->busnr?
> 
> I think the more likely scenario is that 'sys' in general is
> architecture specific and its use is being discouraged so that host
> drivers are not arch specific.
> 
> A domain driver like rcar should always place the root complex
> integrated bus as bus 0 in the domain.

Ok, I now understand the reason for removing the dependency on sys->busnr. That makes sense & I'll update the driver for this.

Thanks for your patience :)
Phil
