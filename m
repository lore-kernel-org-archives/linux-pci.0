Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:45084 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754011AbaDKKXT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Apr 2014 06:23:19 -0400
Date: Fri, 11 Apr 2014 12:23:14 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Neil Greatorex <neil@fatboyfat.co.uk>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Willy Tarreau <w@1wt.eu>,
	Matthew Minter <matthew_minter@xyratex.com>,
	Gerlando Falauto <gerlando.falauto@keymile.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Gregory =?UTF-8?B?Q2zDqW1lbnQ=?=
	<gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>, linux-pci@vger.kernel.org,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>
Subject: Re: Fixing PCIe issues on Armada XP
Message-ID: <20140411122314.220614bf@skate>
In-Reply-To: <alpine.DEB.2.10.1404102206090.28003@vroombuntu>
References: <20140410181953.50ccfcc3@skate>
	<20140410165733.GB23104@obsidianresearch.com>
	<20140410200153.46669e0c@skate>
	<20140410201201.GA12661@obsidianresearch.com>
	<alpine.DEB.2.10.1404102206090.28003@vroombuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Neil Greatorex,

On Thu, 10 Apr 2014 22:56:00 +0100 (BST), Neil Greatorex wrote:
> > In any event, turning on the clock should almost certainly be
> > accompanied by a phy reset sequence to get both link ends on the same
> > page.
> >
> > Attached is a rough, untested patch along those lines.
> >
> 
> I took your attached patch and extended it a bit to print out how long it 
> took. The delays also need to be much longer for me. I also fixed a small 
> typo you made where the bit wasn't being set again to bring the link back 
> up. I've attached the diff to your patch, as well as the combined patch 
> (hope that makes sense).

I managed to reproduce the problem of the PCIe device not being
detected on Mirabox when earlyprintk is disabled.

However, the proposed patch doesn't seem to work:

mvebu-pcie pcie-controller.3: PCIe0.0: performing link reset
mvebu-pcie pcie-controller.3: PCIe0.0: link went down after 100 tries
mvebu-pcie pcie-controller.3: PCIe0.0: link came back up after 0 tries

It waits hundred times for the link to go down, but it never goes down,
and then it doesn't wait at all to go up... because it never went down.

Moreover, I am not entirely convinced that a PHY reset is needed here.
In my tests, doing just a wait after setting the local dev number was
sufficient. The fact is works with earlyprintk also indicates that we
don't need to do any specific action with the PHY, just to wait a bit
of time. I am worried that resetting the PHY might actually take more
time than what is needed, and may have other consequences that we don't
necessarily understand at this point.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
