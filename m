Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08816C282E1
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D625B2183E
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbfDWQcN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:32:13 -0400
Received: from foss.arm.com ([217.140.101.70]:59450 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728005AbfDWQcL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Apr 2019 12:32:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FA2780D;
        Tue, 23 Apr 2019 09:32:10 -0700 (PDT)
Received: from red-moon (unknown [10.1.197.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A3C13F557;
        Tue, 23 Apr 2019 09:32:08 -0700 (PDT)
Date:   Tue, 23 Apr 2019 17:32:15 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH] pci: aardvark: Wait for endpoint to be ready before
 training link
Message-ID: <20190423163215.GB26523@red-moon>
References: <20190313213752.1246-1-repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313213752.1246-1-repk@triplefau.lt>
User-Agent: Mutt/1.5.21 (2010-09-15)
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
> 
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

Nit: I prefer the prototype to be in one line, I wrap it for you.

I am wondering why you need to pass in ep_rdy_time parameter when you
can easily compute it in the function itself.

Regardless, I need Thomas's ACK to proceed, I can make these changes
myself.

Thanks,
Lorenzo

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
> +
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
