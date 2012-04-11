Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46989 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756224Ab2DKPem (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Apr 2012 11:34:42 -0400
Received: by pbcun15 with SMTP id un15so1362119pbc.19
        for <linux-pci@vger.kernel.org>; Wed, 11 Apr 2012 08:34:41 -0700 (PDT)
Message-ID: <4F85A481.1020807@gmail.com>
Date: Wed, 11 Apr 2012 23:34:25 +0800
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
References: <1334103063-2283-1-git-send-email-jiang.liu@huawei.com> <CAErSpo7zWEXBhC7+gaq+BCussyKOYORaBG-PBe4ERruCAA-cfQ@mail.gmail.com> <4F8573A4.8070307@jp.fujitsu.com>
In-Reply-To: <4F8573A4.8070307@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/11/2012 08:05 PM, Kenji Kaneshige wrote:
> (2012/04/11 13:02), Bjorn Helgaas wrote:
>> On Tue, Apr 10, 2012 at 6:10 PM, Jiang Liu<liuj97@gmail.com>  wrote:
>>> This patchset enhance pci_root driver to update MMCFG information when
>>> hot-plugging PCI root bridges. It applies to Yinghai's tree at
>>> git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci-root-bus-hotplug
>>>
>>> The second patch is based on Taku Izumi work with some enhancements to
>>> correctly handle PCI host bridges without _CBA method.
>>
>> I'm sorry I won't have time to really review these for a couple weeks.
>>
>> It always seemed wrong to me that we parse MCFG and set things up
>> before we even look at PNP0A03/PNP0A08 devices.  It would make more
>> sense to me to have something in acpi_pci_root_add() to set up
>> MMCONFIG using _CBA if available, and falling back to parsing MCFG if
>> it's not.
> 
> I think your idea could make the code (design) much cleaner.
> Do you have any other reason why you think "It always seemed
> wrong..."?
Yeah, that may lead to a cleaner design. 
But there are still some special cases, such as:
1) ACPI subsystem is disabled by kernel boot options, so we can't rely
on the ACPI pci_root driver to initialize the MMCFG.
2) Some PCI host bridges are not reported by the ACPI namespace. My partner
has observed a system which doesn't report the host bridges embedded in the
NHM-EX processors.

Thanks!

> 
> Regards,
> Kenji Kaneshige

