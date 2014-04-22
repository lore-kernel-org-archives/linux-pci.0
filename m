Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:49210 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932850AbaDVR4c (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 22 Apr 2014 13:56:32 -0400
Date: Tue, 22 Apr 2014 11:56:05 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Neil Greatorex <neil@fatboyfat.co.uk>, Willy Tarreau <w@1wt.eu>,
	Matthew Minter <matthew_minter@xyratex.com>,
	Gerlando Falauto <gerlando.falauto@keymile.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Gregory =?iso-8859-1?Q?Cl=E9ment?=
	<gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>, linux-pci@vger.kernel.org,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>
Subject: Re: Fixing PCIe issues on Armada XP
Message-ID: <20140422175605.GE23955@obsidianresearch.com>
References: <20140410181953.50ccfcc3@skate>
 <20140410165733.GB23104@obsidianresearch.com>
 <20140410200153.46669e0c@skate>
 <20140410201201.GA12661@obsidianresearch.com>
 <alpine.DEB.2.10.1404102206090.28003@vroombuntu>
 <20140418145847.709b29ce@skate>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140418145847.709b29ce@skate>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> mvebu-pcie pcie-controller.2: PCIe0.0: performing link reset
> mvebu-pcie pcie-controller.2: PCIe0.0: link went down after 20 tries
> mvebu-pcie pcie-controller.2: PCIe0.0: link came back up after 100 tries

So the '100' here says the timeout expired. My first stab would be to
set the timeout longer.. Maybe your chip takes longer to train the
link.

You also mentioned that setting Conf_TrainingDisable doesn't cause the
link to go down? That would be useful to verify (in a clean
environment without clock gating weirdness..)

> # /usr/sbin/lspci 
> 00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6710
> 00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 6710

I'm guessing:

echo 1 > /sys/bus/pci/rescan

Will make it appear?

Jason
