Return-Path: <SRS0=e3W/=SH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85FFC4360F
	for <linux-pci@archiver.kernel.org>; Fri,  5 Apr 2019 08:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895A12175B
	for <linux-pci@archiver.kernel.org>; Fri,  5 Apr 2019 08:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfDEIKq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 5 Apr 2019 04:10:46 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5672 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725955AbfDEIKq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Apr 2019 04:10:46 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DC704323CCF8F62B0DB1;
        Fri,  5 Apr 2019 16:10:43 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Fri, 5 Apr 2019
 16:10:35 +0800
Subject: Re: [PATCH v3 3/4] lib: logic_pio: Reject accesses to unregistered
 CPU MMIO regions
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
References: <1554393602-152448-1-git-send-email-john.garry@huawei.com>
 <1554393602-152448-4-git-send-email-john.garry@huawei.com>
 <20190404164130.GA12203@roeck-us.net>
 <24cc8006-0f0d-6b20-a466-e4a32a0bb656@huawei.com>
 <20190404174336.GA10404@roeck-us.net> <20190404185815.GA26522@google.com>
CC:     <wangkefeng.wang@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <arnd@arndb.de>, <rafael@kernel.org>, <linux-pci@vger.kernel.org>,
        <will.deacon@arm.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <andy.shevchenko@gmail.com>,
        <catalin.marinas@arm.com>, <bp@suse.de>,
        <linux-arm-kernel@lists.infradead.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <2d0f583a-cabe-df4e-ad89-c1800d9b4804@huawei.com>
Date:   Fri, 5 Apr 2019 09:10:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190404185815.GA26522@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 04/04/2019 19:58, Bjorn Helgaas wrote:
> On Thu, Apr 04, 2019 at 10:43:36AM -0700, Guenter Roeck wrote:
>> On Thu, Apr 04, 2019 at 05:52:35PM +0100, John Garry wrote:
>>>>> Note that the f71805f driver does not call
>>>>> request_{muxed_}region(), as it should.
>>>
>>>> ... which is the real problem, one that is not solved by this
>>>> patch. This may result in parallel and descructive accesses if
>>>> there is another device on the LPC bus, and another driver
>>>> accessing that device. Personally I'd rather have
>>>> request_muxed_region() added to the f71805f driver.
>>>
>>> Right, we should and will still fix f71805f. If you recall, I did
>>> have the f71805f fix in the v1 series, but you committed that it
>>> was orthogonal, so I decided to take it out of this work for now.
>>>
>>> And even if we fix up f71805f and other known drivers which don't
>>> call request_muxed_region(), we still need to police against these
>>> rogue accesses, which is what this patch attempts to do.
>>>
>> Do we ? I am personally not convinced that LPC accesses _have_ to
>> occur through PCI on any given system.
>
> On current systems, I suspect ISA/LPC devices are typically connected
> via a PCI-to-ISA/LPC bridge.  But AFAIK there's no actual requirement
> for that bridge, and there certainly *were* systems with ISA devices
> but no PCI at all.
>
> IMO, if you want to build ISA drivers on your arch, you need to make
> sure the inb() probing done by those drivers works like it does on
> x86.  If there's no device there, the inb() should return 0xff with no
> fuss and no crash.

Right, and this is what I am attempting to do here.

So today a call to request_muxed_region() can still succeed even if no 
IO space mapped.

As such, even well-behaved drivers like f71882fg can still crash the 
system, as noted in RFC patch 1/4 ("resource: Request IO port regions 
from children of ioport_resource").

Thanks,
John

>
> Bjorn
>
> .
>


