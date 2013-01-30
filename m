Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:55679 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754283Ab3A3Jru (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Jan 2013 04:47:50 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v2 05/27] arm: pci: add a align_resource hook
Date: Wed, 30 Jan 2013 09:46:53 +0000
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	"Russell King - ARM Linux" <linux@arm.linux.org.uk>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	"Eran Ben-Avi" <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com> <201301291645.08040.arnd@arndb.de> <20130130045655.GE5734@obsidianresearch.com>
In-Reply-To: <20130130045655.GE5734@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201301300946.54040.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 30 January 2013, Jason Gunthorpe wrote:
> > But we normally only assign a 64 KB I/O window to each PCI host bridge.
> > Requiring PCI bridges to be space 64 KB apart would mean that we cannot
> > actually support bridges at all.
> 
> The PCI resource code uses full 32 bit integers when it handles IO
> addresses, so this actually does sort of work out.

However, we only reserve 1 MB (I think) virtual address window for all
I/O spaces of all PCI domains combined, at a fixed location (0xfee00000).
This means we can have at most 16 such windows at run-time. That can
be changed if necessary, but it seems like overkill when in practice
you only need a few bytes at most.

	Arnd
