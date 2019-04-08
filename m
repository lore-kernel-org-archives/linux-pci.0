Return-Path: <SRS0=/7fE=SK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1598DC282CE
	for <linux-pci@archiver.kernel.org>; Mon,  8 Apr 2019 16:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1EE2087F
	for <linux-pci@archiver.kernel.org>; Mon,  8 Apr 2019 16:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfDHQgM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:36:12 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6712 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726383AbfDHQgM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Apr 2019 12:36:12 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 49DD39514EBCBB9798D0;
        Tue,  9 Apr 2019 00:36:07 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Tue, 9 Apr 2019
 00:36:00 +0800
Subject: Re: [PATCH v3 3/4] lib: logic_pio: Reject accesses to unregistered
 CPU MMIO regions
To:     Guenter Roeck <linux@roeck-us.net>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <1554393602-152448-1-git-send-email-john.garry@huawei.com>
 <1554393602-152448-4-git-send-email-john.garry@huawei.com>
 <20190404164130.GA12203@roeck-us.net>
 <24cc8006-0f0d-6b20-a466-e4a32a0bb656@huawei.com>
 <20190404174336.GA10404@roeck-us.net> <20190404185815.GA26522@google.com>
 <2d0f583a-cabe-df4e-ad89-c1800d9b4804@huawei.com>
 <20190405180615.GB109021@google.com> <20190405182923.GA11563@roeck-us.net>
 <ec054678-ce9e-bd5c-5225-a025214f1075@huawei.com>
 <9be8d131-d1d5-cc97-26fe-e32fe30c0544@roeck-us.net>
CC:     Hardware Monitoring <linux-hwmon@vger.kernel.org>,
        <wangkefeng.wang@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <arnd@arndb.de>, <rafael@kernel.org>, <linux-pci@vger.kernel.org>,
        <will.deacon@arm.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <andy.shevchenko@gmail.com>,
        <catalin.marinas@arm.com>, <bp@suse.de>,
        <linux-arm-kernel@lists.infradead.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <efff6e58-b48d-f168-ed92-1714f5a08292@huawei.com>
Date:   Mon, 8 Apr 2019 17:35:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <9be8d131-d1d5-cc97-26fe-e32fe30c0544@roeck-us.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 08/04/2019 14:47, Guenter Roeck wrote:
>>>>> FC patch 1/4 ("resource: Request IO port regions from children
>>>>> of ioport_resource").
>>>>
>>>> Maybe I'm missing something, but on x86, drivers like f71882fg do not
>>>> crash the system because inb() *never* causes a crash.
>>>>
>>>> If you want to build that driver for ARM, I think you need to make
>>>> sure that inb() on ARM also *never* causes a crash.  I don't think
>>>> changing f71882fg and all the similar drivers is the right answer.
>>>>
>>>
>>> Agreed. As I had mentioned earlier, the driver changes are orthogonal:
>>> the drivers should request the IO region before accessing it, primarily
>>> to avoid conflicting accesses by multiple drivers in parallel. For
>>> example, the f71882fg driver supports chips which implement hardware
>>> monitoring as well as watchdog functionality, and both the hwmon
>>> and the watchdog driver may try to access the io space.
>>>
>>> If and how the system ensures that the IO region exists and/or that
>>> inb() always succeeds is a different question. I would prefer a less
>>> complex solution than the one suggested here, but that is my personal
>>> opionion.
>>
>> Hi Guenter,
>>
>> I have a question about these super-IO accesses:
>>
>> To me, it's not good that these hwmon, watchdog, gpio, etc drivers
>> make unconstrained accesses to 0x2e and 0x4e ports (ignoring the
>> request_muxed_region() call).
>>
>> The issue I see is that on an arm, IO space for some other device may
>> be mapped in this region, so it would not be right for these drivers
>> to access those same regions.
>>
> Yes, but then there _could_ be some arm or arm64 device supporting one
> of those chips,
> so we can not just add something like "depends on !(ARM || ARM64)".

This looks like what has been added for PPC in commmit 746cdfbf01c0.

However, agreed, it's not a good approach.

>
>> Is there any other platform check which can be made to ensure that
>> accesses these super-IO ports is appropriate?
>>
>
> Not that I know of. It would make some sense to provide API functions
> for Super-IO accesses, but that would be a lot of work, and I guess
> it isn't really valuable enough for anyone to pick up and do.
>
> Normally, if you have such a system, the respective drivers should not be
> built. After all, this isn't the only instance where drivers
> unconditionally
> access some io region, no matter if the underlying hardware exists or not.
> The only real defense against that is to not build those drivers into
> a given kernel.

If we're going to support a multi-plaform kernel for a given arch, then 
we can't always avoid it.

It seems that the only solution on the table now is to discard these IO 
port accesses on arm64 when the IO port are not mapped.

Thanks again,
John

>
> Guenter
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> .


