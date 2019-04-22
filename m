Return-Path: <SRS0=L200=SY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7E8C10F11
	for <linux-pci@archiver.kernel.org>; Mon, 22 Apr 2019 13:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B0220874
	for <linux-pci@archiver.kernel.org>; Mon, 22 Apr 2019 13:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555939581;
	bh=iZV98+DgIq1WOnHtS6eiNLmeAgTd6U/MZrz+Bb9WEG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LOppG4bwX/qbCGAu0n0Ewj5mdXgY5WI8DyuIjdUSbTIlyH3yO2vg3tnjKYM4ww1gv
	 7S8g0FAqAP9Y1HCYTCujopdeVMEXZYh4iukj4Yl/SAEzTTocVgQWiJVNTZNRhQ2uZU
	 nz5t2fDSYfy29Xmdfj173YSoBk6XtgkykxQRtrsE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfDVN0U (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 22 Apr 2019 09:26:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfDVN0U (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Apr 2019 09:26:20 -0400
Received: from localhost (50-82-46-41.client.mchsi.com [50.82.46.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5C3320693;
        Mon, 22 Apr 2019 13:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555939579;
        bh=iZV98+DgIq1WOnHtS6eiNLmeAgTd6U/MZrz+Bb9WEG4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ru1/PXLgJryRpXW9KDsdfSAcikT3Lq0GO8AMI2Wzqq5lP5zQjhZD5ol8UvemMLJph
         35PlKT2AsrwlhbKWzPx7vFzbkztsDU1ZcTlvY/u030PSKPFD3vYVwl977fUbGu85/H
         +5KfiiNCqYI2sUw3Bv4qzy3xixgdJ9gRGOf3q6xc=
Date:   Mon, 22 Apr 2019 08:26:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     YueHaibing <yuehaibing@huawei.com>, lorenzo.pieralisi@arm.com,
        robh@kernel.org, l.stach@pengutronix.de, andrew.smirnov@gmail.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: keystone: Fix build error while only
 CONFIG_PCI_KEYSTONE is set
Message-ID: <20190422132617.GL173520@google.com>
References: <20190419025855.40760-1-yuehaibing@huawei.com>
 <20190419133137.GA173520@google.com>
 <35486240-8c29-410d-e0f4-c87dc42fb668@huawei.com>
 <20190419174735.GE173520@google.com>
 <9e674a96-5d19-47f6-41a4-9a4313652b5b@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e674a96-5d19-47f6-41a4-9a4313652b5b@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 22, 2019 at 01:19:53PM +0530, Kishon Vijay Abraham I wrote:
> Hi Bjorn,
> ...

> Sometime back Niklas had fixed this for DRA7xx in
> 
> commit b052835c63857e13d9ada3ebc57a8f9e1d124f3a
> Author: Niklas Cassel <niklas.cassel@axis.com>
> Date:   Wed Dec 20 00:29:28 2017 +0100
> 
>     PCI: dwc: dra7xx: Refactor Kconfig and Makefile handling for host/ep mode
> 
>     Refactor the Kconfig and Makefile handling for host/ep mode, since
>     the previous handling was a bit unorthodox and would have been a bit
>     bloated once more DWC based controllers added support for ep mode.
> 
>     Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
>     Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>     Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
> Something similar is applicable for Keystone too as you mentioned without
> selecting PCI_KEYSTONE_HOST or PCI_KEYSTONE_EP, compiling pci-keystone.c
> doesn't make sense.
> 
> Please see if below looks okay to you. This can be merged with "PCI:
> keystone:Add support for PCIe EP in AM654x Platforms"). Let me know if I have
> to send it separately with Fixes tag.

Lorenzo merged that commit, so I assume he'll take care of this.

> 8<---------------------------------------------------------
> From 8fba36048112cf72c49996fc47fd808534bf9689 Mon Sep 17 00:00:00 2001
> From: Kishon Vijay Abraham I <kishon@ti.com>
> Date: Mon, 22 Apr 2019 11:42:32 +0530
> Subject: [PATCH] PCI: keystone: Refactor Kconfig for RC/EP mode
> 
> Do not allow PCI_KEYSTONE to be visible to user and let user visible
> CONFIG symbols PCI_KEYSTONE_HOST and PCI_KEYSTONE_EP select
> PCI_KEYSTONE. This will let pci-keystone.c to be compiled only when
> either PCI_KEYSTONE_HOST or PCI_KEYSTONE_EP is selected.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/dwc/Kconfig | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig
> b/drivers/pci/controller/dwc/Kconfig
> index b450ad2823a5..90618233d15b 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -103,34 +103,32 @@ config PCIE_SPEAR13XX
>  	  Say Y here if you want PCIe support on SPEAr13XX SoCs.
> 
>  config PCI_KEYSTONE
> -	bool "TI Keystone PCIe controller"
> -	depends on ARCH_KEYSTONE || ARCH_K3 || ((ARM || ARM64) && COMPILE_TEST)
> -	help
> -	  Say Y here if you want to enable PCI controller support on Keystone
> -	  SoCs. The PCI controller on Keystone is based on DesignWare hardware
> -	  and therefore the driver re-uses the DesignWare core functions to
> -	  implement the driver.
> -
> -if PCI_KEYSTONE
> +	bool
> 
>  config PCI_KEYSTONE_HOST
>  	bool "PCI Keystone Host Mode"
> +	depends on ARCH_KEYSTONE || ARCH_K3 || ((ARM || ARM64) && COMPILE_TEST)
>  	depends on PCI_MSI_IRQ_DOMAIN
>  	select PCIE_DW_HOST
> +	select PCI_KEYSTONE
>  	default y
>  	help
>  	 Enables support for the PCIe controller in the Keystone SoC to work in
> -	 host mode.
> +	 host mode. The PCI controller on Keystone is based on DesignWare hardware
> +	 and therefore the driver re-uses the DesignWare core functions to
> +	 implement the driver.
> 
>  config PCI_KEYSTONE_EP
>  	bool "PCI Keystone Endpoint Mode"
> +	depends on ARCH_KEYSTONE || ARCH_K3 || ((ARM || ARM64) && COMPILE_TEST)
>  	depends on PCI_ENDPOINT
>  	select PCIE_DW_EP
> +	select PCI_KEYSTONE
>  	help
>  	 Enables support for the PCIe controller in the Keystone SoC to work in
> -	 endpoint mode.
> -
> -endif
> +	 endpoint mode. The PCI controller on Keystone is based on DesignWare hardware
> +	 and therefore the driver re-uses the DesignWare core functions to
> +	 implement the driver.
> 
>  config PCI_LAYERSCAPE
>  	bool "Freescale Layerscape PCIe controller"
> -- 
> 2.17.1
