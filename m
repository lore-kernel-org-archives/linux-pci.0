Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH 02/37] iommu/sva: Bind process address spaces to devices
To: "Tian, Kevin" <kevin.tian@intel.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
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
        "xieyisheng1@huawei.com" <xieyisheng1@huawei.com>,
        "xuzaibo@huawei.com" <xuzaibo@huawei.com>,
        "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
        "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "shunyong.yang@hxt-semitech.com" <shunyong.yang@hxt-semitech.com>,
        "nwatters@codeaurora.org" <nwatters@codeaurora.org>,
        "okaya@codeaurora.org" <okaya@codeaurora.org>,
        "jcrouse@codeaurora.org" <jcrouse@codeaurora.org>,
        "rfranz@cavium.com" <rfranz@cavium.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "robdclark@gmail.com" <robdclark@gmail.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "bharatku@xilinx.com" <bharatku@xilinx.com>,
        mykyta.iziumtsev@linaro.org
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-3-jean-philippe.brucker@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191002897@SHSMSX101.ccr.corp.intel.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <b9eacb30-817f-9027-bc0a-1f01cf9f13f9@arm.com>
Date: Tue, 13 Feb 2018 12:57:23 +0000
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D191002897@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 13/02/18 07:54, Tian, Kevin wrote:
>> From: Jean-Philippe Brucker
>> Sent: Tuesday, February 13, 2018 2:33 AM
>>
>> Add bind() and unbind() operations to the IOMMU API. Device drivers can
>> use them to share process page tables with their devices. bind_group()
>> is provided for VFIO's convenience, as it needs to provide a coherent
>> interface on containers. Other device drivers will most likely want to
>> use bind_device(), which binds a single device in the group.
> 
> I saw your bind_group implementation tries to bind the address space
> for all devices within a group, which IMO has some problem. Based on PCIe
> spec, packet routing on the bus doesn't take PASID into consideration. 
> since devices within same group cannot be isolated based on requestor-ID
> i.e. traffic not guaranteed going to IOMMU, enabling SVA on multiple devices
> could cause undesired p2p.
But so does enabling "classic" DMA... If two devices are not protected by
ACS for example, they are put in the same IOMMU group, and one device
might be able to snoop the other's DMA. VFIO allows userspace to create a
container for them and use MAP/UNMAP, but makes it explicit to the user
that for DMA, these devices are not isolated and must be considered as a
single device (you can't pass them to different VMs or put them in
different containers). So I tried to keep the same idea as MAP/UNMAP for
SVA, performing BIND/UNBIND operations on the VFIO container instead of
the device.

I kept the analogy simple though, because I don't think there will be many
SVA-capable systems that require IOMMU groups. They will likely implement
proper device isolation. Unlike iommu_attach_device(), bind_device()
doesn't call bind_group(), because keeping bonds consistent in groups is
complicated, not worth implementing (drivers can explicitly bind() all
devices that need it) and probably wouldn't ever be used. I also can't
test it. But maybe we could implement the following for now:

* bind_device() fails if the device's group has more than one device,
otherwise calls __bind_device(). This prevents device drivers that are
oblivious to IOMMU groups from opening a backdoor.

* bind_group() calls __bind_device() for all devices in group. This way
users that are aware of IOMMU groups can still use them safely. Note that
at the moment bind_group() fails as soon as it finds a device that doesn't
support SVA. Having all devices support SVA in a given group is
unrealistic and this behavior ought to be improved.

* hotplugging a device into a group still succeeds even if the group
already has mm bonds. Same happens for classic DMA, a hotplugged device
will have access to all mappings already present in the domain.

> If my understanding of PCIe spec is correct, probably we should fail 
> calling bind_group()/bind_device() when there are multiple devices within 
> the given group. If only one device then bind_group is essentially a wrapper
> to bind_device.>>
>> Regardless of the IOMMU group or domain a device is in, device drivers
>> should call bind() for each device that will use the PASID.
>>
[...]
>> +/**
>> + * iommu_sva_bind_device() - Bind a process address space to a device
>> + * @dev: the device
>> + * @mm: the mm to bind, caller must hold a reference to it
>> + * @pasid: valid address where the PASID will be stored
>> + * @flags: bond properties (IOMMU_SVA_FEAT_*)
>> + * @drvdata: private data passed to the mm exit handler
>> + *
>> + * Create a bond between device and task, allowing the device to access
>> the mm
>> + * using the returned PASID. A subsequent bind() for the same device and
>> mm will
>> + * reuse the bond (and return the same PASID), but users will have to call
>> + * unbind() twice.
> 
> what's the point of requiring unbind twice?

Mmh, that was necessary when we kept bond information as domain<->mm, but
since it's now device<->mm, we can probably remove the bond refcount. I
consider that a bind() between a given device and mm will always be issued
by the same driver.

Thanks,
Jean
