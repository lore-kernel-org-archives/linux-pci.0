Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
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
        "mykyta.iziumtsev@linaro.org" <mykyta.iziumtsev@linaro.org>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-3-jean-philippe.brucker@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191002897@SHSMSX101.ccr.corp.intel.com>
 <b9eacb30-817f-9027-bc0a-1f01cf9f13f9@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191003AD6@SHSMSX101.ccr.corp.intel.com>
Message-ID: <ca4d4992-0c8b-dae6-e443-7c7f7164be60@arm.com>
Date: Thu, 15 Feb 2018 12:40:57 +0000
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D191003AD6@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 13/02/18 23:34, Tian, Kevin wrote:
>> From: Jean-Philippe Brucker
>> Sent: Tuesday, February 13, 2018 8:57 PM
>>
>> On 13/02/18 07:54, Tian, Kevin wrote:
>>>> From: Jean-Philippe Brucker
>>>> Sent: Tuesday, February 13, 2018 2:33 AM
>>>>
>>>> Add bind() and unbind() operations to the IOMMU API. Device drivers
>> can
>>>> use them to share process page tables with their devices. bind_group()
>>>> is provided for VFIO's convenience, as it needs to provide a coherent
>>>> interface on containers. Other device drivers will most likely want to
>>>> use bind_device(), which binds a single device in the group.
>>>
>>> I saw your bind_group implementation tries to bind the address space
>>> for all devices within a group, which IMO has some problem. Based on
>> PCIe
>>> spec, packet routing on the bus doesn't take PASID into consideration.
>>> since devices within same group cannot be isolated based on requestor-
>> ID
>>> i.e. traffic not guaranteed going to IOMMU, enabling SVA on multiple
>> devices
>>> could cause undesired p2p.
>> But so does enabling "classic" DMA... If two devices are not protected by
>> ACS for example, they are put in the same IOMMU group, and one device
>> might be able to snoop the other's DMA. VFIO allows userspace to create a
>> container for them and use MAP/UNMAP, but makes it explicit to the user
>> that for DMA, these devices are not isolated and must be considered as a
>> single device (you can't pass them to different VMs or put them in
>> different containers). So I tried to keep the same idea as MAP/UNMAP for
>> SVA, performing BIND/UNBIND operations on the VFIO container instead of
>> the device.
> 
> there is a small difference. for classic DMA we can reserve PCI BARs 
> when allocating IOVA, thus multiple devices in the same group can 
> still work correctly applied with same translation, if isolation is not
> cared in between. However for SVA it's CPU virtual addresses 
> managed by kernel mm thus difficult to introduce similar address 
> reservation. Then it's possible for a VA falling into other device's 
> BAR in the same group and cause undesired p2p traffic. In such 
> regard, SVA is actually functionally-broken.

I think the problem exists even if there is a single device in the group.
If for example, malloc() returns a VA that corresponds to a PCI host
bridge in IOVA space, performing DMA on that buffer won't reach the IOMMU
and will cause undesirable side-effects.

My series doesn't address the problem, but I believe we should carve
reserved regions out of the process address space during bind(), for
example by creating a PROT_NONE vma preventing userspace from obtaining
that VA.

If you solve this problem, you also solve it for multiple devices in a
group, because the IOMMU core provides the resv API on groups... That's
until you hotplug a device into a live group (currently WARN in VFIO),
with different resv regions.

>> I kept the analogy simple though, because I don't think there will be many
>> SVA-capable systems that require IOMMU groups. They will likely
> 
> I agree that multiple SVA-capable devices in same IOMMU group is not
> a typical configuration, especially it's usually observed on new devices.
> Then based on above limitation, I think we could just explicitly avoid
> enabling SVA in such case. :-)

I'd certainly like that :)

Thanks,
Jean
