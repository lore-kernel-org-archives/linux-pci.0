Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34178 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754857AbbFOKbD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 15 Jun 2015 06:31:03 -0400
Date: Mon, 15 Jun 2015 11:31:09 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Henderson <rth@twiddle.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	David Howells <dhowells@redhat.com>,
	Russell King <linux@arm.linux.org.uk>,
	Tony Luck <tony.luck@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Ingo Molnar <mingo@redhat.com>,
	Michal Simek <monstr@monstr.eu>,
	Chris Zankel <chris@zankel.net>, Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Halasa <khalasa@piap.pl>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Simon Horman <horms@verge.net.au>,
	Minghuan Lian <minghuan.Lian@freescale.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Will Deacon <Will.Deacon@arm.com>,
	Jayachandran C <jchandra@broadcom.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
Subject: Re: [RFC/RFT PATCH v2] PCI: move pci_read_bridge_bases to the
 generic PCI layer
Message-ID: <20150615103020.GA21068@red-moon>
References: <1433840506-20083-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20150613014755.GA29649@roeck-us.net>
 <20150613091200.GA8125@red-moon>
 <557D9DF0.50806@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <557D9DF0.50806@roeck-us.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jun 14, 2015 at 04:29:52PM +0100, Guenter Roeck wrote:
> On 06/13/2015 02:12 AM, Lorenzo Pieralisi wrote:
> > On Sat, Jun 13, 2015 at 02:47:55AM +0100, Guenter Roeck wrote:
> >> On Tue, Jun 09, 2015 at 10:01:45AM +0100, Lorenzo Pieralisi wrote:
> >>> When a PCI bus is scanned, upon PCI bridge detection the kernel
> >>> has to read the bridge registers to set-up its resources so that
> >>> the PCI resource hierarchy can be validated properly.
> >>>
> >>> Most if not all architectures read PCI bridge registers in the
> >>> pcibios_fixup_bus hook, that is called by the PCI generic layer
> >>> whenever a PCI bus is scanned.
> >>>
> >>> Since pci_read_bridge_bases is an arch agnostic operation (and it
> >>> is carried out on all architectures) it can be moved to the generic
> >>> PCI layer in order to consolidate code and remove the respective
> >>> calls from the architectures back-ends.
> >>>
> >>> The PCI_PROBE_ONLY flag is not checked before calling
> >>> pci_read_bridge_buses in the generic layer since reading the bridge
> >>> bases is not related to resources assignment; this implies that it
> >>> can be carried out safely on PCI_PROBE_ONLY systems too and should
> >>> not affect architectures (alpha, mips) that check the PCI_PROBE_ONLY
> >>> flag before reading the bridge bases.
> >>>
> >>> In order to validate the resource hierarchy as soon as the resources
> >>> themselves are probed (ie read from the bridge), this patch also adds
> >>> code to pci_read_bridge_bases that claims the bridge resources, so that
> >>> they are validated and inserted in the resource hierarchy as soon as
> >>> the bridge bases are probed.
> >>>
> >>
> >> Hi Lorenzo,
> >>
> >> on one of our systems, I see a lot of messages with your patch applied.
> >>
> >> bart kernel: pci 0000:b0:00.0: can't claim BAR 7 [io 0x0000-0x0fff]: no compatible bridge window
> >> bart kernel: pci 0000:b0:00.0: can't claim BAR 8 [mem 0x94000000-0x941fffff]: no compatible bridge window
> >> bart kernel: pci 0000:b1:03.0: can't claim BAR 7 [io 0x0000-0x0fff]: no compatible bridge window
> >> bart kernel: pci 0000:b1:03.0: can't claim BAR 8 [mem 0x95800000-0x959fffff]: no compatible bridge window
> >>
> >> and so on. The final IO memory assignment is the same, though,
> >> before and after your patch.
> >>
> >>        95800000-95bfffff : PCI Bus 0000:b0
> >>          95800000-959fffff : PCI Bus 0000:b1
> >> 	  95800000-959fffff : PCI Bus 0000:b2
> >> 	95a00000-95a3ffff : 0000:b0:00.0
> >>
> >>
> >> Does that have any relevance or is it just nuisance messages ?
> >
> > Yes, I knew this could happen. It should be just nuisance messages,
> > since we are claming bridge resources even on systems where they
> > are reassigned. We should remove those messages, this means that I
> > have to craft a function that claims resources without spitting too
> > much unwanted noise, I can't use pci_claim_bridge_resource for this
> > purpose as you have noticed, unless I refactor it, open to suggestions
> > (we claim bridge resources by default, regardless of PROBE_ONLY flag).
> >
> > Thanks a lot for testing it, appreciated, I will prepare a v3.
> >
> 
> Hi Lorenzo,
> 
> There is no need for v3 because of this. My patch set addresses the BAR 7
> message, and the BAR 8 message is actually warranted since the memory
> window on the upstream port is too small.

I'd agree it is warranted, still we have to expect similar messages
printed on kernel logs for other platforms that are _not_ printed
by current mainline, I guess that's acceptable and it was expected
when we decided to claim bridge resources in core code by default.

I am open to feedback if we want to change this behaviour, I am more
concerned about the patch test coverage to check it does not affect
behaviour on archs we do not have HW to test on.

Thank you,
Lorenzo
