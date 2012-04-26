Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:31082 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752473Ab2DZDgL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 25 Apr 2012 23:36:11 -0400
Message-ID: <4F98C298.1010504@redhat.com>
Date: Wed, 25 Apr 2012 23:35:52 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Jiang Liu <liuj97@gmail.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org,
	"Pearson, Greg" <greg.pearson@hp.com>
Subject: Re: [PATCH V4 0/6] PCI, x86: update MMCFG information when hot-plugging
 PCI host bridges
References: <1334103063-2283-1-git-send-email-jiang.liu@huawei.com> <CAErSpo7zWEXBhC7+gaq+BCussyKOYORaBG-PBe4ERruCAA-cfQ@mail.gmail.com> <4F8573A4.8070307@jp.fujitsu.com> <4F85A481.1020807@gmail.com> <CAErSpo4gqLBQjYf-pKsHWgZOTUTJEi0uqKxSJ5pB_F0uu+CKMA@mail.gmail.com> <4F880482.1090903@jp.fujitsu.com> <4F883956.2040200@gmail.com> <4F8C3B0C.4080606@redhat.com> <4F8C4430.90501@gmail.com> <4F8C5CD9.2020100@redhat.com> <CAErSpo4weTAGVLs748FJbcacyKL=wWfuuDOKEoG8=Skmc+-V8Q@mail.gmail.com> <4F95A485.2030700@redhat.com> <CAErSpo6pN4kShaK94LB0JtZpX=wUO7jwNuvxU20Pyp0A6mjZsg@mail.gmail.com>
In-Reply-To: <CAErSpo6pN4kShaK94LB0JtZpX=wUO7jwNuvxU20Pyp0A6mjZsg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/25/2012 12:50 PM, Bjorn Helgaas wrote:
> On Mon, Apr 23, 2012 at 12:50 PM, Don Dutile<ddutile@redhat.com>  wrote:
>> On 04/23/2012 01:41 PM, Bjorn Helgaas wrote:
>>>
>>> On Mon, Apr 16, 2012 at 11:54 AM, Don Dutile<ddutile@redhat.com>    wrote:
>>>>
>>>> On 04/16/2012 12:09 PM, Jiang Liu wrote:
>>>>>
>>>>>
>>>>> Hi Don,
>>>>>         Thanks for your comments and please refer to inline comments
>>>>> below.
>>>>
>>>>
>>>>
>>>> Thanks for the info below; couple quick replies below.. - Don
>>>>
>>>>
>>>>> On 04/16/2012 11:30 PM, Don Dutile wrote:
>>>>>>
>>>>>>
>>>>>> On 04/13/2012 10:33 AM, Jiang Liu wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 04/13/2012 06:48 PM, Kenji Kaneshige wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> (2012/04/12 9:06), Bjorn Helgaas wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On Wed, Apr 11, 2012 at 9:34 AM, Jiang Liu<liuj97@gmail.com>
>>>>>>>>>   wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 04/11/2012 08:05 PM, Kenji Kaneshige wrote:
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> (2012/04/11 13:02), Bjorn Helgaas wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> On Tue, Apr 10, 2012 at 6:10 PM, Jiang Liu<liuj97@gmail.com>
>>>>>>>>>>>>   wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> This patchset enhance pci_root driver to update MMCFG
>>>>>>>>>>>>> information
>>>>>>>>>>>>> when
>>>>>>>>>>>>> hot-plugging PCI root bridges. It applies to Yinghai's tree at
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
>>>>>>>>>>>>> for-pci-root-bus-hotplug
>>>>>>>>>>>>>
>>>>>>>>>>>>> The second patch is based on Taku Izumi work with some
>>>>>>>>>>>>> enhancements to
>>>>>>>>>>>>> correctly handle PCI host bridges without _CBA method.
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> I'm sorry I won't have time to really review these for a couple
>>>>>>>>>>>> weeks.
>>>>>>>>>>>>
>>>>>>>>>>>> It always seemed wrong to me that we parse MCFG and set things up
>>>>>>>>>>>> before we even look at PNP0A03/PNP0A08 devices.  It would make
>>>>>>>>>>>> more
>>>>>>>>>>>> sense to me to have something in acpi_pci_root_add() to set up
>>>>>>>>>>>> MMCONFIG using _CBA if available, and falling back to parsing
>>>>>>>>>>>> MCFG
>>>>>>>>>>>> if
>>>>>>>>>>>> it's not.
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> I think your idea could make the code (design) much cleaner.
>>>>>>>>>>> Do you have any other reason why you think "It always seemed
>>>>>>>>>>> wrong..."?
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> The current scheme is just an ugly design.  Does I need more
>>>>>>>>> reasons?
>>>>>>>>>   :)
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Ok, I just wanted to know if I'm missing anything we need to
>>>>>>>> take into account when re-factoring the code.
>>>>>>>>
>>>>>>>> By the way, the following code makes me think there could be
>>>>>>>> some hardwares that need a fixup using mmconfig access before
>>>>>>>> scanning the PCI tree. If this is the case, we would need
>>>>>>>> something to enable early mmconfig initialization for those
>>>>>>>> hardwares.
>>>>>>>>
>>>>>>>> static __init int pci_arch_init(void)
>>>>>>>> {
>>>>>>>>       ...
>>>>>>>>           if (!(pci_probe&       PCI_PROBE_NOEARLY))
>>>>>>>>                   pci_mmcfg_early_init();
>>>>>>>>
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Kenji Kaneshige
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> If MMCFG could be treated as an optional configuration space access
>>>>>>> method,
>>>>>>> we can refine the MMCFG code according to Bjorn's suggestion. And as
>>>>>>> Kenji
>>>>>>> has mentioned, there may be some risks ahead. So need more
>>>>>>> confirmation
>>>>>>> from other PCI experts here.
>>>>>>>
>>>>>> I looked at the thread, but didn't know which suggestion of Bjorn's you
>>>>>> were referring to.
>>>>>> But, mmcfg access to PCI config space is need for any cap structure
>>>>>> greater than 256 byte offset.  A number of devices have cap structures
>>>>>> in this upper PCI config space, esp. SRIOV devices.
>>>>>> So, if 'optional MMCFG' only means at the beginning of kernel scanning
>>>>>> of
>>>>>> PCI (pass-0 scanning), that should be ok, but in-depth, pass-1 scanning
>>>>>> of PCIe devices may require MMCFG for full functional support.
>>>>>
>>>>>
>>>>> For mainstream systems with support of ACPI and MMCFG, the booting
>>>>> sequences are about:
>>>>> 1) Probe for legacy PCI configuration access mechanism, such as CONF1,
>>>>> CONF2, BIOS
>>>>> 2) Start ACPICA/ACPI subsystem with the legacy PCI configuration access
>>>>> mechanism
>>>>> 3) Enumerate PCI root bridges (PNP0A03/PNP0A08) in ACPI namespace and
>>>>> bind
>>>>> pci_root
>>>>>     driver to them
>>>>> 4) pci_root driver calls into arch code to add MMCFG information for the
>>>>> host bridge
>>>>> 5) pci_root driver calls PCI core to enumerate all PCI devices under the
>>>>> host bridge
>>>>>
>>>>> The above flow should work for SRIOV case. But still need to check
>>>>> following cases:
>>>>> 1) ACPICA/ACPI subsystem has no dependency on MMCFG
>>>>> 2) Systems implementing SFI instead of ACPI work as expected
>>>>> 3) ACPI has been disabled by user (Bjorn points out we could ignore this
>>>>> case)
>>>>
>>>>
>>>> Agreed. My least favorite bz: "I set boot param to noacpi and can't scan
>>>> entire PCI space.... duh!
>>>>
>>>>
>>>>> 4) Some host bridges are not reported by ACPI (Bjorn points out we
>>>>> should
>>>>> eventually
>>>>>     get rid of the blind probing logic)
>>>>
>>>>
>>>> And depend on BIOS-ACPI to be correct all the time? ....hahahahahaha  ...
>>>> sorry.... you hit my funny bone! ;-)
>>>> Is blind probing problematic ?
>>>> Seems like a pci-fixup/quirk can be implemented under arch/<>/pci to
>>>> handle
>>>> these cases, and thus, depend on ACPI for host-bridge info... wait! did I
>>>> just
>>>> say depend on ACPI?!?!   :)
>>>
>>>
>>> Hope your funny bone has stopped tingling by now :)
>>>
>> Not when ACPI's always there to bang it again! ;-)
>>
>>> When we probe blindly, we don't know what resources are available on
>>> the bus (except for AMD systems).  Therefore, we can't do reliable
>>> assignment, and we have to rely on whatever the BIOS did.
>>>
>>> Blind probing finds devices not exposed by the BIOS.  This might be a
>>> BIOS bug, or it might be a conscious decision to hide the devices from
>>> the OS.  Some OEMs hide devices to reduce the likelihood of users
>>> messing things up with setpci.
>>>
>>> It would be interesting and relatively easy to figure out whether
>>> Windows ever discovers a device behind an unreported host bridge.  My
>>> guess is "no," but I haven't had time to verify this.
>>>
>> Well, call me crazy(again!), but why put a host-bridge device on a system
>> and then (try to) hide it with software(BIOS/ACPI) ?
>> Sounds like a recipe for disaster if the OS tries to
>> reconfigure address space or bus-number space.....
>
> Some OEMs do leave host bridges unreported.  Here's an example, from
> an HP DL380 G7:
>
I didn't doubt they tried to.... again, why!?!

