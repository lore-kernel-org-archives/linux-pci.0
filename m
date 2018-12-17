Return-Path: <SRS0=7Kzx=O2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38F9C43387
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 13:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D852145D
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 13:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545055117;
	bh=fMAJHnfi5IG4Ruj4T3wXEl4IsIwZe6gAaTaAQFNacZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GMyzBlq/2pRQJeX0NaUWTkdgYACfAGM8roV1vReeBARiDPpiwrg6C9mBI0jb4uq41
	 VhiQrwG6Xlz8eYbCcPa7snkKL8E5cCCwf80LiGagda7XoWARCs3fI2Hu2gSk7uipY8
	 2AP+G1zdv/nhzcCvdgk99zKc5GoMnJD9tyzMSqX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbeLQN6g (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Dec 2018 08:58:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:57334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727651AbeLQN6g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Dec 2018 08:58:36 -0500
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B0282133F;
        Mon, 17 Dec 2018 13:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545055115;
        bh=fMAJHnfi5IG4Ruj4T3wXEl4IsIwZe6gAaTaAQFNacZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MIC4UmgFCJhAASGPwQ/R2JehEu2jCJ92mdSwyM6IM8o6/CSwqPcpfwolKflSUM0hk
         V88ifYAgrUgP1iIamyzKZt8igCCvW8aWslmUwQtH/eq9+OVHfES6DGsePBfPfcFI9m
         VsOaWTNvt0nsG/UvXozjweEkDCP05izvsR5TMcK0=
Date:   Mon, 17 Dec 2018 07:58:33 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: imx6: Make fallthrough comments more consistent
Message-ID: <20181217135833.GJ20725@google.com>
References: <20181216230916.22982-1-andrew.smirnov@gmail.com>
 <20181216230916.22982-4-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181216230916.22982-4-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Dec 16, 2018 at 03:09:16PM -0800, Andrey Smirnov wrote:
> Convert all fallthrough comments to say "fall through", as well as
> modify their placement to the point where the "break" would normally
> be.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Leonard Crestez <leonard.crestez@nxp.com>
> Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: linux-imx@nxp.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>

I didn't make it very clear, but my suggestion was really to remove
the annotation completely; see below.

> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 59658577e81d..a0510e185d44 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -362,7 +362,8 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
>  
>  	switch (imx6_pcie->variant) {
>  	case IMX7D:
> -	case IMX8MQ: /* FALLTHROUGH */
> +		/* fall through */
> +	case IMX8MQ:
>  		reset_control_assert(imx6_pcie->pciephy_reset);
>  		reset_control_assert(imx6_pcie->apps_reset);
>  		break;

IMO this use of "fall through" is superfluous and unusual in the Linux
source.

A "fall through" comment would be useful if the IMX7D case had
executable code but no "break".  Then the comment shows that the
intent was to execute *both* the IMX7D code and the IMX8MQ code and
the lack of a "break" was intentional.

In this case, the intent is to treat IMX7D and IMX8MQ the same, and
there's no executable code specifically for the IMX7D.  I think it's
easiest to read that when the list of identical cases is all together
without the comment in the middle, i.e., as

>  	case IMX7D:
> 	case IMX8MQ:
>  		reset_control_assert(imx6_pcie->pciephy_reset);

rather than this:

>  	case IMX7D:
> 		/* fall through */
> 	case IMX8MQ:
>  		reset_control_assert(imx6_pcie->pciephy_reset);
