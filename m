Return-Path: <SRS0=OSBU=MB=cisco.com=danielwa@kernel.org>
Return-Path: <SRS0=OSBU=MB=cisco.com=danielwa@kernel.org>
Subject: Re: PCI: Enforce bus address limits in resource allocation
To: Oliver <oohall@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Device Tree <devicetree@vger.kernel.org>
References: <abb9aa39-3128-3a4d-01f7-d0614d63f37e@cisco.com>
 <20180918132056.GA254348@bhelgaas-glaptop.roam.corp.google.com>
 <b5883e58-861a-807e-f4c8-3745b006ce0d@cisco.com>
 <20180918184706.GA13616@bhelgaas-glaptop.roam.corp.google.com>
 <b6281224-18cf-50af-aa38-6b048d741854@cisco.com>
 <20180918204834.GB13616@bhelgaas-glaptop.roam.corp.google.com>
 <CAOSf1CHcDqrwy5W-GAjJ-x+rBwbRMLoVsM8D6veFVPPXmdAsZQ@mail.gmail.com>
From: Daniel Walker <danielwa@cisco.com>
Message-ID: <4ba13a62-a2b4-662d-4f55-779312aa7871@cisco.com>
Date: Wed, 19 Sep 2018 14:13:28 -0700
MIME-Version: 1.0
In-Reply-To: <CAOSf1CHcDqrwy5W-GAjJ-x+rBwbRMLoVsM8D6veFVPPXmdAsZQ@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------887203805D2212F361329024"
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------887203805D2212F361329024
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/19/2018 07:25 AM, Oliver wrote:
> On Wed, Sep 19, 2018 at 6:48 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> [+cc Rob, Frank, devicetree list,
>>
>> thread starts here:
>> https://lkml.kernel.org/r/abb9aa39-3128-3a4d-01f7-d0614d63f37e@cisco.com
>>
>> dmesg snippets here:
>> https://lkml.kernel.org/r/20180918184706.GA13616@bhelgaas-glaptop.roam.corp.google.com]
>>
>> On Tue, Sep 18, 2018 at 11:56:20AM -0700, Daniel Walker wrote:
>>> On 09/18/2018 11:47 AM, Bjorn Helgaas wrote:
>>>> On Tue, Sep 18, 2018 at 07:24:02AM -0700, Daniel Walker wrote:
>>>>> On 09/18/2018 06:20 AM, Bjorn Helgaas wrote:
>>>>>> On Fri, Sep 14, 2018 at 08:16:35AM -0700, Daniel Walker wrote:
>>>>>>> I have a powerpc system with PCI, and some devices attached to
>>>>>>> the PCI bus.  In 3.10 everything worked fine, then we moved to
>>>>>>> 4.9 and we had some issues.  I was able to bisect the issue down
>>>>>>> to the patch in the subject line.
>>>>>>>
>>>>>>> f75b99d PCI: Enforce bus address limits in resource allocation
>>>>>>>
>>>>>>>    From 3.10 here is part of the PCI initialization,
>>>>>>>
>>>>>>> |pci 0001:0e:00.0: BAR 0: assigned [mem 0xfc0000000-0xfc00fffff pref]|
>>>>>>> |pci 0001:07:09.0: PCI bridge to [bus 0e]|
>>>>>>> |pci 0001:07:09.0: bridge window [mem 0xfc0000000-0xfc00fffff 64bit pref]|
>>>>>>>                    |||In this section the memory resource for the bridge is
>>>>>>> 64bit, and the device "BAR 0" gets a 64bit range. However, it seems the
>>>>>>> device is 32bit.|
>>>>
>>>>>>> |Now fast forward to 4.9 we get this,|
>>>>>>
>>>>>>> pci 0001:0e:00.0: BAR 0: no space for [mem size 0x00100000 pref]
>>>>>>> pci 0001:0e:00.0: BAR 0: failed to assign [mem size 0x00100000 pref]
>>>>>>> pci 0001:07:09.0: PCI bridge to [bus 0e]
>>>>>>> pci 0001:07:09.0: bridge window [mem 0xfc0000000-0xfc00fffff 64bit pref]
>>>>>>>
>>>>>>> |Here it seems to have a larger size, I'm not sure where the size is coming
>>>>>>> from.
>>>>>>
>>>>>> The size is 0x00100000 (1MB), which is the same size as
>>>>>> [mem 0xfc0000000-0xfc00fffff pref].
>>>>>>
>>>>>> The size is normally discovered by probing the BAR (write all 1's to
>>>>>> the BAR then read it back to find which bits are writable and which
>>>>>> are read-only).  On powerpc we might learn it from DT instead.  But in
>>>>>> any case, we to get the same 1MB size, which is the same size as the
>>>>>> bridge window.  So this should still work unless there are other BARs
>>>>>> in that window.
>>>>>
>>>>> As far as I know there is only one BAR connected to this window.
>>>>>
>>>>> It kind of strikes me as an off-by-one problem because it says "no space"
>>>>> but the window is the same size as what's requested. With the patch removed
>>>>> you get the whole window assigned.
>>>>>
>>>>> In the context of the patch if you change the pci_32_bit to pci_64_bit for
>>>>> the region when calling pci_bus_alloc_from_region() in the 32bit case this
>>>>> problem disappears. I do have CONFIG_ARCH_DMA_ADDR_T_64BIT enabled in my
>>>>> config.
>>>>>
>>>>>>> I was able to work around the issue by setting IORESOURCE_MEM_64 on
>>>>>>> the resource for this device. I also was able to work around it by setting
>>>>>>> "max = avail.end" to "max = (-1);" inside pci_bus_alloc_resource(). |
>>>>>>> ||
>>>>>>> ||I don't know if the problem is the patch, or something else inside our
>>>>>>> system, but any thoughts are appreciated.
>>>>>>
>>>>>> It seems like we think the bridge window contains only 64-bit space
>>>>>> and therefore contains nothing usable by the 32-bit BAR.
>>>>>>
>>>>>> You said later that the same problem exists on v4.19-rc4.  Can you
>>>>>> collect the complete dmesg log with that kernel?  That should tell us
>>>>>> about any host bridge address translation.
>>>>>
>>>>> Sure. I have attached the dmesg.
>>>>
>>>> The relevant parts are below.  I think your DT is incorrect.  Either
>>>> it neglects to describe the host bridge address translation for the
>>>> ffb240000.pcie and ffb250000.pcie bridges, or it incorrectly describes
>>>> the BARs of devices below those bridges as 32-bit BARs when they are
>>>> really 64-bit BARs.
>>>
>>> I don't know if the DTS is correct, it very well could be incorrect. Here
>>> are the relevant parts of the DTS. The BAR at issue is connected to PCI1.
>>
>> The DTS matches what I pointed out in the dmesg log.  I think you need
>> to reconcile it with your hardware and firmware, which I don't know
>> anything about, so I don't know what else I can do at this point.  I
>> copied some DT folks in case they have advice.
>>
>>>          pci0: pcie@ffb240000 {
>>>                  compatible = "fsl,t1040-pcie", "fsl,qoriq-pcie-v2.4",
>>> "fsl,qoriq-pcie";
>>>                  device_type = "pci";
>>>                  #size-cells = <2>;
>>>                  #address-cells = <3>;
>>>                  bus-range = <0x0 0xff>;
>>>                  interrupts = <20 2 0 0>;
>>>                  fsl,iommu-parent = <&pamu0>;
>>>                  reg = <0xf 0xfb240000 0 0x10000>;
>>>                  ranges = <0x03000000 0xf 0xe0000000 0xf 0xe0000000 0
>>> 0x01000000>;
>>>
>>>                  pcie@0 {
>>>                          reg = <0 0 0 0 0>;
>>>                          #size-cells = <2>;
>>>                          #address-cells = <3>;
>>>                          device_type = "pci";
>>>                  };
>>>          };
>>>
>>>          pci1: pcie@ffb250000 {
>>>                  compatible = "fsl,t1040-pcie", "fsl,qoriq-pcie-v2.4",
>>> "fsl,qoriq-pcie";
>>>                  device_type = "pci";
>>>                  #size-cells = <2>;
>>>                  #address-cells = <3>;
>>>                  bus-range = <0 0xff>;
>>>                  interrupts = <21 2 0 0>;
>>>                  fsl,iommu-parent = <&pamu0>;
>>>                  reg = <0xf 0xfb250000 0 0x10000>;
>>>
>>>                  ranges = <0x03000000 0x4 0x00000000 0x4 0x00000000 0xc
>>> 0x00000000>;
>>>
>>>                  pcie@0 {
>>>                          reg = <0 0 0 0 0>;
>>>                          #size-cells = <2>;
>>>                          #address-cells = <3>;
>>>                          device_type = "pci";
>>>                  };
>>>          };
> 
> The upstream fsl-pci driver seems to configure the bridge windows
> based on what's in the ranges property rather than just consuming it.
> It might be possible to add some 32bit BAR space by tweaking the
> ranges to something like:
> 
>          ranges = <0x02000000 0x0 0x80000000 0x4 0x0 0x0 0x80000000>;

I added this line for pci1 , and the initialization appears to be 
different. I don't see the same "no space" lines (there is no reference 
to 0001:0e at all in that sequence). The unit test I have referenced 
below starts working.

