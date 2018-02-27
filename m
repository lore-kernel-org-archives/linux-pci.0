Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC: Mark Rutland <Mark.Rutland@arm.com>,
        "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        "xuzaibo@huawei.com" <xuzaibo@huawei.com>,
        Will Deacon <Will.Deacon@arm.com>,
        "okaya@codeaurora.org" <okaya@codeaurora.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "bharatku@xilinx.com" <bharatku@xilinx.com>,
        "rfranz@cavium.com" <rfranz@cavium.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "shunyong.yang@hxt-semitech.com" <shunyong.yang@hxt-semitech.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH 01/37] iommu: Introduce Shared Virtual Addressing API
Date: Tue, 27 Feb 2018 06:21:58 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19101C8A7@SHSMSX101.ccr.corp.intel.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-2-jean-philippe.brucker@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191002823@SHSMSX101.ccr.corp.intel.com>
 <b3c190e7-1a33-971e-b86c-a9725118ba05@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191003B1B@SHSMSX101.ccr.corp.intel.com>
 <0b579768-3090-dd50-58b1-3385be92ef21@arm.com>
In-Reply-To: <0b579768-3090-dd50-58b1-3385be92ef21@arm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> From: Jean-Philippe Brucker [mailto:jean-philippe.brucker@arm.com]
> Sent: Thursday, February 15, 2018 8:42 PM
> 
> On 13/02/18 23:43, Tian, Kevin wrote:
> >> From: Jean-Philippe Brucker
> >> Sent: Tuesday, February 13, 2018 8:40 PM
> >>
> >>
> >> [...]
> >>>> +
> >>>> +/**
> >>>> + * iommu_sva_device_init() - Initialize Shared Virtual Addressing for
> a
> >>>> device
> >>>> + * @dev: the device
> >>>> + * @features: bitmask of features that need to be initialized
> >>>> + * @max_pasid: max PASID value supported by the device
> >>>> + *
> >>>> + * Users of the bind()/unbind() API must call this function to initialize
> all
> >>>> + * features required for SVA.
> >>>> + *
> >>>> + * - If the device should support multiple address spaces (e.g. PCI
> >> PASID),
> >>>> + *   IOMMU_SVA_FEAT_PASID must be requested.
> >>>
> >>> I think it is by default assumed when using this API, based on definition
> of
> >>> SVA. Can you elaborate the situation where this flag can be cleared?
> >>
> >> When passing a device to userspace, you could also share its non-pasid
> >> address space with the process. It requires a new domain type so is left
> >> as a TODO in patch 2/37. I did get requests for this feature, though I
> >> think it was mostly for prototyping. I guess I could remove the flag, and
> >> reintroduce it as IOMMU_SVA_FEAT_NO_PASID later on.
> >
> > sorry I still didn't get the definition of non-pasid address space.
> > Did you mean the GPA/IOVA address space and no_pasid implies
> > actually some default PASID associated?
> 
> Yes I mean merging the process address space and IOVA space. There are
> no
> PASIDs involved if the device or the IOMMU doesn't support it. Instead of
> private DMA page tables you program the mm pgd into the IOMMU. A VFIO
> userspace driver, instead of sending MAP/UNMAP ioctl, could simply issue
> a
> BIND.

got it. yes it's better to remove it for now which can avoid
unnecessary confusion. :-)

> 
> Technically nothing prevents it, but now the resv problem discussed on
> patch 2/37 stands out. For example on x86 you'd probably need to carve
> the
> IOAPIC MSI range out of the process address space. On Arm you'd need to
> create a write-only mapping for MSIs (IOMMU translates it to the IRQ chip
> address, but thankfully accessing the doorbell from CPU side doesn't
> trigger an MSI.)

so if overlap already exists when binding a process address space
(since binding may happen much later than creating the process),
I assume the call will simply fail since carve out at this point is not
possible?

> 
> >> [...]
> >>>> +	ret = domain->ops->sva_device_init(dev, features, &min_pasid,
> >>>> +					   &max_pasid);
> >>>> +	if (ret)
> >>>> +		return ret;
> >>>> +
> >>>> +	/* FIXME: racy. Next version should have a mutex (same as fault
> >>>> handler) */
> >>>> +	dev_param->sva_features = features;
> >>>> +	dev_param->min_pasid = min_pasid;
> >>>> +	dev_param->max_pasid = max_pasid;
> >>>
> >>> what's the point of min_pasid here?
> >>
> >> Arm SMMUv3 uses entry 0 of the PASID table for the default (non-pasid)
> >> context, so it needs to set min_pasid to 1. AMD IOMMU recently added
> a
> >> similar feature (GIoSup), if I understood correctly.
> >>
> >
> > just for such purpose maybe we should just define a reserved_pasid
> > otherwise there will be some waste if an implementation allows it
> > non-zero.
> 
> What's wasted? It's slightly simpler to use min_pasid because we just pass
> that limit to idr_alloc(). With a reserved_pasid we'll have to call
> idr_alloc(reserved_pasid) once, for the same result.
> 

I'm thinking about the case where an implementation allows
software to define a random reserved_pasid, then banning
all pasids below reserved one could be a waste. But after
more thinking it is not a big problem. We can request such
driver to use 0 as reserved_pasid then same situation as
ARM side.

Thanks
Kevin
