Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:46556 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133AbaDKR3w (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 11 Apr 2014 13:29:52 -0400
Date: Fri, 11 Apr 2014 11:29:21 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Matthew Minter <matthew_minter@xyratex.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Neil Greatorex <neil@fatboyfat.co.uk>,
	Willy Tarreau <w@1wt.eu>,
	Gerlando Falauto <gerlando.falauto@keymile.com>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Gregory =?iso-8859-1?Q?Cl=E9ment?=
	<gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>, linux-pci@vger.kernel.org,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>
Subject: Re: Fixing PCIe issues on Armada XP
Message-ID: <20140411172921.GA31254@obsidianresearch.com>
References: <20140410181953.50ccfcc3@skate>
 <20140410165733.GB23104@obsidianresearch.com>
 <20140410200153.46669e0c@skate>
 <20140410201201.GA12661@obsidianresearch.com>
 <alpine.DEB.2.10.1404102206090.28003@vroombuntu>
 <20140411122314.220614bf@skate>
 <20140411163129.GA20565@obsidianresearch.com>
 <CAFJTrDs4oOHCTNBcUnhQ6O0nXXA1WjbpWTPRce7vrgjzv=kQ_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAFJTrDs4oOHCTNBcUnhQ6O0nXXA1WjbpWTPRce7vrgjzv=kQ_w@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 11, 2014 at 06:21:08PM +0100, Matthew Minter wrote:

> I would also like to note, my board uses an external clock for the
> PCI ports, thus it is unlikely to be effected by any issues relating
> to clock drivers.

It doesn't matter, the clock in question is the internal divided CPU
synchronous clock that drives the PEX TLP logic. Externally sourcing
the PHY clock won't change the synchronous side.

Jason
