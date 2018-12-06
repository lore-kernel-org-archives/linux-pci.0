Return-Path: <SRS0=KO/x=OP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADFEC04EB8
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 08:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F8ED20989
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 08:10:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F8ED20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tkos.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbeLFIKq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 6 Dec 2018 03:10:46 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:49705 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728909AbeLFIKq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Dec 2018 03:10:46 -0500
Received: from tarshish (unknown [10.0.8.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 7E2B744011A;
        Thu,  6 Dec 2018 10:10:43 +0200 (IST)
References: <20181206074555.19579-1-andrew.smirnov@gmail.com>
User-agent: mu4e 1.0; emacs 25.2.2
From:   Baruch Siach <baruch@tkos.co.il>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Robert Hancock <hancock@sedsystems.ca>
Cc:     linux-pci@vger.kernel.org, "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, bhelgaas@google.com,
        Leonard Crestez <leonard.crestez@nxp.com>, cphealy@gmail.com,
        l.stach@pengutronix.de, Trent Piepho <tpiepho@impinj.com>
Subject: Re: [PATCH] PCI: controller: dwc: Make PCI_IMX6 depend on PCIEPORTBUS
In-reply-to: <20181206074555.19579-1-andrew.smirnov@gmail.com>
Date:   Thu, 06 Dec 2018 10:10:43 +0200
Message-ID: <87o99zjcsc.fsf@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andrey,

Adding Robert Hancock who reported[1] on a PCIe MSI issue with i.MX6.

Andrey Smirnov writes:

> Building a kernel with CONFIG_PCI_IMX6=y, but CONFIG_PCIEPORTBUS=n
> produces a system where built-in PCIE bridge (16c3:abcd) isn't bound
> to pcieport driver. This, in turn, results in a PCIE bus that is
> capable of enumerating attached PCIE device, but lacks functional
> interrupt support.

Robert, does that fix your issue?

> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>
> Assuming this is a reasonable dependency, shold this be done to more
> than just i.MX6 driver?
>
>  drivers/pci/controller/dwc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 2b139acccf32..44ededbeab85 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -92,6 +92,7 @@ config PCI_IMX6
>  	bool "Freescale i.MX6 PCIe controller"
>  	depends on SOC_IMX8MQ || SOC_IMX6Q || (ARM && COMPILE_TEST)
>  	depends on PCI_MSI_IRQ_DOMAIN
> +	depends on PCIEPORTBUS

This effectively disables PCIe in imx_v6_v7_defconfig, since
CONFIG_PCIEPORTBUS is not enabled there. Maybe do 'select' instead?

>  	Select PCIE_DW_HOST
>
>  config PCIE_SPEAR13XX

baruch

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-November/614800.html

--
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
