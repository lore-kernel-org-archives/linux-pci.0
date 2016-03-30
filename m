Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:42606 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753444AbcC3NU5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2016 09:20:57 -0400
Message-ID: <1459344050.2565.41.camel@pengutronix.de>
Subject: Re: [PATCH v2] Revert "PCI: imx6: Add support for active-low reset
 GPIO"
From: Lucas Stach <l.stach@pengutronix.de>
To: Petr =?UTF-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
Cc: Fabio Estevam <festevam@gmail.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Krzysztof =?UTF-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	stable <stable@vger.kernel.org>
Date: Wed, 30 Mar 2016 15:20:50 +0200
In-Reply-To: <20160330131639.GO20367@ibawizard.net>
References: <1459201536-5558-1-git-send-email-festevam@gmail.com>
	 <CAJ+vNU3kZ2886wRQFUfFTyo2kzYgjGTroKdiuPynZkaNf1BvEw@mail.gmail.com>
	 <20160330122103.GN20367@ibawizard.net>
	 <CAOMZO5Bh=JgVEMM-8JBX1cpk5Kgn2O2KBiOGdZT+QQfGUizBUg@mail.gmail.com>
	 <20160330130002.GA13529@ibawizard.net>
	 <CAOMZO5BNteOTj+m3h6y83wa25yqz7pb3c1osJbxrea+8B=se3Q@mail.gmail.com>
	 <20160330131639.GO20367@ibawizard.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Mittwoch, den 30.03.2016, 15:16 +0200 schrieb Petr Štetiar:
> Fabio Estevam <festevam@gmail.com> [2016-03-30 10:07:16]:
> 
> > If we apply Krzysztof's patch then we break PCI in imx6qdl-sabresd.
> > 
> > In this board we have:
> > 
> > reset-gpio = <&gpio7 12 0>;
> > 
> > , which is wrong. Of course, we should fix this to be 'reset-gpio =
> > <&gpio7 12 GPIO_ACTIVE_LOW>;'
> > 
> > However we should not break old dtb's. That's why reverting the patch
> > is the only solution we have so that old dtb's still work.
> 
> But this only apply for stable right? I understand this and it's fine with me.
> 
> > We have had this same problem for the FEC PHY reset. The solution
> > there was to add a new property to treat the active-high case.
> 
> In next we should fix it correctly, apply Krzysztof's patch and fix broken
> DTBs, right?
> 
We can and should fix broken DTs, but keeping DT stability means we need
to be able to support old (unfixed) DTs with future kernels.

So we can not just fix the DTs and move on, as kernel and DT are two
separate entities, even if they are currently distributed through the
same source tree.

Regards,
Lucas

