Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:40895 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755223AbbGZS6n (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 26 Jul 2015 14:58:43 -0400
Date: Sun, 26 Jul 2015 19:58:22 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Jingoo Han <jingoohan1@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Michal Simek <michal.simek@xilinx.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	James Morse <james.morse@arm.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Jayachandran C <jchandra@broadcom.com>
Subject: Re: [PATCH v2 2/2] ARM: pci: kill pcibios_msi_controller
Message-ID: <20150726185822.GB7557@n2100.arm.linux.org.uk>
References: <1437754383-8162-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1437754383-8162-2-git-send-email-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437754383-8162-2-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 24, 2015 at 05:13:03PM +0100, Lorenzo Pieralisi wrote:
> On ARM PCI systems relying on the pcibios API to initialize PCI host
> controllers, the pcibios_msi_controller weak callback is used to look-up
> the msi_controller pointer, through pci_sys_data msi_ctrl pointer.
> 
> pci_sys_data is an ARM specific structure, which prevents using the
> same mechanism (so same PCI host controller drivers) on ARM64 systems.
> 
> Since the struct pci_bus already contains an msi_controller pointer and
> the kernel already uses it to look-up the msi controller,
> this patch converts ARM host controller and related pcibios/host bridges
> initialization routines so that the msi_controller pointer look-up can be
> carried out by PCI core code through the struct pci_bus msi pointer,
> removing the need for the arch specific pcibios_msi_controller callback
> and the related pci_sys_data msi_ctrl pointer.
> 
> ARM is the only arch relying on the pcibios_msi_controller() weak
> function, hence this patch removes the default weak implementation
> from PCI core code since it becomes of no use.

You don't mention the change from using pci_scan_root_bus() to using
pci_create_root_bus() here.

> -				sys->bus = pci_scan_root_bus(parent, sys->busnr,
> -						hw->ops, sys, &sys->resources);
> +			} else {
> +				sys->bus = pci_create_root_bus(parent,
> +							       sys->busnr,
> +							       hw->ops, sys,
> +							       &sys->resources);

By making this change, there is no nothing which will call
pci_bus_insert_busn_res().

What about the 18 users of the ->scan method, at least IOP13xx appears
to be MSI-enabled, though it's not clear whether it works with MSI.

This doesn't seem to be a good approach.  Maybe having a version of
pci_scan_root_bus() which takes the MSI data as an argument would be
better than selectively copying pci_scan_root_bus() into the ARM code?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
