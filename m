Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:44133 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751770AbaABVFF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 2 Jan 2014 16:05:05 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1VypRv-00022J-Qg
	for linux-pci@vger.kernel.org; Thu, 02 Jan 2014 22:05:03 +0100
Received: from 64.89.225.77 ([64.89.225.77])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Thu, 02 Jan 2014 22:05:03 +0100
Received: from DanaGoyette by 64.89.225.77 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Thu, 02 Jan 2014 22:05:03 +0100
To: linux-pci@vger.kernel.org
From: Dana Goyette <DanaGoyette@gmail.com>
Subject: Re: IOMMU groups ... PEX8606 switch?
Date: Thu, 02 Jan 2014 13:01:54 -0800
Message-ID: <la4k3n$gia$1@ger.gmane.org>
References: <l9o1h7$33k$2@ger.gmane.org>		 <1388287383.4981.16.camel@ul30vt.home> <l9oj5j$miu$1@ger.gmane.org>	 <1388377005.4981.69.camel@ul30vt.home> <l9t26b$i61$1@ger.gmane.org> <1388691378.30327.235.camel@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
In-Reply-To: <1388691378.30327.235.camel@bling.home>
Cc: kvm@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/02/2014 11:36 AM, Alex Williamson wrote:
> On Mon, 2013-12-30 at 16:13 -0800, Dana Goyette wrote:
>> On 12/29/2013 08:16 PM, Alex Williamson wrote:
>>> On Sat, 2013-12-28 at 23:32 -0800, Dana Goyette wrote:
>>>> On 12/28/2013 7:23 PM, Alex Williamson wrote:
>>>>> On Sat, 2013-12-28 at 18:31 -0800, Dana Goyette wrote:
>>>>>> I have purchased both a SuperMicro X10SAE and an X10SAT, and I need to
>>>>>> soon decide which one to keep.
>>>>>>
>>>>>> The SuperMicro X10SAT has all the PCIe x1 slots hidden behind a PLX
>>>>>> PEX8066 switch, which claims to support ACS.  I'd expect the devices
>>>>>> downstream of the PLX switch to be in separate groups.
>>>>>>
>>>>>> With Linux 3.13-rc5 and "enable overrides for missing ACS capabilities"
>>>>>> applied and set for the Intel root ports, the devices behind the switch
>>>>>> remain stuck in the same group.
>>>>>>
>>>>>> In terms of passing devices to different VMs, which is better: all
>>>>>> devices on different root ports, or all devices behind the one
>>>>>> ACS-supporting switch?
>>>>>
>>>>> Can you provide lspci -vvv info?  If you're getting that for groups
>>>>> either the switch has ACS capabilities, but doesn't support the features
>>>>> we need or we're doing something wrong.  Thanks,
>>>>>
>>>> I initially tried attaching the output as a .txt file, but it's too
>>>> large.  Anyway, here's the output of lspci -nnvvv (you may notice that I
>>>> moved the Radeon to a different slot).
>>>
>>> Well, something seems amiss since the downstream switch ports all seem
>>> to support and enable the correct set of ACS capabilities.  I'm tending
>>> to suspect something wrong with the ACS override patch or how it's being
>>> used since your IOMMU group is still based at the root port.  Each root
>>> port is isolated from the other root ports though, so something is
>>> happening with the override patch.  Can you provide the kernel command
>>> line you use to enable ACS overrides and the override patch you're
>>> using, as it applies to 3.13-rc5?  Thanks,
>>>
>>> Alex
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe kvm" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>> I'm using the original acs-override patch from this post:
>> https://lkml.org/lkml/2013/5/30/513
>>
>> Kernel parameter is:
>> pcie_acs_override=id:8086:8c10,id:8086:8c12,id:8086:8c16,id:8086:8c18
>>
>> When booting a kernel without the override patch, the following devices
>> are all in the same group: Intel Root Ports 1, 2, 4, 5; ASMedia SATA
>> controller; PLX PEX8606 switch; Renesas USB controller; TI Firewire
>> controller; Intel I210 Ethernet controller.
>
> Ok, here's my shot in the dark; we must be detecting something about the
> upstream switch port to make it fail the ACS test and the only thing I
> can find that might do this is if the PCI config header on the upstream
> switch reported itself as a multifunction device.  Multifunction
> upstream switch ports do need ACS capabilities to make sure that traffic
> isn't routed back through other functions.  Single function devices do
> not.  To test that theory, please provide 'lspci -vxs 4:00.0'.  We're
> looking to see whether the byte at 0xe has the MSB set.  If it does, it
> lies that it's a multifunction device.  If it doesn't I'll have to get
> the dart board back out.
>
> FWIW, you should be able to work around this by adding id:10b5:8606 to
> your list of overrides.  Long term, if this is the problem, we'll want
> to add a quirk to sanitize the multifunction device flag.  Thanks,
>
> Alex
>

04:00.0 is the ASMedia SATA controller; I'll assume you meant the 
upstream port of the PLX switch.

05:00.0 PCI bridge: PLX Technology, Inc. PEX 8606 6 Lane, 6 Port PCI 
Express Gen 2 (5.0 GT/s) Switch (rev ba) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Memory at eeb00000 (32-bit, non-prefetchable) [size=128K]
	Bus: primary=05, secondary=06, subordinate=0c, sec-latency=0
	Memory behind bridge: ee800000-eeafffff
	Capabilities: [40] Power Management version 3
	Capabilities: [48] MSI: Enable+ Count=1/4 Maskable+ 64bit+
	Capabilities: [68] Express Upstream Port, MSI 00
	Capabilities: [a4] Subsystem: PLX Technology, Inc. PEX 8606 6 Lane, 6 
Port PCI Express Gen 2 (5.0 GT/s) Switch
	Capabilities: [100] Device Serial Number ba-86-01-10-b5-df-0e-00
	Capabilities: [fb4] Advanced Error Reporting
	Capabilities: [138] Power Budgeting <?>
	Capabilities: [148] Virtual Channel
	Capabilities: [448] Vendor Specific Information: ID=0000 Rev=0 Len=0cc <?>
	Capabilities: [950] Vendor Specific Information: ID=0001 Rev=0 Len=010 <?>
	Kernel driver in use: pcieport
00: b5 10 06 86 47 05 10 40 ba 00 04 06 10 00 01 00
10: 00 00 b0 ee 00 00 00 00 05 06 0c 00 f1 01 00 00
20: 80 ee a0 ee f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 01 13 00

