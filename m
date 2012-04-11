Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:50578 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757389Ab2DKMGN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Apr 2012 08:06:13 -0400
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 3B7343EE081
	for <linux-pci@vger.kernel.org>; Wed, 11 Apr 2012 21:06:11 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
	by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 1F4AF45DE56
	for <linux-pci@vger.kernel.org>; Wed, 11 Apr 2012 21:06:11 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
	by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 0789945DE55
	for <linux-pci@vger.kernel.org>; Wed, 11 Apr 2012 21:06:11 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id EF1E31DB8049
	for <linux-pci@vger.kernel.org>; Wed, 11 Apr 2012 21:06:10 +0900 (JST)
Received: from ml13.s.css.fujitsu.com (ml13.s.css.fujitsu.com [10.240.81.133])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id AB2C71DB8042
	for <linux-pci@vger.kernel.org>; Wed, 11 Apr 2012 21:06:10 +0900 (JST)
Message-ID: <4F8573A4.8070307@jp.fujitsu.com>
Date: Wed, 11 Apr 2012 21:05:56 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Jiang Liu <liuj97@gmail.com>, Yinghai Lu <yinghai@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH V4 0/6] PCI, x86: update MMCFG information when hot-plugging
 PCI host bridges
References: <1334103063-2283-1-git-send-email-jiang.liu@huawei.com> <CAErSpo7zWEXBhC7+gaq+BCussyKOYORaBG-PBe4ERruCAA-cfQ@mail.gmail.com>
In-Reply-To: <CAErSpo7zWEXBhC7+gaq+BCussyKOYORaBG-PBe4ERruCAA-cfQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

(2012/04/11 13:02), Bjorn Helgaas wrote:
> On Tue, Apr 10, 2012 at 6:10 PM, Jiang Liu<liuj97@gmail.com>  wrote:
>> This patchset enhance pci_root driver to update MMCFG information when
>> hot-plugging PCI root bridges. It applies to Yinghai's tree at
>> git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci-root-bus-hotplug
>>
>> The second patch is based on Taku Izumi work with some enhancements to
>> correctly handle PCI host bridges without _CBA method.
>
> I'm sorry I won't have time to really review these for a couple weeks.
>
> It always seemed wrong to me that we parse MCFG and set things up
> before we even look at PNP0A03/PNP0A08 devices.  It would make more
> sense to me to have something in acpi_pci_root_add() to set up
> MMCONFIG using _CBA if available, and falling back to parsing MCFG if
> it's not.

I think your idea could make the code (design) much cleaner.
Do you have any other reason why you think "It always seemed
wrong..."?

Regards,
Kenji Kaneshige
