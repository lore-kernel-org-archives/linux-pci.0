Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ibawizard.net ([82.208.49.253]:40937 "EHLO
	mengele.ibawizard.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983AbcC3NAK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2016 09:00:10 -0400
Date: Wed, 30 Mar 2016 15:00:02 +0200
From: Petr =?iso-8859-2?Q?=A9tetiar?= <ynezz@true.cz>
To: Fabio Estevam <festevam@gmail.com>
Cc: Petr =?iso-8859-2?Q?=A9tetiar?= <ynezz@true.cz>,
	Tim Harvey <tharvey@gateworks.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Krzysztof =?iso-8859-2?Q?Ha=B3asa?= <khalasa@piap.pl>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	stable <stable@vger.kernel.org>
Subject: Re: [PATCH v2] Revert "PCI: imx6: Add support for active-low reset
	GPIO"
Message-ID: <20160330130002.GA13529@ibawizard.net>
Reply-To: Petr =?iso-8859-2?Q?=A9tetiar?= <ynezz@true.cz>
References: <1459201536-5558-1-git-send-email-festevam@gmail.com> <CAJ+vNU3kZ2886wRQFUfFTyo2kzYgjGTroKdiuPynZkaNf1BvEw@mail.gmail.com> <20160330122103.GN20367@ibawizard.net> <CAOMZO5Bh=JgVEMM-8JBX1cpk5Kgn2O2KBiOGdZT+QQfGUizBUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOMZO5Bh=JgVEMM-8JBX1cpk5Kgn2O2KBiOGdZT+QQfGUizBUg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Fabio Estevam <festevam@gmail.com> [2016-03-30 09:36:35]:

Hi Fabio,

> In order to make the Toradex board to work without breaking old dtb's is to
> introduce a property like 'phy-reset-active-high' and handle it in the
> driver.

do we really need to do this?  With Krzysztof's patch it should work for both
cases correctly. If I understand gpiolib correctly, you don't need to
introduce reset-active-high, if you use gpiod_* functions, then the GPIO
polarity is handled correctly inside the gpiolib framework[1] and all you need
is to define pin's polarity correctly via gpio pin definition. Or am I missing
something?

Then we need to just fix the broken DTBs.

1. http://lxr.free-electrons.com/source/drivers/gpio/gpiolib.c#L1759

-- ynezz
