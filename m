Return-Path: <SRS0=y4Wk=RD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF1EC43381
	for <linux-pci@archiver.kernel.org>; Thu, 28 Feb 2019 13:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58E62171F
	for <linux-pci@archiver.kernel.org>; Thu, 28 Feb 2019 13:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfB1N3o (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:29:44 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47744 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727876AbfB1N3o (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Feb 2019 08:29:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25A1B80D;
        Thu, 28 Feb 2019 05:29:44 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F8B73F703;
        Thu, 28 Feb 2019 05:29:42 -0800 (PST)
Date:   Thu, 28 Feb 2019 13:29:36 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Tim Harvey <tharvey@gateworks.com>, kernel@pengutronix.de,
        patchwork-lst@pengutronix.de
Subject: Re: [PATCH] PCI: dwc: skip MSI init if MSIs have been explicitly
 disabled
Message-ID: <20190228132936.GA17873@e107981-ln.cambridge.arm.com>
References: <20190227165219.31911-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227165219.31911-1-l.stach@pengutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 27, 2019 at 05:52:19PM +0100, Lucas Stach wrote:
> Since 7c5925afbc58 (PCI: dwc: Move MSI IRQs allocation to IRQ domains
> hierarchical API) the MSI init claims one of the controller IRQs as a
> chained IRQ line for the MSI controller. On some designs, like the i.MX6,
> this line is shared with a PCIe legacy IRQ. When the line is claimed for
> the MSI domain, any device trying to use this legacy IRQs will fail to
> request this IRQ line.
> 
> As MSI and legacy IRQs are already mutually exclusive on the DWC core,
> as the core won't forward any legacy IRQs once any MSI has been enabled,
> users wishing to use legacy IRQs already need to explictly disable MSI
> support (usually via the pci=nomsi kernel commandline option). To avoid
> any issues with MSI conflicting with legacy IRQs, just skip all of the
> DWC MSI initalization, including the IRQ line claim, when MSI is disabled.
> 
> Fixes: c5925afbc58
>        (PCI: dwc: Move MSI IRQs allocation to IRQ domains hierarchical API)
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Tested-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I request Gustavo's ACK to proceed, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 29a05759a294..f4a8494f616b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -433,7 +433,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	if (ret)
>  		pci->num_viewport = 2;
>  
> -	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +	if (IS_ENABLED(CONFIG_PCI_MSI) && pci_msi_enabled()) {
>  		/*
>  		 * If a specific SoC driver needs to change the
>  		 * default number of vectors, it needs to implement
> -- 
> 2.20.1
> 
