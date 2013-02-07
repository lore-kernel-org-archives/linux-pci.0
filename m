Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:58658 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758973Ab3BGQxw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Feb 2013 11:53:52 -0500
Date: Thu, 7 Feb 2013 16:53:47 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
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
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130207165347.GA31995@arm.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130129132204.GA23886@arm.com>
 <20130207153750.0fef1192@skate>
 <20130207155117.GA19666@arm.com>
 <20130207171904.70270598@skate>
 <20130207174040.3a345770@skate>
MIME-Version: 1.0
In-Reply-To: <20130207174040.3a345770@skate>
Content-Type: text/plain; charset=WINDOWS-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 07, 2013 at 04:40:40PM +0000, Thomas Petazzoni wrote:
> Dear Thomas Petazzoni,
> 
> On Thu, 7 Feb 2013 17:19:04 +0100, Thomas Petazzoni wrote:
> 
> > Unfortunately, I don't quite agree with any of your three solutions. I
> > still do believe the root problem is that pdev->dev.of_node should be
> > NULL for the PCIe endpoints, since those devices are not probed with
> > the Device Tree.
> 
> Looking more at this, the pdev->dev.of_node is in fact NULL, but the
> code uses the of_node of the parent PCI device.
> 
> So in fact the problem is indeed that the subnodes pcie0,0 and pcie1,0
> are seen as corresponding to the PCI-to-PCI bridges.

I would suggest changing the interrupt-mask to match any bus number. (Don't
forget that the secondary bus number of each of your emulated bridges will
vary depending on how many devices are detected underneath each root port,
assuming you don't try and partition bus numbers or use domains between ports).

Andrew Murray

> 
> Thanks,
> 
> Thomas
> -- 
> Thomas Petazzoni, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
> 

