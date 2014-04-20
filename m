Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:40363 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751082AbaDTVIe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 20 Apr 2014 17:08:34 -0400
Date: Sun, 20 Apr 2014 23:08:27 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Lior Amsalem <alior@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Matthew Minter <matthew_minter@xyratex.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Neil Greatorex <neil@fatboyfat.co.uk>,
	Nadav Haklai <nadavh@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Willy Tarreau <w@1wt.eu>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/7] Fixes for Armada 370/XP PCIe
Message-ID: <20140420230827.1d5eec5f@skate>
In-Reply-To: <20140420200409.GI28159@titan.lakedaemon.net>
References: <1397823593-1932-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<20140420200409.GI28159@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jason Cooper,

On Sun, 20 Apr 2014 16:04:09 -0400, Jason Cooper wrote:

> I've tentatively pulled this series as follows:
> 
>   patches 1-3 into mvebu/drivers-irqchip-fixes
> 
>   patches 4-7 into mvebu/drivers-mbus_pci-fixes

Thanks!

> with the latter depending on the former.  I'm going to hold them in
> -next for a bit.  At least until we get an Ack from Bjorn.  Then I'll
> send them their appropriate ways.

There is actually no need for a dependency between the two. Neither
from a build point of view, or a runtime point of view. 1-3 fix purely
MSI related things, while 4-7 fix purely MBus/PCI related things. I
don't if not having a dependency will make things easier for you, but I
thought it was worth mentioning. The only reason why all those patches
were together is that, as a whole, they allow to fix a number of
problems with certain PCIe devices.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
