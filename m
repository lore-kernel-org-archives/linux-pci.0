Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 1wt.eu ([62.212.114.60]:3945 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758712AbaDJRKr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 10 Apr 2014 13:10:47 -0400
Date: Thu, 10 Apr 2014 19:10:00 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Neil Greatorex <neil@fatboyfat.co.uk>,
	Matthew Minter <matthew_minter@xyratex.com>,
	Gerlando Falauto <gerlando.falauto@keymile.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Gregory =?iso-8859-1?Q?Cl=E9ment?=
	<gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>, linux-pci@vger.kernel.org,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>
Subject: Re: Fixing PCIe issues on Armada XP
Message-ID: <20140410171000.GF25890@1wt.eu>
References: <20140410181953.50ccfcc3@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140410181953.50ccfcc3@skate>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Thomas,

On Thu, Apr 10, 2014 at 06:19:53PM +0200, Thomas Petazzoni wrote:
> Hello all,
> 
> This is an e-mail that attempts to summarize the situation in terms of
> Armada XP PCIe issues.
> 
> At
> https://github.com/MISL-EBU-System-SW/mainline-public/commits/3.14/pci-debug,
> I've pushed a branch based on top of v3.14 that contains:

Thanks for putting all this online.

I have a minor comment below :

>  * 2 patches on the pci-mvebu driver. One from Willy Tarreau to fix the
>    off by one on the sizes. And another one from me which splits the
>    PCI BAR into power-of-two sized chunks, in order to create valid
>    MBus windows.

As suggested by Jason, this one should be merged before his that's just
before, to ensure that it will not cause a regression.

> I've tested this with my IGB card which needs a 9 MB
>    BAR (so 8 MB + 1 MB needed), and I've also faked the code to code to
>    simulate a 11.5 MB BAR (so 8 + 2 + 1 + 0.5 MB), and it worked. I
>    also checked that if we have an error when creating one of the
>    windows, then all the previous windows needed for the current BAR
>    are properly removed.

Really cool, I'm going to test that on a few PCIe cards and will report
the results here. How can we check the number of mbus windows in use ?

Thanks,
Willy

