Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 22 Sep 2015 16:39:31 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
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
Subject: Re: [PATCH 2/3] PCI: Add quirks for devices found on Cavium ThunderX
 SoCs.
Message-ID: <20150922153931.GD17444@red-moon>
References: <1442529694-1792-1-git-send-email-ddaney.cavm@gmail.com>
 <3066583.BWDZlYWxXU@wuerfel>
 <55FC4330.10302@caviumnetworks.com>
 <2512701.zkjk3n3AQS@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2512701.zkjk3n3AQS@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 18, 2015 at 08:45:50PM +0100, Arnd Bergmann wrote:
> On Friday 18 September 2015 10:00:32 David Daney wrote:
> > On 09/18/2015 12:19 AM, Arnd Bergmann wrote:
> > > On Thursday 17 September 2015 15:41:33 David Daney wrote:
> > >> From: David Daney <david.daney@cavium.com>
> > >>
> > >> The on-chip devices all have fixed bars.  So, fix them up.
> > >>
> > >> Signed-off-by: David Daney <david.daney@cavium.com>
> > >>
> > >
> > > You should be able to just mark the BARs as fixed in DT
> > 
> > In the case of ACPI, there is no DT.  So we would need a different 
> > solution for ACPI.  What would you recommend for ACPI?
> 
> I would expect that this does not matter at all on ACPI, because
> the devices that need it are not hot-plugged, and all boot-time
> devices are probed by the firmware: the ACPI PCI implementation
> does not reassign any BARs, except for the hotplug case.

What do you mean by "the ACPI PCI implementation does not reassign
any BARs" ? Do you mean on x86 ? The resource assignment is part
of the resource survey on x86, where all resources that can be claimed
are claimed, but still, some of them may be still reassigned IIUC.

On arm64 we do not carry out any resource survey at present, but
if we do (and we should), it will have to work for both DT and ACPI
systems.

> > Also, can you point me to the OF device tree specification where it 
> > tells how to specify PCI BAR addresses, I would especially be interested 
> > in knowing how to specify fixed SRIOV BAR addresses in the device tree.
> 
> This is the 'n' bit mentioned sections 2.1.3 and 2.2.1.1 of the
> PCI binding. When it is set, the OS is not supposed to try to
> reassign the BAR even on machines that otherwise do a complete
> rescan.

I do not see any code in the kernel taking care of that bit and
if I am not mistaken the code that allows creating pci devices
exists in PowerPC arch code (arch/powerpc/kernel/pci_of_scan.c) and
should be moved out of there for the other arches to use it.

Or maybe we can use DT just to fix-up the resource flags (ie
every PCI device will have its own of_node set if it is present
in the DT, we can use it to fixup its resources and related flags,
pcibios_add_device() ?).

> The PCI binding traditionally requires you to list all PCI devices
> in DT, Linux as an extension (for the flattened DT format) allows
> leaving out the devices, but in this case you probably need to
> list every device that has a fixed BAR.
> 
> > Yes, it is a bit of a hack.  That is why I put it in its own file, and 
> > only try to hack up PCI devices that exactly match the vendor and device 
> > ids that need fixing.
> > 
> > IMHO, putting infrastructure into drivers/pci/probe.c, et al. to handle 
> > this would be much more intrusive.
> 
> My guess is that it's already there, but even if it's not, this is a
> generic well-defined case that has a standardized binding, and we should
> implement that.

See above.

Thanks,
Lorenzo

> > Forthe record:  The PCI Enhanced Allocation (EA) capability (approved 
> > by PCI SIG on 23 October 2014) is the proper way to handle this going 
> > forward.  However, this is not yet implemented in the SoCs that this 
> > patch addresses.  Our plan is to implement the EA capability in the core 
> > PCI code, so that we do not need to keep adding devices to this fixup code.
> 
> Good, but still this should only be required for the embedded case where
> you don't have a firmware to probe the bus.
> 
> 	Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