Is it possible to identify all the BAR's in the window as 64bit ? We 
have shown that the device works fine with 64-bit addresses , although 
it's not identified as a 64-bit device. This device has no DTS entry 
currently.


> 
> That said, it looks Daniel's kernel has some patches that change how
> PCI setup works so it might not be using the upstream driver.

Are you talking about these lines,

FPGA_PCIE: fpga_pcie_init_module enter
FPGA_PCIE: fpga mmio_start=0 fpga mmio_len=0
FPGA_PCIE: resource start=0 end=0, name="PCI Bus 0001:0e"
FPGA_PCIE: resource start=0 end=0, name="PCI Bus 0001:0e"
FPGA_PCIE: resource start=0 end=0, name="PCI Bus 0001:0e"
FPGA_PCIE: resource start=0 end=0, name="PCI Bus 0001:0e"
__ioremap(): phys addr 0x0 is RAM lr fpga_pcie_probe

This is a custom unit test for this issue.

I noticed some changes to this file arch/powerpc/sysdev/fsl_pci.c in my 
tree , I removed them and the issues stays the same. I don't believe I'm 
adding anything which alters this problem.

The tree I'm working off of is massively stripped down, it only provides 
support for the platform I'm working on which is based in Freescale 
T1042 which is upstream.

I have attached a dmesg with the ranges property added, and the 
fsl_pci.c changes removed in my tree.

Daniel

--------------887203805D2212F361329024
Content-Type: application/gzip;
 name="bootlog2.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="bootlog2.txt.gz"

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
--------------887203805D2212F361329024--
