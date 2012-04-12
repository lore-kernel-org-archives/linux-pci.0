Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:62085 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933639Ab2DLAG0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Apr 2012 20:06:26 -0400
Received: by lbbgm6 with SMTP id gm6so1170426lbb.19
        for <linux-pci@vger.kernel.org>; Wed, 11 Apr 2012 17:06:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4F85A481.1020807@gmail.com>
References: <1334103063-2283-1-git-send-email-jiang.liu@huawei.com>
 <CAErSpo7zWEXBhC7+gaq+BCussyKOYORaBG-PBe4ERruCAA-cfQ@mail.gmail.com>
 <4F8573A4.8070307@jp.fujitsu.com> <4F85A481.1020807@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 11 Apr 2012 18:06:05 -0600
Message-ID: <CAErSpo4gqLBQjYf-pKsHWgZOTUTJEi0uqKxSJ5pB_F0uu+CKMA@mail.gmail.com>
Subject: Re: [PATCH V4 0/6] PCI, x86: update MMCFG information when
 hot-plugging PCI host bridges
To: Jiang Liu <liuj97@gmail.com>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 11, 2012 at 9:34 AM, Jiang Liu <liuj97@gmail.com> wrote:
> On 04/11/2012 08:05 PM, Kenji Kaneshige wrote:
>> (2012/04/11 13:02), Bjorn Helgaas wrote:
>>> On Tue, Apr 10, 2012 at 6:10 PM, Jiang Liu<liuj97@gmail.com>  wrote:
>>>> This patchset enhance pci_root driver to update MMCFG information when
>>>> hot-plugging PCI root bridges. It applies to Yinghai's tree at
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci-root-bus-hotplug
>>>>
>>>> The second patch is based on Taku Izumi work with some enhancements to
>>>> correctly handle PCI host bridges without _CBA method.
>>>
>>> I'm sorry I won't have time to really review these for a couple weeks.
>>>
>>> It always seemed wrong to me that we parse MCFG and set things up
>>> before we even look at PNP0A03/PNP0A08 devices.  It would make more
>>> sense to me to have something in acpi_pci_root_add() to set up
>>> MMCONFIG using _CBA if available, and falling back to parsing MCFG if
>>> it's not.
>>
>> I think your idea could make the code (design) much cleaner.
>> Do you have any other reason why you think "It always seemed
>> wrong..."?

The current scheme is just an ugly design.  Does I need more reasons?  :)

> Yeah, that may lead to a cleaner design.
> But there are still some special cases, such as:
> 1) ACPI subsystem is disabled by kernel boot options, so we can't rely
> on the ACPI pci_root driver to initialize the MMCFG.

I don't think it's a requirement to make everything work with
"acpi=off".  On a system with ACPI, running with "acpi=off" is just a
kludge and if things work at all, it's only because we're very lucky.

> 2) Some PCI host bridges are not reported by the ACPI namespace. My partner
> has observed a system which doesn't report the host bridges embedded in the
> NHM-EX processors.

I don't think it's a requirement for Linux to use PCI devices behind
unreported host bridges.  I'd like to pick a date and say "after BIOS
date X, we will no longer blindly probe for these unreported host
bridges."

Bjorn
