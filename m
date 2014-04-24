Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:44356 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751366AbaDXCwC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Apr 2014 22:52:02 -0400
Date: Wed, 23 Apr 2014 22:51:23 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Neil Greatorex <neil@fatboyfat.co.uk>,
	Willy Tarreau <w@1wt.eu>,
	Matthew Minter <matthew_minter@xyratex.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 4/7] pci: mvebu: fix off-by-one in the computed size of
 the mbus windows
Message-ID: <20140424025123.GN28159@titan.lakedaemon.net>
References: <1397823593-1932-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397823593-1932-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140421164754.GA17260@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140421164754.GA17260@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 21, 2014 at 10:47:54AM -0600, Bjorn Helgaas wrote:
> On Fri, Apr 18, 2014 at 02:19:50PM +0200, Thomas Petazzoni wrote:
> > From: Willy Tarreau <w@1wt.eu>
> > 
> > mvebu_pcie_handle_membase_change() and
> > mvebu_pcie_handle_iobase_change() do not correctly compute the window
> > size. PCI uses an inclusive start/end address pair, which requires a
> > +1 when converting to size.
> > 
> > This only worked because a bug in the mbus driver allowed it to
> > silently accept and round up bogus sizes.
> > 
> > Fix this by adding one to the computed size.
> > 
> > Fixes: 45361a4fe4464180815157654aabbd2afb4848ad ('PCIe driver for Marvell Armada 370/XP systems')
> > Cc: <stable@vger.kernel.org> # v3.11+
> > Signed-off-by: Willy Tarreau <w@1wt.eu>
> > Reviewed-By: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > Tested-by: Neil Greatorex <neil@fatboyfat.co.uk>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> If I were merging via my tree, I would tweak the subject capitalization
> so "git log --oneline drivers/pci/host/pci-mvebu.c" looks consistent.

Will do, thanks for the reminder.

thx,

Jason.
