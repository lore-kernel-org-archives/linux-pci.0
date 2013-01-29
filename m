Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:52435 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923Ab3A2QqD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jan 2013 11:46:03 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v2 05/27] arm: pci: add a align_resource hook
Date: Tue, 29 Jan 2013 16:45:07 +0000
Cc: "Russell King - ARM Linux" <linux@arm.linux.org.uk>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	"Eran Ben-Avi" <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com> <20130129155820.GB23505@n2100.arm.linux.org.uk> <20130129172055.0ca5f341@skate>
In-Reply-To: <20130129172055.0ca5f341@skate>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201301291645.08040.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 29 January 2013, Thomas Petazzoni wrote:
> And the Linux PCI resource allocation code complies with this, so that
> if I have two PCI-to-PCI bridges (each having downstream a device with
> an I/O BAR), then the first PCI-to-PCI bridge gets its I/O base address
> register set to ADDR + 0x0, and the second bridge gets its I/O base
> address set to ADDR + 0x1000. And this doesn't play well with the
> requirements of Marvell address decoding windows for PCIe I/O regions,
> which must be 64 KB aligned.

But we normally only assign a 64 KB I/O window to each PCI host bridge.
Requiring PCI bridges to be space 64 KB apart would mean that we cannot
actually support bridges at all.

Is this just about your "virtual" bridges? If each one has its
own 64 KB I/O range and its own configuration space, that sounds
a lot like you should make them appear as individual domains instead.

	Arnd
