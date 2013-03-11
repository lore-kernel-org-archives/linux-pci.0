Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:37854 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751247Ab3CKSXp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 11 Mar 2013 14:23:45 -0400
Date: Mon, 11 Mar 2013 12:23:39 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Mitch Bradley <wmb@firmworks.com>
Cc: Thierry Reding <thierry.reding@avionic-design.de>,
	Lior Amsalem <alior@marvell.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
Message-ID: <20130311182339.GB10992@obsidianresearch.com>
References: <20130308191227.GA6551@avionic-0098.mockup.avionic-design.de>
 <513A3F4F.2090501@firmworks.com>
 <20130308200245.GC29435@obsidianresearch.com>
 <513A7845.6040304@firmworks.com>
 <20130309013152.GA3883@obsidianresearch.com>
 <513C117D.6080800@firmworks.com>
 <20130310065539.GA14704@obsidianresearch.com>
 <513D6F9C.9000100@firmworks.com>
 <20130311074615.GA6365@avionic-0098.mockup.avionic-design.de>
 <513E1CBA.4040007@firmworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <513E1CBA.4040007@firmworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> (b) The discovery/enumeration code needs to access config space via
> pci_ops.  The root complex driver implements pci_ops based on a trivial
> parsing of ranges (omitting irrelevant details):
> 
> pci_op_read(devfn, pos) {
>    loop_over_ranges_entries {
>       if (to_devfn(ranges_entry.child) == devfn) {
>          return mmio_read(ranges_entry.parent + pos);
                            ^^^^^^^^^^^^^^^^^^^

This has to be converted through all enclosing node's ranges prior to
being used as a CPU address - the OF core has all the code to do this,
but a new entry point would be needed for this specific application...

Cheers,
Jason
