Return-Path: <SRS0=okY7=QN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23856C169C4
	for <linux-pci@archiver.kernel.org>; Wed,  6 Feb 2019 11:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19C32075D
	for <linux-pci@archiver.kernel.org>; Wed,  6 Feb 2019 11:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfBFLMv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:12:51 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:32923 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfBFLMv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Feb 2019 06:12:51 -0500
Received: from localhost (alyon-652-1-53-40.w109-213.abo.wanadoo.fr [109.213.164.40])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id D8A79240003;
        Wed,  6 Feb 2019 11:12:46 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v3 15/15] ARM64: dts: marvell: armada-3720-espressobin: declare PCIe warm reset pin
In-Reply-To: <20190108162441.5278-16-miquel.raynal@bootlin.com>
References: <20190108162441.5278-1-miquel.raynal@bootlin.com> <20190108162441.5278-16-miquel.raynal@bootlin.com>
Date:   Wed, 06 Feb 2019 12:12:46 +0100
Message-ID: <87r2cl6uhd.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Miquel,
 
 On mar., janv. 08 2019, Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Ensure the PCIe endpoint card reset that is toggled by the PCIe
> controller itself is muxed correctly on the EspressoBin.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to mvebu/dt64

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> index c5c72902c647..f19c1ecd5703 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> @@ -47,6 +47,8 @@
>  &pcie0 {
>  	status = "okay";
>  	phys = <&comphy1 0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie_reset_pins &pcie_clkreq_pins>;
>  };
>  
>  /* J6 */
> -- 
> 2.19.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
