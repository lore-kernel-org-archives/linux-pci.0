Return-Path: <SRS0=ra+W=MA=cisco.com=danielwa@kernel.org>
Return-Path: <SRS0=ra+W=MA=cisco.com=danielwa@kernel.org>
Subject: Re: PCI: Enforce bus address limits in resource allocation
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <abb9aa39-3128-3a4d-01f7-d0614d63f37e@cisco.com>
 <20180918132056.GA254348@bhelgaas-glaptop.roam.corp.google.com>
From: Daniel Walker <danielwa@cisco.com>
Message-ID: <b5883e58-861a-807e-f4c8-3745b006ce0d@cisco.com>
Date: Tue, 18 Sep 2018 07:24:02 -0700
MIME-Version: 1.0
In-Reply-To: <20180918132056.GA254348@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: multipart/mixed;
 boundary="------------CB26E06E4FC7596C32E803BE"
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------CB26E06E4FC7596C32E803BE
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/18/2018 06:20 AM, Bjorn Helgaas wrote:
> Hi Daniel,
> 
> Sorry about the regression, and thanks very much for your
> investigation to identify the cause!
> 
> On Fri, Sep 14, 2018 at 08:16:35AM -0700, Daniel Walker wrote:
>> I have a powerpc system with PCI, and some devices attached to the PCI bus.
>> In 3.10 everything worked fine, then we moved to 4.9 and we had some issues.
>> I was able to bisect the issue down to the patch in the subject line.
>>
>> f75b99d PCI: Enforce bus address limits in resource allocation
>>
>>
>>  From 3.10 here is part of the PCI initialization,
>>
>> |pci 0001:0e:00.0: BAR 0: assigned [mem 0xfc0000000-0xfc00fffff pref]|
>> |pci 0001:07:09.0: PCI bridge to [bus 0e]|
>> |pci 0001:07:09.0: bridge window [mem 0xfc0000000-0xfc00fffff 64bit pref]|
>>                  |||In this section the memory resource for the bridge is
>> 64bit, and the device "BAR 0" gets a 64bit range. However, it seems the
>> device is 32bit.|
> 
> The device does appear to have a 32-bit BAR because the "BAR 0" line
> doesn't include "64bit".  However, the 0xfc0000000 resource is not an
> indication of a 64-bit range because 0xfc0000000 is a CPU address, not
> a bus address.
> 
> If the host bridge performs address translation, e.g., it might
> produce a bus address by stripping off the high-order bits of the CPU
> address, this might produce a 32-bit bus address.  The fact that the
> device works suggests that the host bridge is doing some translation.
> 
> Documentation/DMA-API-HOWTO.txt has some generic background on these
> translations.
> 
> The "bridge window" line contains "64bit", but that's telling us the
> *width* of the bridge window register; it doesn't tell us anything
> about the current *setting* of that register.
> 

Ok ..


>> |Now fast forward to 4.9 we get this,|
> 
>> pci 0001:0e:00.0: BAR 0: no space for [mem size 0x00100000 pref]
>> pci 0001:0e:00.0: BAR 0: failed to assign [mem size 0x00100000 pref]
>> pci 0001:07:09.0: PCI bridge to [bus 0e]
>> pci 0001:07:09.0: bridge window [mem 0xfc0000000-0xfc00fffff 64bit pref]
>>
>> |Here it seems to have a larger size, I'm not sure where the size is coming
>> from.
> 
> The size is 0x00100000 (1MB), which is the same size as
> [mem 0xfc0000000-0xfc00fffff pref].
> 
> The size is normally discovered by probing the BAR (write all 1's to
> the BAR then read it back to find which bits are writable and which
> are read-only).  On powerpc we might learn it from DT instead.  But in
> any case, we to get the same 1MB size, which is the same size as the
> bridge window.  So this should still work unless there are other BARs
> in that window.

As far as I know there is only one BAR connected to this window.

It kind of strikes me as an off-by-one problem because it says "no 
space" but the window is the same size as what's requested. With the 
patch removed you get the whole window assigned.

In the context of the patch if you change the pci_32_bit to pci_64_bit 
for the region when calling pci_bus_alloc_from_region() in the 32bit 
case this problem disappears. I do have CONFIG_ARCH_DMA_ADDR_T_64BIT 
enabled in my config.


> 
>> I was able to work around the issue by setting IORESOURCE_MEM_64 on
>> the resource for this device. I also was able to work around it by setting
>> "max = avail.end" to "max = (-1);" inside pci_bus_alloc_resource(). |
>> ||
>> ||I don't know if the problem is the patch, or something else inside our
>> system, but any thoughts are appreciated.
> 
> It seems like we think the bridge window contains only 64-bit space
> and therefore contains nothing usable by the 32-bit BAR.
> 
> You said later that the same problem exists on v4.19-rc4.  Can you
> collect the complete dmesg log with that kernel?  That should tell us
> about any host bridge address translation.
> 
> Bjorn
> 

Sure. I have attached the dmesg.

Daniel

--------------CB26E06E4FC7596C32E803BE
Content-Type: application/gzip;
 name="bootlog.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="bootlog.txt.gz"

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
CS48JpU01cVFFP0NkVRHMTRvAAA=
--------------CB26E06E4FC7596C32E803BE--
