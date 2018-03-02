Return-Path: <SRS0=SU4p=FY=arm.com=will.deacon@kernel.org>
Return-Path: <SRS0=SU4p=FY=arm.com=will.deacon@kernel.org>
Date: Fri, 2 Mar 2018 10:30:32 +0000
From: Will Deacon <will.deacon@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Sinan Kaya <okaya@codeaurora.org>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
	Nate Watterson <nwatters@codeaurora.org>,
	"shankerd@codeaurora.org" <shankerd@codeaurora.org>,
	Vikram Sethi <vikrams@codeaurora.org>,
	"Goel, Sameer" <sgoel@codeaurora.org>, kexec@lists.infradead.org,
	Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
	David Woodhouse <dwmw2@infradead.org>
Subject: Re: RFC on Kdump and PCIe on ARM64
Message-ID: <20180302103032.GB19323@arm.com>
References: <c5c2d8d2-0384-442a-7bc6-8929457b8447@codeaurora.org>
 <20180301190552.GK13722@bhelgaas-glaptop.roam.corp.google.com>
 <2b2de17c-8527-e49b-2ef2-2a3d1801e4f9@codeaurora.org>
 <20180302000303.GD74737@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180302000303.GD74737@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 01, 2018 at 06:03:03PM -0600, Bjorn Helgaas wrote:
> On Thu, Mar 01, 2018 at 02:19:09PM -0500, Sinan Kaya wrote:
> > On 3/1/2018 2:05 PM, Bjorn Helgaas wrote:
> > > On Thu, Mar 01, 2018 at 12:44:26PM -0500, Sinan Kaya wrote:
> > >> Hi,
> > >>
> > >> We are seeing IOMMU faults when booting the kdump kernel on ARM64.
> > >>
> > >> [    7.220162] arm-smmu-v3 arm-smmu-v3.0.auto: event 0x02 received:
> > >> [    7.226123] arm-smmu-v3 arm-smmu-v3.0.auto:            0x0000010000000002
> > >> [    7.232023] arm-smmu-v3 arm-smmu-v3.0.auto:            0x0000000000000000
> > >> [    7.237925] arm-smmu-v3 arm-smmu-v3.0.auto:            0x0000000000000000
> > >> [    7.243827] arm-smmu-v3 arm-smmu-v3.0.auto:            0x0000000000000000
> > >>
> > >> This is Nate's interpretation of the fault:
> > >>
> > >> "The PCI device is sending transactions just after the SMMU was
> > >> reset/reinitialized which is problematic because the device has not
> > >> yet been added to the SMMU and thus should not be doing *any* DMA.
> > >> DMA from the PCI devices should be quiesced prior to starting the
> > >> crashdump kernel or you risk overwriting portions of memory you
> > >> meant to preserve. In this case the SMMU was actually doing you a
> > >> favor by blocking these errant DMA operations!!"
> > >>
> > >> I think this makes sense especially for the IOMMU enabled case on
> > >> the host where an IOVA can overlap with the region of memory kdump
> > >> reserved for itself.
> > >>
> > >> Apparently, there has been similar concerns in the past.
> > >>
> > >> https://www.fujitsu.com/jp/documents/products/software/os/linux/catalog/LinuxConJapan2013-Indoh.pdf
> > >>
> > >> and was not addressed globally due to IOMMU+PCI driver ordering
> > >> issues and bugs in HW due to hot reset.
> > >>
> > >> https://lkml.org/lkml/2012/8/3/160
> > >>
> > >> Hot reset as mentioned is destructive and may not be the best
> > >> implementation choice.  However, most of the modern endpoints
> > >> support PCIE function level reset.
> > >>
> > >> One other solution is for SMMUv3 driver to reserve the kdump used
> > >> IOVA addresses.
> > >>
> > >> Another solution is for the SMMUv3 driver to disable PCIe devices
> > >> behind the SMMU if it see SMMU is already enabled.
> > > 
> > > What problem are you trying to solve?  If the IOMMU is blocking DMA
> > > after the kdump kernel starts up, that sounds like the desired
> > > behavior.
> > > 
> > 
> > Three issues:
> > 1. I'm seeing a flood of SMMUv3 faults due to adapter using
> > addresses from the previous kernel. This might be OK. 
> 
> Yep.  That's cosmetic and we could suppress the messages if they were
> a problem.
> 
> Isn't part of the point of an IOMMU protection against malicious
> devices and drivers?  If so, we should be able to withstand an
> arbitrary number of faults.
> 
> > 2. When the SMMUv3 driver sees that it is enabled, it resets itself
> > and configures it one more time. 
> > 
> > [    7.018304] arm-smmu-v3 arm-smmu-v3.0.auto: ias 44-bit, oas 44-bit (features 0x00001fef)
> > [    7.026379] arm-smmu-v3 arm-smmu-v3.0.auto: SMMU currently enabled! Resetting...
> > 
> > From the moment IOMMU is disabled to the point where IOMMU get
> > enabled again, there is a potential for the PCIE device to corrupt
> > the kdump kernel memory as the bus master and memory enable bits are
> > left enabled.
> 
> Do you really have to reset the IOMMU?  Can you just give it new page
> tables that start out with all IOVAs from all devices being invalid,
> then add valid mappings as drivers need them (presumably after the
> driver has done whatever it needs to so the device stops using the old
> DMA addresses)?

We already have the option to do that via the command line using the
disable_bypass option, so it just sounds like we need to take this into
account when resetting the SMMU to take care that GBPA is configured so
that transactions are terminated when SMMUEN=0.

Will
