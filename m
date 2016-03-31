Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ni.piap.pl ([195.187.100.4]:42609 "EHLO ni.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978AbcCaFHV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 31 Mar 2016 01:07:21 -0400
From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
To: Fabio Estevam <festevam@gmail.com>
Cc: Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>,
	Tim Harvey <tharvey@gateworks.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	"linux-pci\@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	stable <stable@vger.kernel.org>
Subject: Re: [PATCH v2] Revert "PCI: imx6: Add support for active-low reset GPIO"
References: <1459201536-5558-1-git-send-email-festevam@gmail.com>
	<CAJ+vNU3kZ2886wRQFUfFTyo2kzYgjGTroKdiuPynZkaNf1BvEw@mail.gmail.com>
	<20160330122103.GN20367@ibawizard.net>
	<CAOMZO5Bh=JgVEMM-8JBX1cpk5Kgn2O2KBiOGdZT+QQfGUizBUg@mail.gmail.com>
Date: Thu, 31 Mar 2016 07:07:17 +0200
In-Reply-To: <CAOMZO5Bh=JgVEMM-8JBX1cpk5Kgn2O2KBiOGdZT+QQfGUizBUg@mail.gmail.com>
	(Fabio Estevam's message of "Wed, 30 Mar 2016 09:36:35 -0300")
Message-ID: <m3h9fni6be.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Fabio Estevam <festevam@gmail.com> writes:

> In order to make the Toradex board to work without breaking old dtb's
> is to introduce a property like 'phy-reset-active-high' and handle it
> in the driver.

Well, I don't know. Most DTBs are distributed along the kernel on the
same boot medium. Both ways are far from the ideal. Reverting for now is
ok, but long-term I'd rather fix the buggy DTSs and remove extra stuff.

Old DTBs aren't compatible with new kernels anyway and I guess it will
be the case in the future again (e.g. IIRC pre-4.2 IMX6 DTBs don't boot
on 4.2+ - or was it 4.1?).
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
