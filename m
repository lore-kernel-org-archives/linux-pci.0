Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH v2 01/40] iommu: Introduce Shared Virtual Addressing API
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Auger Eric <eric.auger@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-mm@kvack.org
Cc: xieyisheng1@huawei.com, liubo95@huawei.com, xuzaibo@huawei.com,
        thunder.leizhen@huawei.com, will.deacon@arm.com,
        okaya@codeaurora.org, yi.l.liu@intel.com, ashok.raj@intel.com,
        tn@semihalf.com, joro@8bytes.org, bharatku@xilinx.com,
        liudongdong3@huawei.com, rfranz@cavium.com, kevin.tian@intel.com,
        jacob.jun.pan@linux.intel.com, jcrouse@codeaurora.org,
        rgummal@xilinx.com, jonathan.cameron@huawei.com,
        shunyong.yang@hxt-semitech.com, robin.murphy@arm.com,
        ilias.apalodimas@linaro.org, alex.williamson@redhat.com,
        robdclark@gmail.com, dwmw2@infradead.org, nwatters@codeaurora.org,
        baolu.lu@linux.intel.com
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
 <20180511190641.23008-2-jean-philippe.brucker@arm.com>
 <bf42affd-e9d0-e4fc-6d28-f3c3f7795348@redhat.com>
 <03d31ba5-1eda-ea86-8c0c-91d14c86fe83@arm.com>
 <ed39159c-087e-7e56-7d29-d1de9fa1677f@amd.com>
 <f0b317d5-e2e9-5478-952c-05e8b97bd68b@arm.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <2fd4a0a1-1a35-bf82-df84-b995cce011d9@amd.com>
Date: Fri, 7 Sep 2018 10:55:31 +0200
MIME-Version: 1.0
In-Reply-To: <f0b317d5-e2e9-5478-952c-05e8b97bd68b@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am 06.09.2018 um 14:45 schrieb Jean-Philippe Brucker:
> On 06/09/2018 12:12, Christian König wrote:
>> Am 06.09.2018 um 13:09 schrieb Jean-Philippe Brucker:
>>> Hi Eric,
>>>
>>> Thanks for reviewing
>>>
>>> On 05/09/2018 12:29, Auger Eric wrote:
>>>>> +int iommu_sva_device_init(struct device *dev, unsigned long features,
>>>>> +              unsigned int max_pasid)
>>>> what about min_pasid?
>>> No one asked for it... The max_pasid parameter is here for drivers that
>>> have vendor-specific PASID size limits, such as AMD KFD (see
>>> kfd_iommu_device_init and
>>> https://patchwork.kernel.org/patch/9989307/#21389571). But in most cases
>>> the PASID size will only depend on the PCI PASID capability and the
>>> IOMMU limits, both known by the IOMMU driver, so device drivers won't
>>> have to set max_pasid.
>>>
>>> IOMMU drivers need to set min_pasid in the sva_device_init callback
>>> because it may be either 1 (e.g. Arm where PASID #0 is reserved) or 0
>>> (Intel Vt-d rev2), but at the moment I can't see a reason for device
>>> drivers to override min_pasid
>> Sorry to ruin your day, but if I'm not completely mistaken PASID zero is
>> reserved in the AMD KFD as well.
> Heh, fair enough. I'll add the min_pasid parameter

I will take this as an opportunity to summarize some of the requirements 
we have for PASID management from the amdgpu driver point of view:

1. We need to be able to allocate PASID between 1 and some maximum. Zero 
is reserved as far as I know, but we don't necessary need a minimum.

2. We need to be able to allocate PASIDs without a process address space 
backing it. E.g. our hardware uses PASIDs even without Shared Virtual 
Addressing enabled to distinct clients from each other.
         Would be a pity if we need to still have a separate PASID 
handling because the system wide is only available when IOMMU is turned on.

3. Even after destruction of a process address space we need some grace 
period before a PASID is reused because it can be that the specific 
PASID is still in some hardware queues etc...
         At bare minimum all device drivers using process binding need 
to explicitly note to the core when they are done with a PASID.

4. It would be nice to have to be able to set a "void *" for each 
PASID/device combination while binding to a process which then can be 
queried later on based on the PASID.
         E.g. when you have a per PASID/device structure around anyway, 
just add an extra field.

5. It would be nice to have to allocate multiple PASIDs for the same 
process address space.
         E.g. some teams at AMD want to use a separate GPU address space 
for their userspace client library. I'm still trying to avoid that, but 
it is perfectly possible that we are going to need that.
         Additional to that it is sometimes quite useful for debugging 
to isolate where exactly an incorrect access (segfault) is coming from.

Let me know if there are some problems with that, especially I want to 
know if there is pushback on #5 so that I can forward that :)

Thanks,
Christian.

>
> Thanks,
> Jean
