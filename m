Return-Path: <SRS0=okY7=QN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF76C169C4
	for <linux-pci@archiver.kernel.org>; Wed,  6 Feb 2019 11:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 987C3218A3
	for <linux-pci@archiver.kernel.org>; Wed,  6 Feb 2019 11:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbfBFLME (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:12:04 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:35987 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfBFLMD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Feb 2019 06:12:03 -0500
Received: from localhost (alyon-652-1-53-40.w109-213.abo.wanadoo.fr [109.213.164.40])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id A6096240003;
        Wed,  6 Feb 2019 11:11:59 +0000 (UTC)
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
Subject: Re: [PATCH v3 14/15] ARM64: dts: marvell: armada-37xx: declare PCIe reset pin
In-Reply-To: <20190108162441.5278-15-miquel.raynal@bootlin.com>
References: <20190108162441.5278-1-miquel.raynal@bootlin.com> <20190108162441.5278-15-miquel.raynal@bootlin.com>
Date:   Wed, 06 Feb 2019 12:11:59 +0100
Message-ID: <87tvhh6uio.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Miquel,
 
 On mar., janv. 08 2019, Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> One pin can be muxed as PCIe endpoint card reset.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to mvebu/dt64

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> index f6f8d2b3b2c1..91c0ec9c382b 100644
> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> @@ -295,6 +295,15 @@
>  					function = "mii";
>  				};
>  
> +				pcie_reset_pins: pcie-reset-pins {
> +					groups = "pcie1";
> +					function = "pcie";
> +				};
> +
> +				pcie_clkreq_pins: pcie-clkreq-pins {
> +					groups = "pcie1_clkreq";
> +					function = "pcie";
> +				};
>  			};
>  
>  			eth0: ethernet@30000 {
> -- 
> 2.19.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
