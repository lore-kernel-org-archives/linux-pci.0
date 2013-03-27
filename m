Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:33795 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752459Ab3C0SLT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Mar 2013 14:11:19 -0400
Date: Wed, 27 Mar 2013 19:11:14 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree-discuss@lists.ozlabs.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Maen Suleiman <maen@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Andrew Murray <andrew.murray@arm.com>
Subject: Re: [RFC PATCHv1 0/5] Use the mvebu PCIe driver on Kirkwood
Message-ID: <20130327191114.2662b3b8@skate>
In-Reply-To: <201303271807.51023.arnd@arndb.de>
References: <1364407504-13524-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<201303271807.51023.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Arnd Bergmann,

On Wed, 27 Mar 2013 18:07:50 +0000, Arnd Bergmann wrote:

> > # /usr/sbin/lspci
> > 00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 7846
> > 00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 7846
> > 01:00.0 SCSI storage controller: Marvell Technology Group Ltd. 88SX7042 PCI-e 4-port SATA-II (rev 02)
> > 02:00.0 Ethernet controller: Intel Corporation 82572EI Gigabit Ethernet Controller (Copper) (rev 06)
> > 
> > # cat /proc/cpuinfo | grep ^Hardware
> > Hardware        : Marvell Kirkwood (Flattened Device Tree)
> 
> Very nice!

Yeah, I find it quite nice too :)

> > I've tested both the e1000e NIC card and the SATA 4 ports card and
> > they work fine.
> 
> I assume it works with PIO, but does the SATA card use the I/O
> space registers, or just memory space?

Both cards only use memory space. I have a quick and dirty patch for
the e1000e driver that makes it read/write one particular register from
the I/O space to test that it works, but I haven't checked this yet on
Kirkwood. I don't expect much troubles, but who knows.

As I said, this patch set is for now just to show that it works, there
are some adjustments to be made here and there before those patches are
ready to be merged.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
