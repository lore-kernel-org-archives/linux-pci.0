Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60589 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535Ab2DMOeK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 Apr 2012 10:34:10 -0400
Received: by pbcun15 with SMTP id un15so3699473pbc.19
        for <linux-pci@vger.kernel.org>; Fri, 13 Apr 2012 07:34:10 -0700 (PDT)
Message-ID: <4F883956.2040200@gmail.com>
Date: Fri, 13 Apr 2012 22:33:58 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH V4 0/6] PCI, x86: update MMCFG information when hot-plugging
 PCI host bridges
References: <1334103063-2283-1-git-send-email-jiang.liu@huawei.com> <CAErSpo7zWEXBhC7+gaq+BCussyKOYORaBG-PBe4ERruCAA-cfQ@mail.gmail.com> <4F8573A4.8070307@jp.fujitsu.com> <4F85A481.1020807@gmail.com> <CAErSpo4gqLBQjYf-pKsHWgZOTUTJEi0uqKxSJ5pB_F0uu+CKMA@mail.gmail.com> <4F880482.1090903@jp.fujitsu.com>
In-Reply-To: <4F880482.1090903@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/13/2012 06:48 PM, Kenji Kaneshige wrote:
> (2012/04/12 9:06), Bjorn Helgaas wrote:
>> On Wed, Apr 11, 2012 at 9:34 AM, Jiang Liu<liuj97@gmail.com>  wrote:
>>> On 04/11/2012 08:05 PM, Kenji Kaneshige wrote:
>>>> (2012/04/11 13:02), Bjorn Helgaas wrote:
>>>>> On Tue, Apr 10, 2012 at 6:10 PM, Jiang Liu<liuj97@gmail.com>    wrote:
>>>>>> This patchset enhance pci_root driver to update MMCFG information when
>>>>>> hot-plugging PCI root bridges. It applies to Yinghai's tree at
>>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci-root-bus-hotplug
>>>>>>
>>>>>> The second patch is based on Taku Izumi work with some enhancements to
>>>>>> correctly handle PCI host bridges without _CBA method.
>>>>>
>>>>> I'm sorry I won't have time to really review these for a couple weeks.
>>>>>
>>>>> It always seemed wrong to me that we parse MCFG and set things up
>>>>> before we even look at PNP0A03/PNP0A08 devices.  It would make more
>>>>> sense to me to have something in acpi_pci_root_add() to set up
>>>>> MMCONFIG using _CBA if available, and falling back to parsing MCFG if
>>>>> it's not.
>>>>
>>>> I think your idea could make the code (design) much cleaner.
>>>> Do you have any other reason why you think "It always seemed
>>>> wrong..."?
>>
>> The current scheme is just an ugly design.  Does I need more reasons?  :)
> 
> Ok, I just wanted to know if I'm missing anything we need to
> take into account when re-factoring the code.
> 
> By the way, the following code makes me think there could be
> some hardwares that need a fixup using mmconfig access before
> scanning the PCI tree. If this is the case, we would need
> something to enable early mmconfig initialization for those
> hardwares.
> 
> static __init int pci_arch_init(void)
> {
>     ...
>         if (!(pci_probe & PCI_PROBE_NOEARLY))
>                 pci_mmcfg_early_init();
> 
> 
> Regards,
> Kenji Kaneshige

If MMCFG could be treated as an optional configuration space access method,
we can refine the MMCFG code according to Bjorn's suggestion. And as Kenji
has mentioned, there may be some risks ahead. So need more confirmation
from other PCI experts here.

It may be a good idea to ping the ACPI community to check whether ACPICA
has any dependency on the MMCFG mechanism too.

Thanks
Gerry

> 
> 
> 
>>
>>> Yeah, that may lead to a cleaner design.
>>> But there are still some special cases, such as:
>>> 1) ACPI subsystem is disabled by kernel boot options, so we can't rely
>>> on the ACPI pci_root driver to initialize the MMCFG.
>>
>> I don't think it's a requirement to make everything work with
>> "acpi=off".  On a system with ACPI, running with "acpi=off" is just a
>> kludge and if things work at all, it's only because we're very lucky.
>>
>>> 2) Some PCI host bridges are not reported by the ACPI namespace. My partner
>>> has observed a system which doesn't report the host bridges embedded in the
>>> NHM-EX processors.
>>
>> I don't think it's a requirement for Linux to use PCI devices behind
>> unreported host bridges.  I'd like to pick a date and say "after BIOS
>> date X, we will no longer blindly probe for these unreported host
>> bridges."
>>
>> Bjorn
>>
> 

