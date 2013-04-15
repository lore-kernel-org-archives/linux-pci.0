Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:60690 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752437Ab3DOPrQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2013 11:47:16 -0400
Date: Mon, 15 Apr 2013 11:46:20 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Maen Suleiman <maen@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Andrew Murray <andrew.murray@arm.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org,
	Mitch Bradley <wmb@firmworks.com>
Subject: Re: [PATCHv8 00/19] PCIe support for the Armada 370 and Armada XP
 SoCs
Message-ID: <20130415154620.GE28693@titan.lakedaemon.net>
References: <1365541601-14095-1-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1365541601-14095-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thomas,

On Tue, Apr 09, 2013 at 11:06:21PM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> This series of patches introduces PCIe support for the Marvell Armada
> 370 and Armada XP. In the future, we plan to extend the driver to
> cover Kirkwood platforms, and possibly other Marvell EBU platforms as
> well.
> 
> Here is the current status of the different patches:
> 
>  * Patches 1-5 are awaiting a formal Acked-by from the Device Tree
>    maintainers. Patches 1-3 are the new version of the OF PCI range
>    parsing functions from Andrew Murray, which he worked on after the
>    comments from Rob Herring. Patches 4 and 5 are much more trivial
>    and have been around since many versions of this series.

Applied to mvebu/drivers


>  * Patch 6 and 10, that are touching drivers/pci/ have been formally
>    Acked-by Bjorn Helgaas, the PCI maintainer.

Applied to mvebu/drivers

>  * Patch 7, which is touching arch/arm/kernel, has been merged by
>    Russell King already, see
>    http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7683/1.

Added remote branch dependency on rmk/for-next in mvebu/soc

>  * Patches 8 and 9 are touching drivers/clk, and are awaiting an
>    Acked-by from Mike Turquette. However, they are fairly trivial
>    patches, so they shouldn't cause too much problem.

Applied to mvebu/drivers

> 
>  * All the other patches touch mvebu-specific things, either
>    mach-mvebu or the related Device Tree files or defconfig, so it's
>    up to the Marvell maintainers to pick them up.

Patches 10,11,19 applied to mvebu/soc with dep on rmk/for-next, and
mvebu/drivers (in /soc to catch mvebu-mbus dependency).

I'm going to flag a separate PR for this marked "late" so that it goes
in *after* rmk/for-next.

thx,

Jason.
