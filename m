Return-Path: <SRS0=v2Vw=SP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD488C10F11
	for <linux-pci@archiver.kernel.org>; Sat, 13 Apr 2019 14:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7079E2077C
	for <linux-pci@archiver.kernel.org>; Sat, 13 Apr 2019 14:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555165807;
	bh=TX+7DG1vbXdb5EhlxAQmPXddgCAEBxPibp6kcITTDjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zOFXx0SaSG5QDXgxgH08DtRzTVDtd44hjt6Zg9mFIXc7Ft+c1kUBrTOOHiMrqXjSR
	 vUC6FeXUeH1J4XnHY41ht2cEItR1zWNbnQiiVeDU0ojFCaye14jZwrPoYUOEi05Yn8
	 F+q3NceCTlststPmvXjFF6NWlmC1cvX2k9iB6ZQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfDMOaF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 13 Apr 2019 10:30:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbfDMOaF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 13 Apr 2019 10:30:05 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B6AD2077C;
        Sat, 13 Apr 2019 14:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555165803;
        bh=TX+7DG1vbXdb5EhlxAQmPXddgCAEBxPibp6kcITTDjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bklrcgo2lt8Wa3R+Ul/LqqbP40+832Y9Wq//QE7Z+tUF/kj69CP4LCraTCwtal+CQ
         M/ykqHGjiOa7eN7kmZhXbmmJRa7L9aEmYY6THLUkAHqLWHABUMOWYpmFGx+QaW8m5s
         ME2tutXIQ5ka0TuvdoLCGZcO/AEYvXNTGuuyj4AM=
Date:   Sat, 13 Apr 2019 09:30:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-kernel@axis.com
Subject: Re: [PATCH v2 06/26] PCI: keystone: Move initializations to
 appropriate places
Message-ID: <20190413143001.GE126710@google.com>
References: <20190325083501.8088-1-kishon@ti.com>
 <20190325083501.8088-7-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190325083501.8088-7-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 25, 2019 at 02:04:41PM +0530, Kishon Vijay Abraham I wrote:
> No functional change. Move host specific platform_get_resource to
> ks_add_pcie_port and the common platform_get_resource (applicable
> to both host and endpoint) to probe. This is in preparation for
> adding endpoint support to pci-keystone driver.

This seems to move platform_get_resource() *from* (not *to*)
ks_add_pcie_port().

You seem to be making a distinction in the commit log between (1) a
resource that's only used for host mode, and (2) a common resource
that's used for both host and endpoint mode.  But I don't see that
distinction in the patch, so it's a little confusing to mention it in
the commit log.

It must make endpoint support easier, but I can't quite connect the
dots yet.  Maybe endpoint will also use ks_pcie_add_pcie_port(), but
will have a separate .probe() function that doesn't look up the
resource that's specific to host mode?

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/dwc/pci-keystone.c | 27 +++++++++++++----------
>  1 file changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 5eebef9b9ada..95997885a05c 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -806,11 +806,6 @@ static int __init ks_pcie_add_pcie_port(struct keystone_pcie *ks_pcie,
>  	struct resource *res;
>  	int ret;
>  
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbics");
> -	pci->dbi_base = devm_pci_remap_cfg_resource(dev, res);
> -	if (IS_ERR(pci->dbi_base))
> -		return PTR_ERR(pci->dbi_base);
> -
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
>  	pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
>  	if (IS_ERR(pp->va_cfg0_base))
> @@ -818,13 +813,6 @@ static int __init ks_pcie_add_pcie_port(struct keystone_pcie *ks_pcie,
>  
>  	pp->va_cfg1_base = pp->va_cfg0_base;
>  
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "app");
> -	ks_pcie->va_app_base = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(ks_pcie->va_app_base))
> -		return PTR_ERR(ks_pcie->va_app_base);
> -
> -	ks_pcie->app = *res;
> -
>  	pp->ops = &ks_pcie_host_ops;
>  	ret = dw_pcie_host_init(pp);
>  	if (ret) {
> @@ -895,6 +883,8 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
>  	struct dw_pcie *pci;
>  	struct keystone_pcie *ks_pcie;
>  	struct device_link **link;
> +	struct resource *res;
> +	void __iomem *base;
>  	u32 num_viewport;
>  	struct phy **phy;
>  	u32 num_lanes;
> @@ -911,6 +901,19 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
>  	if (!pci)
>  		return -ENOMEM;
>  
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "app");
> +	ks_pcie->va_app_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(ks_pcie->va_app_base))
> +		return PTR_ERR(ks_pcie->va_app_base);
> +
> +	ks_pcie->app = *res;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbics");
> +	base = devm_pci_remap_cfg_resource(dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	pci->dbi_base = base;
>  	pci->dev = dev;
>  	pci->ops = &ks_pcie_dw_pcie_ops;
>  
> -- 
> 2.17.1
> 
