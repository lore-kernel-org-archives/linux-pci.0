Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE910C433B4
	for <linux-pci@archiver.kernel.org>; Thu, 20 May 2021 03:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDD93611AD
	for <linux-pci@archiver.kernel.org>; Thu, 20 May 2021 03:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbhETDXu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 May 2021 23:23:50 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4761 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhETDXu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 May 2021 23:23:50 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Flw1s5hfgzqV70;
        Thu, 20 May 2021 11:18:57 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 11:22:27 +0800
Received: from [127.0.0.1] (10.69.38.203) by dggema757-chm.china.huawei.com
 (10.1.198.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 20
 May 2021 11:22:27 +0800
Subject: Re: [PATCH v4 1/2] docs: perf: Add description for HiSilicon PCIe PMU
 driver
To:     John Garry <john.garry@huawei.com>, <will@kernel.org>,
        <mark.rutland@arm.com>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangshaokun@hisilicon.com>
References: <1621417741-5229-1-git-send-email-liuqi115@huawei.com>
 <1621417741-5229-2-git-send-email-liuqi115@huawei.com>
 <b6988fa7-a1e6-90c2-1c76-7795a0bc4c0a@huawei.com>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <fdee07c8-b8bb-5dd5-a01e-6b6421ad997e@huawei.com>
Date:   Thu, 20 May 2021 11:22:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <b6988fa7-a1e6-90c2-1c76-7795a0bc4c0a@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.203]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema757-chm.china.huawei.com (10.1.198.199)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Hi John,
On 2021/5/19 19:44, John Garry wrote:
> On 19/05/2021 10:49, Qi Liu wrote:
>> PCIe PMU Root Complex Integrated End Point(RCiEP) device is supported on
>> HiSilicon HIP09 platform. Document it to provide guidance on how to
>> use it.
>>
>> Signed-off-by: Qi Liu<liuqi115@huawei.com>
> 
> Reviewed-by: John Garry <john.garry@huawei.com>
> 
> JFYI, perf tool iostat support is in 5.13-rc1, so we can look to add 
> support for this HW as well in future.
> 
> My impression is that we should use metricgroups.
> 

Yes, perf iostat makes it easier for users to monitor PCIe bandwidth. 
I'll add perf iostat for HiSilicon PCIe PMU latter.

Thanks, Qi
> Thanks,
> John
> 
> .

