Return-Path: <SRS0=aMvC=SS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D547C10F13
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 10:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4797320868
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 10:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbfDPK0j (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:26:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51758 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729304AbfDPK0i (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Apr 2019 06:26:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 809E415A2;
        Tue, 16 Apr 2019 03:26:37 -0700 (PDT)
Received: from red-moon (unknown [10.1.197.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9CEE3F68F;
        Tue, 16 Apr 2019 03:26:35 -0700 (PDT)
Date:   Tue, 16 Apr 2019 11:26:36 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        patchwork-lst@pengutronix.de
Subject: Re: [PATCH] PCI: imx6: Allow async probe
Message-ID: <20190416102636.GC14503@red-moon>
References: <20190404164517.17735-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404164517.17735-1-l.stach@pengutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 04, 2019 at 06:45:17PM +0200, Lucas Stach wrote:
> Establishing a PCIe link can take a while. Allow async probing so all
> this happens in the background while other devices are being probed.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to pci/dwc, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 3d627f94a166..2eb39d5de4f6 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1279,6 +1279,7 @@ static struct platform_driver imx6_pcie_driver = {
>  		.of_match_table = imx6_pcie_of_match,
>  		.suppress_bind_attrs = true,
>  		.pm = &imx6_pcie_pm_ops,
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>  	},
>  	.probe    = imx6_pcie_probe,
>  	.shutdown = imx6_pcie_shutdown,
> -- 
> 2.20.1
> 
