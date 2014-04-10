Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:40559 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161030AbaDJSCZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Apr 2014 14:02:25 -0400
Date: Thu, 10 Apr 2014 20:02:22 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Willy Tarreau <w@1wt.eu>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Neil Greatorex <neil@fatboyfat.co.uk>,
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
Message-ID: <20140410200222.27cab16e@skate>
In-Reply-To: <20140410171000.GF25890@1wt.eu>
References: <20140410181953.50ccfcc3@skate>
	<20140410171000.GF25890@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Willy Tarreau,

On Thu, 10 Apr 2014 19:10:00 +0200, Willy Tarreau wrote:

> Thanks for putting all this online.
> 
> I have a minor comment below :
> 
> >  * 2 patches on the pci-mvebu driver. One from Willy Tarreau to fix the
> >    off by one on the sizes. And another one from me which splits the
> >    PCI BAR into power-of-two sized chunks, in order to create valid
> >    MBus windows.
> 
> As suggested by Jason, this one should be merged before his that's just
> before, to ensure that it will not cause a regression.

Ok, will change this, thanks.

> > I've tested this with my IGB card which needs a 9 MB
> >    BAR (so 8 MB + 1 MB needed), and I've also faked the code to code to
> >    simulate a 11.5 MB BAR (so 8 + 2 + 1 + 0.5 MB), and it worked. I
> >    also checked that if we have an error when creating one of the
> >    windows, then all the previous windows needed for the current BAR
> >    are properly removed.
> 
> Really cool, I'm going to test that on a few PCIe cards and will report
> the results here. How can we check the number of mbus windows in use ?

# cat /sys/kernel/debug/mvebu-mbus/devices

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
