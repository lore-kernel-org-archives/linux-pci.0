Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090D3ECE561
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 08:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B5921529
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 08:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6B5921529
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731320AbeITOaE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 10:30:04 -0400
Received: from smtp17.cstnet.cn ([159.226.251.17]:52616 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731487AbeITOaE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Sep 2018 10:30:04 -0400
Received: from [172.20.20.131] (unknown [182.150.46.145])
        by APP-09 (Coremail) with SMTP id swCowAAX+OybXqNbMfJ5Cw--.29835S2;
        Thu, 20 Sep 2018 16:47:24 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
Subject: Re: [LKP] [x86/pci] 7ffb31888c: PANIC:early_exception
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, helgaas@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, lkp@01.org
References: <20180919031923.GC8820@shao2-debian>
 <4f5166f8-97b8-a58f-3e5d-19d1751a4601@hygon.cn>
 <dfc09a36-cfc5-0479-a862-696c224f9a19@intel.com>
Message-ID: <7e9e862a-e890-775f-ed92-74c591c7deb6@hygon.cn>
Date:   Thu, 20 Sep 2018 16:47:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <dfc09a36-cfc5-0479-a862-696c224f9a19@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: swCowAAX+OybXqNbMfJ5Cw--.29835S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKF1kGF4DCr18tw18Cw4fAFb_yoW3uFgEgr
        Wq9asxKan3Z34DGF18Kr4rJF47K3WFv34fGrn5t3W2y34kJ34ktr409r12kw1UJa1rCr13
        Ww40v3W0yF1DtjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb38YjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z2
        80aVCY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4UJVWxJr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
        Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjxU78u4UUUUU
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2018/9/20 8:26, Rong Chen wrote:
> On 09/19/2018 09:53 PM, Pu Wen wrote:
>> I cannot reproduce this panic on Hygon Dhyana platform. I tired lkp-tests
>> both in Ubuntu 16.04 (with gcc-5) and Ubuntu 18.04 (with gcc-7).
>> What kind of host do you use to run the qemu? A Intel one or AMD one?
> It's a Intel one,
> 
> model: Nehalem-EX
> memory: 224G
> nr_node: 4
> nr_cpu: 64
> nr_socket: 4
> brand: Intel(R) Xeon(R) CPU X7560 @ 2.27GHz

I reproduced the PANIC by running lkp-tests with a Intel machine.

The reason is that the function early_is_amd_nb is called even if
running on Intel machine. At this case the misc_ids is NULL so the
PANIC occur.

I'll rework a patch to solve this problem, either restore the default
value of misc_ids with the original AMD one or not call early_is_amd_nb
on Intel platform.

-- 
Regards,
Pu Wen

