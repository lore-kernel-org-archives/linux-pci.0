Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58599 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695AbbFLIEw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 12 Jun 2015 04:04:52 -0400
Message-ID: <557A9292.30901@roeck-us.net>
Date: Fri, 12 Jun 2015 01:04:34 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
CC: Ralf Baechle <ralf@linux-mips.org>,
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
Subject: Re: [RFC/RFT PATCH v2] PCI: move pci_read_bridge_bases to the generic
 PCI layer
References: <1433840506-20083-1-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1433840506-20083-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/09/2015 02:01 AM, Lorenzo Pieralisi wrote:
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
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Chris Zankel <chris@zankel.net>

Working fine on powerpc (tested with Freescale P2020 and P5020) as well as x86
(tested on two different server class systems).

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

