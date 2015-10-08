Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 8 Oct 2015 18:27:38 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: David Daney <ddaney@caviumnetworks.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
	David Daney <david.daney@cavium.com>,
	linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	David Daney <ddaney.cavm@gmail.com>,
	Kumar Gala <galak@codeaurora.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v4 4/5] PCI: generic: Correct, and avoid overflow, in
 bus_max calculation.
Message-ID: <20151008172738.GA2467@red-moon>
References: <1443811443-18878-1-git-send-email-ddaney.cavm@gmail.com>
 <20151008150243.GC3885@localhost>
 <5230007.h2fkbnOlh5@wuerfel>
 <5178627.ufUfdomGdT@wuerfel>
 <56168E4E.3070405@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56168E4E.3070405@caviumnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 08, 2015 at 08:39:58AM -0700, David Daney wrote:
> On 10/08/2015 08:18 AM, Arnd Bergmann wrote:
> >On Thursday 08 October 2015 17:11:32 Arnd Bergmann wrote:
> >>>>--- a/Documentation/devicetree/bindings/pci/host-generic-pci.txt
> >>>>+++ b/Documentation/devicetree/bindings/pci/host-generic-pci.txt
> >>>>@@ -34,7 +34,11 @@ Properties of the host controller node:
> >>>>  - #size-cells    : Must be 2.
> >>>>
> >>>>  - reg            : The Configuration Space base address and size, as accessed
> >>>>-                   from the parent bus.
> >>>>+                   from the parent bus.  The base address corresponds to
> >>>>+                   bus zero, even though the "bus-range" property may specify
> >>>>+                   a different starting bus number.  The driver must only map
> >>>>+                   or access the portion of the Configuration Space that
> >>>>+                   corresponds to the "bus-range"
> >>
> >>I thought we had reached an agreement that it is a bad idea to have a 'reg'
> >>property that lists registers belonging to a different device.
> >>
> >>
> >
> >To further clarify: the argument was to make it mirror what ACPI does for
> >PCI. However, this is unlike what all other devices do with DT, where you
> >have non-overlapping register ranges (start, length) for each device.
> >ACPI as far as I understand it does not give a range for a PCIe host, but
> >instead provides a way to get the start address of the ECAM register area
> >for the domain that the host is part of, and that needs to be the same
> >address for each host in the domain.
> >
> 
> We are agreed that it is a bad thing to do.  There is disagreement
> about if we should do it.
> 
> I think there are two schools of thought (I will attribute them to
> their proponents and my apologies if I misrepresent someone's
> stance):
> 
> 1) (Arnd) Don't make the the "reg" ranges overlap because it is
> ugly, dangerous and arguably incorrect in general.
> 
> 2) (Me, Will Deacon, Lorenzo Pieralisi) Overlapping "reg" properties
> should be maintained, as that is the current behavior and seems to
> agree with legacy OF device-tree specifications (although there is
> some debate about this).

I have just quoted the PCI FW specification, 4.1.4 section:

"System Software Implication of MCFG and _CBA"

which defines the ACPI behaviour of MCFG and _CBA methods for
hotplug bridges.

I understand Arnd's concerns and I do not think the DT bindings are well
defined in this respect, it is ok for me to define the DT bindings
using the "usual" reg property bindings representation, as long as we
document it and we all agree we are deviating from the PCI FW specs
(that just cover ACPI, BTW).

I think it is worth investigating why the current PCI FW specs were
defined that way for ECAM config space before proceeding any further,
to avoid pitfalls we might be missing.

Thanks,
Lorenzo

> Because the driver is broken in this area (thus the patch), it
> indicates that there are probably no users with non-zero starting
> bus numbers. So, we may have some latitude to change it.
> 
> I will generate another patch that does it Arnd's way, and if Will
> is OK with it, we might be able to do that instead.  One thing is
> certain: The driver is currently broken for non-zero starting bus
> numbers.
> 
> David Daney
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
