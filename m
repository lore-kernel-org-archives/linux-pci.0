Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BE4C433DB
	for <linux-pci@archiver.kernel.org>; Wed, 10 Feb 2021 09:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ACEF64E2F
	for <linux-pci@archiver.kernel.org>; Wed, 10 Feb 2021 09:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhBJJcW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Feb 2021 04:32:22 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:12907 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhBJJaO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Feb 2021 04:30:14 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DbDvm0bn8zjK07;
        Wed, 10 Feb 2021 17:28:20 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.196) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Wed, 10 Feb 2021
 17:29:18 +0800
Subject: Re: [Linuxarm] Re: [PATCH] PCI: Use subdir-ccflags-* to inherit debug
 flag
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
CC:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <prime.zeng@huawei.com>, <linuxarm@openeuler.org>
References: <1612438215-33105-1-git-send-email-yangyicong@hisilicon.com>
 <YBvoauS9WagVizdh@rocinante>
 <3171ed82-c114-2298-1c03-f7c854fb15c0@hisilicon.com>
 <YCKN0+wsH/W2lZ+Q@rocinante>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <313c711f-ab0f-b0ec-cfee-8bb65bdfee03@hisilicon.com>
Date:   Wed, 10 Feb 2021 17:29:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <YCKN0+wsH/W2lZ+Q@rocinante>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.38.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021/2/9 21:27, Krzysztof Wilczyński wrote:
> Hi Yicong,
> 
> [...]
>>> By the way, did you have some issues with things like pr_debug() and other
>>> things printing debug information not working correctly before?
>>
>> i cannot remember that i have met any, so maybe they work properly. :)
> [...]
> 
> That's good to know!  I suspect, some of the pr_debug() invocations
> might not be working correctly at the moment, so this is a nice
> improvement.
> 
> Having said that, if you have some time, can you update the patch
> against the PCI tree with the commit message from this thread?
> 
>   https://lore.kernel.org/lkml/1612868899-9185-1-git-send-email-yangyicong@hisilicon.com/
> 
> The commit messages there for the individual patches are much nicer, so
> if you don't mind, it would be nice have the same one in the PCI tree.
> 
> My review still applies.
> 
> Thank you again for sending the patch over!

Bjorn has applied this with nicer commit. Thanks for reviewing this. :)

Regards,
Yicong

> 
> Krzysztof
> _______________________________________________
> Linuxarm mailing list -- linuxarm@openeuler.org
> To unsubscribe send an email to linuxarm-leave@openeuler.org
> 

