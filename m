Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:55541 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751432AbaACSof (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 3 Jan 2014 13:44:35 -0500
Date: Fri, 3 Jan 2014 11:44:24 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>, linux-pci@vger.kernel.org,
	Gregory Cl??ment <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Issue with the emulated PCI bridge implementation
Message-ID: <20140103184424.GC12098@obsidianresearch.com>
References: <20131226160534.36cc4203@skate>
 <20131226165241.2c50b244@skate>
 <20140103002656.GA12098@obsidianresearch.com>
 <201401031322.31433.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201401031322.31433.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 03, 2014 at 01:22:31PM +0100, Arnd Bergmann wrote:

> However the part that made me wonder is that an e1000e with a PCI bridge
> actually /should/not/ need to allocate an I/O space window with a precious
> mbus resource, since AFAIK this adapter does not have an I/O space BARs.

IIRC the e1000 still has a legacy IO port BAR.. (guessing it is used
for PXE boot on x86?)

My patch set to allow the DT to turn off IO port allocation is already
in mainline - drop the IO ranges from the DT and no IO resources are
consumed at all.

Though, that is an interesting point, a small refinement would be to
not allocate the pci io map if IO is turned off as well..

Jason
