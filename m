Return-Path: <SRS0=ZQO4=QM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF47C282CB
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 09:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37BC42073D
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 09:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfBEJn7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 5 Feb 2019 04:43:59 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49795 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbfBEJn7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Feb 2019 04:43:59 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gqxGn-00029G-EA; Tue, 05 Feb 2019 10:43:57 +0100
Message-ID: <1549359836.2544.33.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/3] dt-bindings: imx6q-pcie: Add description of
 imx7d pcie phy
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Trent Piepho <tpiepho@impinj.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org
Date:   Tue, 05 Feb 2019 10:43:56 +0100
In-Reply-To: <20190205001721.18639-2-tpiepho@impinj.com>
References: <20190205001721.18639-1-tpiepho@impinj.com>
         <20190205001721.18639-2-tpiepho@impinj.com>
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
> There is a separate PHY device with its own registers on imx7d.  It's
> currently unused, but a PCIe erratum on imx7d will require it for the
> workaround.
> 
> Signed-off-by: Trent Piepho <tpiepho@impinj.com>

I'm generally fine with this, but really want to see an Ack from the DT
folks (CC'ed) on this.

Acked-by: Lucas Stach <l.stach@pengutronix.de>

Regards,
Lucas

> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> index d514c1f2365f..f4933c8951bc 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> @@ -53,6 +53,7 @@ Additional required properties for imx7d-pcie:
> >  	       - "pciephy"
> >  	       - "apps"
> >  	       - "turnoff"
> +- fsl,imx7d-pcie-phy: A phandle to an fsl,imx7d-pcie-phy node.
>  
>  Example:
>  
> @@ -79,3 +80,13 @@ Example:
> >  		clocks = <&clks 144>, <&clks 206>, <&clks 189>;
> >  		clock-names = "pcie", "pcie_bus", "pcie_phy";
> >  	};
> +
> +* Freescale i.MX7d PCIe PHY
> +
> +This is the PHY associated with the IMX7d PCIe controller.  It's used by the
> +PCI-e controller via the fsl,imx7d-pcie-phy phandle.
> +
> +Required properties:
> +- compatible:
> > +	- "fsl,imx7d-pcie-phy"
> +- reg: base address and length of the PCIe PHY controller
