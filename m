Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:39644 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755488AbaDTUEs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 20 Apr 2014 16:04:48 -0400
Date: Sun, 20 Apr 2014 16:04:09 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
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
Message-ID: <20140420200409.GI28159@titan.lakedaemon.net>
References: <1397823593-1932-1-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1397823593-1932-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thomas,

On Fri, Apr 18, 2014 at 02:19:46PM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> This set of commits fixes a number of problems in the PCIe support of
> the Armada 370 and Armada XP SoCs, allowing to use PCIe devices that
> were not properly supported until now.
> 
> Due to the interaction of PCIe with other subsystems, the fixes are
> not limited to drivers/pci, but also touch drivers/bus and
> drivers/irqchip.

I've tentatively pulled this series as follows:

  patches 1-3 into mvebu/drivers-irqchip-fixes

  patches 4-7 into mvebu/drivers-mbus_pci-fixes

with the latter depending on the former.  I'm going to hold them in
-next for a bit.  At least until we get an Ack from Bjorn.  Then I'll
send them their appropriate ways.

thx,

Jason.
