Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ni.piap.pl ([195.187.100.4]:52149 "EHLO ni.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751248AbcC2Fn1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 29 Mar 2016 01:43:27 -0400
From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
To: Fabio Estevam <festevam@gmail.com>
Cc: Tim Harvey <tharvey@gateworks.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci\@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel\@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i.MX6 PCIe: Fix imx6_pcie_deassert_core_reset() polarity
References: <m3h9fuk7ik.fsf@t19.piap.pl>
	<CAOMZO5DcZCxoLPeGRWSGkstm7F3eN-Q-yJyf6ktMTda2zLviag@mail.gmail.com>
	<CAOMZO5B8Lzn-E4YOeYxVtN5PN11aOvZHn4eU0ixkdV8CO8+xYw@mail.gmail.com>
	<CAJ+vNU2Sg1ZKBsGcQswrJZyTJ1WBEZor3ZqpoYUT7i9FKjEAog@mail.gmail.com>
	<CAOMZO5DO9G18=_YSri3a+UiYbLwN6AMG4asUXbT03mpbU3hHrw@mail.gmail.com>
	<CAJ+vNU1_YqvWQkmuDB7r8z77iZJS6pP4Mr+j9yW4sFLAeJXQDw@mail.gmail.com>
	<CAOMZO5A2osG3=mTaCayYfMokUj-vT+Udq9ckq45b1yaUP9Tn3g@mail.gmail.com>
	<CAJ+vNU2ST=XG5H04-OCwpHgcvkoXOQw8F3MjXhJmWhBUbxWE-g@mail.gmail.com>
	<CAOMZO5DwuBcpL85GYjTV9yy_ZZB33PDY3TfzwkS1WK03hfkhqg@mail.gmail.com>
	<m31t6tkfjw.fsf@t19.piap.pl>
Date: Tue, 29 Mar 2016 07:43:24 +0200
In-Reply-To: <m31t6tkfjw.fsf@t19.piap.pl> ("Krzysztof \=\?utf-8\?Q\?Ha\=C5\=82as\?\=
 \=\?utf-8\?Q\?a\=22's\?\= message of
	"Tue, 29 Mar 2016 07:40:19 +0200")
Message-ID: <m3wpolj0ub.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> OTOH, we should fix it some day, making sure the DTS files are fixed
> first:
>
> imx6qdl-apf6dev.dtsi:       reset-gpio = <&gpio6 2 GPIO_ACTIVE_HIGH>;
> imx6qdl-aristainetos2.dtsi: reset-gpio = <&gpio2 16 GPIO_ACTIVE_HIGH>;
> imx6qdl-hummingboard.dtsi:  reset-gpio = <&gpio3 4 0>; (I think RMK already handles this)
> imx6qdl-phytec-pfla02.dtsi: reset-gpio = <&gpio4 17 0>;
> imx6qdl-sabresd.dtsi:       reset-gpio = <&gpio7 12 0>;
> imx6q-dmo-edmqmx6.dts:      reset-gpio = <&gpio4 8 0>;
> imx6q-novena.dts:           reset-gpio = <&gpio3 29 GPIO_ACTIVE_HIGH>;
> imx6q-tbs2910.dts:          reset-gpio = <&gpio7 12 GPIO_ACTIVE_HIGH>;

Or maybe we should simply change these to *_LOW, add that short patch
from me, and forget about it.
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
