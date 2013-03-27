Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:33870 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705Ab3C0SSy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Mar 2013 14:18:54 -0400
Date: Wed, 27 Mar 2013 19:18:50 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Olof Johansson <olof@lixom.net>, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Grant Likely <grant.likely@secretlab.ca>,
	Maen Suleiman <maen@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Andrew Murray <andrew.murray@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Mitch Bradley <wmb@firmworks.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [RFC PATCHv1 0/5] Use the mvebu PCIe driver on Kirkwood
Message-ID: <20130327191850.26ab1623@skate>
In-Reply-To: <20130327191114.2662b3b8@skate>
References: <1364407504-13524-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<201303271807.51023.arnd@arndb.de>
	<20130327191114.2662b3b8@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Arnd,

On Wed, 27 Mar 2013 19:11:14 +0100, Thomas Petazzoni wrote:

> > I assume it works with PIO, but does the SATA card use the I/O
> > space registers, or just memory space?
> 
> Both cards only use memory space. I have a quick and dirty patch for
> the e1000e driver that makes it read/write one particular register from
> the I/O space to test that it works, but I haven't checked this yet on
> Kirkwood. I don't expect much troubles, but who knows.

Just to let you know, I've tested the e1000e with my small changes that
does one I/O access, and it seems to work properly. At least, I read
from the register the value I should be reading (and therefore writing
works, because the I/O space of the e1000e essentially has two
registers: one address register, and one data register, so you must
write one address in the address register before being able to read
something from the data register).

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
