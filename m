Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:58776 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887Ab3A1Tjx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jan 2013 14:39:53 -0500
Date: Mon, 28 Jan 2013 20:39:47 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 08/27] pci: implement an emulated PCI-to-PCI bridge
Message-ID: <20130128203947.07332698@skate>
In-Reply-To: <20130128193516.GB17722@obsidianresearch.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1359399397-29729-9-git-send-email-thomas.petazzoni@free-electrons.com>
	<20130128193516.GB17722@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jason Gunthorpe,

Thanks a lot for your quick feedback!

On Mon, 28 Jan 2013 12:35:16 -0700, Jason Gunthorpe wrote:

> It is not essential, but desirable, to report an Express Root Port
> capability for PCI-E bridges:

[...]

> In the Marvell case, this capability can be constructed by pulling
> data from the the Express End Point capability of the PCI-E port:

I am not sure what you mean by "pulling". Do you mean that I should get
informations from the real PCIe interface, from within the emulated
PCI-to-PCI bridge implementation? This would unfortunately not be
really nice, because until now, the PCI-to-PCI bridge emulation is
clearly separated from the Marvell PCIe driver itself. Of course, it
could register a hook or something like that, so that the emulated
PCI-to-PCI bridge could potentially call back into the Marvell PCIe
driver.

I'll have to dig a little bit more about this capability to see how it
works exactly.

Thanks again for the feedback,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
