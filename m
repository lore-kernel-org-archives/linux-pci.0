Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:44270 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751664AbcCaKgH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 31 Mar 2016 06:36:07 -0400
Message-ID: <1459420555.17926.6.camel@pengutronix.de>
Subject: Re: [PATCH v2] Revert "PCI: imx6: Add support for active-low reset
 GPIO"
From: Lucas Stach <l.stach@pengutronix.de>
To: Krzysztof =?UTF-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Cc: Fabio Estevam <festevam@gmail.com>,
	Petr =?UTF-8?Q?=C5=A0tetiar?= <ynezz@true.cz>,
	Tim Harvey <tharvey@gateworks.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	stable <stable@vger.kernel.org>
Date: Thu, 31 Mar 2016 12:35:55 +0200
In-Reply-To: <m3h9fni6be.fsf@t19.piap.pl>
References: <1459201536-5558-1-git-send-email-festevam@gmail.com>
	 <CAJ+vNU3kZ2886wRQFUfFTyo2kzYgjGTroKdiuPynZkaNf1BvEw@mail.gmail.com>
	 <20160330122103.GN20367@ibawizard.net>
	 <CAOMZO5Bh=JgVEMM-8JBX1cpk5Kgn2O2KBiOGdZT+QQfGUizBUg@mail.gmail.com>
	 <m3h9fni6be.fsf@t19.piap.pl>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Donnerstag, den 31.03.2016, 07:07 +0200 schrieb Krzysztof Hałasa:
> Fabio Estevam <festevam@gmail.com> writes:
> 
> > In order to make the Toradex board to work without breaking old dtb's
> > is to introduce a property like 'phy-reset-active-high' and handle it
> > in the driver.
> 
> Well, I don't know. Most DTBs are distributed along the kernel on the
> same boot medium. Both ways are far from the ideal. Reverting for now is
> ok, but long-term I'd rather fix the buggy DTSs and remove extra stuff.
> 
> Old DTBs aren't compatible with new kernels anyway and I guess it will
> be the case in the future again (e.g. IIRC pre-4.2 IMX6 DTBs don't boot
> on 4.2+ - or was it 4.1?).

Sorry, but I strongly object to the argument of "DTs are not stable
anyways, so we might just continue to break them". We are trying to keep
them stable.

I think you are referring to the GPC interrupt domain change with your
above statement about DT stability breaking on 4.1/4.2. This is not the
case. While I only catched the boot regression in the -rc phase of this
kernel, the final released kernel will boot just fine with an old DTB.

The i.MX platform tries to keep DTs stable. No exceptions.

Regards,
Lucas

