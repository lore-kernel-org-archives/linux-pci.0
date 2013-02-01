Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:58676 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753432Ab3BAQIC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 1 Feb 2013 11:08:02 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP systems
Date: Fri, 1 Feb 2013 16:07:49 +0000
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	"Eran Ben-Avi" <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	"Russell King - ARM Linux" <linux@arm.linux.org.uk>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com> <20130201035115.GA23649@obsidianresearch.com> <20130201100329.4d57fa55@skate>
In-Reply-To: <20130201100329.4d57fa55@skate>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201302011607.49205.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 01 February 2013, Thomas Petazzoni wrote:
> So there is really a range of I/O addresses associated to it, even
> though the device will apparently not use it. Would it be possible to
> detect that the I/O range is not used by the device, and therefore
> avoid the allocation of an address decoding window for this I/O range?

I suspect it just gets disabled because the port number 0xc0010000 is
larger than IO_PORT_LIMIT and we cannot access that offset inside
of the virtual memory window we use for PIO.

	Arnd