>    ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-1a])
>    pci 0000:00:00.0: [8086:3406] type 0 class 0x000600
>    pci 0000:00:01.0: [8086:3408] type 1 class 0x000604
>    pci 0000:00:02.0: [8086:3409] type 1 class 0x000604
>    ...
>    PCI: Discovered peer bus 3e
>    pci 0000:3e:00.0: [8086:2c70] type 0 class 0x000600
>    pci 0000:3e:00.1: [8086:2d81] type 0 class 0x000600
>    pci 0000:3e:02.0: [8086:2d90] type 0 class 0x000600
>    ...
>    PCI: Discovered peer bus 3f
>    pci 0000:3f:00.0: [8086:2c70] type 0 class 0x000600
>    pci 0000:3f:00.1: [8086:2d81] type 0 class 0x000600
>    pci 0000:3f:02.0: [8086:2d90] type 0 class 0x000600
>
> ACPI did not report host bridges leading to buses 3e and 3f; we found
> those devices by probing blindly.
>
> In this case, these are Intel CPU uncore devices, and they don't
> consume MMIO or IO port resources.  But you're absolutely right that
> we can't safely reconfigure anything we find this way.
>
>> Hiding a PCI device is as simple as not loading its driver... :)
>
> Sure, if it's the OS that wants to hide it.  In this case, it's the
> OEM that wants to hide it, and the only mechanism for doing that is to
> refrain from telling the OS how to find it.  I'm pretty confident that
> the DL380 omission of those host bridges is an intentional choice by
> the BIOS writers.
>
> Bjorn

but this kind of hiding will break code paths/logic like pci=assign-busses,
b/c if the hidden bus nums aren't registered, and they are used by
the assign-bus code, then duplicate busses will have overlapping sec-num/sub-num
ranges and then there are two bridges that will race (or as I experienced, hang)
to reply with config cycles in the overlapping range.
so, scanning & registering (but not configuring) 'hidden' (non-ACPI-id'd)
bridges/busses sounds like something the pci code has to do.
