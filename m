Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:46604 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752769Ab3EWSxz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 May 2013 14:53:55 -0400
Date: Thu, 23 May 2013 20:53:48 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Cooper <jason@lakedaemon.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	linux-arm-kernel@lists.infradead.org,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH v2 0/3] Marvell PCIe driver improvements
Message-ID: <20130523205348.54751fca@skate>
In-Reply-To: <20130523182622.GT31290@titan.lakedaemon.net>
References: <1369319573-19927-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<20130523182622.GT31290@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jason Cooper,

On Thu, 23 May 2013 14:26:22 -0400, Jason Cooper wrote:

> >  drivers/pci/host/pci-mvebu.c |   55 +++++++++++++++++++++++++++++++++---------
> >  1 file changed, 44 insertions(+), 11 deletions(-)
> 
> Whole series applied to mvebu/pcie_bridge with Bjorn's Ack.  The whole
> pcie tree now looks like:
> 
>         /-mvebu/of_pci  /-mvebu/pcie
>         |               |
> +---+---+---+---+---+---+---+---+---+---+ mvebu/pcie_bridge
>                         |
>                         \---+---+---+---+ mvebu/pcie_kirkwood
> (not to scale :) )

Nice diagram, I like it :-)

> This is getting pretty hairy, do you intend on anything else for mvebu
> pcie for this merge window?

No, nothing significant. There might be some minor additional fixes
that you can just stack into the mvebu/pcie_bridge branch, but I don't
have any such fixes sitting anywhere in my repo at this point.

I now intend to work on the MSI support, but since it requires a quite
significant work to properly expose the msi_chip from the IRQ
controller driver, I don't really think it will be ready in time for
3.11.

Thanks a lot for the quick merges. I'm really eager to see this PCIe
code that has been around for a long time finally merged.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
