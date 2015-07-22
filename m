Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36958 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934682AbbGVQyx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 22 Jul 2015 12:54:53 -0400
Date: Wed, 22 Jul 2015 17:55:31 +0100
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
Subject: Re: [RFT PATCH v3] PCI: move pci_read_bridge_bases to the generic
 PCI layer
Message-ID: <20150722165531.GB1153@red-moon>
References: <1436439557-21075-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20150722091427.GB344@red-moon>
 <55AFA741.2010703@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55AFA741.2010703@roeck-us.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Guenter,

On Wed, Jul 22, 2015 at 03:22:57PM +0100, Guenter Roeck wrote:
> On 07/22/2015 02:14 AM, Lorenzo Pieralisi wrote:
> > Bjorn, Guenter,
> >
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
> >> Cc: Ralf Baechle <ralf@linux-mips.org>
> >> Cc: James E.J. Bottomley <jejb@parisc-linux.org>
> >> Cc: Michael Ellerman <mpe@ellerman.id.au>
> >> Cc: Bjorn Helgaas <bhelgaas@google.com>
> >> Cc: Richard Henderson <rth@twiddle.net>
> >> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >> Cc: David Howells <dhowells@redhat.com>
> >> Cc: Russell King <linux@arm.linux.org.uk>
> >> Cc: Tony Luck <tony.luck@intel.com>
> >> Cc: David S. Miller <davem@davemloft.net>
> >> Cc: Ingo Molnar <mingo@redhat.com>
> >> Cc: Guenter Roeck <linux@roeck-us.net>
> >> Cc: Michal Simek <monstr@monstr.eu>
> >> Cc: Chris Zankel <chris@zankel.net>
> >> ---
> >> v2->v3:
> >>
> >> - Dropped RFC status
> >> - Removed bridge resources claiming from pci_read_bridge_bases()
> >
> > What do you want me to do with this patch ? I removed the resource
> > claiming - ie the only controversial bit, I can only test on
> > arm64, I would like to make some progress on this otherwise
> > I will have to add the bridge bases read to arm64 pcibios_fixup_bus()
> > and be done with this.
> >
> 
> Lorenzo,
> 
> please give me a few days to test it. I was out on vacation for
> the last two weeks, and I am still struggling to get my test systems
> back to a working state.

No worries, I just wanted to make sure we can make progress on this,
I do not think there is anything controversial in this set, it just
requires testing the mechanical change on all affected archs, that's
the problem.

Thanks a lot for your help !
Lorenzo
