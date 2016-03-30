Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:33717 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217AbcC3MqO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2016 08:46:14 -0400
MIME-Version: 1.0
In-Reply-To: <20160330120644.GM20367@ibawizard.net>
References: <m3h9fuk7ik.fsf@t19.piap.pl>
	<20160330120644.GM20367@ibawizard.net>
Date: Wed, 30 Mar 2016 09:45:21 -0300
Message-ID: <CAOMZO5DK-K19bHhEpyGoVak5Y7bT-xzA9GjtBSiO6Z+yfeEdgw@mail.gmail.com>
Subject: Re: [PATCH] i.MX6 PCIe: Fix imx6_pcie_deassert_core_reset() polarity
From: Fabio Estevam <festevam@gmail.com>
To: =?UTF-8?Q?Petr_=C5=A0tetiar?= <ynezz@true.cz>
Cc: =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>,
	Marcel Ziswiler <marcel.ziswiler@toradex.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Stefan Agner <stefan@agner.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 30, 2016 at 9:06 AM, Petr Štetiar <ynezz@true.cz> wrote:

> I'm really puzzled by this :-) With your patch applied I get following on
> Toradex Apalis modules:
>
>  DTS:         reset-gpio = <&gpio1 28 GPIO_ACTIVE_LOW>;
>  dmesg:       imx6q-pcie 1ffc000.pcie: phy link never came up
>  gpio:        gpio-28  (                    |reset               ) out hi
>  pin voltage: 0V
>
>  DTS:         reset-gpio = <&gpio1 28 GPIO_ACTIVE_HIGH>;
>  dmesg:       ath9k 0000:01:00.0: enabling device (0140 -> 0142)
>  gpio:        gpio-28  (                    |reset               ) out lo
>  pin voltage: 3V3
>
> So Toradex Apalis is actually active-high? Thanks.

Yes, exactly. That's why you need to introduce a new property to
handle the active-high case, so that old dtb's are not broken.
