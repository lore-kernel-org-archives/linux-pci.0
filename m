Return-Path: <SRS0=8ruR=SA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EACC43381
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 10:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8AE2075E
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 10:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbfC2Kmi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:42:38 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5763 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728737AbfC2Kmh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Mar 2019 06:42:37 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AB8E973CA26D6D9B9EB3;
        Fri, 29 Mar 2019 18:42:35 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Fri, 29 Mar 2019
 18:42:25 +0800
From:   John Garry <john.garry@huawei.com>
Subject: Re: [RFC PATCH v2 1/3] resource: Request IO port regions from
 children of ioport_resource
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <1553105650-28012-1-git-send-email-john.garry@huawei.com>
 <1553105650-28012-2-git-send-email-john.garry@huawei.com>
 <20190325233255.GF24180@google.com>
 <b9164269-c2a1-e0fa-4c17-2d06fb42f39b@huawei.com>
 <20190326224810.GY24180@google.com> <20190328174655.GC19825@red-moon>
CC:     <wangkefeng.wang@huawei.com>, <arnd@arndb.de>, <rafael@kernel.org>,
        <linux-pci@vger.kernel.org>, Will Deacon <will.deacon@arm.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <andy.shevchenko@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>, <bp@suse.de>,
        <linux@roeck-us.net>
Message-ID: <418943e2-19cd-f4b9-b5e1-2a49bce99b66@huawei.com>
Date:   Fri, 29 Mar 2019 10:42:17 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190328174655.GC19825@red-moon>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 28/03/2019 17:46, Lorenzo Pieralisi wrote:
> On Tue, Mar 26, 2019 at 05:48:10PM -0500, Bjorn Helgaas wrote:
>
> [...]
>

Hi Lorenzo,


>> I'm not convinced about this last sentence.
>>
>> It's true that on most modern systems, including that Intel PCH, the
>> Super I/O controller is attached via an LPC bridge on a PCI bus.
>>
>> But I don't think it's an actual requirement that PCI be involved.
>> There certainly once were systems, e.g., PC/104, that had ISA devices
>> but no PCI.  Maybe Super I/O attached via ISA is obsolete enough that
>> we don't care any more, but I really don't know.
>>
>>>> On x86, I think inb/inw/inl from a port where nothing responds
>>>> probably just returns ~0, and outb/outw/outl just get dropped.
>>>> Shouldn't arm64 do the same, without crashing?
>>>
>>> That would be ideal and we're doing something similar in patch 2/3.
>>>
>>> So on ARM64 we have to IO remap the PCI IO resource. If this mapping is not
>>> done (due to no PCI host), then any inb/inw/inl calls will crash the system.
>>
>> My take is that ARM64 is responsible for implementing inb/inw/inl in
>> such a way that they don't crash.  I don't think it's practical to
>> update all the old ISA drivers or even the core code to work around
>> that.
>
> The problem is that those drivers are accessing a resource that does not
> exist in practice, it is taken for granted on x86 systems (and on IA64)
> because that was an actual bus (actual or emulated) and was made part of
> the architecture. The ISA space is not necessarily tied to PCI,
> at least not always.
>
> Side note: these drivers can't be compiled on PPC, it would be
> good to understand why, I have a hunch it can be related.

I mentioned this earlier:

I saw that in commits like 746cdfbf01c0 ("hwmon: Avoid building drivers 
forpowerpc that read/write ISA addresses"), PPC would not build these
drivers, as, like arm, it has no native ISA.

However I still don't think just avoiding compiling these drivers for 
certain archs solves the problem.

[...]

>>>>> [1] https://www.spinics.net/lists/linux-pci/msg49821.html
>>>>
>>>> Please use a https://lore.kernel.org/ URL instead of spinics.net.
>>>
>>> ok, I hope that I can find this old thread.
>>
>> The beauty of lore.kernel.org is that the URL contains the Message-ID, so
>> it's easy build the URL and it would contain useful information even if
>> lore.kernel.org disappeared:
>>
>> https://lore.kernel.org/linux-pci/56F209A9.4040304@huawei.com
>
> Yes, the bottom line is what Arnd outlined in the thread above.
>
> ISA IO port space is not necessarily PCI but it does not exist
> architecturally on ARM systems.
>
> Taking the example of IA64, the ISA space is memory mapped (like any
> other arch except for x86) but IIUC the virtual mapping for the ISA
> port space _always_ exists on IA64 so this issue won't happen.
>
> Arnd pointed out a solution in the thread above but I need to check
> if that's feasible.

I doubt that it can work now.

Since we when introduced the concept of logical PIO space, this IO space 
became sparely populated by 2 regions - MMIO and indirect IO - so we 
cannot grow it as we map in regions. I also don't think it works for 
when we IO unmap regions.

Thanks,
John

>
> Lorenzo
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> .
>


