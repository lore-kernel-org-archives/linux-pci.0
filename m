Return-Path: <SRS0=4r0Q=UN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9278C31E44
	for <linux-pci@archiver.kernel.org>; Fri, 14 Jun 2019 09:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABECF21721
	for <linux-pci@archiver.kernel.org>; Fri, 14 Jun 2019 09:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfFNJGu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 Jun 2019 05:06:50 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18571 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725985AbfFNJGu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Jun 2019 05:06:50 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9E9CFE521DB502BA74A4;
        Fri, 14 Jun 2019 17:03:05 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Fri, 14 Jun 2019
 17:02:59 +0800
Subject: Re: [PATCH v4 1/3] lib: logic_pio: Use logical PIO low-level
 accessors for !CONFIG_INDIRECT_PIO
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <1560262374-67875-1-git-send-email-john.garry@huawei.com>
 <1560262374-67875-2-git-send-email-john.garry@huawei.com>
 <20190613023947.GD13533@google.com>
 <8ef228f8-97cb-e40e-ea6b-410b80a845cf@huawei.com>
 <20190613200932.GJ13533@google.com>
CC:     <lorenzo.pieralisi@arm.com>, <arnd@arndb.de>,
        <linux-pci@vger.kernel.org>, <rjw@rjwysocki.net>,
        <linux-arm-kernel@lists.infradead.org>, <will.deacon@arm.com>,
        <wangkefeng.wang@huawei.com>, <linuxarm@huawei.com>,
        <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <catalin.marinas@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <7495dcab-f293-4b2a-4740-2249f61351f7@huawei.com>
Date:   Fri, 14 Jun 2019 10:02:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190613200932.GJ13533@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 13/06/2019 21:09, Bjorn Helgaas wrote:
> On Thu, Jun 13, 2019 at 10:39:12AM +0100, John Garry wrote:
>> On 13/06/2019 03:39, Bjorn Helgaas wrote:
>>> I'm not sure it's even safe, because CONFIG_INDIRECT_PIO depends on
>>> ARM64,  but PCI_IOBASE is defined on most arches via asm-generic/io.h,
>>> so this potentially affects arches other than ARM64.
>>
>> It would do. It would affect any arch which defines PCI_IOBASE and
>> does not have arch-specific definition of inb et all.
>

Hi Bjorn,

> What's the reason for testing PCI_IOBASE instead of
> CONFIG_INDIRECT_PIO?  If there's a reason it's needed, that's fine,
> but it does make this much more complicated to review.

For ARM64, we have PCI_IOBASE defined but may not have 
CONFIG_INDIRECT_PIO defined. Currently CONFIG_INDIRECT_PIO is only 
selected by CONFIG_HISILICON_LPC.

As such, we should make this change also for when CONFIG_INDIRECT_PIO is 
not defined.

Thanks,
John

>
> Bjorn
>
> .
>


