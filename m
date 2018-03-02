Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 1 Mar 2018 18:03:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: RFC on Kdump and PCIe on ARM64
Message-ID: <20180302000303.GD74737@bhelgaas-glaptop.roam.corp.google.com>
References: <c5c2d8d2-0384-442a-7bc6-8929457b8447@codeaurora.org>
 <20180301190552.GK13722@bhelgaas-glaptop.roam.corp.google.com>
 <2b2de17c-8527-e49b-2ef2-2a3d1801e4f9@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <2b2de17c-8527-e49b-2ef2-2a3d1801e4f9@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Vikram Sethi <vikrams@codeaurora.org>, Linux PCI <linux-pci@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
 iommu@lists.linux-foundation.org,
 "shankerd@codeaurora.org" <shankerd@codeaurora.org>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, "Goel,
 Sameer" <sgoel@codeaurora.org>, David Woodhouse <dwmw2@infradead.org>,
 kexec@lists.infradead.org, Nate Watterson <nwatters@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 01, 2018 at 02:19:09PM -0500, Sinan Kaya wrote:
> On 3/1/2018 2:05 PM, Bjorn Helgaas wrote:
> > On Thu, Mar 01, 2018 at 12:44:26PM -0500, Sinan Kaya wrote:
> >> Hi,
> >>
> >> We are seeing IOMMU faults when booting the kdump kernel on ARM64.
> >>
> >> [    7.220162] arm-smmu-v3 arm-smmu-v3.0.auto: event 0x02 received:
> >> [    7.226123] arm-smmu-v3 arm-smmu-v3.0.auto:            0x0000010000000002
> >> [    7.232023] arm-smmu-v3 arm-smmu-v3.0.auto:            0x0000000000000000
> >> [    7.237925] arm-smmu-v3 arm-smmu-v3.0.auto:            0x0000000000000000
> >> [    7.243827] arm-smmu-v3 arm-smmu-v3.0.auto:            0x0000000000000000
> >>
> >> This is Nate's interpretation of the fault:
> >>
> >> "The PCI device is sending transactions just after the SMMU was
> >> reset/reinitialized which is problematic because the device has not
> >> yet been added to the SMMU and thus should not be doing *any* DMA.
> >> DMA from the PCI devices should be quiesced prior to starting the
> >> crashdump kernel or you risk overwriting portions of memory you
> >> meant to preserve. In this case the SMMU was actually doing you a
> >> favor by blocking these errant DMA operations!!"
> >>
> >> I think this makes sense especially for the IOMMU enabled case on
> >> the host where an IOVA can overlap with the region of memory kdump
> >> reserved for itself.
> >>
> >> Apparently, there has been similar concerns in the past.
> >>
> >> https://www.fujitsu.com/jp/documents/products/software/os/linux/catalog/LinuxConJapan2013-Indoh.pdf
> >>
> >> and was not addressed globally due to IOMMU+PCI driver ordering
> >> issues and bugs in HW due to hot reset.
> >>
> >> https://lkml.org/lkml/2012/8/3/160
> >>
> >> Hot reset as mentioned is destructive and may not be the best
> >> implementation choice.  However, most of the modern endpoints
> >> support PCIE function level reset.
> >>
> >> One other solution is for SMMUv3 driver to reserve the kdump used
> >> IOVA addresses.
> >>
> >> Another solution is for the SMMUv3 driver to disable PCIe devices
> >> behind the SMMU if it see SMMU is already enabled.
> > 
> > What problem are you trying to solve?  If the IOMMU is blocking DMA
> > after the kdump kernel starts up, that sounds like the desired
> > behavior.
> > 
> 
> Three issues:
> 1. I'm seeing a flood of SMMUv3 faults due to adapter using
> addresses from the previous kernel. This might be OK. 

Yep.  That's cosmetic and we could suppress the messages if they were
a problem.

Isn't part of the point of an IOMMU protection against malicious
devices and drivers?  If so, we should be able to withstand an
arbitrary number of faults.

> 2. When the SMMUv3 driver sees that it is enabled, it resets itself
> and configures it one more time. 
> 
> [    7.018304] arm-smmu-v3 arm-smmu-v3.0.auto: ias 44-bit, oas 44-bit (features 0x00001fef)
> [    7.026379] arm-smmu-v3 arm-smmu-v3.0.auto: SMMU currently enabled! Resetting...
> 
> From the moment IOMMU is disabled to the point where IOMMU get
> enabled again, there is a potential for the PCIE device to corrupt
> the kdump kernel memory as the bus master and memory enable bits are
> left enabled.

Do you really have to reset the IOMMU?  Can you just give it new page
tables that start out with all IOVAs from all devices being invalid,
then add valid mappings as drivers need them (presumably after the
driver has done whatever it needs to so the device stops using the old
DMA addresses)?

> [    0.000000] crashkernel reserved: 0x000000007fe00000 - 0x00000000ffe00000 (2048 MB)
> 
> This region happens to overlap with the IOVA addresses that SMMUv3
> driver on the main kernel is allocating.
> 
> IOVA addresses start from 0xFFFFFFFF and get decremented on each
> allocation.
> 
> 3. The last one is adapter gets into fuzzy state due to not coming
> out of clean state in the second time init and being rejected by
> SMMUv3 multiple times.
> 
> [   16.093441] pci 0000:01:00.0: aer_status: 0x00040000, aer_mask: 0x00000000
> [   16.099356] pci 0000:01:00.0: Malformed TLP
> [   16.103522] pci 0000:01:00.0: aer_layer=Transaction Layer, aer_agent=Receiver ID
> [   16.110900] pci 0000:01:00.0: aer_uncor_severity: 0x00062011
> [   16.116543] pci 0000:01:00.0:   TLP Header: 0a00a000 00008100 01010100 00000000

I'm not clear on this.  I don't remember what an IOMMU fault looks
like to an Endpoint.  Are you saying that if an Endpoint sees too many
of those faults, it gets into this "fuzzy state" (whatever that is :))?
Is this a hardware defect?  Do we care (this is a kdump kernel, after
all)?  If we do care, can we fix the device by resetting it?

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
