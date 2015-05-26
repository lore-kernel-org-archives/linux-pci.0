Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49686 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753450AbbEZNOI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 26 May 2015 09:14:08 -0400
Date: Tue, 26 May 2015 13:57:59 +0100
From: Will Deacon <will.deacon@arm.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
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
	"yasutake.koichi@jp.panasonic.com" <yasutake.koichi@jp.panasonic.com>,
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
	Jayachandran C <jchandra@broadcom.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
Subject: Re: [RFC/RFT PATCH] PCI: move pci_read_bridge_bases to the generic
 PCI layer
Message-ID: <20150526125759.GK1565@arm.com>
References: <1432214067-2752-1-git-send-email-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432214067-2752-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

On Thu, May 21, 2015 at 02:14:25PM +0100, Lorenzo Pieralisi wrote:
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

[...]

> diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
> index 82f738e..cded02c 100644
> --- a/arch/alpha/kernel/pci.c
> +++ b/arch/alpha/kernel/pci.c
> @@ -242,12 +242,7 @@ pci_restore_srm_config(void)
>  
>  void pcibios_fixup_bus(struct pci_bus *bus)
>  {
> -	struct pci_dev *dev = bus->self;
> -
> -	if (pci_has_flag(PCI_PROBE_ONLY) && dev &&
> - 		   (dev->class >> 8) == PCI_CLASS_BRIDGE_PCI) {
> - 		pci_read_bridge_bases(bus);
> -	} 

I appreciate you're basically moving this code ...

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 062fee6..335d9f2 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -453,7 +453,11 @@ void pci_read_bridge_bases(struct pci_bus *child)
>  	struct resource *res;
>  	int i;
>  
> -	if (pci_is_root_bus(child))	/* It's a host bus, nothing to read */
> +	/*
> +	 * If it is not a PCI bridge there is nothing to read
> +	 */
> +	if (pci_is_root_bus(child) || !dev ||
> +		!((dev->class >> 8) == PCI_CLASS_BRIDGE_PCI))
>  		return;

... to here, but shouldn't we dispense with the class check and use
pci_is_bridge instead? pci_read_bridge_bases is making an assumption
that the header type is BRIDGE, so that seems like the more sensible
check to me.

Also, with these changes, can we now make pci_read_bridge_bases static
(as it has an implicit rdering requirement on the device having been
scanned)?

Will
