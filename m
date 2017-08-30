Return-Path: <SRS0=xbkj=AA=huawei.com=liudongdong3@kernel.org>
Return-Path: <SRS0=xbkj=AA=huawei.com=liudongdong3@kernel.org>
Subject: Re: [PATCH] PCI/portdrv: Fix MSI/MSI-X bug for PCIe port service
 drivers
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1503654642-59977-1-git-send-email-liudongdong3@huawei.com>
 <20170829201631.GO8154@bhelgaas-glaptop.roam.corp.google.com>
CC: <linux-pci@vger.kernel.org>, <gabriele.paoloni@huawei.com>,
        <charles.chenxin@huawei.com>, <linuxarm@huawei.com>
From: Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <014021d0-51e1-1169-e4b5-2a347ca12598@huawei.com>
Date: Wed, 30 Aug 2017 18:35:37 +0800
MIME-Version: 1.0
In-Reply-To: <20170829201631.GO8154@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn

Many thanks for your review.

e( 2017/8/30 4:16, Bjorn Helgaas ei:
> On Fri, Aug 25, 2017 at 05:50:42PM +0800, Dongdong Liu wrote:
>> Current code is broken as calling pci_free_irq_vectors()
>> invalidates the IRQ numbers returned before by pci_irq_vectors();
>> so we need to move all the assignment of the Linux IRQ numbers at
>> the bottom of the function.
>>
>> After removing and adding back the PCI root port device,
>> we see the PCIe port service drivers request irq failed.
>>
>> root@(none)$ lspci -tv
>> -[0000:00]-+-00.0-[01]----00.0  Device 19e5:0123
>>            \-08.0-[02-03]--+-00.0  Device 8086:10fb
>>                            \-00.1  Device 8086:10fb
>
> It doesn't look like the hierarchy *below* the root port is relevant.
OK, will delete.
>
>> root@(none)$ echo 1 > /sys/devices/pci0000\:00/0000\:00\:00.0/remove
>> iommu: Removing device 0000:00:00.0 from group 2
>> root@(none)$ echo 1 > /sys/devices/pci0000\:00/pci_bus/0000\:00/rescan
>> pci 0000:01:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it
>> with 'pcie_aspm=force'
>> pci 0000:00:00.0: BAR 14: assigned [mem 0xe0100000-0xe03fffff]
>> pci 0000:00:00.0: BAR 15: assigned [mem 0x80000e00000-0x80000ffffff 64bit
>> pref]
>> pci 0000:00:00.0: BAR 13: assigned [io  0x1000-0x1fff]
>> pci 0000:01:00.0: BAR 0: assigned [mem 0xe0100000-0xe013ffff 64bit]
>> pci 0000:01:00.0: BAR 6: assigned [mem 0xe0140000-0xe015ffff pref]
>> pci 0000:00:00.0: PCI bridge to [bus 01]
>> pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
>> pci 0000:00:00.0:   bridge window [mem 0xe0100000-0xe03fffff]
>> pci 0000:00:00.0:   bridge window [mem 0x80000e00000-0x80000ffffff 64bit
>> pref]
>> iommu: Adding device 0000:00:00.0 to group 2
>> pcie_pme: probe of 0000:00:00.0:pcie001 failed with error -22
>> aer: probe of 0000:00:00.0:pcie002 failed with error -22
>> pciehp 0000:00:00.0:pcie004: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd-
>> PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
>> pciehp 0000:00:00.0:pcie004: Cannot get irq 20 for the hotplug controller
>> pciehp 0000:00:00.0:pcie004: Notification initialization failed (-1)
>> dpc 0000:00:00.0:pcie010: request IRQ22 failed: -22
>> dpc: probe of 0000:00:00.0:pcie010 failed with error -22
>
> I think the ASPM, iommu, BAR, and window message are irrelevant to this issue.
> If so, please remove them so they aren't distractions.
OK, I will remove them in PATCH V2.
>
> This looks like it might be a fix for a regression.  Can you add any
> relevant Fixes: tags and possibly stable tags?

Sure, I will add in PATCH V2.
Fixes: 3674cc4 ("PCI/portdrv: Use pci_irq_alloc_vectors()")

Thanks
Dongdong
