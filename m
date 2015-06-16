Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 16 Jun 2015 10:55:07 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
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
	Guenter Roeck <linux@roeck-us.net>,
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
	Jayachandran C <jchandra@broadcom.com>
Subject: Re: [RFC/RFT PATCH v2] PCI: move pci_read_bridge_bases to the
 generic PCI layer
Message-ID: <20150616095507.GB24710@red-moon>
References: <1433840506-20083-1-git-send-email-lorenzo.pieralisi@arm.com>
 <5579E74A.3000808@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5579E74A.3000808@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 11, 2015 at 08:53:46PM +0100, Suravee Suthikulanit wrote:
> For ARM64 PROBE_ONLY and non-PROBE_ONLY modes:
> 
> Reviewed and Tested-by: Suravee Suthikulpanit
> <Suravee.Suthikulpanit@amd.com>

Thank you !

> Please see minor comments below.

[...]

> > +static void pci_claim_bridge_resources(struct pci_bus *bus)
> > +{
> > +     struct pci_dev *dev = bus->self;
> > +     int idx;
> > +
> > +     for (idx = PCI_BRIDGE_RESOURCES; idx < PCI_NUM_RESOURCES; idx++) {
> > +             struct resource *r = &dev->resource[idx];
> > +
> > +             if (!r->flags || r->parent)
> > +                     continue;
> > +
> > +             pci_claim_bridge_resource(dev, idx);
> > +     }
> > +}
> > +
> 
> Nitpicking: Since pci_claim_bridge_resources() is small, and only called
> once from pci_read_brdige_bases(), should we just put the loop inside
> the function?

I think it is ok to add a function for it, I am not fussed either
way I am more concerned by testing the patch on archs I do not have
access to.

Thank you,
Lorenzo
