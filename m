Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:33865 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759375AbcDEPqy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Apr 2016 11:46:54 -0400
MIME-Version: 1.0
In-Reply-To: <1459514508-8557-3-git-send-email-ynezz@true.cz>
References: <1459514508-8557-1-git-send-email-ynezz@true.cz>
	<1459514508-8557-3-git-send-email-ynezz@true.cz>
Date: Tue, 5 Apr 2016 12:46:53 -0300
Message-ID: <CAOMZO5AnN4_RrA4bksWNmioAP1PCBT1Ax4of_OnoCvG+VXgDUQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: imx6: Add reset-gpio-active-high boolean
 property to DT
From: Fabio Estevam <festevam@gmail.com>
To: =?UTF-8?Q?Petr_=C5=A0tetiar?= <ynezz@true.cz>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
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
	=?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>,
	Marcel Ziswiler <marcel.ziswiler@toradex.com>,
	Stefan Agner <stefan@agner.ch>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 1, 2016 at 9:41 AM, Petr Štetiar <ynezz@true.cz> wrote:

>         /* Some boards don't have PCIe reset GPIO. */
>         if (gpio_is_valid(imx6_pcie->reset_gpio)) {
> -               gpio_set_value_cansleep(imx6_pcie->reset_gpio, 0);
> +               gpio_set_value_cansleep(imx6_pcie->reset_gpio,
> +                                       !!imx6_pcie->gpio_active_high);

gpio_set_value_cansleep(imx6_pcie->reset_gpio,
                                      imx6_pcie->gpio_active_high); is enough.

> @@ -546,9 +549,14 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
>
>         /* Fetch GPIOs */
>         imx6_pcie->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
> +       imx6_pcie->gpio_active_high = of_property_read_bool(np,
> +                                               "reset-gpio-active-high");

You need to document reset-gpio-active-high property in
Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt.
