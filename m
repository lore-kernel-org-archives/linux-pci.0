Return-Path: <SRS0=ZQO4=QM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF527C282CB
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 09:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF3552073D
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 09:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbfBEJrG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 5 Feb 2019 04:47:06 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51865 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbfBEJrF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Feb 2019 04:47:05 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gqxJn-0002aD-Ui; Tue, 05 Feb 2019 10:47:03 +0100
Message-ID: <1549360023.2544.35.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/3] ARM: dts: imx7d: Add node for PCIe PHY
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Trent Piepho <tpiepho@impinj.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Date:   Tue, 05 Feb 2019 10:47:03 +0100
In-Reply-To: <20190205001721.18639-3-tpiepho@impinj.com>
References: <20190205001721.18639-1-tpiepho@impinj.com>
         <20190205001721.18639-3-tpiepho@impinj.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Dienstag, den 05.02.2019, 00:17 +0000 schrieb Trent Piepho:
> This adds the PHY as a new node.  The PCI-e controller node gains a
> phandle property that points to it.
> 
> There isn't yet any code in the kernel that uses this device's
> registers, but it will be added for a PCIe PLL erratum workaround.
> 
> Signed-off-by: Trent Piepho <tpiepho@impinj.com>

Looks good, but needs an Ack on the binding change. Also this should go
through Shawns tree, so needs to be split out from the series.

Regards,
Lucas

> ---
>  arch/arm/boot/dts/imx7d.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
> index 6b298e388f4b..6eb98e7c568d 100644
> --- a/arch/arm/boot/dts/imx7d.dtsi
> +++ b/arch/arm/boot/dts/imx7d.dtsi
> @@ -96,6 +96,14 @@
> >  	};
>  };
>  
> +&aips2 {
> +	pcie_phy: pcie-phy@306d0000 {
> +		  compatible = "fsl,imx7d-pcie-phy";
> +		  reg = <0x306d0000 0x10000>;
> +		  status = "disabled";
> +	};
> +};
> +
>  &aips3 {
>  	usbotg2: usb@30b20000 {
>  		compatible = "fsl,imx7d-usb", "fsl,imx27-usb";
> @@ -173,6 +181,7 @@
>  			 <&src IMX7_RESET_PCIE_CTRL_APPS_EN>,
>  			 <&src IMX7_RESET_PCIE_CTRL_APPS_TURNOFF>;
>  		reset-names = "pciephy", "apps", "turnoff";
> +		fsl,imx7d-pcie-phy = <&pcie_phy>;
>  		status = "disabled";
>  	};
>  };
