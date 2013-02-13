Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:62952 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754606Ab3BMTeH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Feb 2013 14:34:07 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
Date: Wed, 13 Feb 2013 19:33:09 +0000
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
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
	Bjorn Helgaas <bhelgaas@google.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com> <20130213095701.0d9f9f20@skate> <20130213180439.GB1601@obsidianresearch.com>
In-Reply-To: <20130213180439.GB1601@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201302131933.09947.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 13 February 2013, Jason Gunthorpe wrote:
> > You seem to propose a global regs = <...> property under
> > pcie-controller, but indexing using marvell,pcie-port cannot work. PCIe
> > interfaces are identified by two values (port,lane), so we have 0.0,
> > 0.1, 0.2, 0.3, 1.0, 1.1, 1.2, 1.3, 2.0 and 3.0 on MV78460. I really
> > would like to avoid having bizarre computations to find which entry in
> > this big regs = <...> array correspond to a given PCIe interface.
> 
> Well, using the 'global' regs is an easy way to avoid the complexity with
> address translation and 'assigned-addresses'. So some way to translate
> between link # and regs index is necessary. How about using the PCI
> device number? Device number 1 is regs entry 0, 2 is regs entry 1, etc.

Or you could use the "reg-names" property.

	Arnd
