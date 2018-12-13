Return-Path: <SRS0=IRPw=OW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A792C65BAE
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 14:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF98520851
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 14:33:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF98520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbeLMOdV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:33:21 -0500
Received: from mail.bootlin.com ([62.4.15.54]:53752 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727947AbeLMOdV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Dec 2018 09:33:21 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 307032079D; Thu, 13 Dec 2018 15:33:18 +0100 (CET)
Received: from xps13 (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4F74D20510;
        Thu, 13 Dec 2018 15:33:07 +0100 (CET)
Date:   Thu, 13 Dec 2018 15:33:06 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH v2 10/12] ARM64: dts: marvell: armada-3720-espressobin:
 declare PCIe reset GPIO
Message-ID: <20181213153306.4fc3b511@xps13>
In-Reply-To: <20181212102142.16053-11-miquel.raynal@bootlin.com>
References: <20181212102142.16053-1-miquel.raynal@bootlin.com>
        <20181212102142.16053-11-miquel.raynal@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

Miquel Raynal <miquel.raynal@bootlin.com> wrote on Wed, 12 Dec 2018
11:21:40 +0100:

> Add a reset-gpios property to the PCIe node.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> index 094994a9c68e..76a508da80b9 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> @@ -46,6 +46,9 @@
>  /* J9 */
>  &pcie0 {
>  	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie_pins>;
> +	reset-gpios = <&gpiosb 3 GPIO_ACTIVE_HIGH>;
>  };
>  
>  /* J6 */

While this change may be fine for platforms based on Armada 3700 SoC,
it is not for the EspressoBin that has no reset GPIO for PCIe and
instead uses this pin to control the Ethenet switch.

I will re-send a series without this patch. I think it does not hurt to
keep the previous patch adding the pinmux setting in the
Armada-37xx.dtsi file even without using it, so I will drop only this
patch.


Thanks,
Miquèl
