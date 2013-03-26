Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:54520 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563Ab3CZRCV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Mar 2013 13:02:21 -0400
Date: Tue, 26 Mar 2013 18:02:17 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Olof Johansson <olof@lixom.net>, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Grant Likely <grant.likely@secretlab.ca>,
	Maen Suleiman <maen@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Andrew Murray <andrew.murray@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Mitch Bradley <wmb@firmworks.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [RFCv1 01/11] arm: mvebu: move L2 cache initialization in
 init_early()
Message-ID: <20130326180217.4c471227@skate>
In-Reply-To: <201303261653.48998.arnd@arndb.de>
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1364316746-8702-2-git-send-email-thomas.petazzoni@free-electrons.com>
	<201303261653.48998.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Arnd Bergmann,

On Tue, 26 Mar 2013 16:53:48 +0000, Arnd Bergmann wrote:
> On Tuesday 26 March 2013, Thomas Petazzoni wrote:
> > @@ -72,6 +73,10 @@ void __init armada_370_xp_init_early(void)
> >                         ARMADA_370_XP_MBUS_WINS_SIZE,
> >                         ARMADA_370_XP_SDRAM_WINS_BASE,
> >                         ARMADA_370_XP_SDRAM_WINS_SIZE);
> > +
> > +#ifdef CONFIG_CACHE_L2X0
> > +       l2x0_of_init(0, ~0UL);
> > +#endif
> 
> I guess you should remove the #ifdef as well here, it's not needed.

Right, will fix for the next version.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
