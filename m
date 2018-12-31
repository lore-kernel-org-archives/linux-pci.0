Return-Path: <SRS0=55Kx=PI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED154C43387
	for <linux-pci@archiver.kernel.org>; Mon, 31 Dec 2018 20:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C8F218A1
	for <linux-pci@archiver.kernel.org>; Mon, 31 Dec 2018 20:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546288852;
	bh=bXn5PAxPmJETDf7IGQcCLV2q8CDe7Qpa3PLg0V7bzS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B0zAldEfftvOJ4zyBI12ErDkEQDkkSnTvt7Z422poeCaUvECUBiGg2EytqzMUBAF5
	 K+iWS5MO9N+xZiJWH98n9umCrJagfNSElVny+43ENlUI6k2EhjdqDLS/bkR32RPNMr
	 akSwuv/5KBW4fkV9tDnBmrMUz6/MUTQqKJCferVI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbeLaUkw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 31 Dec 2018 15:40:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:52394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727624AbeLaUkv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Dec 2018 15:40:51 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CFF921019;
        Mon, 31 Dec 2018 20:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546288850;
        bh=bXn5PAxPmJETDf7IGQcCLV2q8CDe7Qpa3PLg0V7bzS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aTYR1Zxi26Rp+SN7/3G2m+gYVKwErVNsjVHpWFL5sTx5WxMR6Mon/ZJGs/ZtmozxZ
         mw6+Iu9qEh6oz93zYpsX3T2eqRkrdyJMyrUWMNQHMrfhqCTSsAVRmMbQreg4gr9N4d
         4l7OSzdzo9BflPdNxunHwPtSpk+kPjN/aKjPTUFc=
Date:   Mon, 31 Dec 2018 14:40:48 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        pakki001@umn.edu, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pci: dwc: add a check for resetting gpio
Message-ID: <20181231204048.GG159477@google.com>
References: <20181226022236.71682-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181226022236.71682-1-kjlu@umn.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kangjie,

Thanks for the patch.

On Tue, Dec 25, 2018 at 08:22:36PM -0600, Kangjie Lu wrote:
> devm_gpio_request_one() could fail. The fix checks its status and issues
> an error if it fails.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/pci/controller/dwc/pci-exynos.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
> index cee5f2f590e2..e3a045e215d2 100644
> --- a/drivers/pci/controller/dwc/pci-exynos.c
> +++ b/drivers/pci/controller/dwc/pci-exynos.c
> @@ -226,9 +226,12 @@ static void exynos_pcie_assert_reset(struct exynos_pcie *ep)
>  	struct dw_pcie *pci = ep->pci;
>  	struct device *dev = pci->dev;
>  
> -	if (ep->reset_gpio >= 0)
> -		devm_gpio_request_one(dev, ep->reset_gpio,
> -				GPIOF_OUT_INIT_HIGH, "RESET");
> +	if (ep->reset_gpio >= 0) {
> +		if (devm_gpio_request_one(dev, ep->reset_gpio,
> +				GPIOF_OUT_INIT_HIGH, "RESET"))
> +			dev_err(dev, "Failed requesting reset gpio %d\n",
> +					ep->reset_gpio);
> +	}

Even before your patch, this code doesn't make sense to me.

devm_gpio_request_one() is a setup function and should be called in
the probe path.  The "assert_reset" path should do something like
gpio_set_value().  See other callers, e.g.,

  imx6_pcie_probe()
  histb_pcie_probe()
  mvebu_pcie_parse_port()

I'm skeptical that exynos_pcie_assert_reset() ever worked as intended,
so let's straighten that out before worrying about checking the return
code from devm_gpio_request_one().

The result should be two patches: (1) fix the devm_gpio_request_one()
usage, and (2) check the devm_gpio_request_one() return value.

>  }
