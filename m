Return-Path: <SRS0=6piv=WY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46622C3A5A1
	for <linux-pci@archiver.kernel.org>; Wed, 28 Aug 2019 17:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9BE22CF8
	for <linux-pci@archiver.kernel.org>; Wed, 28 Aug 2019 17:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567014865;
	bh=Kl7doDDvFjZeJz2huzkoDhxJddAuklEyxayDYweQoBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c3QCpMv7/4j+ApHetEAdXe+dq7LeXnjAAaFqiJfnuIRLJpBYZ2kC+orerOH92cfl2
	 gy9uWW2BTOlTQQ1gvDkuOF6Xq7swKLCw/sCxGJNU+E18AeC6VGBjdnWcSenX7P0Cxf
	 bIlC3164aTOW4aSa6id/1FvQ753U/C8E0tWFOos8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfH1RyY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Aug 2019 13:54:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbfH1RyY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Aug 2019 13:54:24 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBBEF20679;
        Wed, 28 Aug 2019 17:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567014863;
        bh=Kl7doDDvFjZeJz2huzkoDhxJddAuklEyxayDYweQoBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EYdYqTcOou3ymTbymTEZ8xdytQgKSz0fIkTmELbZiXVDZx7RRjqJnMKHOCsuiI9os
         qtpud9yE9I4cmSNFWjEAOvhYnApFDqRRfjwFOjWEKNgOOiPTAonVkC6c2RAMzMYiR3
         rhm4LanJwS6qtnyIrOjJz8oSyv9VmdX7IwEfqX20=
Date:   Wed, 28 Aug 2019 12:54:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        linux-pci@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 1/5] PCI: exynos: Properly handle optional PHYs
Message-ID: <20190828175420.GA7013@google.com>
References: <20190828163636.12967-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828163636.12967-1-thierry.reding@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This could use a [0/n] cover letter to hold this together as a series.

In my mind, "Properly" adds nothing (why would we merge something done
"improperly"?) and takes space that could be better used for more
specific details.

On Wed, Aug 28, 2019 at 06:36:32PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> devm_of_phy_get() can fail for a number of resides besides probe
> deferral. It can for example return -ENOMEM if it runs out of memory as
> it tries to allocate devres structures. Propagating only -EPROBE_DEFER
> is problematic because it results in these legitimately fatal errors
> being treated as "PHY not specified in DT".

s/resides/reasons/?  (Also in other patches, I think)

> What we really want is to ignore the optional PHYs only if they have not
> been specified in DT. devm_of_phy_get() returns -ENODEV in this case, so
> that's the special case that we need to handle. So we propagate all
> errors, except -ENODEV, so that real failures will still cause the
> driver to fail probe.
> 
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/pci/controller/dwc/pci-exynos.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
> index cee5f2f590e2..14a6ba4067fb 100644
> --- a/drivers/pci/controller/dwc/pci-exynos.c
> +++ b/drivers/pci/controller/dwc/pci-exynos.c
> @@ -465,7 +465,7 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
>  
>  	ep->phy = devm_of_phy_get(dev, np, NULL);
>  	if (IS_ERR(ep->phy)) {
> -		if (PTR_ERR(ep->phy) == -EPROBE_DEFER)
> +		if (PTR_ERR(ep->phy) != -ENODEV)
>  			return PTR_ERR(ep->phy);
>  
>  		ep->phy = NULL;
> -- 
> 2.22.0
> 
