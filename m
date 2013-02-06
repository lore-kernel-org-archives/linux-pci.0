Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:49476 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758026Ab3BFWFC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Feb 2013 17:05:02 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP systems
Date: Wed, 6 Feb 2013 22:04:19 +0000
Cc: Stephen Warren <swarren@wwwdotorg.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	"Russell King - ARM Linux" <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	"Eran Ben-Avi" <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org
References: <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de> <51129F6B.1050709@wwwdotorg.org> <20130206194222.27db0d90@skate>
In-Reply-To: <20130206194222.27db0d90@skate>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201302062204.19383.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 06 February 2013, Thomas Petazzoni wrote:
> Can't we simply agree on having a first implementation that does the
> simple thing, like the existing PCIe implementation for earlier Marvell
> SoC families, and improve that if it happens to be needed, depending on
> user feedback?

Makes sense. I just looked up the kirkwood source to verify that the
window is set up to map PCI IO address 0x10000-0x1ffff for the second
bus to KIRKWOOD_PCIE1_IO_PHYS_BASE, which is mapped to logical port
number 0x10000-0x1ffff (identity mapping).

	Arnd
