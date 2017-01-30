Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V7 08/11] drivers: acpi: Handle IOMMU lookup failure with
 deferred probing or error
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1485188293-20263-9-git-send-email-sricharan@codeaurora.org>
 <20170124123711.GA11996@red-moon>
 <f2370671-ece8-fbee-de19-350dd625088f@codeaurora.org>
 <93e79759-d614-9b36-d5ab-63e8eb725009@arm.com>
 <14751205-f034-7f0d-442a-854c3909425c@codeaurora.org>
 <5ba9f366d6e25397cdef8ad95b49e199@codeaurora.org>
 <175a3798-b824-ef1a-e112-9f6f472973ae@codeaurora.org>
 <20170130143851.GJ16461@arm.com>
 <b2e50c17de156341deab9fb8e91a8dec@codeaurora.org>
 <1e048aff-0d77-b9f2-ebf8-2ba315b90ca7@codeaurora.org>
 <20170130165124.GA11712@red-moon>
Cc: Nate Watterson <nwatters@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Sricharan R <sricharan@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, Tomasz Nowicki <tn@semihalf.com>,
        linux-arm-kernel@lists.infradead.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <f401e27e-d619-0eec-2401-50d8e2fc2f0f@codeaurora.org>
Date: Mon, 30 Jan 2017 15:03:06 -0500
MIME-Version: 1.0
In-Reply-To: <20170130165124.GA11712@red-moon>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 1/30/2017 11:51 AM, Lorenzo Pieralisi wrote:
> On Mon, Jan 30, 2017 at 10:46:39AM -0500, Sinan Kaya wrote:
>> On 1/30/2017 9:54 AM, Nate Watterson wrote:
>>> On 2017-01-30 09:38, Will Deacon wrote:
>>>> On Mon, Jan 30, 2017 at 09:33:50AM -0500, Sinan Kaya wrote:
>>>>> On 1/30/2017 9:23 AM, Nate Watterson wrote:
>>>>>> On 2017-01-30 08:59, Sinan Kaya wrote:
>>>>>>> On 1/30/2017 7:22 AM, Robin Murphy wrote:
>>>>>>>> On 29/01/17 17:53, Sinan Kaya wrote:
>>>>>>>>> On 1/24/2017 7:37 AM, Lorenzo Pieralisi wrote:
>>>>>>>>>> [+hanjun, tomasz, sinan]
>>>>>>>>>>
>>>>>>>>>> It is quite a key patchset, I would be glad if they can test on their
>>>>>>>>>> respective platforms with IORT.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Tested on top of 4.10-rc5.
>>>>>>>>>
>>>>>>>>> 1.    Platform Hidma device passed dmatest
>>>>>>>>> 2.    Seeing some USB stalls on a platform USB device.
>>>>>>>>> 3.    PCIe NVME drive probed and worked fine with MSI interrupts after boot.
>>>>>>>>> 4.     NVMe driver didn't probe following a hotplug insertion and received an
>>>>>>>>> SMMU error event during the insertion.
>>>>>>>>
>>>>>>>> What was the SMMU error - a translation/permission fault (implying the
>>>>>>>> wrong DMA ops) or a bad STE fault (implying we totally failed to tell
>>>>>>>> the SMMU about the device at all)?
>>>>>>>>
>>>>>>>
>>>>>>> root@ubuntu:/sys/bus/pci/slots/4# echo 0 > power
>>>>>>>
>>>>>>> [__204.698522]_iommu:_Removing_device_0003:01:00.0_from_group_0
>>>>>>> [  204.708704] pciehp 0003:00:00.0:pcie004: Slot(4): Link Down
>>>>>>> [  204.708723] pciehp 0003:00:00.0:pcie004: Slot(4): Link Down event
>>>>>>> ignored; already powering off
>>>>>>>
>>>>>>> root@ubuntu:/sys/bus/pci/slots/4#
>>>>>>>
>>>>>>> [__254.820440]_iommu:_Adding_device_0003:01:00.0_to_group_8
>>>>>>> [  254.820599] nvme nvme0: pci function 0003:01:00.0
>>>>>>> [  254.820621] nvme 0003:01:00.0: enabling device (0000 -> 0002)
>>>>>>> [  261.948558] arm-smmu-v3 arm-smmu-v3.0.auto: event 0x0a received:
>>>>>>> [  261.948561] arm-smmu-v3 arm-smmu-v3.0.auto:  0x000001000000000a
>>>>>>> [  261.948563] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000000000000
>>>>>>> [  261.948564] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000000000000
>>>>>>> [  261.948566] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000000000000
>>>>>
>>>>>> Looks like C_BAD_CD. Can you please try with:
>>>>>> iommu/arm-smmu-v3: Clear prior settings when updating STEs
>>>>>
>>>>> This resolved the issue. Can we pull Nate's patch to 4.10 so that I don't see
>>>>> this issue again.
>>>>
>>>> I already sent the pull request to Joerg for 4.11. Do you see this problem
>>>> without Sricharan's patches (i.e. vanilla mainline)? If so, we'll need to
>>>> send the patch to stable after -rc1.
>>> Using vanilla mainline, I see it most commonly when directly assigning
>>> a device to a guest machine. I think I've also seen it after removing then
>>> re-adding a PCI device. Basically anytime an STE's CTX pointer is changed
>>> from a non-NULL value and STE[CFG] indicates translation will be performed.
>>>
>>
>> I was not able to reproduce the issue with Vanilla kernel. I only
>> tested hotplug.
> 
> I would like to get the complete code path leading to this issue, it is
> not clear to me why the probe deferral code triggers it and why we are
> not able to trigger it with vanilla mainline, we must understand that first
> before applying any fix to this series.
> 
> I do not have a platform to reproduce this issue I will send you a patch
> to trace what's going on here please help us debug it.

Sure, send it to both Nate and me.

> 
> Thanks,
> Lorenzo
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
