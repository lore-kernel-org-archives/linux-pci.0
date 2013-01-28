Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:59303 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754953Ab3A1WKG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jan 2013 17:10:06 -0500
Date: Mon, 28 Jan 2013 23:09:59 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
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
	Stephen Warren <swarren@wwwdotorg.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	"Russell King - ARM Linux" <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 07/27] PCI: Add software-emulated host bridge
Message-ID: <20130128230959.45cb503e@skate>
In-Reply-To: <201301282018.17714.arnd@arndb.de>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1359399397-29729-8-git-send-email-thomas.petazzoni@free-electrons.com>
	<201301282018.17714.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Arnd Bergmann,

On Mon, 28 Jan 2013 20:18:17 +0000, Arnd Bergmann wrote:

> Not even a description why this is needed?
> 
> This patch (together with patch 8) seems like the most controversial
> one of the series, so you should better provide a really good reason
> why we would emulate something in software rather than using whatever
> hardware is there.

Hum, you're right. In fact, the very reason why I'm adding an emulated
host bridge and emulated PCI-to-PCI bridges is simply because this was
one of the main suggestion raised during the review of the first
revision of this patch set.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
