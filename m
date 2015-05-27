Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <5565F40C.8010004@amd.com>
Date: Wed, 27 May 2015 11:42:52 -0500
From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC: Ralf Baechle <ralf@linux-mips.org>,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Henderson <rth@twiddle.net>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	David Howells <dhowells@redhat.com>,
	Russell King <linux@arm.linux.org.uk>,
	Tony Luck <tony.luck@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Ingo Molnar <mingo@redhat.com>,
	Michal Simek <monstr@monstr.eu>,
	Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
	Chris Zankel <chris@zankel.net>,
	"Arnd Bergmann" <arnd@arndb.de>,
	Krzysztof Halasa <khalasa@piap.pl>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Jingoo Han <jg1.han@samsung.com>,
	"Lucas Stach" <l.stach@pengutronix.de>,
	Simon Horman <horms@verge.net.au>,
	"Minghuan Lian" <minghuan.Lian@freescale.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Will Deacon <will.deacon@arm.com>,
	Jayachandran C <jchandra@broadcom.com>
Subject: Re: [RFC/RFT PATCH] PCI: move pci_read_bridge_bases to the generic
 PCI layer
References: <1432214067-2752-1-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1432214067-2752-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

Sorry for late reply.

On 5/21/2015 8:14 AM, Lorenzo Pieralisi wrote:
> When a PCI bus is scanned, upon PCI bridge detection the kernel
> has to read the bridge registers to set-up its resources so that
> the PCI resource hierarchy can be validated properly.
>
> Most if not all architectures read PCI bridge registers in the
> pcibios_fixup_bus hook, that is called by the PCI generic layer
> whenever a PCI bus is scanned.
>
> Since pci_read_bridge_bases is an arch agnostic operation (and it
> is carried out on all architectures) it can be moved to the generic
> PCI layer in order to consolidate code and remove the respective
> calls from the architectures back-ends.
>
> The PCI_PROBE_ONLY flag is not checked before calling
> pci_read_bridge_buses in the generic layer since reading the bridge
> bases is not related to resources assignment; this implies that it
> can be carried out safely on PCI_PROBE_ONLY systems too and should
> not affect architectures (alpha, mips) that check the PCI_PROBE_ONLY
> flag before reading the bridge bases.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: James E.J. Bottomley <jejb@parisc-linux.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Koichi Yasutake <yasutake.koichi@jp.panasonic.com>
> Cc: Chris Zankel <chris@zankel.net>
> ---
>   arch/alpha/kernel/pci.c          |  7 +------
>   arch/frv/mb93090-mb00/pci-vdk.c  |  2 --
>   arch/ia64/pci/pci.c              |  1 -
>   arch/microblaze/pci/pci-common.c |  9 +--------
>   arch/mips/pci/pci.c              |  6 ------
>   arch/mn10300/unit-asb2305/pci.c  |  1 -
>   arch/powerpc/kernel/pci-common.c |  8 +-------
>   arch/x86/pci/common.c            |  1 -
>   arch/xtensa/kernel/pci.c         |  4 ----
>   drivers/parisc/dino.c            |  3 ---
>   drivers/parisc/lba_pci.c         |  1 -
>   drivers/pci/probe.c              | 11 ++++++++++-
>   12 files changed, 13 insertions(+), 41 deletions(-)
>
> [.....]
 >
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 062fee6..335d9f2 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -453,7 +453,11 @@ void pci_read_bridge_bases(struct pci_bus *child)
>   	struct resource *res;
>   	int i;
>
> -	if (pci_is_root_bus(child))	/* It's a host bus, nothing to read */
> +	/*
> +	 * If it is not a PCI bridge there is nothing to read
> +	 */
> +	if (pci_is_root_bus(child) || !dev ||
> +		!((dev->class >> 8) == PCI_CLASS_BRIDGE_PCI))
>   		return;
>
>   	dev_info(&dev->dev, "PCI bridge to %pR%s\n",
> @@ -1878,6 +1882,11 @@ unsigned int pci_scan_child_bus(struct pci_bus *bus)
>   	 * all PCI-to-PCI bridges on this bus.
>   	 */
>   	if (!bus->is_added) {
> +		/*
> +		 * Read and initialize bridge resources.
> +		 */
> +		pci_read_bridge_bases(bus);
> +
>   		dev_dbg(&bus->dev, "fixups for bus\n");
>   		pcibios_fixup_bus(bus);
>   		bus->is_added = 1;
>

So, I have tested the patch on ARM64 system w/ PROBE_ONLY mode, and 
noticed that we are calling pci_read_bridge_bases() after adding the 
devices on the slots. This is not soon enough since the downstream 
devices still failing to claim resources.

However, do you think we can move pci_read_bridge_bases() before the 
pci_scan_slot() loop?

Thanks,
Suravee

