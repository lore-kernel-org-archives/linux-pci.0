Return-Path: <SRS0=/7fE=SK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B200C282DE
	for <linux-pci@archiver.kernel.org>; Mon,  8 Apr 2019 08:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46AD2208E3
	for <linux-pci@archiver.kernel.org>; Mon,  8 Apr 2019 08:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfDHIUI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:20:08 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6706 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725925AbfDHIUI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Apr 2019 04:20:08 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 45B2DC6FF5CB88AEA2CF;
        Mon,  8 Apr 2019 16:20:06 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Mon, 8 Apr 2019
 16:19:59 +0800
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
CC:     <wangkefeng.wang@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <arnd@arndb.de>, <rafael@kernel.org>, <linux-pci@vger.kernel.org>,
        <will.deacon@arm.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <andy.shevchenko@gmail.com>,
        <catalin.marinas@arm.com>, <bp@suse.de>,
        <linux-arm-kernel@lists.infradead.org>,
        Hardware Monitoring <linux-hwmon@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <ec054678-ce9e-bd5c-5225-a025214f1075@huawei.com>
Date:   Mon, 8 Apr 2019 09:19:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190405182923.GA11563@roeck-us.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 05/04/2019 19:29, Guenter Roeck wrote:
> On Fri, Apr 05, 2019 at 01:06:15PM -0500, Bjorn Helgaas wrote:
>> On Fri, Apr 05, 2019 at 09:10:27AM +0100, John Garry wrote:
>>> On 04/04/2019 19:58, Bjorn Helgaas wrote:
>>>> On Thu, Apr 04, 2019 at 10:43:36AM -0700, Guenter Roeck wrote:
>>>>> On Thu, Apr 04, 2019 at 05:52:35PM +0100, John Garry wrote:
>>>>>>>> Note that the f71805f driver does not call
>>>>>>>> request_{muxed_}region(), as it should.
>>>>>>
>>>>>>> ... which is the real problem, one that is not solved by this
>>>>>>> patch. This may result in parallel and descructive accesses if
>>>>>>> there is another device on the LPC bus, and another driver
>>>>>>> accessing that device. Personally I'd rather have
>>>>>>> request_muxed_region() added to the f71805f driver.
>>>>>>
>>>>>> Right, we should and will still fix f71805f. If you recall, I did
>>>>>> have the f71805f fix in the v1 series, but you committed that it
>>>>>> was orthogonal, so I decided to take it out of this work for now.
>>>>>>
>>>>>> And even if we fix up f71805f and other known drivers which don't
>>>>>> call request_muxed_region(), we still need to police against these
>>>>>> rogue accesses, which is what this patch attempts to do.
>>>>>>
>>>>> Do we ? I am personally not convinced that LPC accesses _have_ to
>>>>> occur through PCI on any given system.
>>>>
>>>> On current systems, I suspect ISA/LPC devices are typically connected
>>>> via a PCI-to-ISA/LPC bridge.  But AFAIK there's no actual requirement
>>>> for that bridge, and there certainly *were* systems with ISA devices
>>>> but no PCI at all.
>>>>
>>>> IMO, if you want to build ISA drivers on your arch, you need to make
>>>> sure the inb() probing done by those drivers works like it does on
>>>> x86.  If there's no device there, the inb() should return 0xff with no
>>>> fuss and no crash.
>>>
>>> Right, and this is what I am attempting to do here.
>>>
>>> So today a call to request_muxed_region() can still succeed even if no IO
>>> space mapped.
>>>
>>> As such, even well-behaved drivers like f71882fg can still crash the system,
>>> as noted in RFC patch 1/4 ("resource: Request IO port regions from children
>>> of ioport_resource").
>>
>> Maybe I'm missing something, but on x86, drivers like f71882fg do not
>> crash the system because inb() *never* causes a crash.
>>
>> If you want to build that driver for ARM, I think you need to make
>> sure that inb() on ARM also *never* causes a crash.  I don't think
>> changing f71882fg and all the similar drivers is the right answer.
>>
>
> Agreed. As I had mentioned earlier, the driver changes are orthogonal:
> the drivers should request the IO region before accessing it, primarily
> to avoid conflicting accesses by multiple drivers in parallel. For
> example, the f71882fg driver supports chips which implement hardware
> monitoring as well as watchdog functionality, and both the hwmon
> and the watchdog driver may try to access the io space.
>
> If and how the system ensures that the IO region exists and/or that
> inb() always succeeds is a different question. I would prefer a less
> complex solution than the one suggested here, but that is my personal
> opionion.

Hi Guenter,

I have a question about these super-IO accesses:

To me, it's not good that these hwmon, watchdog, gpio, etc drivers make 
unconstrained accesses to 0x2e and 0x4e ports (ignoring the 
request_muxed_region() call).

The issue I see is that on an arm, IO space for some other device may be 
mapped in this region, so it would not be right for these drivers to 
access those same regions.

Is there any other platform check which can be made to ensure that 
accesses these super-IO ports is appropriate?

Thanks,
John


>
> Guenter
>
> .
>


