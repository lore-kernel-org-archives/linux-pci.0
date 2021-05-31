Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273F0C47082
	for <linux-pci@archiver.kernel.org>; Mon, 31 May 2021 13:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 091DD61C53
	for <linux-pci@archiver.kernel.org>; Mon, 31 May 2021 13:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhEaNxP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 31 May 2021 09:53:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:55016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232252AbhEaNvF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 May 2021 09:51:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6CD49616EA;
        Mon, 31 May 2021 13:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622467934;
        bh=+gZ0lcOR49wAN7cN/mgN2LrrDtkYiXcrps9PSlk6+yY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kEoH1OaEXx50iPhQ+e0yGSu6o699+IX/RoJ5U7AO6c2B5/MM6ncamBMHEUI6Ss6iC
         HPskp865yF5EedyaxYCgSbcY1uYCukE+G9VUZhujEmTAV8WA791fPdD0NJT45H7PMt
         vtlIB1fwdei11lAdtKYup8xTkRo2KHTs0PPkwZ1ytCHumQhMqik28bS0JgYGdPZkkp
         WpMniS6ZXOCVEeOCqJOqkmZBGCm5/WxKUduAviI7HWs9wargJJ1qVpAWdbysaRvxaK
         WHx08dV6NcSNd21ZJQ7yRePbjIe8jrWMGDXLhiUp0p6Ik0M58wthAh9ER2oraBkwWK
         YFMt7uXZntxaA==
Received: by pali.im (Postfix)
        id E984CB84; Mon, 31 May 2021 15:32:11 +0200 (CEST)
Date:   Mon, 31 May 2021 15:32:11 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-pci@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2] PCI: dra7xx: Fix reset behaviour
Message-ID: <20210531133211.llyiq3jcfy25tmz4@pali>
References: <20210531090540.2663171-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531090540.2663171-1-luca@lucaceresoli.net>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday 31 May 2021 11:05:40 Luca Ceresoli wrote:
> The PCIe PERSTn reset pin is active low and should be asserted, then
> deasserted.
> 
> The current implementation only drives the pin once in "HIGH" position,
> thus presumably it was intended to deassert the pin. This has two problems:
> 
>   1) it assumes the pin was asserted by other means before loading the
>      driver
>   2) it has the wrong polarity, since "HIGH" means "active", and the pin is
>      presumably configured as active low coherently with the PCIe
>      convention, thus it is driven physically to 0, keeping the device
>      under reset unless the pin is configured as active high.
> 
> Fix both problems by:
> 
>   1) keeping devm_gpiod_get_optional(dev, NULL, GPIOD_OUT_HIGH) as is, but
>      assuming the pin is correctly configured as "active low" this now
>      becomes a reset assertion
>   2) adding gpiod_set_value(reset, 0) after a delay to deassert reset
> 
> Fixes: 78bdcad05ea1 ("PCI: dra7xx: Add support to make GPIO drive PERST# line")
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> 
> ---
> 
> Changes v1 -> v2:
>  - No changes to the patch
>  - Reword commit message according to suggestions from Bjorn Helgaas (from
>    another patchset)
>  - Add Fixes: tag
> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index cb5d4c245ff6..11f392b7a9a2 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -801,6 +801,8 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "gpio request failed, ret %d\n", ret);
>  		goto err_gpio;
>  	}
> +	usleep_range(1000, 2000);

Hello! Just a note that this is again a new code pattern in another
driver for different wait value of PCIe Warm Reset timeout. I sent email
about these issues:
https://lore.kernel.org/linux-pci/20210310110535.zh4pnn4vpmvzwl5q@pali/

Luca, how did you choose value 1000-2000 us? Do you have some reference
or specification which says that this value needs to be used?

> +	gpiod_set_value(reset, 0);
>  
>  	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_DEVICE_CMD);
>  	reg &= ~LTSSM_EN;
> -- 
> 2.25.1
> 
