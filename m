Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:63099 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635AbaACTNv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jan 2014 14:13:51 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>, linux-pci@vger.kernel.org,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Gregory Cl??ment <gregory.clement@free-electrons.com>
Subject: Re: Issue with the emulated PCI bridge implementation
Date: Fri, 03 Jan 2014 20:13:19 +0100
Message-ID: <12006165.Jkey40UWy0@wuerfel>
In-Reply-To: <20140103201024.08ca11fb@skate>
References: <20131226160534.36cc4203@skate> <3246739.aRbALcNl1Y@wuerfel> <20140103201024.08ca11fb@skate>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 03 January 2014 20:10:24 Thomas Petazzoni wrote:
> Dear Arnd Bergmann,
> 
> On Fri, 03 Jan 2014 20:04:57 +0100, Arnd Bergmann wrote:
> 
> > > Digging in the LAKML archive, I found a lspci -v output about the
> > > e1000e, and it has an I/O space:
> > 
> > Ok, thanks for the confirmation!
> > 
> > Do you mind posting your hack here? It may be useful for others as
> > well, such as the xgene developers that seem to be doing funny things
> > with their I/O space.
> 
> The current hack is the following very ugly piece of code... It runs
> some command and reads back some registers, and you should see some
> well-known values (which can be found in the e1000 datasheet, I don't
> remember them right now).

Totally enough for the purpose, thanks!

	Arnd
