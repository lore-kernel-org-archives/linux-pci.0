Return-Path: <SRS0=PPlZ=SV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEB6C282DA
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 18:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E25C20449
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 18:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698722;
	bh=upGy2TdU16HfkEriubkDgSX3+ftl0DPDey0K7makTLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IebJ0yQjv0rFSOkNK8HZhIa2YPSsuxUmU7itdGCUhj+wwy/iMLqn7VnLu5eotKl2V
	 eyq+NpJl/ZdbWGfr7n64vRtMSaWp0JfHZ3/7v7BAxK/TOG0ipsiyJlFAWHTirycZXM
	 0RRxWZW1dQfPt4xf+x63Tn59tUt2kz3zBKsqsjWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfDSS3R (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:29:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727786AbfDSS3R (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Apr 2019 14:29:17 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37C4C222AC;
        Fri, 19 Apr 2019 13:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555680699;
        bh=upGy2TdU16HfkEriubkDgSX3+ftl0DPDey0K7makTLU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NPLllMydalscHfKsEer+OOlgBCBr2KI+tRfCkJfRJFzHQ8HrpePbqAza5CWOm7gZk
         jwd292GC7MOXqdorMm5ph/CoyWi0cWvS26hR4Jwy57dsH1Ot3K+cV7WoC4TQpm1zz+
         J8ACXLKHMcgbUM0on89dSwSg4d8gqM54JpaiUSro=
Date:   Fri, 19 Apr 2019 08:31:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     lorenzo.pieralisi@arm.com, kishon@ti.com, robh@kernel.org,
        l.stach@pengutronix.de, andrew.smirnov@gmail.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: keystone: Fix build error while only
 CONFIG_PCI_KEYSTONE is set
Message-ID: <20190419133137.GA173520@google.com>
References: <20190419025855.40760-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419025855.40760-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 19, 2019 at 10:58:55AM +0800, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> During randconfig builds, I occasionally run into an invalid configuration
> 
> drivers/pci/controller/dwc/pci-keystone.o: In function `ks_pcie_link_up':
> pci-keystone.c:(.text+0x90): undefined reference to `__dw_pcie_read_dbi'
> pci-keystone.c:(.text+0x90): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `__dw_pcie_read_dbi'
> drivers/pci/controller/dwc/pci-keystone.o: In function `ks_pcie_v3_65_scan_bus':
> pci-keystone.c:(.text+0x4f0): undefined reference to `__dw_pcie_write_dbi'
> pci-keystone.c:(.text+0x4f0): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `__dw_pcie_write_dbi'
> 
> while CONFIG_PCI_KEYSTONE is selected but CONFIG_PCIE_DW
> is not set, the building failed like this. This patch
> selects PCIE_DW to fix it.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 5709114f0a97 ("PCI: keystone: Add support for PCIe EP in AM654x Platforms")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/pci/controller/dwc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index b450ad2..641fa0f 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -105,6 +105,7 @@ config PCIE_SPEAR13XX
>  config PCI_KEYSTONE
>  	bool "TI Keystone PCIe controller"
>  	depends on ARCH_KEYSTONE || ARCH_K3 || ((ARM || ARM64) && COMPILE_TEST)
> +	select PCIE_DW

What version are you building?  In v5.0, PCI_KEYSTONE already selects
PCIE_DW_HOST:

$ git grep -A4 PCI_KEYSTONE v5.0:drivers/pci/controller/dwc/Kconfig | cat
v5.0:drivers/pci/controller/dwc/Kconfig:config PCI_KEYSTONE
v5.0:drivers/pci/controller/dwc/Kconfig-	bool "TI Keystone PCIe controller"
v5.0:drivers/pci/controller/dwc/Kconfig-	depends on ARCH_KEYSTONE || (ARM && COMPILE_TEST)
v5.0:drivers/pci/controller/dwc/Kconfig-	depends on PCI_MSI_IRQ_DOMAIN
v5.0:drivers/pci/controller/dwc/Kconfig-	select PCIE_DW_HOST
08:30:42 ~/history (master)$

>  	help
>  	  Say Y here if you want to enable PCI controller support on Keystone
>  	  SoCs. The PCI controller on Keystone is based on DesignWare hardware
> -- 
> 2.7.4
> 
> 
