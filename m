Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56553 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753885Ab2FVKlz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jun 2012 06:41:55 -0400
Received: by dady13 with SMTP id y13so2166361dad.19
        for <linux-pci@vger.kernel.org>; Fri, 22 Jun 2012 03:41:54 -0700 (PDT)
Message-ID: <4FE44BEA.5030101@gmail.com>
Date: Fri, 22 Jun 2012 18:41:46 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
CC: Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>
Subject: Re: [PATCH 0/4] acpi, pci: hostbridge hotplug support
References: <20120621183430.2b84fb53.izumi.taku@jp.fujitsu.com> <CAE9FiQUn-NhgJkhHXFu4gMi=xzWz06hSVxUJunj25e8gH_xqBw@mail.gmail.com> <20120622192128.60b57d14.izumi.taku@jp.fujitsu.com>
In-Reply-To: <20120622192128.60b57d14.izumi.taku@jp.fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/22/2012 06:21 PM, Taku Izumi wrote:
> On Thu, 21 Jun 2012 11:18:07 -0700
> Yinghai Lu <yinghai@kernel.org> wrote:
> 
>> On Thu, Jun 21, 2012 at 2:34 AM, Taku Izumi <izumi.taku@jp.fujitsu.com> wrote:
>>>
>>>  This patchset adds basic code for host bridge hotplug.
>>>
>>>  I assume ACPI container device (ACPI0004) which carries
>>>  hostbridges will be hot-added or hot-removed. In that case
>>>  some codes are now missing for hostbridge hotplug.
>>>  This patchset mainly adds the following:
>>>   - remove hostbridge and devices under it
>>>   - resoruce-assign code for devices under hot-added hostbridge
>>>
>>>  The behavior when you don't try hostbridge hotplug should not change.
>>>
>>>  *[PATCH 1/4] acpi, pci: introduce list for acpi_pci_root drivers
>>>  *[PATCH 2/4] acpi, pci: introduce acpi_root_sem for list manipulation
>>>  *[PATCH 3/4] acpi, pci: add hostbridge removal function
>>>  *[PATCH 4/4] acpi, pci: add resoruce-assign code for devices under
>>>      hot-added hostbridge
>>
>> Hi, did you check our pci root bus hot plug branch ?
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
>> for-pci-root-bus-hotplug
>>
>> It contain some similar patches from jiang and me.
> 
>   Hi Yinghai,
>   Thank you for your comment.
> 
>   I checked your branch out. It seems to include many work.
>   Is it already scheduled to be merged to Bjorn's tree?
>   If not, should I develop based on your tree?
Hi Taku,
I think the target is to merge those changes into Bjorn gate in near future,
so it would be better to base on Yinghai's gate.
Thanks!
Gerry
