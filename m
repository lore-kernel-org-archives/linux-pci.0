Return-Path: <SRS0=AiiY=S3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946D6C43218
	for <linux-pci@archiver.kernel.org>; Thu, 25 Apr 2019 16:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1BD82088F
	for <linux-pci@archiver.kernel.org>; Thu, 25 Apr 2019 16:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556209849;
	bh=+GpxpvH8Ypyz9dB3lEJ82ecIBEgBI7Svu/UiJ/kFqCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UAbe6OdwZKaLhXVdP8w16fqNmfJqi/ztLG8WnXaqm3ClROVrxjVoYqkM8h+y0yHOy
	 SVMtO4pEXqJ9fvtRZA6vQIbEuavgQhxmG8FkYRNrbyHDUXiqw2WyXudb1Vw+VrNhW9
	 a6rGPVWGWFELM32H2ID3cQmHgQkVF4YAJwIRGKjI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbfDYQar (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:30:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:35284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbfDYQar (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Apr 2019 12:30:47 -0400
Received: from localhost (odyssey.drury.edu [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C6CA20717;
        Thu, 25 Apr 2019 16:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556209847;
        bh=+GpxpvH8Ypyz9dB3lEJ82ecIBEgBI7Svu/UiJ/kFqCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wc6LpSWKRXgIAJwDsnWHfXsImbXZ8Qqi2ru+4mkIjqSaxwaJy3Gr3qbZxMCF3wU10
         ewajRtpHLkfonK8/IuRPudiQ0+h4IaRd44tvr4S96NqsUMy4rGtZxvci5Z7CSRkSBs
         STujNZb5gqGUoyYtdUvUMkjtwYX2eZScnH1XptE4=
Date:   Thu, 25 Apr 2019 11:30:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH] pci: aardvark: Wait for endpoint to be ready before
 training link
Message-ID: <20190425163044.GF11428@google.com>
References: <20190313213752.1246-1-repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313213752.1246-1-repk@triplefau.lt>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 13, 2019 at 10:37:52PM +0100, Remi Pommarel wrote:
> When configuring pcie reset pin from gpio (e.g. initially set by
> u-boot) to pcie function this pin goes low for a brief moment
> asserting the PERST# signal. Thus connected device enters fundamental
> reset process and link configuration can only begin after a minimal
> 100ms delay (see [1]).
> 
> This makes sure that link is configured after at least 100ms from
> beginning of probe() callback (shortly after the reset pin function
> configuration switch through pinctrl subsytem).
> 
> [1] "PCI Express Base Specification", REV. 2.1
>         PCI Express, March 4 2009, 6.6.1 Conventional Reset

It would be nice to use a current reference, e.g., PCIe r4.0, sec
6.6.1.

> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
>  drivers/pci/controller/pci-aardvark.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index a30ae7cf8e7e..70a1023d0ef1 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -177,6 +177,9 @@
>  
>  #define PIO_TIMEOUT_MS			1
>  
> +/* Endpoint can take up to 100ms to be ready after a reset */
> +#define ENDPOINT_RST_MS			100
> +
>  #define LINK_WAIT_MAX_RETRIES		10
>  #define LINK_WAIT_USLEEP_MIN		90000
>  #define LINK_WAIT_USLEEP_MAX		100000
> @@ -242,8 +245,10 @@ static int advk_pcie_wait_for_link(struct advk_pcie *pcie)
>  	return -ETIMEDOUT;
>  }
>  
> -static void advk_pcie_setup_hw(struct advk_pcie *pcie)
> +static void
> +advk_pcie_setup_hw(struct advk_pcie *pcie, unsigned long ep_rdy_time)
>  {
> +	unsigned long now;
>  	u32 reg;
>  
>  	/* Set to Direct mode */
> @@ -327,9 +332,12 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
>  	reg |= PIO_CTRL_ADDR_WIN_DISABLE;
>  	advk_writel(pcie, reg, PIO_CTRL);
>  
> -	/* Start link training */
> +	/* Wait for endpoint to exit reset state and start link training */
>  	reg = advk_readl(pcie, PCIE_CORE_LINK_CTRL_STAT_REG);
>  	reg |= PCIE_CORE_LINK_TRAINING;
> +	now = jiffies;
> +	if (time_before(now, ep_rdy_time))
> +		msleep(jiffies_to_msecs(ep_rdy_time - now));
>  	advk_writel(pcie, reg, PCIE_CORE_LINK_CTRL_STAT_REG);
>  
>  	advk_pcie_wait_for_link(pcie);
> @@ -993,8 +1001,11 @@ static int advk_pcie_probe(struct platform_device *pdev)
>  	struct advk_pcie *pcie;
>  	struct resource *res;
>  	struct pci_host_bridge *bridge;
> +	unsigned long ep_rdy_time;
>  	int ret, irq;
>  
> +	ep_rdy_time = jiffies + msecs_to_jiffies(ENDPOINT_RST_MS);

I think this is partly what Lorenzo is getting at, so at the risk of
being repetitious, there should be some connection between the point
where PERST# is deasserted and the point where you sample "jiffies".
Ideally you would sample "jiffies" immediately after the function call
that deasserts PERST#.

I see that you mention this connection in the commit log, but I don't
see a way to easily deduce it from the code.  This looks like the very
first executable statement in the advk driver, so presumably there's
some implicit connection and ordering with the pinctrl driver.

>  	bridge = devm_pci_alloc_host_bridge(dev, sizeof(struct advk_pcie));
>  	if (!bridge)
>  		return -ENOMEM;
> @@ -1022,7 +1033,7 @@ static int advk_pcie_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	advk_pcie_setup_hw(pcie);
> +	advk_pcie_setup_hw(pcie, ep_rdy_time);
>  
>  	advk_sw_pci_bridge_init(pcie);
>  
> -- 
> 2.20.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
