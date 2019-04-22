Return-Path: <SRS0=L200=SY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5AEC282E1
	for <linux-pci@archiver.kernel.org>; Mon, 22 Apr 2019 07:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F6CD20857
	for <linux-pci@archiver.kernel.org>; Mon, 22 Apr 2019 07:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s1Lu9PcZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfDVHvO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 22 Apr 2019 03:51:14 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50452 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfDVHvO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Apr 2019 03:51:14 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3M7ovN1078686;
        Mon, 22 Apr 2019 02:50:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555919457;
        bh=tR+K/cW3/uS/6ipyuzJ9bzqKOfv7AFVC8VnuWezEYwI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=s1Lu9PcZvZIwh0AE3Ml0RRpxmxPrkgh/hA9PMaeC5gamHtgePLFq5wRNfRBRtyh6Q
         fkePdrtIKtl/z8RBTUTN+Ye18dhRmirW9vCDJH4rrjudPJU4ZcOcVOyeuoTtcPyaKb
         QuliOFRszx0M4LlMmqIrTEcyvj5/OYIQn6rEs5IU=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3M7ovY8038513
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Apr 2019 02:50:57 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 22
 Apr 2019 02:50:57 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 22 Apr 2019 02:50:57 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3M7osDc035716;
        Mon, 22 Apr 2019 02:50:54 -0500
Subject: Re: [PATCH] PCI: keystone: Fix build error while only
 CONFIG_PCI_KEYSTONE is set
To:     Bjorn Helgaas <helgaas@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
CC:     <lorenzo.pieralisi@arm.com>, <robh@kernel.org>,
        <l.stach@pengutronix.de>, <andrew.smirnov@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20190419025855.40760-1-yuehaibing@huawei.com>
 <20190419133137.GA173520@google.com>
 <35486240-8c29-410d-e0f4-c87dc42fb668@huawei.com>
 <20190419174735.GE173520@google.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <9e674a96-5d19-47f6-41a4-9a4313652b5b@ti.com>
