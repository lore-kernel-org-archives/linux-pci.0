Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:64036 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbaACTFV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jan 2014 14:05:21 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Lior Amsalem <alior@marvell.com>, linux-pci@vger.kernel.org,
	Gregory Cl??ment <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Issue with the emulated PCI bridge implementation
Date: Fri, 03 Jan 2014 20:04:57 +0100
Message-ID: <3246739.aRbALcNl1Y@wuerfel>
In-Reply-To: <20140103200106.5a0999a3@skate>
References: <20131226160534.36cc4203@skate> <201401031322.31433.arnd@arndb.de> <20140103200106.5a0999a3@skate>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 03 January 2014 20:01:06 Thomas Petazzoni wrote:
> I don't have the hardware next to me, but IIRC the card does have an
> I/O space. It is not used by the mainline kernel driver, so I have a
> hacky patch that modifies the e1000e driver to make it use the I/O
> space and do a few I/O reads and writes. I've used that since the
> beginning to test I/O space functionality of the pci-mvebu driver.
> 
> Digging in the LAKML archive, I found a lspci -v output about the
> e1000e, and it has an I/O space:

Ok, thanks for the confirmation!

Do you mind posting your hack here? It may be useful for others as
well, such as the xgene developers that seem to be doing funny things
with their I/O space.

	Arnd
