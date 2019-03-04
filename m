Return-Path: <SRS0=xyCL=RH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F58AC43381
	for <linux-pci@archiver.kernel.org>; Mon,  4 Mar 2019 19:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E873208E4
	for <linux-pci@archiver.kernel.org>; Mon,  4 Mar 2019 19:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551727552;
	bh=cg2H2O/LudcWigtqlmavYA6HCrRLepT/5ilQN0/b1RI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bapoMhctYBH3VPA5tajtkks1DfcerOcg1MvetHRX2sMIpGvrviX0dRU1oI5ac6AeN
	 kdfl6OAI7kDiRzWX+9iG4i5aoTSOzNBrf43dfApyJCjxvi2zWF7vteFgXqVLn7Wkj6
	 pGHXeEGvLp92S7VXmBi3kFmWnJpmnfeAhO+0In3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfCDTZv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:25:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:35110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbfCDTZv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Mar 2019 14:25:51 -0500
Received: from localhost (unknown [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6A692070B;
        Mon,  4 Mar 2019 19:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551727550;
        bh=cg2H2O/LudcWigtqlmavYA6HCrRLepT/5ilQN0/b1RI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OafehZ9NB0A3HkmjpzAHXm0h1IX20h0Y3vNnbtGLnC91eN38bM+wbHymVWYtMtODW
         gCjb1KrRjmc1O3GqTTjiEqTHcaublBIA6HJgD6PJUza/0AXd3e4mQLFijtmLK+TM4I
         DECAFtwEjV1azNejkWax3QEYfkKK4NQBxwZsq5QQ=
Date:   Mon, 4 Mar 2019 13:25:48 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>,
        kernel@pengutronix.de, patchwork-lst@pengutronix.de,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH] PCI: dwc: skip MSI init if MSIs have been explicitly
 disabled
Message-ID: <20190304192548.GB26569@google.com>
References: <20190227165219.31911-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227165219.31911-1-l.stach@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Marc, in case you have any suggestions]

Hi Lucas,

Nit: this has already been merged, but next time please make the
subject line match the convention wrt capitalization.  This is not a
PCI-specific idea; all it takes is "git log --oneline <file>", and
that should be common practice anywhere in the kernel.

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

Does this mean that if we have a device that uses legacy IRQs, the
user has to figure out to boot with "pci=nomsi"?

I don't like kernel command line parameters.  If we need that
parameter to make devices with legacy IRQs work, what happens without
the parameter?  How obvious is it that the fix is to use "pci=nomsi"?
Is it impossible for Linux to figure this out and make it work
automatically?

If we can't do it automatically, fine, maybe we have to live with the
parameter.  But if there's any way we can avoid it, we should.

> Fixes: c5925afbc58
>        (PCI: dwc: Move MSI IRQs allocation to IRQ domains hierarchical API)
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Tested-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
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
