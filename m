Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93545C433B4
	for <linux-pci@archiver.kernel.org>; Wed, 12 May 2021 07:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C2916192B
	for <linux-pci@archiver.kernel.org>; Wed, 12 May 2021 07:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhELHaP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 12 May 2021 03:30:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2636 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhELHaP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 May 2021 03:30:15 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fg5tH6RkVzQlRn;
        Wed, 12 May 2021 15:25:43 +0800 (CST)
Received: from [10.67.103.235] (10.67.103.235) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 15:29:03 +0800
Subject: Re: [PATCH V2 1/5] PCI: Use cached Device Capabilities 2 Register
To:     Christoph Hellwig <hch@infradead.org>
References: <1620745744-91316-1-git-send-email-liudongdong3@huawei.com>
 <1620745744-91316-2-git-send-email-liudongdong3@huawei.com>
 <YJqiEAoxcCkVAEsK@infradead.org>
CC:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
From:   Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <9119e466-e153-52b2-051a-bdb17081872b@huawei.com>
Date:   Wed, 12 May 2021 15:29:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YJqiEAoxcCkVAEsK@infradead.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.235]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Christoph
Many thanks for your review.
On 2021/5/11 23:26, Christoph Hellwig wrote:
> On Tue, May 11, 2021 at 11:09:00PM +0800, Dongdong Liu wrote:
>> It will make sense to store the devcap2 value in the pci_dev structure
>> instead of reading Device Capabilities 2 Register multiple times.
>> So we add pci_init_devcap2() to get the value of devcap2, then use
>> cached devcap2 in the needed place.
>
> This looks sensible.  Should the devcap field maybe grow a pcie_
> prefix?
Yes, It will be good to use pcie_prefix.
> What about caching PCI_EXP_DEVCAP as well while you're at it?
Make sense, will do.

Thanks,
Dongdong
>
