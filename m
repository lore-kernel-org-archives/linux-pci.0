Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43472 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932505AbcDKNiR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 11 Apr 2016 09:38:17 -0400
Date: Mon, 11 Apr 2016 08:38:10 -0500
From: Rob Herring <robh@kernel.org>
To: Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Russell King <linux@arm.linux.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Sascha Hauer <kernel@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Tim Harvey <tharvey@gateworks.com>,
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Fabio Estevam <festevam@gmail.com>,
	Marcel Ziswiler <marcel.ziswiler@toradex.com>, stefan@agner.ch
Subject: Re: [PATCH v3 2/2] PCI: imx6: Add reset-gpio-active-high boolean
 property to DT
Message-ID: <20160411133810.GA15094@rob-hp-laptop>
References: <1459936100.2256.30.camel@pengutronix.de>
 <1459946207-11923-1-git-send-email-ynezz@true.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1459946207-11923-1-git-send-email-ynezz@true.cz>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 06, 2016 at 02:36:47PM +0200, Petr Štetiar wrote:
> Currently the reset-gpio DT property which controls the PCI bus device
> reset signal defaults to active-low reset sequence (L=reset state,
> H=operation state) plus the code in reset function isn't GPIO polarity
> aware - it doesn't matter if the defined reset-gpio is active-low or
> active-high, it will always result into active-low reset sequence.
> 
> I've tried to fix it properly and changed the reset-gpio reset sequence
> to be polarity aware, but this patch has been accepted and then reverted
> as it has introduced few backward incompatible issues:
> 
> 1. Some of the DTBs as for example imx6qdl-sabresd, doesn't define
> reset-gpio polarity correctly:
> 
>   reset-gpio = <&gpio7 12 0>;
> 
> which means, that it's defined as active-high, but in reality it's
> active-low, thus it wouldn't work without DTS fix.
> 
> 2. The logic in reset function is inverted:
> 
> 	gpio_set_value_cansleep(imx6_pcie->reset_gpio, 0)
> 	msleep(100);
> 	gpio_set_value_cansleep(imx6_pcie->reset_gpio, 1);
> 
> so even if some of the i.MX6 boards had reset-gpio polarity defined
> correctly in their DTSes, they would stop working.
> 
> As we can't break old DTBs, we can't fix them and that's why we need to
> introduce this new DT reset-gpio-active-high boolean property, so we can
> support boards with active-high reset sequence.
> 
> This active-high reset sequence is for example needed on Apalis SoMs,
> where GPIO1_IO28, used to PCIe reset is not connected directly to PERST#
> PCIe signal, but it's ORed with RESETBMCU coming off the PMIC, and thus
> is inverted, active-high.
> 
> Signed-off-by: Petr Štetiar <ynezz@true.cz>
> ---
>  Changes since v1:
> 
>   * Added documentation of reset-gpio and reset-gpio-active-high DT properties
>   * Removed unnecessary double negation of GPIO value
> 
>  Changes since v2:
> 
>   * Changed commit message so it explains in more detail why we need new DT
>     property
>   * Changed PHY to 'bus device' in binding's documentation
> 
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt |  6 ++++++
>  drivers/pci/host/pci-imx6.c                              | 14 +++++++++++---
>  2 files changed, 17 insertions(+), 3 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
