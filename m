Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:50388 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097AbbFMBsL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 12 Jun 2015 21:48:11 -0400
Date: Fri, 12 Jun 2015 18:47:55 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
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
	Will Deacon <will.deacon@arm.com>,
	Jayachandran C <jchandra@broadcom.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: Re: [RFC/RFT PATCH v2] PCI: move pci_read_bridge_bases to the
 generic PCI layer
Message-ID: <20150613014755.GA29649@roeck-us.net>
References: <1433840506-20083-1-git-send-email-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1433840506-20083-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 09, 2015 at 10:01:45AM +0100, Lorenzo Pieralisi wrote:
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
> In order to validate the resource hierarchy as soon as the resources
> themselves are probed (ie read from the bridge), this patch also adds
> code to pci_read_bridge_bases that claims the bridge resources, so that
> they are validated and inserted in the resource hierarchy as soon as
> the bridge bases are probed.
> 

Hi Lorenzo,

on one of our systems, I see a lot of messages with your patch applied.

bart kernel: pci 0000:b0:00.0: can't claim BAR 7 [io 0x0000-0x0fff]: no compatible bridge window
bart kernel: pci 0000:b0:00.0: can't claim BAR 8 [mem 0x94000000-0x941fffff]: no compatible bridge window
bart kernel: pci 0000:b1:03.0: can't claim BAR 7 [io 0x0000-0x0fff]: no compatible bridge window
bart kernel: pci 0000:b1:03.0: can't claim BAR 8 [mem 0x95800000-0x959fffff]: no compatible bridge window

and so on. The final IO memory assignment is the same, though,
before and after your patch.

      95800000-95bfffff : PCI Bus 0000:b0
        95800000-959fffff : PCI Bus 0000:b1
	  95800000-959fffff : PCI Bus 0000:b2
	95a00000-95a3ffff : 0000:b0:00.0


Does that have any relevance or is it just nuisance messages ?

Thanks,
Guenter
