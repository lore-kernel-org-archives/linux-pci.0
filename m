Return-Path: <SRS0=l472=MF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD412ECE562
	for <linux-pci@archiver.kernel.org>; Sun, 23 Sep 2018 10:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B43F214DC
	for <linux-pci@archiver.kernel.org>; Sun, 23 Sep 2018 10:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B43F214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbeIWQCY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 23 Sep 2018 12:02:24 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21]:53710 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726066AbeIWQCX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Sep 2018 12:02:23 -0400
Received: from [172.20.20.131] (unknown [182.150.46.145])
        by APP-01 (Coremail) with SMTP id qwCowACHj79SZadbjPG0DA--.8659S2;
        Sun, 23 Sep 2018 18:05:07 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
Subject: Re: [LKP] [x86/pci] 7ffb31888c: PANIC:early_exception
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Rong Chen <rong.a.chen@intel.com>, bp@alien8.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com,
        helgaas@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-pci@vger.kernel.org, lkp@01.org
References: <20180919031923.GC8820@shao2-debian>
 <4f5166f8-97b8-a58f-3e5d-19d1751a4601@hygon.cn>
 <dfc09a36-cfc5-0479-a862-696c224f9a19@intel.com>
 <7e9e862a-e890-775f-ed92-74c591c7deb6@hygon.cn>
 <alpine.DEB.2.21.1809201138230.3243@nanos.tec.linutronix.de>
Message-ID: <17475050-594c-0037-52d4-25bb631da141@hygon.cn>
Date:   Sun, 23 Sep 2018 18:05:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1809201138230.3243@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: qwCowACHj79SZadbjPG0DA--.8659S2
X-Coremail-Antispam: 1UD129KBjvdXoW5Kr48Cryktw4DWF4kuF18AFb_yoWxWwcEg3
        yqk39rGwnxurn2krs5Kr1ayFWIgF4Sva4fJrWkGan3Cryrt3ykWr1YgryI934xXa1kWrnI
        9ay5CF1xGwn2gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb38YjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z2
        80aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
        c7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF
        0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWI
        evJa73UjIFyTuYvjxU4o7KUUUUU
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2018/9/20 17:39, Thomas Gleixner wrote:
>> I reproduced the PANIC by running lkp-tests with a Intel machine.
>>
>> The reason is that the function early_is_amd_nb is called even if
>> running on Intel machine. At this case the misc_ids is NULL so the
>> PANIC occur.
>>
>> I'll rework a patch to solve this problem, either restore the default
>> value of misc_ids with the original AMD one or not call early_is_amd_nb
>> on Intel platform.
> 
> Return when !AMD and !HYGON is the right thing to do. No point in checking
> device ids which cannot happen in the first place.

All right, I reworked a new reversion which will return if it's Intel.

Thanks,
Pu Wen

