Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ibawizard.net ([82.208.49.253]:41429 "EHLO
	mengele.ibawizard.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753843AbcDFILr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Apr 2016 04:11:47 -0400
Date: Wed, 6 Apr 2016 10:11:40 +0200
From: Petr =?iso-8859-2?Q?=A9tetiar?= <ynezz@true.cz>
To: Fabio Estevam <festevam@gmail.com>
Cc: Petr =?iso-8859-2?Q?=A9tetiar?= <ynezz@true.cz>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Russell King <linux@arm.linux.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Tim Harvey <tharvey@gateworks.com>,
	Krzysztof =?iso-8859-2?Q?Ha=B3asa?= <khalasa@piap.pl>,
	Marcel Ziswiler <marcel.ziswiler@toradex.com>,
	Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH 2/2] PCI: imx6: Add reset-gpio-active-high boolean
	property to DT
Message-ID: <20160406081140.GR20367@ibawizard.net>
Reply-To: Petr =?iso-8859-2?Q?=A9tetiar?= <ynezz@true.cz>
References: <1459514508-8557-1-git-send-email-ynezz@true.cz> <1459514508-8557-3-git-send-email-ynezz@true.cz> <CAOMZO5AnN4_RrA4bksWNmioAP1PCBT1Ax4of_OnoCvG+VXgDUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOMZO5AnN4_RrA4bksWNmioAP1PCBT1Ax4of_OnoCvG+VXgDUQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Fabio Estevam <festevam@gmail.com> [2016-04-05 12:46:53]:

> > @@ -546,9 +549,14 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
> >
> >         /* Fetch GPIOs */
> >         imx6_pcie->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
> > +       imx6_pcie->gpio_active_high = of_property_read_bool(np,
> > +                                               "reset-gpio-active-high");
> 
> You need to document reset-gpio-active-high property in
> Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt.

Is something like this fine?

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index 3be80c6..23ecb47 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -19,6 +19,11 @@ Optional properties:
 - fsl,tx-deemph-gen2-6db: Gen2 (6db) De-emphasis value. Default: 20
 - fsl,tx-swing-full: Gen2 TX SWING FULL value. Default: 127
 - fsl,tx-swing-low: TX launch amplitude swing_low value. Default: 127
+- reset-gpio: Should specify the GPIO for PHY reset. Its not polarity aware
+  and defaults to active-low reset sequence (L=reset state, H=operation state).
+- reset-gpio-active-high: If present then the reset sequence using the GPIO
+  specified in the "reset-gpio" property is reversed (H=reset state,
+  L=operation state).

-- ynezz
