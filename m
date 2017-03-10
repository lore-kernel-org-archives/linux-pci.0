Return-Path: <SRS0=YAYN=2T=gmail.com=zajec5@kernel.org>
Return-Path: <SRS0=YAYN=2T=gmail.com=zajec5@kernel.org>
Subject: Re: pcie-iproc: broken 2nd (& 3rd?) controller support by
 c3245a566400 ("PCI: iproc: Request host bridge window resources")
To: Bjorn Helgaas <helgaas@kernel.org>
References: <faab6b85-58e8-3e62-8763-56a94b13fba1@gmail.com>
 <f40bbf2f-3ba9-3992-d417-6588085f3d62@gmail.com>
 <20170309182205.GB3685@bhelgaas-glaptop.roam.corp.google.com>
 <04f747ef-0f39-33ec-0cea-2e9fb85d46e8@gmail.com>
 <20170310174740.GF19517@bhelgaas-glaptop.roam.corp.google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>,
 Oza Oza <oza.oza@broadcom.com>, JD Zheng <jiandong.zheng@broadcom.com>,
 Andy Gospodarek <gospo@broadcom.com>, linux-pci@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org,
 Felix Fietkau <nbd@nbd.name>
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <cc0acebf-12d4-83cd-0e1b-1aac0056aaee@gmail.com>
Date: Fri, 10 Mar 2017 22:11:28 +0100
MIME-Version: 1.0
In-Reply-To: <20170310174740.GF19517@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 03/10/2017 06:47 PM, Bjorn Helgaas wrote:
> On Fri, Mar 10, 2017 at 05:02:48PM +0100, Rafał Miłecki wrote:
>> On 03/09/2017 07:22 PM, Bjorn Helgaas wrote:
>>> On Thu, Mar 09, 2017 at 08:39:07AM +0100, Rafał Miłecki wrote:
>>>> On 03/08/2017 01:56 PM, Rafał Miłecki wrote:
>>>>> I just tried upgrading BCM5301X from 4.4 to 4.9 and noticed I don't see card
>>>>> connected to the 2nd controller.
>>>>>
>>>>> pcie_iproc_bcma bcma0:7: PCI host bridge to bus 0000:00
>>>>> pci_bus 0000:00: root bus resource [mem 0x08000000-0x0fffffff]
>>>>> pcie_iproc_bcma bcma0:7: link: UP
>>>>> PCI: bus0: Fast back to back transfers disabled
>>>>> pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>>>>> PCI: bus1: Fast back to back transfers disabled
>>>>> pci 0000:00:00.0: BAR 8: assigned [mem 0x08000000-0x080fffff]
>>>>> pci 0000:01:00.0: BAR 0: assigned [mem 0x08000000-0x08007fff 64bit]
>>>>> pci 0000:00:00.0: PCI bridge to [bus 01]
>>>>> pci 0000:00:00.0:   bridge window [mem 0x08000000-0x080fffff]
>>>>>
>>>>> pcie_iproc_bcma bcma0:8: resource collision: [mem 0x40000000-0x47ffffff] conflicts with PCIe MEM space [mem 0x40000000-0x47ffffff]
>>>>> pcie_iproc_bcma bcma0:8: PCIe controller setup failed
>>>>> pcie_iproc_bcma: probe of bcma0:8 failed with error -16
>>>>>
>>>>>
>>>>> This used to work with older kernels because there wasn't any collision check:
>>>>>
>>>>> pcie_iproc_bcma bcma0:7: PCI host bridge to bus 0000:00
>>>>> pci_bus 0000:00: root bus resource [mem 0x08000000-0x0fffffff]
>>>>> pcie_iproc_bcma bcma0:7: link: UP
>>>>> PCI: bus0: Fast back to back transfers disabled
>>>>> pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>>>>> PCI: bus1: Fast back to back transfers disabled
>>>>> pci 0000:00:00.0: BAR 8: assigned [mem 0x08000000-0x080fffff]
>>>>> pci 0000:01:00.0: BAR 0: assigned [mem 0x08000000-0x08007fff 64bit]
>>>>> pci 0000:00:00.0: PCI bridge to [bus 01]
>>>>> pci 0000:00:00.0:   bridge window [mem 0x08000000-0x080fffff]
>>>>>
>>>>> pcie_iproc_bcma bcma0:8: PCI host bridge to bus 0001:00
>>>>> pci_bus 0001:00: root bus resource [mem 0x40000000-0x47ffffff]
>>>>> pcie_iproc_bcma bcma0:8: link: UP
>>>>> PCI: bus0: Fast back to back transfers disabled
>>>>> pci 0001:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>>>>> PCI: bus1: Fast back to back transfers disabled
>>>>> pci 0001:00:00.0: BAR 8: assigned [mem 0x40000000-0x400fffff]
>>>>> pci 0001:01:00.0: BAR 0: assigned [mem 0x40000000-0x40007fff 64bit]
>>>>> pci 0001:00:00.0: PCI bridge to [bus 01]
>>>>> pci 0001:00:00.0:   bridge window [mem 0x40000000-0x400fffff]
>>>>>
>>>>>
>>>>> I guess the check is OK after all and the real problem is iproc driver assigning
>>>>> the same resource.
>>>>>
>>>>> Broadcom team: could you take a look at this, please?
>>>>
>>>> I found a reason of this conflict (and probably random crashes I started
>>>> seeing with 4.9). I believe we have a memory corruption.
>>>
>>> Yep, we're using a resource structure on the stack when we shouldn't.  Can
>>> you try the patch below?
>>
>> Works great! Will you push it with
>> Cc: stable@vger.kernel.org # v4.8+
>> please?
>
> Thanks for testing this.  I applied the patch (with the braces fix) to
> for-linus for v4.11.

Thanks!

Btw. this is how it looks now (all good it seems):

root@LEDE:/# cat /proc/iomem
00000000-07ffffff : System RAM
   00008000-0043cfff : Kernel code
   00476000-004d95df : Kernel data
08000000-0fffffff : PCIe MEM space
   08000000-085fffff : PCI Bus 0000:01
     08000000-083fffff : 0000:01:00.0
     08400000-08407fff : 0000:01:00.0
18000300-180003ff : serial
18003000-18003fff : ccb-mii
1800c000-1800cfff : dmu
18021000-18021fff : /axi@18000000/usb2@21000/ehci@21000
18022000-18022fff : /axi@18000000/usb2@21000/ohci@22000
18023000-18023fff : /axi@18000000/usb3@23000/xhci@23000
18028000-180285ff : nand
18028f00-18028f1f : iproc-ext
18105000-18105fff : dmp
1811a408-1811aa07 : iproc-idm
40000000-47ffffff : PCIe MEM space
   40000000-405fffff : PCI Bus 0001:01
     40000000-403fffff : 0001:01:00.0
     40400000-40407fff : 0001:01:00.0
88000000-8fffffff : System RAM
