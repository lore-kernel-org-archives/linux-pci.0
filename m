Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B43BC433ED
	for <linux-pci@archiver.kernel.org>; Wed, 12 May 2021 07:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F07D61941
	for <linux-pci@archiver.kernel.org>; Wed, 12 May 2021 07:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhELHgi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 12 May 2021 03:36:38 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2714 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhELHgi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 May 2021 03:36:38 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fg62T5tp7z16Q8T;
        Wed, 12 May 2021 15:32:49 +0800 (CST)
Received: from [10.67.103.235] (10.67.103.235) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 15:35:27 +0800
Subject: Re: [PATCH V2 5/5] PCI: Enable 10-Bit tag support for PCIe RP devices
To:     Christoph Hellwig <hch@infradead.org>
References: <1620745965-91535-1-git-send-email-liudongdong3@huawei.com>
 <YJqi7M/2bg0v5HvG@infradead.org>
CC:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
From:   Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <b12f19a1-423f-0da0-48c5-f1366961325c@huawei.com>
Date:   Wed, 12 May 2021 15:35:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YJqi7M/2bg0v5HvG@infradead.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.235]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021/5/11 23:29, Christoph Hellwig wrote:
>> +	/*
>> +	 * PCIe spec 5.0r1.0 section 2.2.6.2 implementation note
>> +	 * For configurations where a Requester with 10-Bit Tag Requester capability
>> +	 * targets Completers where some do and some do not have 10-Bit Tag
>> +	 * Completer capability, how the Requester determines which NPRs include
>> +	 * 10-Bit Tags is outside the scope of this specification.  So we do not consider
>> +	 * hotplug scenario.
>> +	 */
>
> Please avoid > 80 char lines that make comments completely unreadable.
Thanks for pointing this, will fix.

Thanks,
Dongdong
> .
>
