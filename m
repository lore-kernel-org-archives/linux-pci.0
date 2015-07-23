Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41548 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753270AbbGWRwU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 23 Jul 2015 13:52:20 -0400
Date: Thu, 23 Jul 2015 18:52:58 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
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
Subject: Re: [RFT PATCH v3] PCI: move pci_read_bridge_bases to the generic
 PCI layer
Message-ID: <20150723175258.GC23324@red-moon>
References: <1436439557-21075-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20150723161257.GZ21967@google.com>
 <55B11AB0.7050002@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55B11AB0.7050002@roeck-us.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 23, 2015 at 05:47:44PM +0100, Guenter Roeck wrote:
> On 07/23/2015 09:12 AM, Bjorn Helgaas wrote:
> > On Thu, Jul 09, 2015 at 11:59:16AM +0100, Lorenzo Pieralisi wrote:
> >> When a PCI bus is scanned, upon PCI bridge detection the kernel
> >> has to read the bridge registers to set-up its resources so that
> >> the PCI resource hierarchy can be validated properly.
> >>
> >> Most if not all architectures read PCI bridge registers in the
> >> pcibios_fixup_bus hook, that is called by the PCI generic layer
> >> whenever a PCI bus is scanned.
> >>
> >> Since pci_read_bridge_bases is an arch agnostic operation (and it
> >> is carried out on all architectures) it can be moved to the generic
> >> PCI layer in order to consolidate code and remove the respective
> >> calls from the architectures back-ends.
> >>
> >> The PCI_PROBE_ONLY flag is not checked before calling
> >> pci_read_bridge_buses in the generic layer since reading the bridge
> >> bases is not related to resources assignment; this implies that it
> >> can be carried out safely on PCI_PROBE_ONLY systems too and should
> >> not affect architectures (alpha, mips) that check the PCI_PROBE_ONLY
> >> flag before reading the bridge bases.
> >>
> >> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >
> > Applied to pci/resource for v4.3, thanks!
> >
> > The PCI_PROBE_ONLY text seems backward to me: previously alpha and mips
> > only called pci_read_bridge_bases() if PCI_PROBE_ONLY was set.  After this
> > patch, alpha and mips systems that do not set PCI_PROBE_ONLY will also call
> > pci_read_bridge_bases().
> >
> > I really don't know why alpha and mips were like that.  It seems backwards.
> > It seems like we'd want to know the bridge windows if we were assigning
> > things, but they only read them if they were *not* going to assign things.
> >
> > I'm a little uneasy that we might break some alpha or mips system, since
> > there must have been some reason this was done originally.  It'd be ideal
> > if somebody could test a non-PCI_PROBE_ONLY system.  But maybe they're all
> > obsolete.
> >
> 
> For alpha, PCI_PROBE_ONLY is set for two platforms, marvel and titan,
> out of ~20. mips sets the flag for 6 platforms out of >25.
> Unlikely that those are the only relevant ones.
> 
> I could try to run some qemu tests for both architectures, but I have
> no idea what to look out for. Ideas, anyone ?

As I replied to Bjorn, I would not expect pci_read_bridge_bases() to
be a disruptive operation on !PCI_PROBE_ONLY systems, I will check
again alpha and mips code but it is really hard to say, I will
inspect the code again to try to figure it out.

Thanks !
Lorenzo
