Return-Path: <SRS0=PPlZ=SV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C92C282E0
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 21:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2953A21736
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 21:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfDSVcU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Apr 2019 17:32:20 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6664 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726000AbfDSVcU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Apr 2019 17:32:20 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B4B438779134A61EA796;
        Fri, 19 Apr 2019 21:46:45 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Fri, 19 Apr 2019
 21:46:41 +0800
Subject: Re: [PATCH] PCI: keystone: Fix build error while only
 CONFIG_PCI_KEYSTONE is set
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <20190419025855.40760-1-yuehaibing@huawei.com>
 <20190419133137.GA173520@google.com>
CC:     <lorenzo.pieralisi@arm.com>, <kishon@ti.com>, <robh@kernel.org>,
        <l.stach@pengutronix.de>, <andrew.smirnov@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <35486240-8c29-410d-e0f4-c87dc42fb668@huawei.com>
Date:   Fri, 19 Apr 2019 21:46:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190419133137.GA173520@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2019/4/19 21:31, Bjorn Helgaas wrote:
> On Fri, Apr 19, 2019 at 10:58:55AM +0800, Yue Haibing wrote:
>> From: YueHaibing <yuehaibing@huawei.com>
>>
>> During randconfig builds, I occasionally run into an invalid configuration
>>
>> drivers/pci/controller/dwc/pci-keystone.o: In function `ks_pcie_link_up':
>> pci-keystone.c:(.text+0x90): undefined reference to `__dw_pcie_read_dbi'
>> pci-keystone.c:(.text+0x90): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `__dw_pcie_read_dbi'
>> drivers/pci/controller/dwc/pci-keystone.o: In function `ks_pcie_v3_65_scan_bus':
>> pci-keystone.c:(.text+0x4f0): undefined reference to `__dw_pcie_write_dbi'
>> pci-keystone.c:(.text+0x4f0): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `__dw_pcie_write_dbi'
>>
>> while CONFIG_PCI_KEYSTONE is selected but CONFIG_PCIE_DW
>> is not set, the building failed like this. This patch
>> selects PCIE_DW to fix it.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Fixes: 5709114f0a97 ("PCI: keystone: Add support for PCIe EP in AM654x Platforms")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/pci/controller/dwc/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
>> index b450ad2..641fa0f 100644
>> --- a/drivers/pci/controller/dwc/Kconfig
>> +++ b/drivers/pci/controller/dwc/Kconfig
>> @@ -105,6 +105,7 @@ config PCIE_SPEAR13XX
>>  config PCI_KEYSTONE
>>  	bool "TI Keystone PCIe controller"
>>  	depends on ARCH_KEYSTONE || ARCH_K3 || ((ARM || ARM64) && COMPILE_TEST)
>> +	select PCIE_DW
> 
> What version are you building?  In v5.0, PCI_KEYSTONE already selects
> PCIE_DW_HOST:
> 
> $ git grep -A4 PCI_KEYSTONE v5.0:drivers/pci/controller/dwc/Kconfig | cat
> v5.0:drivers/pci/controller/dwc/Kconfig:config PCI_KEYSTONE
> v5.0:drivers/pci/controller/dwc/Kconfig-	bool "TI Keystone PCIe controller"
> v5.0:drivers/pci/controller/dwc/Kconfig-	depends on ARCH_KEYSTONE || (ARM && COMPILE_TEST)
> v5.0:drivers/pci/controller/dwc/Kconfig-	depends on PCI_MSI_IRQ_DOMAIN
> v5.0:drivers/pci/controller/dwc/Kconfig-	select PCIE_DW_HOST
> 08:30:42 ~/history (master)$

This patch based on linux-next:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=5709114f0a97

> 
>>  	help
>>  	  Say Y here if you want to enable PCI controller support on Keystone
>>  	  SoCs. The PCI controller on Keystone is based on DesignWare hardware
>> -- 
>> 2.7.4
>>
>>
> 
> .
> 

