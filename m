Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout3.freenet.de ([195.4.92.93]:56342 "EHLO mout3.freenet.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbeIHTy0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 8 Sep 2018 15:54:26 -0400
From: Andreas Hartmann <andihartmann@01019freenet.de>
Subject: ryzen X370: iommu - unusable huge groups
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <95b7f350-76f7-daff-be4a-f3fc70589ba9@01019freenet.de>
 <20170716085334.7ae210d2@w520.home>
 <ecdf6b75-4966-fa3a-00de-99b1c9fe6caa@01019freenet.de>
 <20170716125630.7cfcec1c@w520.home>
 <7b5757d3-d0dc-e70a-2c15-954d252a9834@01019freenet.de>
 <73797d4e-cc94-3b2d-ae5b-c5ecf7cb9d92@amd.com>
Message-ID: <c447ccee-fa18-50bd-5656-f94dc3848c3c@01019freenet.de>
Date: Sat, 8 Sep 2018 16:59:52 +0200
MIME-Version: 1.0
In-Reply-To: <73797d4e-cc94-3b2d-ae5b-c5ecf7cb9d92@amd.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Suravee,

On 07/17/2017 at 03:52 PM Suravee Suthikulpanit wrote:
> 
> 
> On 7/17/17 02:39, Andreas Hartmann wrote:
>> On 07/16/2017 at 08:56 PM, Alex Williamson wrote:
>>
>>> On Sun, 16 Jul 2017 18:53:11 +0200
>>> Andreas Hartmann <andihartmann@01019freenet.de> wrote:
>>>
>>>> Hello Alex!
>>>>
>>>> Nice to hear you again :-)
>>>>
>>>>
>>>>
>>>> On 07/16/2017 at 04:53 PM Alex Williamson wrote:
>>>>> On Sun, 16 Jul 2017 07:44:01 +0200
>>>>> Andreas Hartmann <andihartmann@01019freenet.de> wrote:
>>>>>
>>>>>> Hello!
>>>>>>
>>>>>> I've got a Asus X370-Pro motherboard with enabled iommu.
>>>>>> Unfortunately,
>>>>>> the group 0 is mostly all of the system :-).
>>>>>>
>>>>>> [    2.602426] iommu: Adding device 0000:00:01.0 to group 0
>>>>>> [    2.602440] iommu: Adding device 0000:00:01.3 to group 0
>>>>>> [    2.603368] iommu: Adding device 0000:03:00.0 to group 0
>>>>>> [    2.603377] iommu: Adding device 0000:03:00.1 to group 0
>>>>>> [    2.603385] iommu: Adding device 0000:03:00.2 to group 0
>>>>>> [    2.603396] iommu: Adding device 0000:1d:00.0 to group 0
>>>>>> [    2.603406] iommu: Adding device 0000:1d:02.0 to group 0
>>>>>> [    2.603417] iommu: Adding device 0000:1d:03.0 to group 0
>>>>>> [    2.603428] iommu: Adding device 0000:1d:04.0 to group 0
>>>>>> [    2.603439] iommu: Adding device 0000:1d:06.0 to group 0
>>>>>> [    2.603450] iommu: Adding device 0000:1d:07.0 to group 0
>>>>>> [    2.603466] iommu: Adding device 0000:24:00.0 to group 0
>>>>>> [    2.603481] iommu: Adding device 0000:25:00.0 to group 0
>>>>>> [    2.603498] iommu: Adding device 0000:26:00.0 to group 0
>>>>>> [    2.603513] iommu: Adding device 0000:27:00.0 to group 0
>>>>>
>>>>>
>>>>> Update your motherboard BIOS, AMD AGESA 1.0.0.6 is supposed to
>>>>> enable ACS in the PCIe root ports.  Thanks,
>>>>
>>>> Group 0 is now group 10 - that's mostly all :-( - no significant
>>>> change.
>>>> (Version 805 which should contain AGESA 1.0.0.6).
>>>>
>>>>
>>>> [    2.600097] iommu: Adding device 0000:03:00.0 to group 10
>>>> [    2.600117] iommu: Adding device 0000:03:00.1 to group 10
>>>> [    2.600136] iommu: Adding device 0000:03:00.2 to group 10
>>>> [    2.600148] iommu: Adding device 0000:1d:00.0 to group 10
>>>> [    2.600158] iommu: Adding device 0000:1d:02.0 to group 10
>>>> [    2.600169] iommu: Adding device 0000:1d:03.0 to group 10
>>>> [    2.600180] iommu: Adding device 0000:1d:04.0 to group 10
>>>> [    2.600190] iommu: Adding device 0000:1d:06.0 to group 10
>>>> [    2.600201] iommu: Adding device 0000:1d:07.0 to group 10
>>>> [    2.600216] iommu: Adding device 0000:24:00.0 to group 10
>>>> [    2.600233] iommu: Adding device 0000:25:00.0 to group 10
>>>> [    2.600249] iommu: Adding device 0000:26:00.0 to group 10
>>>> [    2.600266] iommu: Adding device 0000:27:00.0 to group 10
>>>>
>>>>
>>>> All devices that are used are in the same group again.
>>>>
>>>> Isn't it possible to allow them to put to VM anyway if there is no peer
>>>> to peer communication - same as it was possible with the previous
>>>> chipset (990xa)?
>>>
>>> Ah, I see you have a PCIe switch with downstream ports 1d.*.0 where
>>> the downstream switch ports don't support ACS (not surprising for
>>> something reporting ASMedia as a subsystem capability).  So ACS was
>>> broken at multiple levels and now that it's exposed at the root port
>>> it's still broken by the non-ACS switch.  The endpoints downstream of
>>> the switch are not sufficiently isolated to separate between VMs,
>>> sorry, the hardware isn't up to the task at hand.  Thanks,
>>
>> In other words, you're telling, that there can't be done anything to
>> get it
>> working? Do you know any other board, which doesn't have this problem
>> and could
>> work?
>>
>> Gigabyte? Asrock?
>>
>>
>> Thanks,
>> Andreas
> 
> I have checked with the BIOS team, and they said that this is supposed
> to get fixed in 1.0.0.7.  Sorry for inconvenience.

