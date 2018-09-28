Return-Path: <SRS0=ex/N=MK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FEEC43382
	for <linux-pci@archiver.kernel.org>; Fri, 28 Sep 2018 15:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A388020868
	for <linux-pci@archiver.kernel.org>; Fri, 28 Sep 2018 15:31:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A388020868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbeI1Vzq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 28 Sep 2018 17:55:46 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52186 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbeI1Vzq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Sep 2018 17:55:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 853B0ED1;
        Fri, 28 Sep 2018 08:31:29 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.Emea.Arm.com [10.4.13.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47A8C3F5BD;
        Fri, 28 Sep 2018 08:31:28 -0700 (PDT)
Date:   Fri, 28 Sep 2018 16:31:25 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Alan Douglas <adouglas@cadence.com>
Cc:     kishon@ti.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        cyrille.pitchen@bootlin.com, colin.king@canonical.com
Subject: Re: [PATCH v2] PCI: cadence: Correct probe behaviour when failing to
 get PHY
Message-ID: <20180928153125.GB24460@e107981-ln.cambridge.arm.com>
References: <1538131878-8305-1-git-send-email-adouglas@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538131878-8305-1-git-send-email-adouglas@cadence.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 28, 2018 at 11:51:18AM +0100, Alan Douglas wrote:
> Test the correct value to see whether the PHY get failed.
> 
> Use devm_phy_get() instead of devm_phy_optional_get(), since it is
> only called if phy name is given in devicetree and so should exist.
> If failure when getting or linking PHY, put any PHYs which were
> already got and unlink them.
> 
> Fixes: dfb80534692ddc5b ("PCI: cadence: Add generic PHY support to host and EP drivers")
> Signed-off-by: Alan Douglas <adouglas@cadence.com>
> ---
> changes since v1:
>    - Correct error in while loop pointed out by Colin King

Is there a reason why I should NOT add Colin as a Reported-by ?

Lorenzo

>  drivers/pci/controller/pcie-cadence.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-cadence.c b/drivers/pci/controller/pcie-cadence.c
> index 86f1b00..5865512 100644
> --- a/drivers/pci/controller/pcie-cadence.c
> +++ b/drivers/pci/controller/pcie-cadence.c
> @@ -190,14 +190,16 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
>  
>  	for (i = 0; i < phy_count; i++) {
>  		of_property_read_string_index(np, "phy-names", i, &name);
> -		phy[i] = devm_phy_optional_get(dev, name);
> -		if (IS_ERR(phy))
> -			return PTR_ERR(phy);
> -
> +		phy[i] = devm_phy_get(dev, name);
> +		if (IS_ERR(phy[i])) {
> +			ret = PTR_ERR(phy[i]);
> +			goto err_phy;
> +		}
>  		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
>  		if (!link[i]) {
> +			devm_phy_put(dev, phy[i]);
>  			ret = -EINVAL;
> -			goto err_link;
> +			goto err_phy;
>  		}
>  	}
>  
> @@ -207,13 +209,15 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
>  
>  	ret =  cdns_pcie_enable_phy(pcie);
>  	if (ret)
> -		goto err_link;
> +		goto err_phy;
>  
>  	return 0;
>  
> -err_link:
> -	while (--i >= 0)
> +err_phy:
> +	while (--i >= 0) {
>  		device_link_del(link[i]);
> +		devm_phy_put(dev, phy[i]);
> +	}
>  
>  	return ret;
>  }
> -- 
> 1.9.0
> 
