Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6940FC47082
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jun 2021 12:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 512EE61245
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jun 2021 12:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhFGMpt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 7 Jun 2021 08:45:49 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7130 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbhFGMpt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jun 2021 08:45:49 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FzCfC0LcLzYsVC;
        Mon,  7 Jun 2021 20:41:07 +0800 (CST)
Received: from dggpemm500009.china.huawei.com (7.185.36.225) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 20:43:55 +0800
Received: from [10.174.185.226] (10.174.185.226) by
 dggpemm500009.china.huawei.com (7.185.36.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 20:43:54 +0800
To:     Joerg Roedel <joro@8bytes.org>
CC:     <robh@kernel.org>, <will@kernel.org>, <helgaas@kernel.org>,
        <robh+dt@kernel.org>, <gregkh@linuxfoundation.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <xieyingtai@huawei.com>
References: <1621566204-37456-1-git-send-email-wangxingang5@huawei.com>
 <YLpIcwdWDGKpw39s@8bytes.org>
From:   Xingang Wang <wangxingang5@huawei.com>
Subject: Re: [PATCH v4] iommu/of: Fix pci_request_acs() before enumerating PCI
 devices
Message-ID: <9054b39b-a73c-f5b4-cd61-9af4449a0649@huawei.com>
Date:   Mon, 7 Jun 2021 20:43:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <YLpIcwdWDGKpw39s@8bytes.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.185.226]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021/6/4 23:36, Joerg Roedel wrote:
> On Fri, May 21, 2021 at 03:03:24AM +0000, Wang Xingang wrote:
>> From: Xingang Wang <wangxingang5@huawei.com>
>>
>> When booting with devicetree, the pci_request_acs() is called after the
>> enumeration and initialization of PCI devices, thus the ACS is not
>> enabled. And ACS should be enabled when IOMMU is detected for the
>> PCI host bridge, so add check for IOMMU before probe of PCI host and call
>> pci_request_acs() to make sure ACS will be enabled when enumerating PCI
>> devices.
>>
>> Fixes: 6bf6c24720d33 ("iommu/of: Request ACS from the PCI core when
>> configuring IOMMU linkage")
>> Signed-off-by: Xingang Wang <wangxingang5@huawei.com>
>> ---
>>   drivers/iommu/of_iommu.c | 1 -
>>   drivers/pci/of.c         | 8 +++++++-
>>   2 files changed, 7 insertions(+), 2 deletions(-)
> 
> Should probably go through the PCI tree, so
> 
> Acked-by: Joerg Roedel <jroedel@suse.de>
> 
> .
> 

Thanks

.
