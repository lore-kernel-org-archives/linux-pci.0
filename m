Return-Path: <SRS0=ivaI=RS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0101EC10F00
	for <linux-pci@archiver.kernel.org>; Fri, 15 Mar 2019 12:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2AAA218A1
	for <linux-pci@archiver.kernel.org>; Fri, 15 Mar 2019 12:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oYeCcZgz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbfCOM6X (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 15 Mar 2019 08:58:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36876 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfCOM6X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Mar 2019 08:58:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id 8so2897138pfr.4;
        Fri, 15 Mar 2019 05:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YYHUJSeVSKoF+aLnw0ZfVLEeQtwLXFfiZu9+xmGZPDk=;
        b=oYeCcZgzxY/h9iGLXGjGvFZpptqM9b9+cd0thLKGqTfC1zrRiNf/b47wxFhKeCmkER
         JYjGE7IDkJhdkssKS+4lqIahxRW7AkS7jcKSqrd9TInxIFS7tB3Ke1kcePWfCUawgSW0
         eZztcEJSVfbYUxi8b8eGjmfh+2e781oRS3TUCfjGicrU5sYhjzqvG3+g33hsqf3rSHyU
         dWl2CQD0V18smasPQOPku5qA3BiToHW76MCV2TAhjwQDdBPXkWEU423QU5dWJekxjS44
         etYf6awLEwtBQICY7xhkrtCpcci9eKiNeBbUmT+yzrmAtGF+LauFr075H1th7Px41MmR
         7X3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YYHUJSeVSKoF+aLnw0ZfVLEeQtwLXFfiZu9+xmGZPDk=;
        b=NrVLaXgXlXc/QFsKzqwPJrteqh94sQuk7jOog4+n1bagvRt+Zl7BWdGHjcOMCXooAD
         ESuUMwnuNHj4nMDx3x4JDNkE8veaSzci7V8bd+B4Q2U2oqZGmJPsejrsTUwICFfec1yA
         FDbW2s0p7VAY8pstvqcSd3NLsFCptWUSbP1r7+xsJG3JG/NirWO5MKOWwgdwJEaRTKvw
         V4cwduO6wK4nXunxy4MsVfyougBGQnCEyZDJFY2Ivq9gKkNXmdvOAGL9PPLWDLqJY69f
         eMk+KvGQM2zI9eowbZo9O7RbuDRSAt3sdfh3RXKYZFyHqpn/IbFQNAliEUk7WvQFXmgs
         3eFA==
X-Gm-Message-State: APjAAAUWVBhKiKkBui6mGieGk3Klb58ku3BjdFPaqdKjiywAeqUFwZ04
        3vvHlNbe5n/3zRQQiKcKz7k=
X-Google-Smtp-Source: APXvYqxWg4YgZRPgvWH80DVQkCZXErmy+RtwAmUG17SDBgcFFGsFrRBzZ7TqY1ZOIjqxPvfSet5fzg==
X-Received: by 2002:a65:5cc4:: with SMTP id b4mr3355410pgt.334.1552654702089;
        Fri, 15 Mar 2019 05:58:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 195sm2709568pfc.50.2019.03.15.05.58.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 05:58:20 -0700 (PDT)
Subject: Re: [RFC PATCH 2/2] hwmon: (f71805f): Use request_region() in
 f71805f_init()
To:     John Garry <john.garry@huawei.com>
Cc:     jdelvare@suse.com, bhelgaas@google.com, rafael@kernel.org,
        arnd@arndb.de, lorenzo.pieralisi@arm.com, bp@suse.de,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, wangkefeng.wang@huawei.com,
        linuxarm@huawei.com
References: <1552582516-70855-1-git-send-email-john.garry@huawei.com>
 <1552582516-70855-3-git-send-email-john.garry@huawei.com>
 <20190314170534.GB14159@roeck-us.net>
 <db84d2d3-cb16-7633-afeb-913096c86e8d@huawei.com>
 <20190314174408.GD14159@roeck-us.net>
 <7759ffa5-3e7b-26b0-d4d5-8fb0776d36b9@huawei.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <5d3e06ab-5a5f-6193-3539-0c8c9c581565@roeck-us.net>
Date:   Fri, 15 Mar 2019 05:58:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <7759ffa5-3e7b-26b0-d4d5-8fb0776d36b9@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/15/19 4:20 AM, John Garry wrote:
> On 14/03/2019 17:44, Guenter Roeck wrote:
>> On Thu, Mar 14, 2019 at 05:21:32PM +0000, John Garry wrote:
>>> On 14/03/2019 17:05, Guenter Roeck wrote:
>>>> On Fri, Mar 15, 2019 at 12:55:16AM +0800, John Garry wrote:
>>>>> Currently the driver does not call request_region() prior to
>>>>> accessing IO port regions in f71805f_init(), so add it.
>>>>>
>>>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>>>> ---
>>>>> drivers/hwmon/f71805f.c | 13 ++++++++++++-
>>>>> 1 file changed, 12 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/hwmon/f71805f.c b/drivers/hwmon/f71805f.c
>>>>> index 73c681162653..910082c7f184 100644
>>>>> --- a/drivers/hwmon/f71805f.c
>>>>> +++ b/drivers/hwmon/f71805f.c
>>>>> @@ -1617,10 +1617,21 @@ static int __init f71805f_init(void)
>>>>>     int err;
>>>>>     unsigned short address;
>>>>>     struct f71805f_sio_data sio_data;
>>>>> +    struct resource *res;
>>>>> +    size_t size = 0x4e - 0x2e + SIO_REG_ADDR + 4;
>>>>> +
>>>>> +    /* Request the whole 0x2e - 0x4e region */
>>>>> +    res = request_region(0x2e, size, "f71805f");
>>>>
>>>
>>> Hi Guenter,
>>>
>>>> request_muxed_region() would be a better choice here since it doesn't
>>>> bail out immediately if the region is temporarily busy.
>>>
>>> Are you saying that this region could be busy due to another driver
>>> accessing this same region (probably for the same purpose)?
>>>
> 
> Hi Guenter,
> 
>> Depends on the definition of "same reason". To access the chip's
>> Super-IO configuration registers, yes, that can happen. I don't
>> see it used in the kernel today, but examples would be someone
>> adding support for the chips supported by this driver to gpio-f7188x,
>> or adding support for the F71872 watchdog to the f71808e_wdt driver.
> 
> OK, understood.
> 
> In terms of fixing these up, as mentioned @ https://www.spinics.net/lists/linux-pci/msg49843.html, there are other modules which have this issue. I asked Kefang today, and here's his list:
> 
> f71805f.ko
> f71882fg.ko
> pc87427.ko
> sch56xx-common.ko
> smsc47b397.ko
> smsc47m1.ko
> 
> So maybe it's better to send separate patch(sets) for 1/2 and 2/2+other hwmon fixes - let me know your preference.
> 

One patch per file, please.

Thanks,
Guenter

> Thanks,
> John
> 
>>
>> Guenter
>>
>> .
>>
> 
> 
> 

