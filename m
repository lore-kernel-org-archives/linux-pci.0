Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42043 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751319Ab2DPSI6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 16 Apr 2012 14:08:58 -0400
Message-ID: <4F8C5CD9.2020100@redhat.com>
Date: Mon, 16 Apr 2012 13:54:33 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Jiang Liu <liuj97@gmail.com>
CC: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH V4 0/6] PCI, x86: update MMCFG information when hot-plugging
 PCI host bridges
References: <1334103063-2283-1-git-send-email-jiang.liu@huawei.com> <CAErSpo7zWEXBhC7+gaq+BCussyKOYORaBG-PBe4ERruCAA-cfQ@mail.gmail.com> <4F8573A4.8070307@jp.fujitsu.com> <4F85A481.1020807@gmail.com> <CAErSpo4gqLBQjYf-pKsHWgZOTUTJEi0uqKxSJ5pB_F0uu+CKMA@mail.gmail.com> <4F880482.1090903@jp.fujitsu.com> <4F883956.2040200@gmail.com> <4F8C3B0C.4080606@redhat.com> <4F8C4430.90501@gmail.com>
In-Reply-To: <4F8C4430.90501@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/16/2012 12:09 PM, Jiang Liu wrote:
> Hi Don,
> 	Thanks for your comments and please refer to inline comments below.

Thanks for the info below; couple quick replies below.. - Don

> On 04/16/2012 11:30 PM, Don Dutile wrote:
>> On 04/13/2012 10:33 AM, Jiang Liu wrote:
>>> On 04/13/2012 06:48 PM, Kenji Kaneshige wrote:
>>>> (2012/04/12 9:06), Bjorn Helgaas wrote:
>>>>> On Wed, Apr 11, 2012 at 9:34 AM, Jiang Liu<liuj97@gmail.com>    wrote:
>>>>>> On 04/11/2012 08:05 PM, Kenji Kaneshige wrote:
>>>>>>> (2012/04/11 13:02), Bjorn Helgaas wrote:
>>>>>>>> On Tue, Apr 10, 2012 at 6:10 PM, Jiang Liu<liuj97@gmail.com>      wrote:
>>>>>>>>> This patchset enhance pci_root driver to update MMCFG information when
>>>>>>>>> hot-plugging PCI root bridges. It applies to Yinghai's tree at
>>>>>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci-root-bus-hotplug
>>>>>>>>>
>>>>>>>>> The second patch is based on Taku Izumi work with some enhancements to
>>>>>>>>> correctly handle PCI host bridges without _CBA method.
>>>>>>>>
>>>>>>>> I'm sorry I won't have time to really review these for a couple weeks.
>>>>>>>>
>>>>>>>> It always seemed wrong to me that we parse MCFG and set things up
>>>>>>>> before we even look at PNP0A03/PNP0A08 devices.  It would make more
>>>>>>>> sense to me to have something in acpi_pci_root_add() to set up
>>>>>>>> MMCONFIG using _CBA if available, and falling back to parsing MCFG if
>>>>>>>> it's not.
>>>>>>>
>>>>>>> I think your idea could make the code (design) much cleaner.
>>>>>>> Do you have any other reason why you think "It always seemed
>>>>>>> wrong..."?
>>>>>
>>>>> The current scheme is just an ugly design.  Does I need more reasons?  :)
>>>>
>>>> Ok, I just wanted to know if I'm missing anything we need to
>>>> take into account when re-factoring the code.
>>>>
>>>> By the way, the following code makes me think there could be
>>>> some hardwares that need a fixup using mmconfig access before
>>>> scanning the PCI tree. If this is the case, we would need
>>>> something to enable early mmconfig initialization for those
>>>> hardwares.
>>>>
>>>> static __init int pci_arch_init(void)
>>>> {
>>>>       ...
>>>>           if (!(pci_probe&   PCI_PROBE_NOEARLY))
>>>>                   pci_mmcfg_early_init();
>>>>
>>>>
>>>> Regards,
>>>> Kenji Kaneshige
>>>
>>> If MMCFG could be treated as an optional configuration space access method,
>>> we can refine the MMCFG code according to Bjorn's suggestion. And as Kenji
>>> has mentioned, there may be some risks ahead. So need more confirmation
>>> from other PCI experts here.
>>>
>> I looked at the thread, but didn't know which suggestion of Bjorn's you were referring to.
>> But, mmcfg access to PCI config space is need for any cap structure
>> greater than 256 byte offset.  A number of devices have cap structures
>> in this upper PCI config space, esp. SRIOV devices.
>> So, if 'optional MMCFG' only means at the beginning of kernel scanning of
>> PCI (pass-0 scanning), that should be ok, but in-depth, pass-1 scanning
>> of PCIe devices may require MMCFG for full functional support.
> For mainstream systems with support of ACPI and MMCFG, the booting sequences are about:
> 1) Probe for legacy PCI configuration access mechanism, such as CONF1, CONF2, BIOS
> 2) Start ACPICA/ACPI subsystem with the legacy PCI configuration access mechanism
> 3) Enumerate PCI root bridges (PNP0A03/PNP0A08) in ACPI namespace and bind pci_root
>     driver to them
> 4) pci_root driver calls into arch code to add MMCFG information for the host bridge
> 5) pci_root driver calls PCI core to enumerate all PCI devices under the host bridge
>
> The above flow should work for SRIOV case. But still need to check following cases:
> 1) ACPICA/ACPI subsystem has no dependency on MMCFG
> 2) Systems implementing SFI instead of ACPI work as expected
> 3) ACPI has been disabled by user (Bjorn points out we could ignore this case)
Agreed. My least favorite bz: "I set boot param to noacpi and can't scan entire PCI space.... duh!

> 4) Some host bridges are not reported by ACPI (Bjorn points out we should eventually
>     get rid of the blind probing logic)
And depend on BIOS-ACPI to be correct all the time? ....hahahahahaha  ...
sorry.... you hit my funny bone! ;-)
Is blind probing problematic ?
Seems like a pci-fixup/quirk can be implemented under arch/<>/pci to handle
these cases, and thus, depend on ACPI for host-bridge info... wait! did I just
say depend on ACPI?!?!   :)

>
> So we may have a try according to Bjorn's suggestions.
> Thanks!
>
>
>>
>>> It may be a good idea to ping the ACPI community to check whether ACPICA
>>> has any dependency on the MMCFG mechanism too.
>>>
>>> Thanks
>>> Gerry
>>>
>>>>
>>>>
>>>>
>>>>>
>>>>>> Yeah, that may lead to a cleaner design.
>>>>>> But there are still some special cases, such as:
>>>>>> 1) ACPI subsystem is disabled by kernel boot options, so we can't rely
>>>>>> on the ACPI pci_root driver to initialize the MMCFG.
>>>>>
>>>>> I don't think it's a requirement to make everything work with
>>>>> "acpi=off".  On a system with ACPI, running with "acpi=off" is just a
>>>>> kludge and if things work at all, it's only because we're very lucky.
>>>>>
>>>>>> 2) Some PCI host bridges are not reported by the ACPI namespace. My partner
>>>>>> has observed a system which doesn't report the host bridges embedded in the
>>>>>> NHM-EX processors.
>>>>>
>>>>> I don't think it's a requirement for Linux to use PCI devices behind
>>>>> unreported host bridges.  I'd like to pick a date and say "after BIOS
>>>>> date X, we will no longer blindly probe for these unreported host
>>>>> bridges."
>>>>>
>>>>> Bjorn
>>>>>
>>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>

