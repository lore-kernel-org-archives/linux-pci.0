Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:42147 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752941AbaDJVHE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Apr 2014 17:07:04 -0400
Date: Thu, 10 Apr 2014 23:07:01 +0200
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
Message-ID: <20140410230701.1aabb32b@skate>
In-Reply-To: <alpine.DEB.2.10.1404101849270.1578@vroombuntu>
References: <20140410181953.50ccfcc3@skate>
	<alpine.DEB.2.10.1404101849270.1578@vroombuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Neil Greatorex,

On Thu, 10 Apr 2014 19:20:37 +0100 (BST), Neil Greatorex wrote:

> I have tested this branch on my Mirabox. I still get the link up problem 
> but if I work around that (see below) the igb driver works flawlessly.
> 
> Tested-by: Neil Greatorex <neil@fatboyfat.co.uk>

Good, thanks, we're making progress!

> > Remaining issues:
> >
> > * The link up problem. Unfortunately, I tried to reproduce it today,
> >   and didn't manage to. It's weird, because I'm sure I was able to
> >   produce it in the past, but I'm no longer able to, I don't know.
> >   Therefore, it's not easy for me to work on this topic. Neil, Jason,
> >   do you think this is a topic you could potentially handle?
> 
> Do you have earlyprintk enabled? I've found that if I have earlyprintk in 
> my bootargs / command line then I don't get the issue. I assume that is 
> because of timing, but it could be something else?

I have indeed disabled earlyprintk. Initially by removing it from the
command line, and then even by disabling CONFIG_DEBUG_LL.

In fact the original bug report I had came from my colleague Gregory
Clement, who precisely reported to me that a PCIe card was properly
detected on his Armada 385 board when earlyprintk was enabled, but the
PCIe card was not detected when earlyprintk was disabled. At the time,
I was able to reproduce the problem as well on my Armada 385, and
debugged it to find that the mvebu_pcie_set_local_dev_nr().

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
