Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C64C28CF8
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 15:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 197D3206BB
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 15:41:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 197D3206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbeKUCK5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:10:57 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51296 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbeKUCK5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 21:10:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7AC580D;
        Tue, 20 Nov 2018 07:41:12 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B741F3F5A0;
        Tue, 20 Nov 2018 07:41:11 -0800 (PST)
Date:   Tue, 20 Nov 2018 15:41:08 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Trent Piepho <tpiepho@impinj.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH v2] PCI: dwc: Adjust Kconfig to allow IMX6 PCIe host on
 IMX7
Message-ID: <20181120154108.GB26247@e107981-ln.cambridge.arm.com>
References: <20181116000803.5880-1-tpiepho@impinj.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116000803.5880-1-tpiepho@impinj.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 16, 2018 at 12:08:33AM +0000, Trent Piepho wrote:
> The IMX6 PCI-e host drier also supports the IMX7d.  However, the
> Kconfig dependencies of the driver prevented it from being enabled
> unless the kernel was built with both IMX6 and IMX7 support.  It works
> fine to build with only IMX7 support enabled.
> 
> Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Trent Piepho <tpiepho@impinj.com>
> ---
> Changes from v1:
>   Ported to current kernel
> 
>  drivers/pci/controller/dwc/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to pci/dwc for v4.21, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 91b0194240a5..6aafec3fad00 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -89,8 +89,8 @@ config PCI_EXYNOS
>  	select PCIE_DW_HOST
>  
>  config PCI_IMX6
> -	bool "Freescale i.MX6 PCIe controller"
> -	depends on SOC_IMX6Q || (ARM && COMPILE_TEST)
> +	bool "Freescale i.MX6/7 PCIe controller"
> +	depends on SOC_IMX6Q || SOC_IMX7D || (ARM && COMPILE_TEST)
>  	depends on PCI_MSI_IRQ_DOMAIN
>  	select PCIE_DW_HOST
>  
> -- 
> 2.14.4
> 
