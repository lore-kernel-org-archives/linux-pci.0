Return-Path: <SRS0=ivaI=RS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0707C43381
	for <linux-pci@archiver.kernel.org>; Fri, 15 Mar 2019 11:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40EE2184C
	for <linux-pci@archiver.kernel.org>; Fri, 15 Mar 2019 11:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfCOLVJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 15 Mar 2019 07:21:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5258 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726503AbfCOLVJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Mar 2019 07:21:09 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 12B394C07BCC25BC242F;
        Fri, 15 Mar 2019 19:21:03 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Fri, 15 Mar 2019
 19:20:55 +0800
Subject: Re: [RFC PATCH 2/2] hwmon: (f71805f): Use request_region() in
 f71805f_init()
To:     Guenter Roeck <linux@roeck-us.net>
References: <1552582516-70855-1-git-send-email-john.garry@huawei.com>
 <1552582516-70855-3-git-send-email-john.garry@huawei.com>
 <20190314170534.GB14159@roeck-us.net>
 <db84d2d3-cb16-7633-afeb-913096c86e8d@huawei.com>
 <20190314174408.GD14159@roeck-us.net>
CC:     <jdelvare@suse.com>, <bhelgaas@google.com>, <rafael@kernel.org>,
        <arnd@arndb.de>, <lorenzo.pieralisi@arm.com>, <bp@suse.de>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <wangkefeng.wang@huawei.com>,
        <linuxarm@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <7759ffa5-3e7b-26b0-d4d5-8fb0776d36b9@huawei.com>
Date:   Fri, 15 Mar 2019 11:20:48 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190314174408.GD14159@roeck-us.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14/03/2019 17:44, Guenter Roeck wrote:
> On Thu, Mar 14, 2019 at 05:21:32PM +0000, John Garry wrote:
>> On 14/03/2019 17:05, Guenter Roeck wrote:
>>> On Fri, Mar 15, 2019 at 12:55:16AM +0800, John Garry wrote:
>>>> Currently the driver does not call request_region() prior to
>>>> accessing IO port regions in f71805f_init(), so add it.
>>>>
>>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>>> ---
>>>> drivers/hwmon/f71805f.c | 13 ++++++++++++-
>>>> 1 file changed, 12 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/hwmon/f71805f.c b/drivers/hwmon/f71805f.c
>>>> index 73c681162653..910082c7f184 100644
>>>> --- a/drivers/hwmon/f71805f.c
>>>> +++ b/drivers/hwmon/f71805f.c
>>>> @@ -1617,10 +1617,21 @@ static int __init f71805f_init(void)
>>>> 	int err;
>>>> 	unsigned short address;
>>>> 	struct f71805f_sio_data sio_data;
>>>> +	struct resource *res;
>>>> +	size_t size = 0x4e - 0x2e + SIO_REG_ADDR + 4;
>>>> +
>>>> +	/* Request the whole 0x2e - 0x4e region */
>>>> +	res = request_region(0x2e, size, "f71805f");
>>>
>>
>> Hi Guenter,
>>
>>> request_muxed_region() would be a better choice here since it doesn't
>>> bail out immediately if the region is temporarily busy.
>>
>> Are you saying that this region could be busy due to another driver
>> accessing this same region (probably for the same purpose)?
>>

Hi Guenter,

> Depends on the definition of "same reason". To access the chip's
> Super-IO configuration registers, yes, that can happen. I don't
> see it used in the kernel today, but examples would be someone
> adding support for the chips supported by this driver to gpio-f7188x,
> or adding support for the F71872 watchdog to the f71808e_wdt driver.

OK, understood.

In terms of fixing these up, as mentioned @ 
https://www.spinics.net/lists/linux-pci/msg49843.html, there are other 
modules which have this issue. I asked Kefang today, and here's his list:

f71805f.ko
f71882fg.ko
pc87427.ko
sch56xx-common.ko
smsc47b397.ko
smsc47m1.ko

So maybe it's better to send separate patch(sets) for 1/2 and 2/2+other 
hwmon fixes - let me know your preference.

Thanks,
John

>
> Guenter
>
> .
>


