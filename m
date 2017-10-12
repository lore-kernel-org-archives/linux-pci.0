Return-Path: <SRS0=OSuf=BL=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=OSuf=BL=huawei.com=liudongdong3@kernel.org>
Subject: Re: [PATCH V4 1/2] PCI/portdrv: Fix MSI/MSI-X bug for PCIe port
 service drivers
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1507719178-112556-1-git-send-email-liudongdong3@huawei.com>
 <1507719178-112556-2-git-send-email-liudongdong3@huawei.com>
 <20171011113049.GD25517@bhelgaas-glaptop.roam.corp.google.com>
CC: <hch@lst.de>, <linux-pci@vger.kernel.org>, <stable@vger.kernel.org>,
        <gabriele.paoloni@huawei.com>, <charles.chenxin@huawei.com>,
        <linuxarm@huawei.com>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <ea6f7306-e4d3-9748-e3f4-f787aa700ec4@huawei.com>
Date: Thu, 12 Oct 2017 10:40:21 +0800
MIME-Version: 1.0
In-Reply-To: <20171011113049.GD25517@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>



在 2017/10/11 19:30, Bjorn Helgaas 写道:
> On Wed, Oct 11, 2017 at 06:52:57PM +0800, Dongdong Liu wrote:
>> After removing and adding back the PCI root port device,
>> we see the PCIe port service drivers request irq failed.
>> pcie_pme: probe of 0000:00:00.0:pcie001 failed with error -22
>> aer: probe of 0000:00:00.0:pcie002 failed with error -22
>> pciehp 0000:00:00.0:pcie004: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd-
>> PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
>> pciehp 0000:00:00.0:pcie004: Cannot get irq 20 for the hotplug controller
>> pciehp 0000:00:00.0:pcie004: Notification initialization failed (-1)
>> dpc 0000:00:00.0:pcie010: request IRQ22 failed: -22
>> dpc: probe of 0000:00:00.0:pcie010 failed with error -22
>>
>> The current code basically does this:
>>
>>   - allocate 32 vectors
>>   - figure out vector used by PME and hotplug
>>   - figure out vector used by AER
>>   - figure out vector used by DPC
>>   - free the 32 vectors we allocated
>>   - allocate only as many vectors as we need
>>
>> but it is broken as calling pci_free_irq_vectors()
>> invalidates the IRQ numbers returned before by pci_irq_vectors();
>>
>> The hardware works:
>>   - PME and hotplug use the Interrupt Message Number from the PCIe
>>     Capability register.
>>
>>   - AER uses the AER Interrupt Message Number from the AER Root Error
>>     Status register.
>>
>>   - DPC uses the DPC Interrupt Message Number from the DPC Capability
>>     register.
>>
>>   - FRS (not supported by Linux yet) uses the FRS Interrupt Message
>>     Number from the FRS Queuing Capability register.
>>
>>   - That's a total of 4 possible MSI/MSI-X vectors used for PME,
>>     hotplug, AER, DPC, and FRS, so there's no point in trying to
>>     allocate more than 4 vectors (we currently start with 32).
>
> You pointed out that there actually may be some benefit to allocating
> more than 4 vectors because the hardware may not distribute the
> Interrupt Message Numbers across the allocated vectors, e.g., you have
> a system with
>
>   HP/PME - message number 0
>   AER - message number 2
>   DPC - message number 6
>
> In that case, if we allocate 8 vectors, there's probably no sharing
> (other than HP/PME), but if we allocate 4 vectors, the hardware might
> put DPC on message number 0 or 2.

Yes, test on HiSilicon hip08 platform, the HW puts DPC on message number 2.

>
> Out of curiosity, what does happen on this system when we only
> allocate 4 vectors?  Does DPC end up sharing a vector with PME or AER?
> Or is it smart enough to put DPC on message number 1 or 3?

Test on HiSilicon hip08 platform, DPC shares a vector withs AER.

[  139.106191] pcieport 0000:00:08.0: PME entry 0
[  139.112511] pcieport 0000:00:08.0: AER entry 2
[  139.117890] pcieport 0000:00:08.0: DPC entry 2

  19:          1   ITS-MSI 131074 Edge      aerdrv, pcie-dpc

Thanks,
Dongdong
>
> Bjorn
>
> .
>
