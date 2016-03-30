Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ibawizard.net ([82.208.49.253]:55722 "EHLO
	mengele.ibawizard.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752998AbcC3MPz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2016 08:15:55 -0400
Date: Wed, 30 Mar 2016 14:06:44 +0200
From: Petr =?iso-8859-2?Q?=A9tetiar?= <ynezz@true.cz>
To: Krzysztof =?iso-8859-2?Q?Ha=B3asa?= <khalasa@piap.pl>
Cc: Petr =?iso-8859-2?Q?=A9tetiar?= <ynezz@true.cz>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Marcel Ziswiler <marcel.ziswiler@toradex.com>,
	Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH] i.MX6 PCIe: Fix imx6_pcie_deassert_core_reset()
	polarity
Message-ID: <20160330120644.GM20367@ibawizard.net>
Reply-To: Petr =?iso-8859-2?Q?=A9tetiar?= <ynezz@true.cz>
References: <m3h9fuk7ik.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <m3h9fuk7ik.fsf@t19.piap.pl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Krzysztof Ha³asa <khalasa@piap.pl> [2016-03-25 14:32:35]:

Cze¶æ,

> I wonder if all boards (except maybe that Toradex set) use an active-low
> PCIe reset and are now broken. Perhaps Toradex uses active-high and thus
> works.

I'm really puzzled by this :-) With your patch applied I get following on
Toradex Apalis modules:

 DTS:         reset-gpio = <&gpio1 28 GPIO_ACTIVE_LOW>;
 dmesg:       imx6q-pcie 1ffc000.pcie: phy link never came up
 gpio:        gpio-28  (                    |reset               ) out hi
 pin voltage: 0V

 DTS:         reset-gpio = <&gpio1 28 GPIO_ACTIVE_HIGH>;
 dmesg:       ath9k 0000:01:00.0: enabling device (0140 -> 0142)
 gpio:        gpio-28  (                    |reset               ) out lo
 pin voltage: 3V3

So Toradex Apalis is actually active-high? Thanks.

-- ynezz
