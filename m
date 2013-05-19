Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:40004 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754541Ab3ESU3A (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 19 May 2013 16:29:00 -0400
Date: Sun, 19 May 2013 16:28:24 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Rob Herring <rob.herring@calxeda.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv10 1/9] arm: mvebu: fix the 'ranges' property to handle
 PCIe
Message-ID: <20130519202824.GN11137@titan.lakedaemon.net>
References: <1368719725-21265-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1368719725-21265-2-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1368719725-21265-2-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 16, 2013 at 05:55:16PM +0200, Thomas Petazzoni wrote:
> Since 82a682676 ('ARM: dts: mvebu: Convert all the mvebu files to use
> the range property') all the device nodes of Armada 370/XP are under a
> common 'ranges' property that translates the device register addresses
> into their absolute address, thanks to the base address of the
> internal register space.
> 
> However, beyond just the register areas, there are also PCIe I/O and
> memory regions, whose addresses should be properly translated. This
> patch fixes the Armada 370 and XP ranges property to take PCIe into
> account properly.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
> Since the PCIe Device Tree description has been merged in 3.10-rc1,
> this commit should go in 3.10-rc as well.
> ---
>  arch/arm/boot/dts/armada-370-xp.dtsi |    3 ++-
>  arch/arm/boot/dts/armada-370.dtsi    |    3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)

Applied to mvebu/fixes

thx,

Jason.
