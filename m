Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: David Daney <ddaney@caviumnetworks.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	David Daney <ddaney.cavm@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Will Deacon <Will.Deacon@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Marc Zyngier <Marc.Zyngier@arm.com>,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 2/3] PCI: Add quirks for devices found on Cavium ThunderX SoCs.
Date: Tue, 22 Sep 2015 21:33:25 +0200
Message-ID: <1763517.VsvPY9OlHW@wuerfel>
In-Reply-To: <20150922153931.GD17444@red-moon>
References: <1442529694-1792-1-git-send-email-ddaney.cavm@gmail.com> <2512701.zkjk3n3AQS@wuerfel> <20150922153931.GD17444@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 22 September 2015 16:39:31 Lorenzo Pieralisi wrote:
> On Fri, Sep 18, 2015 at 08:45:50PM +0100, Arnd Bergmann wrote:
> > On Friday 18 September 2015 10:00:32 David Daney wrote:
> > > On 09/18/2015 12:19 AM, Arnd Bergmann wrote:
> > > > On Thursday 17 September 2015 15:41:33 David Daney wrote:
> > > >> From: David Daney <david.daney@cavium.com>
> > > >>
> > > >> The on-chip devices all have fixed bars.  So, fix them up.
> > > >>
> > > >> Signed-off-by: David Daney <david.daney@cavium.com>
> > > >>
> > > >
> > > > You should be able to just mark the BARs as fixed in DT
> > > 
> > > In the case of ACPI, there is no DT.  So we would need a different 
> > > solution for ACPI.  What would you recommend for ACPI?
> > 
> > I would expect that this does not matter at all on ACPI, because
> > the devices that need it are not hot-plugged, and all boot-time
> > devices are probed by the firmware: the ACPI PCI implementation
> > does not reassign any BARs, except for the hotplug case.
> 
> What do you mean by "the ACPI PCI implementation does not reassign
> any BARs" ? Do you mean on x86 ? The resource assignment is part
> of the resource survey on x86, where all resources that can be claimed
> are claimed, but still, some of them may be still reassigned IIUC.

The ACPI PCI implementation should be completely architecture
independent and do the same thing everywhere. The code is spread
over drivers/acpi/pci*, with small parts currently residing in
arch/{x86,ia64} that need to be moved to drivers/acpi/

> On arm64 we do not carry out any resource survey at present, but
> if we do (and we should), it will have to work for both DT and ACPI
> systems.

This is not a difference between DT and ACPI, but a difference between
embedded and server. Server platforms that have a proper firmware
to scan the PCI bus should not set PCI_REASSIGN_ALL_RSRC and
PCI_REASSIGN_ALL_BUS, while embedded systems that don't set up
the PCI bus before boot have to set those.

On ACPI, reassigning the resources would actually be dangerous
because the firmware may rely on devices to be at a certain
location (both bus number and mmio address), or may play tricks
here to hide stuff from the OS.

> > > Also, can you point me to the OF device tree specification where it 
> > > tells how to specify PCI BAR addresses, I would especially be interested 
> > > in knowing how to specify fixed SRIOV BAR addresses in the device tree.
> > 
> > This is the 'n' bit mentioned sections 2.1.3 and 2.2.1.1 of the
> > PCI binding. When it is set, the OS is not supposed to try to
> > reassign the BAR even on machines that otherwise do a complete
> > rescan.
> 
> I do not see any code in the kernel taking care of that bit and
> if I am not mistaken the code that allows creating pci devices
> exists in PowerPC arch code (arch/powerpc/kernel/pci_of_scan.c) and
> should be moved out of there for the other arches to use it.
> 
> Or maybe we can use DT just to fix-up the resource flags (ie
> every PCI device will have its own of_node set if it is present
> in the DT, we can use it to fixup its resources and related flags,
> pcibios_add_device() ?).

I haven't looked at the code in detail now, but I'm pretty sure that
a device node that refers to a PCI device is connected to the
dev->of_node pointer already on all architectures.

It's quite possible that we never implemented the fixed BAR logic
though, but it can be done based on those pointers.

	Arnd
