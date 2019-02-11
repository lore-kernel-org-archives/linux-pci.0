Return-Path: <SRS0=XN0A=QS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEE8C169C4
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 21:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2764218A1
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 21:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549921143;
	bh=t07PDIPAIXwBNn2qAlVYcGhMOJCqHlnakdrVi8oEDtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RvXByRJYWad+Woy2rcBkeBeglV2AMiQ2oievFzYjoCrJseH4TyOs7WsH3br0nCOSc
	 iilm7R22vkQFwE8KbvvmRLylbkcJSgjE5pfKRhz7af4zQfmylvT0mLTXxI4FFN20q2
	 4DcW1V6wsrnvs8pTY4fMvTI4kWtPhb50FWR1t6IU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfBKVjD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:39:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:46688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbfBKVjC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Feb 2019 16:39:02 -0500
Received: from localhost (unknown [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC0662081B;
        Mon, 11 Feb 2019 21:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549921141;
        bh=t07PDIPAIXwBNn2qAlVYcGhMOJCqHlnakdrVi8oEDtQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n6hk4t+MTEDJiSs+9/9yxCGnVZ6yuEE0xeY8WOD2eNhYzvdPoNYCAdnbA319cUfwn
         8L9zeBydJ7CbN3yQX2vuUVN3vTPhK75V+StVZ15/c0vDhgRJeB/q2N++Fj+4MOy+nL
         V+zwoB6Rdr0myKru/6Jpcz0fQ9mwhkm5zqWmuWoQ=
Date:   Mon, 11 Feb 2019 15:39:00 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stefan Agner <stefan@agner.ch>
Cc:     lorenzo.pieralisi@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, l.stach@pengutronix.de,
        tpiepho@impinj.com, leonard.crestez@nxp.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: imx6: limit DBI register length
Message-ID: <20190211213900.GA247873@google.com>
References: <14fafdf52d19feb9c926c312f4e3ba7ff8a4bad9.1549446867.git.stefan@agner.ch>
 <119211b4f2e9ada55b86041d009656e49c2b5281.1549446867.git.stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <119211b4f2e9ada55b86041d009656e49c2b5281.1549446867.git.stefan@agner.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 06, 2019 at 10:57:32AM +0100, Stefan Agner wrote:
> Define the length of the DBI registers. This makes sure that
> the kernel does not access registers beyond that point, avoiding
> the following abort on a i.MX 6Quad:
>   # cat /sys/devices/soc0/soc/1ffc000.pcie/pci0000\:00/0000\:00\:00.0/config
>   [  100.021433] Unhandled fault: imprecise external abort (0x1406) at 0xb6ea7000
>   ...
>   [  100.056423] PC is at dw_pcie_read+0x50/0x84
>   [  100.060790] LR is at dw_pcie_rd_own_conf+0x44/0x48
>   ...

I assume this problem happens when using the pci_read_config() path or
something similar?

Could this be solved using pci_dev.cfg_size instead of building a new
dwc-specific mechanism?  There are some quirks that set dev->cfg_size
to keep from reading past certain points in config space, e.g.,
quirk_citrine(), quirk_nfp6000().

I'm not necessarily opposed to doing it in dwc, but maybe there's some
advantage in reducing the number of ways of doing the same thing.

> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> ---
> Changes in v3:
> - Rebase on pci/dwc
> Changes in v4:
> - Rebase on pci/dwc
> Changes in v5:
> - Rebased ontop of pci/dwc
> - Use DBI length of 0x200
> 
>  drivers/pci/controller/dwc/pci-imx6.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index c1d434ba3642..1ef7be1232f3 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -55,6 +55,7 @@ enum imx6_pcie_variants {
>  struct imx6_pcie_drvdata {
>  	enum imx6_pcie_variants variant;
>  	u32 flags;
> +	int dbi_length;
>  };
>  
>  struct imx6_pcie {
> @@ -1087,6 +1088,8 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  		break;
>  	}
>  
> +	pci->dbi_length = imx6_pcie->drvdata->dbi_length;
> +
>  	/* Grab turnoff reset */
>  	imx6_pcie->turnoff_reset = devm_reset_control_get_optional_exclusive(dev, "turnoff");
>  	if (IS_ERR(imx6_pcie->turnoff_reset)) {
> @@ -1170,6 +1173,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  		.variant = IMX6Q,
>  		.flags = IMX6_PCIE_FLAG_IMX6_PHY |
>  			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
> +		.dbi_length = 0x200,
>  	},
>  	[IMX6SX] = {
>  		.variant = IMX6SX,
> -- 
> 2.20.1
> 
