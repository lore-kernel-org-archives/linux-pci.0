Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:52418 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759516Ab3BGXdW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Feb 2013 18:33:22 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: Giving special alignment/size constraints to the Linux PCI core?
Date: Thu, 7 Feb 2013 23:33:11 +0000
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	"Russell King - ARM Linux" <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-pci@vger.kernel.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	"Eran Ben-Avi" <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org
References: <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de> <20130206175019.GA24248@obsidianresearch.com> <20130207165009.73b1f340@skate>
In-Reply-To: <20130207165009.73b1f340@skate>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201302072333.12010.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 07 February 2013, Thomas Petazzoni wrote:
> I am unfortunately starting to believe that using the standard PCI
> resource allocator is too complicated for our hardware, and that we
> should maybe have a dedicated allocator. But I would really like to
> avoid that if possible.

I see this just as more evidence that the emulated P2P bridge approach
is not the easiest solution and that it would be easier to go back
to adding the ports separately and make it possible to have every
port assign the BARs first and then set the resources based on
the physical address of the window we pick for it.

	Arnd
