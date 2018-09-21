Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F198C433F4
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 14:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B9202154F
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 14:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B9202154F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390244AbeIUTwa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:52:30 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12672 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390216AbeIUTwa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Sep 2018 15:52:30 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 26F4760D0BD38;
        Fri, 21 Sep 2018 22:03:26 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.42) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.399.0; Fri, 21 Sep 2018
 22:03:21 +0800
Subject: Re: [PATCH] arm64: defconfig: Enable PCIEPORTBUS
To:     Dongdong Liu <liudongdong3@huawei.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <Lorenzo.Pieralisi@arm.com>
References: <1535632172-127690-1-git-send-email-liudongdong3@huawei.com>
CC:     <linux-pci@vger.kernel.org>, <helgaas@kernel.org>,
        <linuxarm@huawei.com>, <linux-arm-kernel@lists.infradead.org>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5BA4FA22.7000602@hisilicon.com>
Date:   Fri, 21 Sep 2018 15:03:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1535632172-127690-1-git-send-email-liudongdong3@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Dongdong,

On 2018/8/30 13:29, Dongdong Liu wrote:
> PCIe features like AER, Hotplug, PME, DPC depend on PCIEPORTBUS,
> so enable PCIEPORTBUS as default.
> 
> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>

Thanks!
Applied to the hisilicon defconfig tree.

Best Regards,
Wei

> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index f67e8d5..e5652e9 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -67,6 +67,7 @@ CONFIG_ARCH_XGENE=y
>  CONFIG_ARCH_ZX=y
>  CONFIG_ARCH_ZYNQMP=y
>  CONFIG_PCI=y
> +CONFIG_PCIEPORTBUS=y
>  CONFIG_PCI_IOV=y
>  CONFIG_HOTPLUG_PCI=y
>  CONFIG_HOTPLUG_PCI_ACPI=y
> 

