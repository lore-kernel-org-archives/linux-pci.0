Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:39887 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755316Ab3A3LhW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Jan 2013 06:37:22 -0500
Date: Wed, 30 Jan 2013 12:37:17 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130130123717.410d13ff@skate>
In-Reply-To: <20130130113245.GH23505@n2100.arm.linux.org.uk>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
	<20130130113245.GH23505@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Russell,

On Wed, 30 Jan 2013 11:32:46 +0000, Russell King - ARM Linux wrote:

> You do realise that this will result in all PCI I/O BARs being rounded
> up to 64K.

Hum, yes, correct.

> I've just been digging through the PCI code and have come across a
> function - pcibios_window_alignment() - which the PCI code allows to be
> overriden which allows you to increase the alignment requirement of
> bridge windows.  It takes the PCI bus and window type as arguments.
> 
> I'd suggest using that, and checking whether the bus which is passed
> corresponds with a bus which gives you problems, so that you don't
> impose the 64K requirement on downstream bridges.

Seems interesting indeed, I'll look into this idea! Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
