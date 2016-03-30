Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:37611 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbcC3Mgg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2016 08:36:36 -0400
MIME-Version: 1.0
In-Reply-To: <20160330122103.GN20367@ibawizard.net>
References: <1459201536-5558-1-git-send-email-festevam@gmail.com>
	<CAJ+vNU3kZ2886wRQFUfFTyo2kzYgjGTroKdiuPynZkaNf1BvEw@mail.gmail.com>
	<20160330122103.GN20367@ibawizard.net>
Date: Wed, 30 Mar 2016 09:36:35 -0300
Message-ID: <CAOMZO5Bh=JgVEMM-8JBX1cpk5Kgn2O2KBiOGdZT+QQfGUizBUg@mail.gmail.com>
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

On Wed, Mar 30, 2016 at 9:21 AM, Petr Štetiar <ynezz@true.cz> wrote:

> It's just a nitpick :-) but this commit doesn't set the polarity in the wrong
> logic level,

Yes, it does. That's why it causes regressions.

> as you can see, the polarity was simply wrong from the beginning[1]. My patch
> has just probably made the error more exposed.

No, polarity was active low since the beginning.

In order to make the Toradex board to work without breaking old dtb's
is to introduce a property like 'phy-reset-active-high' and handle it
in the driver.

Take a look at the FEC driver for a an example:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/net/ethernet/freescale/fec_main.c?id=962d8cdc3133435aed2928637f73e272128a326c
