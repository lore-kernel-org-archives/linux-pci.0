Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 8 Oct 2015 10:28:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Daney <ddaney.cavm@gmail.com>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Marc Zyngier <marc.zyngier@arm.com>,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v4 0/5] PCI: generic: Misc. bug fixes/enhancements
Message-ID: <20151008152811.GD3885@localhost>
References: <1443811443-18878-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1443811443-18878-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 02, 2015 at 11:43:58AM -0700, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> While using the pci-host-generic driver to add PCI support for the
> Cavium ThunderX processors, several bugs were discovered.  This patch
> set fixes the bugs, a follow-on set will add the ThunderX support.
> 
> Changes from v3:
> 
>   - Drop "PCI: generic: Claim device resources if PCI_PROBE_ONLY"
> 
>   - Add some Acked-by:
> 
>   - Add to explanation of "reg" property in host-generic-pci.txt.
> 
>   - Add error message if "reg" property is too big.
> 
>   - Use pointer to ops rather than make a copy.
> 
> Changes from v2:
> 
>   - Added " PCI: generic: Claim device resources if PCI_PROBE_ONLY"
> 
> Changes from v1:
> 
>   - "PCI: generic: Allow bus default MSI controller to be specified."
>     patch was dropped as it is no longer necessary.
> 
>   - "PCI: Make global and export pdev_fixup_irq()." and "PCI: generic:
>     Only fixup irqs for bus we are creating." were rewritten to move
>     the support into a somewhat more generic form in setup-irq.c.
> 
>   - Add some clarifying text to host-generic-pci.txt
> 
>   - Add some Acked-by:
> 
> 
> David Daney (5):
>   PCI: Add pci_bus_fixup_irqs().
>   PCI: generic: Only fixup irqs for bus we are creating.

I'm hoping we won't need the above if we can resurrect Matthew's
patches.

>   PCI: generic: Quit clobbering our pci_ops.

Applied to pci/host-generic for v4.4 with Arnd's Reviewed-by and minor
changelog tweaks (as below).

>   PCI: generic: Correct, and avoid overflow, in bus_max calculation.

Seems not settled yet.

>   PCI: generic: Pass proper starting bus number to pci_scan_root_bus().

Also applied to pci/host-generic, thanks!

commit 9a28033753ca
Author: David Daney <david.daney@cavium.com>
Date:   Thu Oct 8 10:15:10 2015 -0500

    PCI: generic: Allow multiple hosts with different map_bus() methods
    
    The generic driver kept a global struct pci_ops ("gen_pci_ops") which it
    patched with the .map_bus() method appropriate for the bus device.  This is
    a problem when we have two different types of bus devices: the .map_bus()
    method for the last device probed clobbers the method for previous devices.
    The result is that only the last bus device probed has the correct
    .map_bus(), and the others fail.
    
    Move the struct pci_ops into the bus-specific structure and initialize a
    pointer to it when the bus device is probed.
    
    Signed-off-by: David Daney <david.daney@cavium.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Arnd Bergmann <arnd@arndb.de>
    Acked-by: Will Deacon <will.deacon@arm.com>

commit 47ddb949029f
Author: David Daney <david.daney@cavium.com>
Date:   Thu Oct 8 10:24:41 2015 -0500

    PCI: generic: Pass starting bus number to pci_scan_root_bus()
    
    If the bus is being configured with a bus-range that does not start at
    zero, pass that starting bus number to pci_scan_root_bus().  Passing the
    incorrect value of zero causes attempted config accesses outside of the
    supported range, which cascades to an OOPs spew and eventual kernel panic.
    
    Signed-off-by: David Daney <david.daney@cavium.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Acked-by: Will Deacon <will.deacon@arm.com>
