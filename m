Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ni.piap.pl ([195.187.100.4]:41973 "EHLO ni.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758020AbcDAH0J (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 1 Apr 2016 03:26:09 -0400
From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>,
	Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>,
	Tim Harvey <tharvey@gateworks.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	"linux-pci\@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	stable <stable@vger.kernel.org>
Subject: Re: [PATCH v2] Revert "PCI: imx6: Add support for active-low reset GPIO"
References: <1459201536-5558-1-git-send-email-festevam@gmail.com>
	<CAJ+vNU3kZ2886wRQFUfFTyo2kzYgjGTroKdiuPynZkaNf1BvEw@mail.gmail.com>
	<20160330122103.GN20367@ibawizard.net>
	<CAOMZO5Bh=JgVEMM-8JBX1cpk5Kgn2O2KBiOGdZT+QQfGUizBUg@mail.gmail.com>
	<m3h9fni6be.fsf@t19.piap.pl> <1459420555.17926.6.camel@pengutronix.de>
Date: Fri, 01 Apr 2016 09:26:05 +0200
In-Reply-To: <1459420555.17926.6.camel@pengutronix.de> (Lucas Stach's message
	of "Thu, 31 Mar 2016 12:35:55 +0200")
Message-ID: <m3d1q9iycy.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Lucas Stach <l.stach@pengutronix.de> writes:

> I think you are referring to the GPC interrupt domain change with your
> above statement about DT stability breaking on 4.1/4.2. This is not the
> case. While I only catched the boot regression in the -rc phase of this
> kernel, the final released kernel will boot just fine with an old DTB.

It seems it was the other way around:
    BIG FAT WARNING: because the DTs were so far lying by not
    exposing the fact that the GPC block is actually the first
    interrupt controller in the chain, kernels with this patch
    applied wont have any suspend-resume facility when booted
    with old DTs, and old kernels with updated DTs won't even boot.

... perhaps combined with something else. I don't remember.

Nevertheless, the ugly DTS entries are just this - ugly. We should have
a way to remove them eventually.
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
