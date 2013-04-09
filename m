Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:54192 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935487Ab3DITJ5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Apr 2013 15:09:57 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCHv7 08/17] pci: PCIe driver for Marvell Armada 370/XP systems
Date: Tue, 9 Apr 2013 21:09:43 +0200
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm" <linux-arm-kernel@lists.infradead.org>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Maen Suleiman <maen@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Andrew Murray <andrew.murray@arm.com>
References: <1364395234-11195-1-git-send-email-thomas.petazzoni@free-electrons.com> <201304090014.06959.arnd@arndb.de> <20130409210652.3bc1958b@skate>
In-Reply-To: <20130409210652.3bc1958b@skate>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201304092109.43404.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 09 April 2013, Thomas Petazzoni wrote:
> Dear Arnd Bergmann,
> 
> On Tue, 9 Apr 2013 00:14:06 +0200, Arnd Bergmann wrote:
> 
> >       pcie->realio.type = IORESOURCE_IO;
> >       pcie->realio.start = max(PCIBIOS_MIN_IO, range->pci_addr);
> >       pcie->realio.end = max(IO_SPACE_LIMIT, range->pci_addr + range->size);
> 
> Shouldn't this last line be using "min()" so that we guarantee we don't
> have an I/O region that goes beyond IO_SPACE_LIMIT?
> 

Yes, of course. Sorry for not typing what I was thinking ;-)

	Arnd
