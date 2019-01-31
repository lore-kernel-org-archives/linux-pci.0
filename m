Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C47BC282D9
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 17:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 307272082F
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 17:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfAaR3M (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 12:29:12 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48504 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726507AbfAaR3M (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Jan 2019 12:29:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBFF6A78;
        Thu, 31 Jan 2019 09:29:11 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD2A93F59C;
        Thu, 31 Jan 2019 09:29:10 -0800 (PST)
Date:   Thu, 31 Jan 2019 17:29:07 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dra7xx: Invoke phy_set_mode API to set PHY mode to
 PHY_MODE_PCIE
Message-ID: <20190131172907.GB31110@e107981-ln.cambridge.arm.com>
References: <20190124104537.22271-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124104537.22271-1-kishon@ti.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 24, 2019 at 04:15:37PM +0530, Kishon Vijay Abraham I wrote:
> Certain PHYs used with PCIe controller can also be used with other
> controllers such as USB or SATA. In order to configure the PHY
> to work with PCIe controller, invoke phy_set_mode API with mode
> set to PHY_MODE_PCIE.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied to pci/dwc for v5.1, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index efb26096ccb5..b287dbf6914c 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -517,6 +517,10 @@ static int dra7xx_pcie_enable_phy(struct dra7xx_pcie *dra7xx)
>  	int i;
>  
>  	for (i = 0; i < phy_count; i++) {
> +		ret = phy_set_mode(dra7xx->phy[i], PHY_MODE_PCIE);
> +		if (ret < 0)
> +			goto err_phy;
> +
>  		ret = phy_init(dra7xx->phy[i]);
>  		if (ret < 0)
>  			goto err_phy;
> -- 
> 2.17.1
> 
