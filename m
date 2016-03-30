Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ibawizard.net ([82.208.49.253]:35583 "EHLO
	mengele.ibawizard.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbcC3MVL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2016 08:21:11 -0400
Date: Wed, 30 Mar 2016 14:21:03 +0200
From: Petr =?iso-8859-2?Q?=A9tetiar?= <ynezz@true.cz>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Fabio Estevam <festevam@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Krzysztof =?iso-8859-2?Q?Ha=B3asa?= <khalasa@piap.pl>,
	Petr =?iso-8859-2?Q?=A9tetiar?= <ynezz@true.cz>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@nxp.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] Revert "PCI: imx6: Add support for active-low reset
	GPIO"
Message-ID: <20160330122103.GN20367@ibawizard.net>
Reply-To: Petr =?iso-8859-2?Q?=A9tetiar?= <ynezz@true.cz>
References: <1459201536-5558-1-git-send-email-festevam@gmail.com> <CAJ+vNU3kZ2886wRQFUfFTyo2kzYgjGTroKdiuPynZkaNf1BvEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJ+vNU3kZ2886wRQFUfFTyo2kzYgjGTroKdiuPynZkaNf1BvEw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Tim Harvey <tharvey@gateworks.com> [2016-03-29 06:43:19]:

> > Commit 5c5fb40de8f14 ("PCI: imx6: Add support for active-low reset GPIO")
> > cause regressions on some boards like MX6 Gateworks Ventana, for example.

Sorry for the problems.

> > The reason for the breakage is that this commit sets the gpio polarity
> > in the wrong logic level.

It's just a nitpick :-) but this commit doesn't set the polarity in the wrong
logic level, 

> > -       if (imx6_pcie->reset_gpio) {
> > -               gpiod_set_value_cansleep(imx6_pcie->reset_gpio, 0);
> > +       if (gpio_is_valid(imx6_pcie->reset_gpio)) {
> > +               gpio_set_value_cansleep(imx6_pcie->reset_gpio, 0);
> >                 msleep(100);
> > -               gpiod_set_value_cansleep(imx6_pcie->reset_gpio, 1);
> > +               gpio_set_value_cansleep(imx6_pcie->reset_gpio, 1);

as you can see, the polarity was simply wrong from the beginning[1]. My patch
has just probably made the error more exposed.

1. https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/pci/host/pci-imx6.c?id=bb38919ec56e0758c3ae56dfc091dcde1391353e

-- ynezz
