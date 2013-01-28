Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:59472 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755323Ab3A1Way (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jan 2013 17:30:54 -0500
Date: Mon, 28 Jan 2013 23:30:48 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 07/27] PCI: Add software-emulated host bridge
Message-ID: <20130128233048.2ab6a6d2@skate>
In-Reply-To: <20130128222348.GA21628@obsidianresearch.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1359399397-29729-8-git-send-email-thomas.petazzoni@free-electrons.com>
	<201301282018.17714.arnd@arndb.de>
	<5106F5CB.8050304@wwwdotorg.org>
	<20130128220904.GA21446@obsidianresearch.com>
	<20130128231829.6b205c3c@skate>
	<20130128222348.GA21628@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jason Gunthorpe,

On Mon, 28 Jan 2013 15:23:48 -0700, Jason Gunthorpe wrote:

> I'm refering to your earlier question about what PCI IDs to use for
> the SW emulated devices. If there is no need for the host bridge then
> you only need 1 PCI ID (for the root port bridge) and you can probably
> fairly safely re-use the one in the Marvell config space of the HW.

Ah, ok, I see. But isn't a host bridge needed to bind all the
PCI-to-PCI bridges under a single bus, in order to get the global
resource assignment I was referring to?

Regarding the PCI IDs, I have started to work with Marvell to see what
is possible. I, unfortunately, haven't received the answer for now.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
