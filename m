Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DDBC433E0
	for <linux-pci@archiver.kernel.org>; Tue, 23 Mar 2021 08:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC4E6619B9
	for <linux-pci@archiver.kernel.org>; Tue, 23 Mar 2021 08:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhCWIOq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Mar 2021 04:14:46 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14012 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhCWIOR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Mar 2021 04:14:17 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F4PH00ggbzrTb9;
        Tue, 23 Mar 2021 16:12:12 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.117) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Tue, 23 Mar 2021
 16:14:03 +0800
Subject: Re: [PATCH] pci: fix memory leak when virtio pci hotplug
To:     Wu Bo <wubo40@huawei.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <bhelgaas@google.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, linfeilong <linfeilong@huawei.com>
References: <c48998b7-5308-e196-66b5-905fc8c4edc4@huawei.com>
 <768d4a60-7442-fbdd-9c00-cc927a54d340@huawei.com>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <fc38cd3b-9e48-6787-afe6-1c991a7186ca@huawei.com>
Date:   Tue, 23 Mar 2021 16:14:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <768d4a60-7442-fbdd-9c00-cc927a54d340@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

friendly ping..

On 2021/3/22 10:43, Wu Bo wrote:
> On 2021/3/21 23:29, Zhiqiang Liu wrote:
>> From: Feilong Lin <linfeilong@huawei.com>
>>
>> Repeated hot-plugging of pci devices for a virtual
>> machine driven by virtio, we found that there is a
>> leak in kmalloc-4k, which was confirmed as the memory
>> of the pci_device structure. Then we found out that
>> it was missing pci_dev_put() after pci_get_slot() in
>> enable_slot() of acpiphp_glue.c.
>>
>> Signed-off-by: Feilong Lin <linfeilong@huawei.com>
>> Reviewed-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
>> ---
>>   drivers/pci/hotplug/acpiphp_glue.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
>> index 3365c93abf0e..f031302ad401 100644
>> --- a/drivers/pci/hotplug/acpiphp_glue.c
>> +++ b/drivers/pci/hotplug/acpiphp_glue.c
>> @@ -533,6 +533,7 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
>>               slot->flags &= ~SLOT_ENABLED;
>>               continue;
>>           }
>> +        pci_dev_put(dev);
>>       }
>>   }
>>
> Reviewed-by: Wu Bo <wubo40@huawei.com>
>
> .

