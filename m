Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:61394 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490Ab3BLXGE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Feb 2013 18:06:04 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: Giving special alignment/size constraints to the Linux PCI core?
Date: Tue, 12 Feb 2013 23:05:28 +0000
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
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
References: <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de> <201302121902.14276.arnd@arndb.de> <20130212193848.GE1471@obsidianresearch.com>
In-Reply-To: <20130212193848.GE1471@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201302122305.28467.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 12 February 2013, Jason Gunthorpe wrote:
> PCI-E hotplug can be supported through the generic /sys/bus/pci/rescan
> mechanism, which forces a rediscovery/re-evaluation of all the buses
> in the system. The PCI core is smart enough to know what it can/can
> not reassign and can move the bridge windows around (IIRC most of the
> issues here are resolved these days?).
> 
> For PCI-E, the root port bridge can be placed anywhere in the host
> aperture, so as long as the host aperture isn't filled the core can
> allocate a memory region for the now active port.
> 
> Thomas's driver should support this as the regions and windows are all
> properly dynamic.

Ah, so you only allow hotplugging into the root ports, but not behind
additional bridges that have active devices on them, right?

I guess that is a common limitation for PCIe hotplugging.
 
> This is one reason why re-using the PCI core code is so desirable, it
> handles all these complexities.

Ok, I'm starting to understand what the entire discussion is about ;)

	Arnd
