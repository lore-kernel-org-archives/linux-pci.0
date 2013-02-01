Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:37906 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756276Ab3BAT6E (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 1 Feb 2013 14:58:04 -0500
Date: Fri, 1 Feb 2013 12:58:04 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130201195804.GD19335@obsidianresearch.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201302011607.49205.arnd@arndb.de>
 <20130201162638.GT23505@n2100.arm.linux.org.uk>
 <201302011745.29223.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201302011745.29223.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 01, 2013 at 05:45:29PM +0000, Arnd Bergmann wrote:

> Yes, that was my point. I think in this case, the bug is in the new
> of_pci_process_ranges functions, which returns a 'struct resource'
> translated into IORESOURCE_MEM space, but with the type set
> to IORESOURCE_IO. This resource then gets passed to 
> pci_add_resource_offset().

A standard way to express the required address translation from CPU
physical address to IO bus address might help other people avoid this
trap??

Jason
