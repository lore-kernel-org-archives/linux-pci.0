Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:55535 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753272Ab3BAAel (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 31 Jan 2013 19:34:41 -0500
Message-ID: <510B0D9C.1000101@wwwdotorg.org>
Date: Thu, 31 Jan 2013 17:34:36 -0700
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
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
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP systems
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com> <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/28/2013 11:56 AM, Thomas Petazzoni wrote:
> This driver implements the support for the PCIe interfaces on the
> Marvell Armada 370/XP ARM SoCs. In the future, it might be extended to
> cover earlier families of Marvell SoCs, such as Dove, Orion and
> Kirkwood.

Bjorn and I happen to live very close, so we got together today and
talked about PCIe on ARM.

One of the questions he asked is: why does the window management on the
Marvell SoCs need to be dynamic?

(Sorry if this was covered earlier; I vaguely recall some discussion on
the topic, but couldn't find it quickly)

As background, PCIe enumeration in Linux usually works like:

1) You start off with some CPU physical address regions that generate
transactions on the PCIe bus.

2) You enumerate all the PCIe devices, and assign an address to each BAR
found, carved out of the PCIe address range corresponding to the regions
you knew from (1).

However, it sounds like the Marvell code wants to:

1) Start off with no real knowledge of the CPU physical address that
will generate transactions on the PCIe bus, since you want to assign
that later.

2) You enumerate all the PCIe devices, and assign an address. But, what
address range do you use?

3) Then you program the SoC's windows to set up the CPU->PCIe address
translations.

Am I recalling what you're trying to do correctly, or am I completely
confused?

Now, I recall that a related issue was that you are tight on CPU
physical address space, and the second algorithm above would allow the
size of the PCIe controller's window configuration to be as small as
possible, and hence there would be more CPU physical address space
available to fit in other peripherals.

However, why does this need to be dynamic? On a particular board, you
know all the other (non-PCIe) peripherals that you need to fit into the
CPU physical address space, so you know how much is left over for PCIe,
so why not always make the PCIe window fill up all the available space,
and use the first algorithm I described above? And also, I think you
always know the exact set of PCIe devices that are attached to the
boards, so you know the exact BAR size requirements there (or are there
user-accessible PCIe devices; I don't think so from your recent comments
about PCIe<->PCIe bridges not needing to be supported since the user
couldn't plug one in?)

Note that with DT, you can easily specify the window location/size in
the board .dts file rather than the SoC .dtsi file, so it can easily be
customized based on how much physical address space is taken up by RAM,
directly mapped NOR flash, etc.

With a static window configuration in DT, you'd end up with a system
that worked much like any x86 system or Tegra, with some static memory
range available to PCIe. It's just that in your case, the region
location/size could change from boot to boot based on DT, whereas it's
hard-coded in HW for Tegra and I assume x86 too.
