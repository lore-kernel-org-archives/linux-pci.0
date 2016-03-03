Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:45107 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754693AbcCCJcJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Mar 2016 04:32:09 -0500
Message-ID: <1456997527.3772.37.camel@pengutronix.de>
Subject: Re: iMX6q PCIe phy link never came up on kernel v4.4.x
From: Lucas Stach <l.stach@pengutronix.de>
To: Roberto Fichera <kernel@tekno-soft.it>
Cc: linux-pci@vger.kernel.org
Date: Thu, 03 Mar 2016 10:32:07 +0100
In-Reply-To: <56D5E3DF.9030906@tekno-soft.it>
References: <56D5E3DF.9030906@tekno-soft.it>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Roberto,

Am Dienstag, den 01.03.2016, 19:47 +0100 schrieb Roberto Fichera:
> Hi There,
> 
> Working on a custom iMX6q board I'm getting a PCIe phy link never came up, even if uboot seems detecting
> everything ok. My DTS is enabling PCIe with
> 
> &pcie {
>     pinctrl-names = "default";
>     pinctrl-0 = <&pinctrl_pcie_reset>;
>     reset-gpio = <&gpio7 12 0>;
>     status = "okay";
> };
> 
> The PCIe is connected to a PCIe-to-PCI TI XIO2001. The XIO2001 power is controlled by GPIO_9 and 
> the corresponding fixed regulator is set as
> 
> 		reg_pcie: regulator@4 {
> 			compatible = "regulator-fixed";
> 			reg = <4>;
> 			pinctrl-names = "default";
> 			pinctrl-0 = <&pinctrl_pcie_reg>;
> 			regulator-name = "MPCIE_3V3";
> 			regulator-min-microvolt = <3300000>;
> 			regulator-max-microvolt = <3300000>;
> 			gpio = <&gpio1 9 0>;
> 			regulator-always-on;
> 			enable-active-high;
> 		};
> 
> so I'd like to know if there is any other special setup to do in order to get it to work on a v4.4.x kernel.
> Or anyway how to debug it.
> 
> Any suggestion?

Is this a regression from earlier kernel versions?

If so, can you please revert 5c5fb40de8f14 (PCI: imx6: Add support for
active-low reset GPIO) and see if this helps?

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

