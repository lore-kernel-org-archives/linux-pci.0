Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 4 Feb 2016 21:10:42 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Daney <ddaney@caviumnetworks.com>
Cc: David Daney <ddaney.cavm@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v4 2/2] pci, pci-thunder-pem: Add PCIe host driver for
 ThunderX processors.
Message-ID: <20160205031042.GA31722@localhost>
References: <1453844781-24380-1-git-send-email-ddaney.cavm@gmail.com>
 <1453844781-24380-3-git-send-email-ddaney.cavm@gmail.com>
 <20160205000452.GI7031@localhost>
 <56B3ECAD.4050605@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56B3ECAD.4050605@caviumnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 04, 2016 at 04:28:29PM -0800, David Daney wrote:
> On 02/04/2016 04:04 PM, Bjorn Helgaas wrote:
> >On Tue, Jan 26, 2016 at 01:46:21PM -0800, David Daney wrote:
> >>From: David Daney <david.daney@cavium.com>
> >>
> >>Some Cavium ThunderX processors require quirky access methods for the
> >>config space of the PCIe bridge.  Add a driver to provide these config
> >>space accessor functions.  The pci-host-common code is used to
> >>configure the PCI machinery.
> >>
> >>Signed-off-by: David Daney <david.daney@cavium.com>
> >>Acked-by: Rob Herring <robh@kernel.org>
> >>Acked-by: Arnd Bergmann <arnd@arndb.de>
> >>---
> >>  .../devicetree/bindings/pci/pci-thunder-pem.txt    |  43 ++++
> >>  MAINTAINERS                                        |   8 +
> >>  drivers/pci/host/Kconfig                           |   7 +
> >>  drivers/pci/host/Makefile                          |   1 +
> >>  drivers/pci/host/pci-thunder-pem.c                 | 283 +++++++++++++++++++++
> >
> >What's the significance of the "pem" part of the name?  I'm wondering
> >if we can shorten the filenames and function names by dropping it and
> >referring to this simply as "thunder" or "thunderx".
> 
> PEM == PCI Express MAC, Essentially the circuitry related to
> off-chip PCI devices.  This differentiates it from the internal
> on-chip devices which are connected to internal buses we refer to as
> "ECAMs"

That's an unusual and confusing usage of ECAM, since the PCIe spec
uses ECAM for "Enhanced Configuration Access Mechanism", which is not
a bus.

> See also the follow on patch, from me, that adds the
> pci-thunder-ecam.c driver.

OK.  In PCIe spec terms, I guess your PEM and ECAM are two separate
root complexes?  The spec defines a way to build a logical topology
and doesn't really care whether the devices are on-chip or off-chip.

> Since PEM and ECAM are terminology used in the hardware manuals that
> have specific meanings relative to the Thunder SoC family, I think
> it is not too inconvenient to carry them over into the file names.

As long as PEM and ECAM are really two distinct root complexes that
are unrelated, I guess this is OK.

I was imagining that PEM devices and ECAM devices would be in the same
hierarchy, in the same domain, in the same bus number space, but with
different ways of accessing their config space.  If that were the
case, you could have a single driver with config accessors that were
smart enough to figure out which method to use.  But if they're truly
separate and unrelated, then I guess it makes sense to have two
drivers.

Maybe a concrete example would make this clearer to me.  Can you share
a dmesg log and lspci output showing both PEM and ECAM devices?

> >>  5 files changed, 342 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/pci/pci-thunder-pem.txt
> >>  create mode 100644 drivers/pci/host/pci-thunder-pem.c
> >>
> 
> >>+
> >>+static int thunder_pem_config_write(struct pci_bus *bus, unsigned int devfn,
> >>+				    int where, int size, u32 val)
> >>+{
> >>+	struct gen_pci *pci = bus->sysdata;
> >>+	struct thunder_pem_pci *pem_pci;
> >>+
> >>+	pem_pci = container_of(pci, struct thunder_pem_pci, gen_pci);
> >>+
> >>+	/*
> >>+	 * The first device on the bus in the PEM PCIe bridge.
> >>+	 * Special case its config access.
> >>+	 */
> >>+	if (bus->number == pci->cfg.bus_range->start) {
> >>+		u64 write_val, read_val;
> >>+
> >>+		if (devfn != 0 || where >= 2048)
> >>+			return PCIBIOS_DEVICE_NOT_FOUND;
> >>+
> >>+		/*
> >>+		 * 32-bit accesses only.  If the write is for a size
> >>+		 * smaller than 32-bits, we must first read the 32-bit
> >>+		 * value and merge in the desired bits and then write
> >>+		 * the whole 32-bits back out.
> >>+		 */
> >
> >Ugh.  Another device that only supports 32-bit writes.  I guess this
> >only affects this single device, and maybe you "know" that it has no
> >registers where RW1C bits may be corrupted.  Although I suppose this
> >device has the standard status registers (Status at 0x06, Secondary
> >Status at 0x1e, Device Status in PCIe capability, etc.), which do
> >contain RW1C bits.
> 
> This device is exactly the specific PCIe host bridge implementation,
> present on these SoCs.  The only sane way to access its config space
> is via 32-bit operations.  We know that it presents the appropriate
> Class and other registers to be recognized as, and operate as, a
> standard PCIe bridge.

The only sane way to manage spec-conformant 16-bit Command and Status
Registers is to use 16-bit accesses.  Using a 32-bit read/modify/write
cycle to emulate a 16-bit write to the Command register means that we
inadvertently clear any RW1C bits that happened to be set in the
adjacent Status register.

Note that these are generic PCI-defined registers, and the code doing
16-bit accesses to them may be in the PCI core or possibly in a
driver.  They're not ThunderX-specific registers, and it's not
ThunderX-specific code.

> >We need to print a warning at probe-time so we know to consider the
> >possibility of corruption when debugging.
> 
> If you really want it, I suppose I can add that, but I am somewhat hesitant.

I think this is a serious quality of implementation issue, and I do
not want to debug status bits that mysteriously get cleared when
nothing in the PCI core code even touches them.  I at least want a
hint.

We have a warning in pcie-hisi.c already, and I intend to do something
similar in tegra, xgene, and iproc, which use
pci_generic_config_write32().  There are probably others that roll
their own.  I'm thinking something along the lines of
dev_warn("sub-32-bit writes may corrupt adjacent RW1C bits").

I don't really like this either, so I'm open to better ideas.  I
considered a one-time warning in pci_generic_config_write32(), but
that would associate the message with the PCI device when the problem
is in the host bridge, and obviously it wouldn't help for ThunderX
anyway.

Bjorn
