Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51832 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752611AbbG0JkC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 27 Jul 2015 05:40:02 -0400
Date: Mon, 27 Jul 2015 10:40:46 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Jingoo Han <jingoohan1@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Michal Simek <michal.simek@xilinx.com>,
	Marc Zyngier <Marc.Zyngier@arm.com>,
	James Morse <James.Morse@arm.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Jayachandran C <jchandra@broadcom.com>
Subject: Re: [PATCH v2 2/2] ARM: pci: kill pcibios_msi_controller
Message-ID: <20150727094046.GB10308@red-moon>
References: <1437754383-8162-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1437754383-8162-2-git-send-email-lorenzo.pieralisi@arm.com>
 <20150726185822.GB7557@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150726185822.GB7557@n2100.arm.linux.org.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jul 26, 2015 at 07:58:22PM +0100, Russell King - ARM Linux wrote:
> On Fri, Jul 24, 2015 at 05:13:03PM +0100, Lorenzo Pieralisi wrote:
> > On ARM PCI systems relying on the pcibios API to initialize PCI host
> > controllers, the pcibios_msi_controller weak callback is used to look-up
> > the msi_controller pointer, through pci_sys_data msi_ctrl pointer.
> > 
> > pci_sys_data is an ARM specific structure, which prevents using the
> > same mechanism (so same PCI host controller drivers) on ARM64 systems.
> > 
> > Since the struct pci_bus already contains an msi_controller pointer and
> > the kernel already uses it to look-up the msi controller,
> > this patch converts ARM host controller and related pcibios/host bridges
> > initialization routines so that the msi_controller pointer look-up can be
> > carried out by PCI core code through the struct pci_bus msi pointer,
> > removing the need for the arch specific pcibios_msi_controller callback
> > and the related pci_sys_data msi_ctrl pointer.
> > 
> > ARM is the only arch relying on the pcibios_msi_controller() weak
> > function, hence this patch removes the default weak implementation
> > from PCI core code since it becomes of no use.
> 
> You don't mention the change from using pci_scan_root_bus() to using
> pci_create_root_bus() here.
> 
> > -				sys->bus = pci_scan_root_bus(parent, sys->busnr,
> > -						hw->ops, sys, &sys->resources);
> > +			} else {
> > +				sys->bus = pci_create_root_bus(parent,
> > +							       sys->busnr,
> > +							       hw->ops, sys,
> > +							       &sys->resources);
> 
> By making this change, there is no nothing which will call
> pci_bus_insert_busn_res().

Yes, you are correct I noticed that too (I guess all ARM bridges
relying on pci_scan_root_bus do NOT initialize the BUS resource
so they rely on pci_scan_root_bus, and related BUS resource insertion
to function properly).

> What about the 18 users of the ->scan method, at least IOP13xx appears
> to be MSI-enabled, though it's not clear whether it works with MSI.

I do not think IOP13xx is affected by this change so we should be fine on
that side, I should have chased all msi_ctrl users in this series,
but the point raised above needs tackling regardless.

> This doesn't seem to be a good approach.  Maybe having a version of
> pci_scan_root_bus() which takes the MSI data as an argument would be
> better than selectively copying pci_scan_root_bus() into the ARM code?

I understand your point, let's try to find a fast way forward, we are
stuck otherwise:

1) I do not touch bios32 at all. I convert all host bridges that require
   an msi pointer to use the scan pointer in struct hw_pci and basically
   implement the change in bios32 in their scan method (I did that
   already for the in tree host bridges that rely on the scan method
   and require an msi pointer in pci_bus to function)
2) I add pci_bus_insert_busn_res() in the bios32 code, therefore as you
   said literally copying core code into bios32 (+ msi pointer
   initialization), horrible, but I promise it will disappear as soon
   as we are done converting all ARM PCI host to the new IRQ MSI domain
   infrastructure, which do not require an msi pointer in the struct
   pci_bus structure to be populated at all.
3) I patch pci_scan_root_bus() to pass the MSI pointer. I think that
   pcibios_msi_controller was added to avoid doing this, that
   function has already 5 parameters and it is a treewide change,
   I suspect Bjorn won't be happy about this at all.

Those are the reasonable ideas I have in mind, I think (1) is the
fastest (basically I _hope_ it should mean that I only have to patch
drivers/pci/host/pcie-rcar.c) and I avoid patching ARM bios32.

Comments very welcome before I proceed and I would appreciate some
feedback from PCI host bridges platform maintainers too to find a way
forward.

Thanks,
Lorenzo
