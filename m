Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:62788 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506Ab3BAQDf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 1 Feb 2013 11:03:35 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP systems
Date: Fri, 1 Feb 2013 16:02:36 +0000
Cc: Stephen Warren <swarren@wwwdotorg.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	"Eran Ben-Avi" <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	"Russell King - ARM Linux" <linux@arm.linux.org.uk>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com> <510B268E.2040104@wwwdotorg.org> <20130201094613.38fa2ad0@skate>
In-Reply-To: <20130201094613.38fa2ad0@skate>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201302011602.36848.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 01 February 2013, Thomas Petazzoni wrote:
> > So while it's obvious that window base address and size shouldn't be
> > static, I wonder if the assignment of a specific window ID to a
> > specific root port ID shouldn be dynamic or static. For example, if
> > your HW configuration leaves you with 6 windows available, you could
> > support 2 PCIe root ports by statically assigning 3 windows to serve
> > each of those 2 root ports. Would that work, or are there systems
> > where over-commit is needed, e.g. if there's no IO space behind a
> > root port, you could get away with two windows per root port, and
> > hence be able to run 3 root ports rather than just 2? Still, if you
> > know which PCIe devices are being the root ports, you could still
> > represent the over-commit statically in DT
> 
> For now, I haven't figured out how not to allocate an I/O window if the
> downstream device doesn't use I/O, but I'd like to achieve that, as it
> would save one of the two windows needed per PCIe interface... and many
> PCIe devices don't need the I/O window.

The easiest hack would be to only ever allow one I/O window on exactly
one of the ports, and not do PIO on the other ports at all. Given the
various troubles of making any other combination work, that sounds like
a good enough compromise to me. A lot of the add-on cards would not
work in the remaining ports anyway, and worrying too much about that
legacy hardware may just not be worth it. That way, you only need 11
windows for PCIe (10*mem, 1*IO), which will always fit.

Do you actually have /any/ PCIe cards with PIO BARs that you can test
with?

	Arnd
