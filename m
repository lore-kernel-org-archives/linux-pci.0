Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EBFC43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 09:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4443820877
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 09:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2z0sMRf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4443820877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbeIYP1K (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:27:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:53944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727588AbeIYP1J (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Sep 2018 11:27:09 -0400
Received: from dragon (unknown [104.237.86.64])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC48C20870;
        Tue, 25 Sep 2018 09:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537867232;
        bh=mj9y9mab7lUzK/UuS2xyBkhBFVZ2e8eqOxK11M21Z9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a2z0sMRfzWdHXDzbF8y9pxHRPoviFAjkpYtR+o3z2Mwg7zzapY+6E5nc2te0HJrd5
         hhgHF2gY7fsUxte3t+j1dEeRKKzab75ED4ZToPVUQxDGzWGeErefuriGw/qBpPuxWv
         nYN/owZweZt6563CaCUop6FBugrlI2/4ZQgyP4m0=
Date:   Tue, 25 Sep 2018 17:20:20 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Joao Pinto <Joao.Pinto@synopsys.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-imx@nxp.com, kernel@pengutronix.de,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 5/6] ARM: dts: imx7d: Add turnoff reset
Message-ID: <20180925092018.GA21282@dragon>
References: <cover.1534264292.git.leonard.crestez@nxp.com>
 <c305d4da96ead7d570bf755fde9f0e0cc68f88e0.1534264292.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c305d4da96ead7d570bf755fde9f0e0cc68f88e0.1534264292.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 14, 2018 at 07:50:19PM +0300, Leonard Crestez wrote:
> This is required for the imx pci driver to send the PME_Turn_Off TLP.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Acked-by: Shawn Guo <shawnguo@kernel.org>

> ---
>  arch/arm/boot/dts/imx7d.dtsi | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
> index 7234e8330a57..efbdeaaa8dcd 100644
> --- a/arch/arm/boot/dts/imx7d.dtsi
> +++ b/arch/arm/boot/dts/imx7d.dtsi
> @@ -144,12 +144,13 @@
>  					 <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>;
>  
>  		fsl,max-link-speed = <2>;
>  		power-domains = <&pgc_pcie_phy>;
>  		resets = <&src IMX7_RESET_PCIEPHY>,
> -			 <&src IMX7_RESET_PCIE_CTRL_APPS_EN>;
> -		reset-names = "pciephy", "apps";
> +			 <&src IMX7_RESET_PCIE_CTRL_APPS_EN>,
> +			 <&src IMX7_RESET_PCIE_CTRL_APPS_TURNOFF>;
> +		reset-names = "pciephy", "apps", "turnoff";
>  		status = "disabled";
>  	};
>  };
>  
>  &ca_funnel_ports {
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
