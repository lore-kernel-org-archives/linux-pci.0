Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:62185 "EHLO
	relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754452AbaEAJvB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 1 May 2014 05:51:01 -0400
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	"Valentine Barshak" <valentine.barshak@cogentembedded.com>,
	Simon Horman <horms@verge.net.au>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	LAKML <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v7 01/10] PCI: host: rcar: Add Renesas R-Car PCIe driver
Date: Thu, 1 May 2014 09:50:56 +0000
Message-ID: <b9160c7a49304270b5070dcf49482723@HKXPR06MB168.apcprd06.prod.outlook.com>
References: <1396261856-22465-1-git-send-email-phil.edworthy@renesas.com>
 <1396261856-22465-2-git-send-email-phil.edworthy@renesas.com>
 <20140424191901.GE29593@google.com>
 <9b8bedae9d604383ac7ec22fd0f62fdb@HKXPR06MB168.apcprd06.prod.outlook.com>
 <CAErSpo6Autto4n4A4wHtXQNJzD3RKevkVcLZHUods-2-eiRDYQ@mail.gmail.com>
 <20140428203501.GA3016@obsidianresearch.com>
 <ac795ce3bb6349708e2e96686e19d24f@HKXPR06MB168.apcprd06.prod.outlook.com>
 <20140430154345.GA1705@obsidianresearch.com>
In-Reply-To: <20140430154345.GA1705@obsidianresearch.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jason,

On 30 April 2014 16:44, Jason wrote:
> On Wed, Apr 30, 2014 at 10:33:08AM +0000, Phil Edworthy wrote:
> 
> > > You set the value of the integrated bus based on the bus number in the
> > > TYPE0 accesses the driver performs and it shows up in the PCI config
> > > space of the root port bridge:
> > >
> > > root@koelsch:~# lspci -vv
> > > 00:00.0 PCI bridge: Renesas Technology Corp. Device 001f (prog-if 00
> > > [Normal decode])
> > >         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> > >
> > > The value here will be also be exported on-the-wire in certain PCI-E
> > > TLPs.
> > >
> > > So it is important, and must be set properly.
> > I am not so sure about this...
> >
> > There are three things we need to consider:
> > 1) talking to the host bridge itself
> > 2) talking to immediate device (connected directly to host bridge)
> > 3) talking to other devices
> >
> > The PCI standard tells us we use type 1's for 3) and type 0's for
> > 2). The driver uses root_bus_nr to make this decision.  For 1),
> > there is a note in the driver that the hardware cannot target
> > itself. The driver has code in rcar_pcie_config_access() to check if
> > it's an access to the host bridge, and if so, use I/O (readl/writel)
> > to perform the config access.
> 
> The logic should be:
>  if (bus == primary)
>     do io access to host bridge
>  else if (bus == secondary)
>     issue type 0 TLP on the wire
>  else if (bus > secondary && bus <= subordinate)
>     issue type 1 TLP on the wire
>  else
>     fail, invalid bus number
> Where the three values come from the register in the PCI host bridge's
> configuration space, and are kept in sync with the programming from
> the Linux PCI core.
> 
> It is just a happy hapenstance that root_bus_nr equals the value the
> PCI core programmed into secondary - that is not guarenteed, you must
> use the primary value directly.
For type0 TLPs, we are not checking that root_bus_nr equals the value the PCI core programmed into secondary, we are checking that the (root_bus_nr == bus->parent->number). The only way this wouldn't work is if root_bus_nr was not the root bus number.

Since the Synopsys DW driver also saves off sys->busnr and later uses this to determine if accesses are for the host bridge, I guess that means it won't always work either, right? Or is it ok because the DW driver saves sys->busnr in its .scan function?

When would the PCI core change the root bus number to something other than set in sys->busnr?

> I recommend capturing it on write to the host bridge config
> space.

Thanks
Phil

