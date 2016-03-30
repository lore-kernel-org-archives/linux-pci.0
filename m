Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ibawizard.net ([82.208.49.253]:47844 "EHLO
	mengele.ibawizard.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753271AbcC3NQq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2016 09:16:46 -0400
Date: Wed, 30 Mar 2016 15:16:39 +0200
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
Message-ID: <20160330131639.GO20367@ibawizard.net>
Reply-To: Petr =?iso-8859-2?Q?=A9tetiar?= <ynezz@true.cz>
References: <1459201536-5558-1-git-send-email-festevam@gmail.com> <CAJ+vNU3kZ2886wRQFUfFTyo2kzYgjGTroKdiuPynZkaNf1BvEw@mail.gmail.com> <20160330122103.GN20367@ibawizard.net> <CAOMZO5Bh=JgVEMM-8JBX1cpk5Kgn2O2KBiOGdZT+QQfGUizBUg@mail.gmail.com> <20160330130002.GA13529@ibawizard.net> <CAOMZO5BNteOTj+m3h6y83wa25yqz7pb3c1osJbxrea+8B=se3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOMZO5BNteOTj+m3h6y83wa25yqz7pb3c1osJbxrea+8B=se3Q@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Fabio Estevam <festevam@gmail.com> [2016-03-30 10:07:16]:

> If we apply Krzysztof's patch then we break PCI in imx6qdl-sabresd.
> 
> In this board we have:
> 
> reset-gpio = <&gpio7 12 0>;
> 
> , which is wrong. Of course, we should fix this to be 'reset-gpio =
> <&gpio7 12 GPIO_ACTIVE_LOW>;'
> 
> However we should not break old dtb's. That's why reverting the patch
> is the only solution we have so that old dtb's still work.

But this only apply for stable right? I understand this and it's fine with me.

> We have had this same problem for the FEC PHY reset. The solution
> there was to add a new property to treat the active-high case.

In next we should fix it correctly, apply Krzysztof's patch and fix broken
DTBs, right?

-- ynezz