We are now more than one year later now and there isn't any usable fix
out there. I'm using BIOS 4011 04/19/2018 on my Asus Prime X370Pro and
it's still impossible to put two pcie cards each to a different VM.

There is a small fix, but it's still unusable:



[    1.913322] iommu: Adding device 0000:00:01.0 to group 0         00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1452
[    1.913464] iommu: Adding device 0000:00:01.3 to group 1         00:01.3 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 1453
[    1.913587] iommu: Adding device 0000:00:02.0 to group 2         00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1452
[    1.913721] iommu: Adding device 0000:00:03.0 to group 3         00:03.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1452
[    1.913855] iommu: Adding device 0000:00:03.1 to group 4         00:03.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 1453
[    1.913974] iommu: Adding device 0000:00:04.0 to group 5         00:04.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1452
[    1.914106] iommu: Adding device 0000:00:07.0 to group 6         00:07.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1452
[    1.914228] iommu: Adding device 0000:00:07.1 to group 7         00:07.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 1454
[    1.914355] iommu: Adding device 0000:00:08.0 to group 8         00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1452
[    1.914475] iommu: Adding device 0000:00:08.1 to group 9         00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 1454

[    1.914599] iommu: Adding device 0000:00:14.0 to group 10        00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller (rev 59)
[    1.914609] iommu: Adding device 0000:00:14.3 to group 10        00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge (rev 51)

[    1.914739] iommu: Adding device 0000:00:18.0 to group 11        00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1460
[    1.914749] iommu: Adding device 0000:00:18.1 to group 11        00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1461
[    1.914760] iommu: Adding device 0000:00:18.2 to group 11        00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1462
[    1.914768] iommu: Adding device 0000:00:18.3 to group 11        00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1463
[    1.914776] iommu: Adding device 0000:00:18.4 to group 11        00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1464
[    1.914786] iommu: Adding device 0000:00:18.5 to group 11        00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1465
[    1.914795] iommu: Adding device 0000:00:18.6 to group 11        00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1466
[    1.914803] iommu: Adding device 0000:00:18.7 to group 11        00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1467

[    1.914945] iommu: Adding device 0000:01:00.0 to group 12        01:00.0 USB controller: Advanced Micro Devices, Inc. [AMD] Device 43b9 (rev 02)
[    1.914967] iommu: Adding device 0000:01:00.1 to group 12        01:00.1 SATA controller: Advanced Micro Devices, Inc. [AMD] Device 43b5 (rev 02)
[    1.914990] iommu: Adding device 0000:01:00.2 to group 12        01:00.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 43b0 (rev 02)
[    1.915000] iommu: Adding device 0000:02:00.0 to group 12        02:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 43b4 (rev 02)
[    1.915010] iommu: Adding device 0000:02:02.0 to group 12        02:02.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 43b4 (rev 02)
[    1.915020] iommu: Adding device 0000:02:03.0 to group 12        02:03.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 43b4 (rev 02)
[    1.915029] iommu: Adding device 0000:02:04.0 to group 12        02:04.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 43b4 (rev 02)
[    1.915040] iommu: Adding device 0000:02:06.0 to group 12        02:06.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 43b4 (rev 02)
[    1.915049] iommu: Adding device 0000:02:07.0 to group 12        02:07.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 43b4 (rev 02)
[    1.915065] iommu: Adding device 0000:05:00.0 to group 12            05:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
[    1.915082] iommu: Adding device 0000:06:00.0 to group 12        06:00.0 USB controller: ASMedia Technology Inc. Device 1343
[    1.915099] iommu: Adding device 0000:07:00.0 to group 12            07:00.0 Ethernet controller: Intel Corporation I211 Gigabit Network Connection (rev 03)
[    1.915116] iommu: Adding device 0000:08:00.0 to group 12            08:00.0 Network controller: Qualcomm Atheros AR93xx Wireless Network Adapter (rev 01)

[    1.915256] iommu: Adding device 0000:09:00.0 to group 13        09:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Turks PRO [Radeon HD 6570/7570/8550]
[    1.915282] iommu: Adding device 0000:09:00.1 to group 13        09:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Turks/Whistler HDMI Audio [Radeon HD 6000 Series]

[    1.915410] iommu: Adding device 0000:0a:00.0 to group 14        0a:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Device 145a
[    1.915539] iommu: Adding device 0000:0a:00.2 to group 15        0a:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD] Device 1456
[    1.915664] iommu: Adding device 0000:0a:00.3 to group 16        0a:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] USB3 Host Controller
[    1.915792] iommu: Adding device 0000:0b:00.0 to group 17        0b:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Device 1455
[    1.915916] iommu: Adding device 0000:0b:00.2 to group 18        0b:00.2 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA Controller [AHCI mode] (rev 51)
[    1.916071] iommu: Adding device 0000:0b:00.3 to group 19        0b:00.3 Audio device: Advanced Micro Devices, Inc. [AMD] Device 1457


For me, device 0000:07:00.0 and 0000:08:00.0 is relevant - now they are both belonging to group 12.

Since more than a year I'm using the PCIe ACS overrides patch (pcie_acs_override=multifunction) to put those devices to two different VMs
and it always worked like a charme - I didn't had any problem so far (now using linux 4.18.6).

Could you please provide official pci quirks for this chipset?


Thanks,
Andreas
