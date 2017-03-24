Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V9 00/11] IOMMU probe deferral support
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        Sricharan R <sricharan@codeaurora.org>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "tn@semihalf.com" <tn@semihalf.com>,
        "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
        "okaya@codeaurora.org" <okaya@codeaurora.org>
References: <1489086061-9356-1-git-send-email-sricharan@codeaurora.org>
 <58D49845.9060407@hisilicon.com>
 <0ea8022b-a19b-335d-6cc6-81510196f891@codeaurora.org>
 <5FC3163CFD30C246ABAA99954A238FA81750B7CB@lhreml504-mbs>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <db3d68f8-713c-9ae2-7df9-324bc1b375b1@arm.com>
Date: Fri, 24 Mar 2017 18:38:39 +0000
MIME-Version: 1.0
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA81750B7CB@lhreml504-mbs>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 24/03/17 09:27, Shameerali Kolothum Thodi wrote:
> Hi Sricharan,
> 
>> -----Original Message-----
>> From: Sricharan R [mailto:sricharan@codeaurora.org]
>> Sent: Friday, March 24, 2017 7:10 AM
>> To: Wangzhou (B); robin.murphy@arm.com; will.deacon@arm.com;
>> joro@8bytes.org; lorenzo.pieralisi@arm.com; iommu@lists.linux-
>> foundation.org; linux-arm-kernel@lists.infradead.org; linux-arm-
>> msm@vger.kernel.org; m.szyprowski@samsung.com;
>> bhelgaas@google.com; linux-pci@vger.kernel.org; linux-
>> acpi@vger.kernel.org; tn@semihalf.com; hanjun.guo@linaro.org;
>> okaya@codeaurora.org
>> Cc: Shameerali Kolothum Thodi
>> Subject: Re: [PATCH V9 00/11] IOMMU probe deferral support
>>
>> Hi Zhou,
>>
>> On 3/24/2017 9:23 AM, Zhou Wang wrote:
>>> On 2017/3/10 3:00, Sricharan R wrote:
>>>> This series calls the dma ops configuration for the devices at a
>>>> generic place so that it works for all busses.
>>>> The dma_configure_ops for a device is now called during the
>>>> device_attach callback just before the probe of the bus/driver is
>>>> called. Similarly dma_deconfigure is called during
>>>> device/driver_detach path.
>>>>
>>>> pci_bus_add_devices    (platform/amba)(_device_create/driver_register)
>>>>        |                         |
>>>> pci_bus_add_device     (device_add/driver_register)
>>>>        |                         |
>>>> device_attach           device_initial_probe
>>>>        |                         |
>>>> __device_attach_driver    __device_attach_driver
>>>>        |
>>>> driver_probe_device
>>>>        |
>>>> really_probe
>>>>        |
>>>> dma_configure
>>>>
>>>> Similarly on the device/driver_unregister path
>>>> __device_release_driver is called which inturn calls dma_deconfigure.
>>>>
>>>> Rebased the series against mainline 4.11-rc1. Applies and builds
>>>> cleanly against mainline and linux-next. There is a conflict with
>>>> patch#9 against iommu-next, but that should go away eventually as
>>>> iommu-next is rebased against 4.11-rc1.
>>>>
>>>> * Tested with platform and pci devices for probe deferral
>>>>   and reprobe on arm64 based platform.
>>>
>>> Hi Sricharan,
>>>
>>> I applied this series on v4.11-rc1 to test PCIe pass through in
>>> HiSilicon
>>> D05 board(with Intel 82599 networking card). It failed.
>>>
>>> After I used:
>>>
>>> echo vfio-pci > /sys/bus/pci/devices/0002:81:10.0/driver_override
>>> echo 0002:81:10.0 > /sys/bus/pci/drivers/ixgbevf/unbind
>>> echo 0002:81:10.0 > /sys/bus/pci/drivers_probe
>>>
>>> to bind vfio-pci driver to Intel 82599 networking card VF.
>>>
>>> I got log in host:
>>> [...]
>>> [  414.275818] ixgbevf: Intel(R) 10 Gigabit PCI Express Virtual
>>> Function Network Driver - version 3.2.2-k [  414.275824] ixgbevf: Copyright
>> (c) 2009 - 2015 Intel Corporation.
>>> [  414.276647] ixgbe 0002:81:00.0 eth12: SR-IOV enabled with 1 VFs [
>>> 414.342252] pcieport 0002:80:00.0: can't derive routing for PCI INT A
>>> [  414.342255] ixgbe 0002:81:00.0: PCI INT A: no GSI [  414.343348]
>>> ixgbe 0002:81:00.0: Multiqueue Enabled: Rx Queue count = 4, Tx Queue
>>> count = 4 [  414.448135] pci 0002:81:10.0: [8086:10ed] type 00 class
>>> 0x020000 [  414.448713] iommu: Adding device 0002:81:10.0 to group 4 [
>>> 414.449798] ixgbevf 0002:81:10.0: enabling device (0000 -> 0002) [
>>> 414.451101] ixgbevf 0002:81:10.0: PF still in reset state.  Is the PF interface
>> up?
>>> [  414.451103] ixgbevf 0002:81:10.0: Assigning random MAC address [
>>> 414.451414] ixgbevf 0002:81:10.0: be:30:8f:ed:f8:02 [  414.451417]
>>> ixgbevf 0002:81:10.0: MAC: 1 [  414.451418] ixgbevf 0002:81:10.0:
>>> Intel(R) 82599 Virtual Function [  414.464271] VFIO - User Level
>>> meta-driver version: 0.3 [  414.570074] ixgbe 0002:81:00.0: registered
>>> PHC device on eth12
>>> [  414.700493] specified DMA range outside IOMMU capability
>> <-- error here
>>> [  414.700496] Failed to set up IOMMU for device 0002:81:10.0; retaining
>> platform DMA ops        <-- error here
>>
>> Looks like this triggers the start of the bug.
>> So the below check in iommu_dma_init_domain fails,
>>
>>          if (domain->geometry.force_aperture) {
>>                  if (base > domain->geometry.aperture_end ||
>>                      base + size <= domain->geometry.aperture_start) {
>>
>> and the rest goes out of sync after that. Can you print out the base,
>> aperture_start and end values to see why the check fails ?
> 
> dev_info(dev, "0x%llx 0x%llx, 0x%llx 0x%llx, 0x%llx 0x%llx\n", base, size, domain->geometry.aperture_start, domain->geometry.aperture_end, *dev->dma_mask, dev->coherent_dma_mask);
> 
> [  183.752100] ixgbevf 0000:81:10.0: 0x0 0x100000000, 0x0 0xffffffffffff, 0xffffffff 0xffffffff
> .....
> [  319.508037] vfio-pci 0000:81:10.0: 0x0 0x0, 0x0 0xffffffffffff, 0xffffffffffffffff 0xffffffffffffffff
> 
> Yes, size seems to be the problem here. When the VF  device gets attached to vfio-pci,
> somehow the dev->coherent_dma_mask is set to 64 bits and size become zero.

AFAICS, this is either down to patch 3 (which should apply on its own
easily enough for testing), or patch 6, implying that somehow the
vfio-pci device gets its DMA mask widened to 64 bits somewhere between
very soon after after creation (where we originally called
of_dma_configure()) and immediately before probe (where we now call it).

Either way I guess this is yet more motivation to write that "change the
arch_setup_dma_ops() interface to take a mask instead of a size" patch...

> @@ -107,7 +107,7 @@ int of_dma_configure(struct device *dev, struct device_node *np)
>   	ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
>   	if (ret < 0) {
>   		dma_addr = offset = 0;
>  -		size = dev->coherent_dma_mask + 1;
>  +		size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
> 
> @@ -1386,7 +1387,8 @@ int acpi_dma_configure(struct device *dev, enum dev_dma_attr attr)
>   	 * Assume dma valid range starts at 0 and covers the whole
>   	 * coherent_dma_mask.
>   	 */
>  -	arch_setup_dma_ops(dev, 0, dev->coherent_dma_mask + 1, iommu,
>  +	size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
>  +	arch_setup_dma_ops(dev, 0, size, iommu,
>   			   attr == DEV_DMA_COHERENT);
> 
> With the above fixes, DT boot works fine. But we still get the below crash on ACPI
> 
>>> [  402.581445] kernel BUG at drivers/iommu/arm-smmu-v3.c:1064!
>>> [  402.587007] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
>>> [  402.592479] Modules linked in: vfio_iommu_type1 vfio_pci irqbypass
>> vfio_virqfd vfio ixgbevf ixgb

I can't see how ACPI vs. DT would make any difference to the domain
attach/detach mechanics getting into an invalid state (if the DT case
works then unbinding the ixgbevf driver clearly does release the Stream
ID correctly in general), so I'm more inclined to believe that something
goes wrong with the fwspec in the ACPI path such that we end up touching
the wrong STE altogether.

Robin.

>> The change that this series does is trying to add the dma/iommu ops to the
>> device after the iommu is actually probed.
>> So in your working case, does the device initially gets hooked to iommu_ops
>> and the above same check passes in working case ?
> 
> I believe so. Because didn't notice the "specified DMA range outside IOMMU capability"
> in the working case.
>  
> Thanks,
> Shameer
> 

