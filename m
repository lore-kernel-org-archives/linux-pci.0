Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:37190 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067Ab3A2V7s (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jan 2013 16:59:48 -0500
Date: Tue, 29 Jan 2013 22:59:32 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
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
Subject: Re: [PATCH v2 05/27] arm: pci: add a align_resource hook
Message-ID: <20130129225932.01efb45b@skate>
In-Reply-To: <20130129213308.7e845064@skate>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<201301291645.08040.arnd@arndb.de>
	<20130129180936.3737e550@skate>
	<201301292015.21478.arnd@arndb.de>
	<20130129213308.7e845064@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Arnd,

On Tue, 29 Jan 2013 21:33:08 +0100, Thomas Petazzoni wrote:

> Basically, I have currently two suggestions:
> 
>  * From Jason Gunthorpe, to not use any host bridge, and instead use
>    only PCI-to-PCI bridges, one per PCIe interface.
> 
>  * From you, to not use any PCI-to-PCI bridge, and use only host
>    bridges, one per PCIe interface.

Thinking more about this, this solution (using one emulated host bridge
per PCIe interface) would cause one problem: the PCIe device itself
would no longer be in slot 0.

If I'm correct, with one host bridge per PCIe interface, we would have
the following topology:

 bus 0, slot 0: emulated host bridge 0
 bus 0, slot 1: PCIe device connected to PCIe interface 0
 bus 1, slot 0: emulated host bridge 1
 bus 1, slot 1: PCIe device connected to PCIe interface 1
 bus 2, slot 0: emulated host bridge 2
 bus 2, slot 1: PCIe device connected to PCIE interface 2
 etc.

However, one of the reason to use a PCI-to-PCI bridge was to ensure
that the PCIe devices were all listed in slot 0. According to the
Marvell engineers who work on the PCIe stuff, some new PCIe devices
have this requirement. I don't have a lot of details about this, but I
was told that most of the new Intel NICs require this, for example the
Intel X520 fiber NIC. Maybe PCIe experts (Jason?) could provide more
details about this, and confirm/infirm this statement.

The usage of PCI-to-PCI bridge allows to have each PCIe device on its
own bus, at slot 0, which also solves this problem.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
