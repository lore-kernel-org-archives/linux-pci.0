Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C096C10F13
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 20:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E052184B
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 20:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555013080;
	bh=j+KWhq2z4FWE3A8jnN7Ik4l0bYsr0VpcCCBRSLikIUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1FXqwAwmaa0OWP0v3UZisHMQg1d6zffl/v+0dxjFcU2CpuRkSWTY/0MJsZXmwaw4S
	 L33Dc+xb25Bt8CQVHkgbH4VwZbkbXWgb/YsUJTDWVAKFZ19NDWxa1uddG145o/ZP2k
	 i1X8xzRCCMWICfTTqP3H5tWoXcSMcKHD7SElpi8I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbfDKUEj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:04:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbfDKUEj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Apr 2019 16:04:39 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3875020850;
        Thu, 11 Apr 2019 20:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555013078;
        bh=j+KWhq2z4FWE3A8jnN7Ik4l0bYsr0VpcCCBRSLikIUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zHG0R476n3eKIMlNdT3zMnxNserFe8Oy3IhLROaAVhrLXBIQvVxADmgbBHCy+zdst
         wT9YvqHUwwSZRlHuW6CMjaIlQlXNvFhJddvX7g9xy3ASklJFK092KoQQUlIqq/y9o1
         cHLQ6W5L0HsquKhHF3xAKIVT8+I+NMxuOp+QUuaw=
Date:   Thu, 11 Apr 2019 15:04:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 14/30] PCI: tegra: Set target speed as Gen1 before link up
Message-ID: <20190411200437.GR256045@google.com>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-15-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411170355.6882-15-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 11, 2019 at 10:33:39PM +0530, Manikanta Maddireddy wrote:
> Some of the legacy PCIe endpoints doesn't enumerate if root port advertises
> both Gen-1 and Gen-2 speeds. Hence, the strategy followed here is to
> initially advertise only Gen-1 and after link is up, retrain link to Gen-2
> speed.
> 
> Following two cards display this behaviour,
>   - Fusion HDTV 5 Express card
>   - IOGear SIL - PCIE - SATA card

This sounds like a Tegra erratum.  If you think this is an issue with
the endpoints above, not with Tegra, we should see issues with these
cards in non-Tegra systems.

If that's the case, we might need a more far-reaching solution that
would fix issues with these cards in all systems.

If it really is a Tegra erratum, that's fine; just own up to it in the
commit log and comment so it's not misleading.

> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>  drivers/pci/controller/pci-tegra.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index 7dc728cc5f51..7e24eac12668 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -670,6 +670,17 @@ static void tegra_pcie_apply_sw_fixup(struct tegra_pcie_port *port)
>  		value |= soc->update_fc_val;
>  		writel(value, port->base + RP_VEND_XP);
>  	}
> +
> +	/*
> +	 * PCIe link doesn't come up with few legacy PCIe endpoints
> +	 * if root port advertises both Gen-1 and Gen-2 speeds.
> +	 * Hence, the strategy followed here is to initially advertise
> +	 * only Gen-1 and after link is up, retrain link to Gen-2 speed
> +	 */
> +	value = readl(port->base + RP_LINK_CONTROL_STATUS_2);
> +	value &= ~PCI_EXP_LNKSTA_CLS;
> +	value |= PCI_EXP_LNKSTA_CLS_2_5GB;
> +	writel(value, port->base + RP_LINK_CONTROL_STATUS_2);
>  }
>  
>  static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
> -- 
> 2.17.1
> 
