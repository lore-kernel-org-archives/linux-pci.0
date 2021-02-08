Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6749FC433DB
	for <linux-pci@archiver.kernel.org>; Mon,  8 Feb 2021 11:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1914364D8F
	for <linux-pci@archiver.kernel.org>; Mon,  8 Feb 2021 11:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbhBHLTR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Feb 2021 06:19:17 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2523 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbhBHLQf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Feb 2021 06:16:35 -0500
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DZ3HB75hpz67lhd;
        Mon,  8 Feb 2021 19:11:02 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Feb 2021 12:15:53 +0100
Received: from [10.47.8.138] (10.47.8.138) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 8 Feb 2021
 11:15:52 +0000
Subject: Re: [Linuxarm] [PATCH v1 0/2] irqchip/gic-v3-its: don't set bitmap
 for LPI which user didn't allocate
To:     Luo Jiaxing <luojiaxing@huawei.com>, <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linuxarm@openeuler.org>
References: <1612781926-56206-1-git-send-email-luojiaxing@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <ea730f9b-c635-317d-c70d-4057590b1d1a@huawei.com>
Date:   Mon, 8 Feb 2021 11:14:19 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1612781926-56206-1-git-send-email-luojiaxing@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.8.138]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 08/02/2021 10:58, Luo Jiaxing wrote:
> When the number of online CPUs is less than 16, we found that it will fail
> to allocate 32 MSI interrupts (including 16 affinity interrupts) after the
> hisi_sas module is unloaded and then reloaded.
> 
> After analysis, it is found that a bug exists when the ITS releases
> interrupt resources, and this patch set contains a bugfix patch and a patch
> for appending debugging information.

Please note that this issue has already been reported:
https://lore.kernel.org/lkml/fd88ce05-8aee-5b1f-5ab6-be88fa53d3aa@huawei.com/

> 
> Luo Jiaxing (2):
>    irqchip/gic-v3-its: don't set bitmap for LPI which user didn't
>      allocate
>    genirq/msi: add an error print when __irq_domain_alloc_irqs() failed
> 
>   drivers/irqchip/irq-gic-v3-its.c | 4 ++++
>   kernel/irq/msi.c                 | 1 +
>   2 files changed, 5 insertions(+)
> 

