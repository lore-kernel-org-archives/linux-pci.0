Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:49869 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046Ab2DMKsu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 Apr 2012 06:48:50 -0400
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id DD7993EE0B6
	for <linux-pci@vger.kernel.org>; Fri, 13 Apr 2012 19:48:48 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
	by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id C73B745DE4F
	for <linux-pci@vger.kernel.org>; Fri, 13 Apr 2012 19:48:48 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
	by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 99F4C45DE50
	for <linux-pci@vger.kernel.org>; Fri, 13 Apr 2012 19:48:48 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 8D9581DB802F
	for <linux-pci@vger.kernel.org>; Fri, 13 Apr 2012 19:48:48 +0900 (JST)
Received: from m105.s.css.fujitsu.com (m105.s.css.fujitsu.com [10.240.81.145])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 301AD1DB8037
	for <linux-pci@vger.kernel.org>; Fri, 13 Apr 2012 19:48:48 +0900 (JST)
Message-ID: <4F880482.1090903@jp.fujitsu.com>
Date: Fri, 13 Apr 2012 19:48:34 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Jiang Liu <liuj97@gmail.com>, Yinghai Lu <yinghai@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH V4 0/6] PCI, x86: update MMCFG information when hot-plugging
 PCI host bridges
References: <1334103063-2283-1-git-send-email-jiang.liu@huawei.com> <CAErSpo7zWEXBhC7+gaq+BCussyKOYORaBG-PBe4ERruCAA-cfQ@mail.gmail.com> <4F8573A4.8070307@jp.fujitsu.com> <4F85A481.1020807@gmail.com> <CAErSpo4gqLBQjYf-pKsHWgZOTUTJEi0uqKxSJ5pB_F0uu+CKMA@mail.gmail.com>
In-Reply-To: <CAErSpo4gqLBQjYf-pKsHWgZOTUTJEi0uqKxSJ5pB_F0uu+CKMA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

(2012/04/12 9:06), Bjorn Helgaas wrote:
> On Wed, Apr 11, 2012 at 9:34 AM, Jiang Liu<liuj97@gmail.com>  wrote:
>> On 04/11/2012 08:05 PM, Kenji Kaneshige wrote:
>>> (2012/04/11 13:02), Bjorn Helgaas wrote:
>>>> On Tue, Apr 10, 2012 at 6:10 PM, Jiang Liu<liuj97@gmail.com>    wrote:
>>>>> This patchset enhance pci_root driver to update MMCFG information when
>>>>> hot-plugging PCI root bridges. It applies to Yinghai's tree at
>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci-root-bus-hotplug
>>>>>
>>>>> The second patch is based on Taku Izumi work with some enhancements to
>>>>> correctly handle PCI host bridges without _CBA method.
>>>>
>>>> I'm sorry I won't have time to really review these for a couple weeks.
>>>>
>>>> It always seemed wrong to me that we parse MCFG and set things up
>>>> before we even look at PNP0A03/PNP0A08 devices.  It would make more
>>>> sense to me to have something in acpi_pci_root_add() to set up
>>>> MMCONFIG using _CBA if available, and falling back to parsing MCFG if
>>>> it's not.
>>>
>>> I think your idea could make the code (design) much cleaner.
>>> Do you have any other reason why you think "It always seemed
>>> wrong..."?
>
> The current scheme is just an ugly design.  Does I need more reasons?  :)

Ok, I just wanted to know if I'm missing anything we need to
take into account when re-factoring the code.

By the way, the following code makes me think there could be
some hardwares that need a fixup using mmconfig access before
scanning the PCI tree. If this is the case, we would need
something to enable early mmconfig initialization for those
hardwares.

static __init int pci_arch_init(void)
{
	...
         if (!(pci_probe & PCI_PROBE_NOEARLY))
                 pci_mmcfg_early_init();


Regards,
Kenji Kaneshige



>
>> Yeah, that may lead to a cleaner design.
>> But there are still some special cases, such as:
>> 1) ACPI subsystem is disabled by kernel boot options, so we can't rely
>> on the ACPI pci_root driver to initialize the MMCFG.
>
> I don't think it's a requirement to make everything work with
> "acpi=off".  On a system with ACPI, running with "acpi=off" is just a
> kludge and if things work at all, it's only because we're very lucky.
>
>> 2) Some PCI host bridges are not reported by the ACPI namespace. My partner
>> has observed a system which doesn't report the host bridges embedded in the
>> NHM-EX processors.
>
> I don't think it's a requirement for Linux to use PCI devices behind
> unreported host bridges.  I'd like to pick a date and say "after BIOS
> date X, we will no longer blindly probe for these unreported host
> bridges."
>
> Bjorn
>