Date:   Mon, 22 Apr 2019 13:19:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190419174735.GE173520@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 19/04/19 11:17 PM, Bjorn Helgaas wrote:
> On Fri, Apr 19, 2019 at 09:46:39PM +0800, YueHaibing wrote:
>> On 2019/4/19 21:31, Bjorn Helgaas wrote:
>>> On Fri, Apr 19, 2019 at 10:58:55AM +0800, Yue Haibing wrote:
>>>> From: YueHaibing <yuehaibing@huawei.com>
>>>>
>>>> During randconfig builds, I occasionally run into an invalid configuration
>>>>
>>>> drivers/pci/controller/dwc/pci-keystone.o: In function `ks_pcie_link_up':
>>>> pci-keystone.c:(.text+0x90): undefined reference to `__dw_pcie_read_dbi'
>>>> pci-keystone.c:(.text+0x90): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `__dw_pcie_read_dbi'
>>>> drivers/pci/controller/dwc/pci-keystone.o: In function `ks_pcie_v3_65_scan_bus':
>>>> pci-keystone.c:(.text+0x4f0): undefined reference to `__dw_pcie_write_dbi'
>>>> pci-keystone.c:(.text+0x4f0): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `__dw_pcie_write_dbi'
>>>>
>>>> while CONFIG_PCI_KEYSTONE is selected but CONFIG_PCIE_DW
>>>> is not set, the building failed like this. This patch
>>>> selects PCIE_DW to fix it.
>>>>
>>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>>> Fixes: 5709114f0a97 ("PCI: keystone: Add support for PCIe EP in AM654x Platforms")
>>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>>> ---
>>>>  drivers/pci/controller/dwc/Kconfig | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
>>>> index b450ad2..641fa0f 100644
>>>> --- a/drivers/pci/controller/dwc/Kconfig
>>>> +++ b/drivers/pci/controller/dwc/Kconfig
>>>> @@ -105,6 +105,7 @@ config PCIE_SPEAR13XX
>>>>  config PCI_KEYSTONE
>>>>  	bool "TI Keystone PCIe controller"
>>>>  	depends on ARCH_KEYSTONE || ARCH_K3 || ((ARM || ARM64) && COMPILE_TEST)
>>>> +	select PCIE_DW
>>>
>>> What version are you building?  In v5.0, PCI_KEYSTONE already selects
>>> PCIE_DW_HOST:
>>>
>>> $ git grep -A4 PCI_KEYSTONE v5.0:drivers/pci/controller/dwc/Kconfig | cat
>>> v5.0:drivers/pci/controller/dwc/Kconfig:config PCI_KEYSTONE
>>> v5.0:drivers/pci/controller/dwc/Kconfig-	bool "TI Keystone PCIe controller"
>>> v5.0:drivers/pci/controller/dwc/Kconfig-	depends on ARCH_KEYSTONE || (ARM && COMPILE_TEST)
>>> v5.0:drivers/pci/controller/dwc/Kconfig-	depends on PCI_MSI_IRQ_DOMAIN
>>> v5.0:drivers/pci/controller/dwc/Kconfig-	select PCIE_DW_HOST
>>> 08:30:42 ~/history (master)$
>>
>> This patch based on linux-next:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=5709114f0a97
> 
> Oh, yep, looks like this was broken by ad5ca801bd7e ("PCI: keystone:
> Add support for PCIe EP in AM654x Platforms"), which added
> PCI_KEYSTONE_HOST and PCI_KEYSTONE_EP.  Those select PCIE_DW_HOST and
> PCIE_DW_EP, respectively, which in turn select PCIE_DW.
> 
> But I guess it's possible to enable PCI_KEYSTONE by itself without
> either PCI_KEYSTONE_HOST or PCI_KEYSTONE_EP.  I'm not sure what that
> would mean, but we would still try to build pci-keystone.o
> 
> I'm hoping we can amend that commit before the merge window.

Sometime back Niklas had fixed this for DRA7xx in

commit b052835c63857e13d9ada3ebc57a8f9e1d124f3a
Author: Niklas Cassel <niklas.cassel@axis.com>
Date:   Wed Dec 20 00:29:28 2017 +0100

    PCI: dwc: dra7xx: Refactor Kconfig and Makefile handling for host/ep mode

    Refactor the Kconfig and Makefile handling for host/ep mode, since
    the previous handling was a bit unorthodox and would have been a bit
    bloated once more DWC based controllers added support for ep mode.

    Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
    Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
    Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

Something similar is applicable for Keystone too as you mentioned without
selecting PCI_KEYSTONE_HOST or PCI_KEYSTONE_EP, compiling pci-keystone.c
doesn't make sense.

Please see if below looks okay to you. This can be merged with "PCI:
keystone:Add support for PCIe EP in AM654x Platforms"). Let me know if I have
to send it separately with Fixes tag.

8<---------------------------------------------------------
From 8fba36048112cf72c49996fc47fd808534bf9689 Mon Sep 17 00:00:00 2001
From: Kishon Vijay Abraham I <kishon@ti.com>
Date: Mon, 22 Apr 2019 11:42:32 +0530
Subject: [PATCH] PCI: keystone: Refactor Kconfig for RC/EP mode

Do not allow PCI_KEYSTONE to be visible to user and let user visible
CONFIG symbols PCI_KEYSTONE_HOST and PCI_KEYSTONE_EP select
PCI_KEYSTONE. This will let pci-keystone.c to be compiled only when
either PCI_KEYSTONE_HOST or PCI_KEYSTONE_EP is selected.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/Kconfig | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig
b/drivers/pci/controller/dwc/Kconfig
index b450ad2823a5..90618233d15b 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -103,34 +103,32 @@ config PCIE_SPEAR13XX
 	  Say Y here if you want PCIe support on SPEAr13XX SoCs.

 config PCI_KEYSTONE
-	bool "TI Keystone PCIe controller"
-	depends on ARCH_KEYSTONE || ARCH_K3 || ((ARM || ARM64) && COMPILE_TEST)
-	help
-	  Say Y here if you want to enable PCI controller support on Keystone
-	  SoCs. The PCI controller on Keystone is based on DesignWare hardware
-	  and therefore the driver re-uses the DesignWare core functions to
-	  implement the driver.
-
-if PCI_KEYSTONE
+	bool

 config PCI_KEYSTONE_HOST
 	bool "PCI Keystone Host Mode"
+	depends on ARCH_KEYSTONE || ARCH_K3 || ((ARM || ARM64) && COMPILE_TEST)
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
+	select PCI_KEYSTONE
 	default y
 	help
 	 Enables support for the PCIe controller in the Keystone SoC to work in
-	 host mode.
+	 host mode. The PCI controller on Keystone is based on DesignWare hardware
+	 and therefore the driver re-uses the DesignWare core functions to
+	 implement the driver.

 config PCI_KEYSTONE_EP
 	bool "PCI Keystone Endpoint Mode"
+	depends on ARCH_KEYSTONE || ARCH_K3 || ((ARM || ARM64) && COMPILE_TEST)
 	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
+	select PCI_KEYSTONE
 	help
 	 Enables support for the PCIe controller in the Keystone SoC to work in
-	 endpoint mode.
-
-endif
+	 endpoint mode. The PCI controller on Keystone is based on DesignWare hardware
+	 and therefore the driver re-uses the DesignWare core functions to
+	 implement the driver.

 config PCI_LAYERSCAPE
 	bool "Freescale Layerscape PCIe controller"
-- 
2.17.1
