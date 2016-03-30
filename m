Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:35707 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549AbcC3NHg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2016 09:07:36 -0400
MIME-Version: 1.0
In-Reply-To: <20160330130002.GA13529@ibawizard.net>
References: <1459201536-5558-1-git-send-email-festevam@gmail.com>
	<CAJ+vNU3kZ2886wRQFUfFTyo2kzYgjGTroKdiuPynZkaNf1BvEw@mail.gmail.com>
	<20160330122103.GN20367@ibawizard.net>
	<CAOMZO5Bh=JgVEMM-8JBX1cpk5Kgn2O2KBiOGdZT+QQfGUizBUg@mail.gmail.com>
	<20160330130002.GA13529@ibawizard.net>
Date: Wed, 30 Mar 2016 10:07:16 -0300
Message-ID: <CAOMZO5BNteOTj+m3h6y83wa25yqz7pb3c1osJbxrea+8B=se3Q@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "PCI: imx6: Add support for active-low reset GPIO"
From: Fabio Estevam <festevam@gmail.com>
To: =?UTF-8?Q?Petr_=C5=A0tetiar?= <ynezz@true.cz>
Cc: Tim Harvey <tharvey@gateworks.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	=?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	stable <stable@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Petr,

On Wed, Mar 30, 2016 at 10:00 AM, Petr Štetiar <ynezz@true.cz> wrote:

> do we really need to do this?  With Krzysztof's patch it should work for both
> cases correctly. If I understand gpiolib correctly, you don't need to
> introduce reset-active-high, if you use gpiod_* functions, then the GPIO
> polarity is handled correctly inside the gpiolib framework[1] and all you need
> is to define pin's polarity correctly via gpio pin definition. Or am I missing
> something?
>
> Then we need to just fix the broken DTBs.

If we apply Krzysztof's patch then we break PCI in imx6qdl-sabresd.

In this board we have:

reset-gpio = <&gpio7 12 0>;

, which is wrong. Of course, we should fix this to be 'reset-gpio =
<&gpio7 12 GPIO_ACTIVE_LOW>;'

However we should not break old dtb's. That's why reverting the patch
is the only solution we have so that old dtb's still work.

We have had this same problem for the FEC PHY reset. The solution
there was to add a new property to treat the active-high case.
