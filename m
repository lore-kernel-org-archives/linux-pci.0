Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92889ECDE32
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 07:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D45820869
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 07:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D45820869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbeJQPty (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:49:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33394 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727000AbeJQPtx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Oct 2018 11:49:53 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DFDC34E73F4C7;
        Wed, 17 Oct 2018 15:55:21 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.399.0; Wed, 17 Oct 2018
 15:55:14 +0800
Subject: Re: [Bug report] NVMe and RAID probe fail with commit cdf6b7362108
From:   Hanjun Guo <guohanjun@huawei.com>
To:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linuxarm <linuxarm@huawei.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <ce7332ed-0dfb-da20-40e8-702c755d3e08@huawei.com>
Message-ID: <733f9331-13b4-f6f3-7189-03f1779a2855@huawei.com>
Date:   Wed, 17 Oct 2018 15:54:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <ce7332ed-0dfb-da20-40e8-702c755d3e08@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2018/10/17 11:38, Hanjun Guo wrote:
> Hi Lukas,
> 
> We met NVMe and RAID probe failure on 4.19-rc1+ based kernel on
> Hisilicon D06, then we bisect to this commit:
> 
> cdf6b7362108 "PCI: pciehp: Always enable occupied slot on probe"
> 
> Reverting this patch makes the system back to functional, I'm not
> sure why this lead some regression on our board, could you share
> some idea on this?

After applying those two patches from linux-next:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=11e87702be65780be92fb1f0a5b7b293954185f7
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=80696f991424d05a784c0cf9c314ac09ac280406

things back to normal, can we merge that for 4.19?

Thanks
Hanjun

