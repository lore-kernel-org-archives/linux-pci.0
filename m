Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:33836 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753929AbbGWQNE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jul 2015 12:13:04 -0400
Received: by iebmu5 with SMTP id mu5so311938ieb.1
        for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2015 09:13:03 -0700 (PDT)
Date: Thu, 23 Jul 2015 11:12:57 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
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
	Will Deacon <will.deacon@arm.com>,
	Jayachandran C <jchandra@broadcom.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: Re: [RFT PATCH v3] PCI: move pci_read_bridge_bases to the generic
 PCI layer
Message-ID: <20150723161257.GZ21967@google.com>
References: <1436439557-21075-1-git-send-email-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1436439557-21075-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 09, 2015 at 11:59:16AM +0100, Lorenzo Pieralisi wrote:
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

Applied to pci/resource for v4.3, thanks!

The PCI_PROBE_ONLY text seems backward to me: previously alpha and mips
only called pci_read_bridge_bases() if PCI_PROBE_ONLY was set.  After this
patch, alpha and mips systems that do not set PCI_PROBE_ONLY will also call
pci_read_bridge_bases().

I really don't know why alpha and mips were like that.  It seems backwards.
It seems like we'd want to know the bridge windows if we were assigning
things, but they only read them if they were *not* going to assign things.

I'm a little uneasy that we might break some alpha or mips system, since
there must have been some reason this was done originally.  It'd be ideal
if somebody could test a non-PCI_PROBE_ONLY system.  But maybe they're all
obsolete.

I amended the changelog like this:

    PCI: Call pci_read_bridge_bases() from core instead of arch code
    
    When we scan a PCI bus, we read PCI-PCI bridge window registers with
    pci_read_bridge_bases() so we can validate the resource hierarchy.  Most
    architectures call pci_read_bridge_bases() from pcibios_fixup_bus(), but
    PCI-PCI bridges are not arch-specific, so this doesn't need to be in
    arch-specific code.
    
    Call pci_read_bridge_bases() directly from the PCI core instead of from
    arch code.
    
    For alpha and mips, we now call pci_read_bridge_bases() always; previously
    we only called it if PCI_PROBE_ONLY was set.
    
    [bhelgaas: changelog]
    Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    ...
