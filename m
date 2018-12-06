Return-Path: <SRS0=KO/x=OP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E156C04EB8
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 10:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE0E20838
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 10:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE0E20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbeLFK27 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:28:59 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59613 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbeLFK27 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Dec 2018 05:28:59 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gUqtt-0007HQ-Hf; Thu, 06 Dec 2018 11:28:57 +0100
Message-ID: <1544092136.3709.57.camel@pengutronix.de>
Subject: Re: [PATCH] PCI: controller: dwc: Make PCI_IMX6 depend on
 PCIEPORTBUS
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-pci@vger.kernel.org
Cc:     bhelgaas@google.com, cphealy@gmail.com,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 06 Dec 2018 11:28:56 +0100
In-Reply-To: <20181206074555.19579-1-andrew.smirnov@gmail.com>
References: <20181206074555.19579-1-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Mittwoch, den 05.12.2018, 23:45 -0800 schrieb Andrey Smirnov:
> Building a kernel with CONFIG_PCI_IMX6=y, but CONFIG_PCIEPORTBUS=n
> produces a system where built-in PCIE bridge (16c3:abcd) isn't bound
> to pcieport driver. This, in turn, results in a PCIE bus that is
> capable of enumerating attached PCIE device, but lacks functional
> interrupt support.

This is odd. AFAIK PCI port services are a totally optional thing and
them being absent should not lead to a non-functional PCI bus. So I
would really like to see some deeper analysis what is going on here.

Regards,
Lucas

> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
> 
> Assuming this is a reasonable dependency, shold this be done to more
> than just i.MX6 driver?
> 
>  drivers/pci/controller/dwc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 2b139acccf32..44ededbeab85 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -92,6 +92,7 @@ config PCI_IMX6
> >  	bool "Freescale i.MX6 PCIe controller"
> >  	depends on SOC_IMX8MQ || SOC_IMX6Q || (ARM && COMPILE_TEST)
> >  	depends on PCI_MSI_IRQ_DOMAIN
> > +	depends on PCIEPORTBUS
> >  	select PCIE_DW_HOST
>  
>  config PCIE_SPEAR13XX
