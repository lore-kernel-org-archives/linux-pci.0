Return-Path: <SRS0=EJXn=O3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9089AC43387
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 10:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1FF217D9
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 10:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbeLRK5t (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Dec 2018 05:57:49 -0500
Received: from foss.arm.com ([217.140.101.70]:43180 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbeLRK5t (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Dec 2018 05:57:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 426C4A78;
        Tue, 18 Dec 2018 02:57:49 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA19E3F5C0;
        Tue, 18 Dec 2018 02:57:47 -0800 (PST)
Date:   Tue, 18 Dec 2018 10:57:42 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: imx: Fix an IS_ERR() vs NULL bug
Message-ID: <20181218105742.GA22156@e107981-ln.cambridge.arm.com>
References: <20181218082329.GB440@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218082329.GB440@kadam>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 18, 2018 at 11:23:29AM +0300, Dan Carpenter wrote:
> The device_link_add() function doesn't return error pointers, it returns
> NULL if there is an error.
> 
> Fixes: 7a6991159bcd ("PCI: imx: Add multi-pd support")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Thanks Dan, if you do not mind I will squash this in the initial
commit given that it is not upstream yet.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index b54b4590ccf9..8e7956224a5f 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -326,9 +326,9 @@ static int imx6_pcie_attach_pd(struct device *dev)
>  			DL_FLAG_STATELESS |
>  			DL_FLAG_PM_RUNTIME |
>  			DL_FLAG_RPM_ACTIVE);
> -	if (IS_ERR(link)) {
> -		dev_err(dev, "Failed to add device_link to pcie pd: %ld\n", PTR_ERR(link));
> -		return PTR_ERR(link);
> +	if (!link) {
> +		dev_err(dev, "Failed to add device_link to pcie pd.\n");
> +		return -EINVAL;
>  	}
>  
>  	imx6_pcie->pd_pcie_phy = dev_pm_domain_attach_by_name(dev, "pcie_phy");
> -- 
> 2.17.1
> 
