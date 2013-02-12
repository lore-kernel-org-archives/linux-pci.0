Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:52646 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933672Ab3BLSEE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Feb 2013 13:04:04 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 06/32] arm: pci: add a align_resource hook
Date: Tue, 12 Feb 2013 18:03:12 +0000
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	"Russell King - ARM Linux" <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	"Eran Ben-Avi" <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Tawfik Bayouk <tawfik@marvell.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com> <1360686546-24277-7-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1360686546-24277-7-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201302121803.12660.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 12 February 2013, Thomas Petazzoni wrote:
> The PCI specifications says that an I/O region must be aligned on a 4
> KB boundary, and a memory region aligned on a 1 MB boundary.
> 
> However, the Marvell PCIe interfaces rely on address decoding windows
> (which allow to associate a range of physical addresses with a given
> device), and those have special requirements compared to the standard
> PCI-to-PCI bridge specifications.

I'm not convince that we should add this complexity yet, until everyone
agrees on the basic approach taken.

	Arnd
