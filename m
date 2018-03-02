Return-Path: <SRS0=1EEN=FY=redhat.com=bhe@kernel.org>
Return-Path: <SRS0=1EEN=FY=redhat.com=bhe@kernel.org>
Date: Fri, 2 Mar 2018 09:44:02 +0800
From: Baoquan He <bhe@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Sinan Kaya <okaya@codeaurora.org>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Vikram Sethi <vikrams@codeaurora.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
	iommu@lists.linux-foundation.org,
	"shankerd@codeaurora.org" <shankerd@codeaurora.org>,
	linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
	"Goel, Sameer" <sgoel@codeaurora.org>,
	David Woodhouse <dwmw2@infradead.org>, kexec@lists.infradead.org,
	Nate Watterson <nwatters@codeaurora.org>
Subject: Re: RFC on Kdump and PCIe on ARM64
Message-ID: <20180302014402.GA32509@localhost.localdomain>
References: <c5c2d8d2-0384-442a-7bc6-8929457b8447@codeaurora.org>
 <20180301190552.GK13722@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180301190552.GK13722@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On 03/01/18 at 01:05pm, Bjorn Helgaas wrote:
> [+cc Joerg, David, iommu list]
> 
> On Thu, Mar 01, 2018 at 12:44:26PM -0500, Sinan Kaya wrote:
> > Hi,
> > 
> > We are seeing IOMMU faults when booting the kdump kernel on ARM64.
> > 
> > [    7.220162] arm-smmu-v3 arm-smmu-v3.0.auto: event 0x02 received:
> > [    7.226123] arm-smmu-v3 arm-smmu-v3.0.auto:            0x0000010000000002
> > [    7.232023] arm-smmu-v3 arm-smmu-v3.0.auto:            0x0000000000000000
> > [    7.237925] arm-smmu-v3 arm-smmu-v3.0.auto:            0x0000000000000000
> > [    7.243827] arm-smmu-v3 arm-smmu-v3.0.auto:            0x0000000000000000
> > 
> > This is Nate's interpretation of the fault:
> > 
> > "The PCI device is sending transactions just after the SMMU was
> > reset/reinitialized which is problematic because the device has not
> > yet been added to the SMMU and thus should not be doing *any* DMA.
> > DMA from the PCI devices should be quiesced prior to starting the
> > crashdump kernel or you risk overwriting portions of memory you
> > meant to preserve. In this case the SMMU was actually doing you a
> > favor by blocking these errant DMA operations!!"

This seems an known issue which existed on x86 arch with intel vt-d
or amd-vi iommu deployed. Both of them have been fixed on x86. The root
cause is that kexec/kdump jumping is a warm reboot, it skips
bios/firmware. That left behind on-flight DMA which is started in 1st
kernel, and on-going during kdump kernel bootup. Then iommu devices
init will cause the on-flight DMA being stray and access those memory
region violently until pci devices initialization.

On x86, for intel vt-d iommu, patches and discussion can be found here:
https://lists.onap.org/pipermail/iommu/2015-May/012948.html

Finally, Joerg made a formal fix to make it.

On amd-iommu, I made a patchset with Joerg's help.

http://linux.kernel.narkive.com/Przi0Xaf/patch-v10-00-12-fix-the-on-flight-dma-issue-on-system-with-amd-iommu

On arm64, not sure how different the smmu is, you might need to do the
similar thing. Personal opinion, just for reference.

Thanks
Baoquan

> > 
> > I think this makes sense especially for the IOMMU enabled case on
> > the host where an IOVA can overlap with the region of memory kdump
> > reserved for itself.
> > 
> > Apparently, there has been similar concerns in the past.
> > 
> > https://www.fujitsu.com/jp/documents/products/software/os/linux/catalog/LinuxConJapan2013-Indoh.pdf
> > 
> > and was not addressed globally due to IOMMU+PCI driver ordering
> > issues and bugs in HW due to hot reset.
> > 
> > https://lkml.org/lkml/2012/8/3/160
> > 
> > Hot reset as mentioned is destructive and may not be the best
> > implementation choice.  However, most of the modern endpoints
> > support PCIE function level reset.
> > 
> > One other solution is for SMMUv3 driver to reserve the kdump used
> > IOVA addresses.
> > 
> > Another solution is for the SMMUv3 driver to disable PCIe devices
> > behind the SMMU if it see SMMU is already enabled.
> 
> What problem are you trying to solve?  If the IOMMU is blocking DMA
> after the kdump kernel starts up, that sounds like the desired
> behavior.
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
