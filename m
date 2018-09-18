Return-Path: <SRS0=ra+W=MA=cisco.com=danielwa@kernel.org>
Return-Path: <SRS0=ra+W=MA=cisco.com=danielwa@kernel.org>
Subject: Re: PCI: Enforce bus address limits in resource allocation
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <abb9aa39-3128-3a4d-01f7-d0614d63f37e@cisco.com>
 <20180918132056.GA254348@bhelgaas-glaptop.roam.corp.google.com>
 <b5883e58-861a-807e-f4c8-3745b006ce0d@cisco.com>
 <20180918184706.GA13616@bhelgaas-glaptop.roam.corp.google.com>
From: Daniel Walker <danielwa@cisco.com>
Message-ID: <b6281224-18cf-50af-aa38-6b048d741854@cisco.com>
Date: Tue, 18 Sep 2018 11:56:20 -0700
MIME-Version: 1.0
In-Reply-To: <20180918184706.GA13616@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 09/18/2018 11:47 AM, Bjorn Helgaas wrote:
> On Tue, Sep 18, 2018 at 07:24:02AM -0700, Daniel Walker wrote:
>> On 09/18/2018 06:20 AM, Bjorn Helgaas wrote:
>>> On Fri, Sep 14, 2018 at 08:16:35AM -0700, Daniel Walker wrote:
>>>> I have a powerpc system with PCI, and some devices attached to
>>>> the PCI bus.  In 3.10 everything worked fine, then we moved to
>>>> 4.9 and we had some issues.  I was able to bisect the issue down
>>>> to the patch in the subject line.
>>>>
>>>> f75b99d PCI: Enforce bus address limits in resource allocation
>>>>
>>>>   From 3.10 here is part of the PCI initialization,
>>>>
>>>> |pci 0001:0e:00.0: BAR 0: assigned [mem 0xfc0000000-0xfc00fffff pref]|
>>>> |pci 0001:07:09.0: PCI bridge to [bus 0e]|
>>>> |pci 0001:07:09.0: bridge window [mem 0xfc0000000-0xfc00fffff 64bit pref]|
>>>>                   |||In this section the memory resource for the bridge is
>>>> 64bit, and the device "BAR 0" gets a 64bit range. However, it seems the
>>>> device is 32bit.|
> 
>>>> |Now fast forward to 4.9 we get this,|
>>>
>>>> pci 0001:0e:00.0: BAR 0: no space for [mem size 0x00100000 pref]
>>>> pci 0001:0e:00.0: BAR 0: failed to assign [mem size 0x00100000 pref]
>>>> pci 0001:07:09.0: PCI bridge to [bus 0e]
>>>> pci 0001:07:09.0: bridge window [mem 0xfc0000000-0xfc00fffff 64bit pref]
>>>>
>>>> |Here it seems to have a larger size, I'm not sure where the size is coming
>>>> from.
>>>
>>> The size is 0x00100000 (1MB), which is the same size as
>>> [mem 0xfc0000000-0xfc00fffff pref].
>>>
>>> The size is normally discovered by probing the BAR (write all 1's to
>>> the BAR then read it back to find which bits are writable and which
>>> are read-only).  On powerpc we might learn it from DT instead.  But in
>>> any case, we to get the same 1MB size, which is the same size as the
>>> bridge window.  So this should still work unless there are other BARs
>>> in that window.
>>
>> As far as I know there is only one BAR connected to this window.
>>
>> It kind of strikes me as an off-by-one problem because it says "no space"
>> but the window is the same size as what's requested. With the patch removed
>> you get the whole window assigned.
>>
>> In the context of the patch if you change the pci_32_bit to pci_64_bit for
>> the region when calling pci_bus_alloc_from_region() in the 32bit case this
>> problem disappears. I do have CONFIG_ARCH_DMA_ADDR_T_64BIT enabled in my
>> config.
>>
>>>> I was able to work around the issue by setting IORESOURCE_MEM_64 on
>>>> the resource for this device. I also was able to work around it by setting
>>>> "max = avail.end" to "max = (-1);" inside pci_bus_alloc_resource(). |
>>>> ||
>>>> ||I don't know if the problem is the patch, or something else inside our
>>>> system, but any thoughts are appreciated.
>>>
>>> It seems like we think the bridge window contains only 64-bit space
>>> and therefore contains nothing usable by the 32-bit BAR.
>>>
>>> You said later that the same problem exists on v4.19-rc4.  Can you
>>> collect the complete dmesg log with that kernel?  That should tell us
>>> about any host bridge address translation.
>>
>> Sure. I have attached the dmesg.
> 
> The relevant parts are below.  I think your DT is incorrect.  Either
> it neglects to describe the host bridge address translation for the
> ffb240000.pcie and ffb250000.pcie bridges, or it incorrectly describes
> the BARs of devices below those bridges as 32-bit BARs when they are
> really 64-bit BARs.

I don't know if the DTS is correct, it very well could be incorrect. 
Here are the relevant parts of the DTS. The BAR at issue is connected to 
PCI1.

         pci0: pcie@ffb240000 {
                 compatible = "fsl,t1040-pcie", "fsl,qoriq-pcie-v2.4", 
"fsl,qoriq-pcie";
                 device_type = "pci";
                 #size-cells = <2>;
                 #address-cells = <3>;
                 bus-range = <0x0 0xff>;
                 interrupts = <20 2 0 0>;
                 fsl,iommu-parent = <&pamu0>;
                 reg = <0xf 0xfb240000 0 0x10000>;
                 ranges = <0x03000000 0xf 0xe0000000 0xf 0xe0000000 0 
0x01000000>;

                 pcie@0 {
                         reg = <0 0 0 0 0>;
                         #size-cells = <2>;
                         #address-cells = <3>;
                         device_type = "pci";
                 };
         };

         pci1: pcie@ffb250000 {
                 compatible = "fsl,t1040-pcie", "fsl,qoriq-pcie-v2.4", 
"fsl,qoriq-pcie";
                 device_type = "pci";
                 #size-cells = <2>;
                 #address-cells = <3>;
                 bus-range = <0 0xff>;
                 interrupts = <21 2 0 0>;
                 fsl,iommu-parent = <&pamu0>;
                 reg = <0xf 0xfb250000 0 0x10000>;

                 ranges = <0x03000000 0x4 0x00000000 0x4 0x00000000 0xc 
0x00000000>;

                 pcie@0 {
                         reg = <0 0 0 0 0>;
                         #size-cells = <2>;
                         #address-cells = <3>;
                         device_type = "pci";
                 };
         };

         pci3: pcie@ffb270000 {
                 compatible = "fsl,t1040-pcie", "fsl,qoriq-pcie-v2.4", 
"fsl,qoriq-pcie";
                 device_type = "pci";
                 #size-cells = <2>;
                 #address-cells = <3>;
                 bus-range = <0x0 0xff>;
                 interrupts = <23 2 0 0>;
                 fsl,iommu-parent = <&pamu0>;
                 reg = <0xf 0xfb270000 0 0x10000>;
                 ranges = <0x03000000 0x0 0xe2000000 0xf 0xe2000000 0 
0x00100000>;

                 pcie@0 {
                         reg = <0 0 0 0 0>;
                         #size-cells = <2>;
                         #address-cells = <3>;
                         device_type = "pci";
                 };
         };



Daniel
