Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [RFCv2 PATCH 00/36] Process management for IOMMU + SVM for SMMUv3
To: Yisheng Xie <xieyisheng1@huawei.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc: "joro@8bytes.org" <joro@8bytes.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        Robin Murphy <Robin.Murphy@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "tn@semihalf.com" <tn@semihalf.com>,
        "liubo95@huawei.com" <liubo95@huawei.com>,
        "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
        "gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>,
        "nwatters@codeaurora.org" <nwatters@codeaurora.org>,
        "okaya@codeaurora.org" <okaya@codeaurora.org>,
        "rfranz@cavium.com" <rfranz@cavium.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "robdclark@gmail.com" <robdclark@gmail.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <0c6778d8-741f-0db7-fe3c-df88a75ebbb2@huawei.com>
 <0fecd29e-eaf7-9503-b087-7bfbc251da88@arm.com>
 <c6b7fb4b-4f2b-0d81-8bb5-8fa6b62aca3a@huawei.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <8a1e090d-22e8-0295-a53f-bc3b5b7d7971@arm.com>
Date: Thu, 12 Oct 2017 13:55:32 +0100
MIME-Version: 1.0
In-Reply-To: <c6b7fb4b-4f2b-0d81-8bb5-8fa6b62aca3a@huawei.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/10/17 13:05, Yisheng Xie wrote:
[...]
>>>> * An iommu_process can be bound to multiple domains, and a domain can have
>>>>   multiple iommu_process.
>>> when bind a task to device, can we create a single domain for it? I am thinking
>>> about process management without shared PT(for some device only support PASID
>>> without pri ability), it seems hard to expand if a domain have multiple iommu_process?
>>> Do you have any idea about this?
>>
>> A device always has to be in a domain, as far as I know. Not supporting
>> PRI forces you to pin down all user mappings (or just the ones you use for
>> DMA) but you should sill be able to share PT. Now if you don't support
>> shared PT either, but only PASID, then you'll have to use io-pgtable and a
>> new map/unmap API on an iommu_process. I don't understand your concern
>> though, how would the link between process and domains prevent this use-case?
>>
> So you mean that if an iommu_process bind to multiple devices it should create
> multiple io-pgtables? or just share the same io-pgtable?

I don't know to be honest, I haven't thought much about the io-pgtable
case, I'm all about sharing the mm :)

It really depends on what the user (GPU driver I assume) wants. I think
that if you're not sharing an mm with the device, then you're trying to
hide parts of the process to the device, so you'd also want the
flexibility of having different io-pgtables between devices. Different
devices accessing isolated parts of the process requires separate io-pgtables.

>>>> * IOMMU groups share same PASID table. IOMMU groups are a convenient way
>>>>   to cover various hardware weaknesses that prevent a group of device to
>>>>   be isolated by the IOMMU (untrusted bridge, for instance). It's foolish
>>>>   to assume that all PASID implementations will perfectly isolate devices
>>>>   within a bus and functions within a device, so let's assume all devices
>>>>   within an IOMMU group have to share PASID traffic as well. In general
>>>>   there will be a single device per group.
>>>>
>>>> * It's up to the driver implementation to decide where to implement the
>>>>   PASID tables. For SMMU it's more convenient to have a single PASID table
>>>>   per domain. And I think the model fits better with the existing IOMMU
>>>>   API: IOVA traffic is shared by all devices in a domain, so should PASID
>>>>   traffic.
>>> What's the meaning of "share PASID traffic"? PASID space is system-wide,
>>> and a domain can have multiple iommu_process , so a domain can have multiple
>>> PASIDs , one PASID for a iommu_process, right?
> I get what your mean now, thanks for your explain.
> 
>>
>> Yes, I meant that if a device can access mappings for a specific PASID,
>> then other devices in that same domain are also able to access them.
>>
>> A few reasons for this choice in the SMMU:
>> * As all devices in an IOMMU group will be in the same domain and share
>> the same PASID traffic, it encompasses that case. Groups are the smallest
>> isolation granularity, then users are free to choose to put different
>> IOMMU groups in different domains.
>> * For architectures that can have both non-PASID and PASID traffic
>> simultaneously, like the SMMU, it is simpler to reason about PASID tables
>> being a domain, rather than sharing PASID0 within the domain and handling
>> all others per device.
>> * It's the same principle as non-PASID mappings (iommu_map/unmap is on a
>> domain).
>> * It implement the classic example of IOMMU architectures where multiple
>> device descriptors point to the same PASID tables.
>> * It may be desirable for drivers to share PASIDs within a domain, if they
>> are actually using domains for conveniently sharing address spaces between
>> devices. I'm not sure how much this is used as a feature. It does model a
>> shared bus where each device can snoop DMA, so it may be useful.
>>
> 
> I get another question about this design, thinking about the following case:
> 
> If a platform device with PASID ability, e.g. accelerator, which have multiple
> accelerator process units(APUs), it may create multiple virtual devices, one
> virtual device represent for an APU, with the same sid.
> 
> They can be in different groups, however must be in the same domain as this
> design, for domain held the PASID table, right? So how could they be used by
> different guest OS?

If they have the same SID, they will be in the same group as there will be
a single entry in the SMMU stream table. Otherwise, if the virtual devices
can be properly isolated from each other (in the same way as PCI SR-IOV),
they will each have their own SID, can each be in a different IOMMU group
and can be assigned to different guests.

Thanks,
Jean
