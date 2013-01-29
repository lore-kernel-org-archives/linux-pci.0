Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:36253 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949Ab3A2Rn1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jan 2013 12:43:27 -0500
Date: Tue, 29 Jan 2013 18:43:20 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Maen Suleiman <maen@marvell.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-pci@vger.kernel.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 07/27] PCI: Add software-emulated host bridge
Message-ID: <20130129184320.59f534c4@skate>
In-Reply-To: <20130129174205.GD25646@obsidianresearch.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1359399397-29729-8-git-send-email-thomas.petazzoni@free-electrons.com>
	<201301282018.17714.arnd@arndb.de>
	<5106F5CB.8050304@wwwdotorg.org>
	<20130128220904.GA21446@obsidianresearch.com>
	<20130128231829.6b205c3c@skate>
	<20130128222348.GA21628@obsidianresearch.com>
	<20130128233048.2ab6a6d2@skate>
	<20130128225105.GA21935@obsidianresearch.com>
	<20130129110119.07cb9ef3@skate>
	<20130129174205.GD25646@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jason Gunthorpe,

On Tue, 29 Jan 2013 10:42:05 -0700, Jason Gunthorpe wrote:

> So if this is what you have now...
> 
> -[0000:00]-+-00.0 <- Host bridge
>            +-10.0 <- Bridge
>            +-11.0 <- Bridge
>            +-12.0 <- Bridge
> 
> Then removing the config space at 00.0 (ie the host bridge) will give
> you:
> 
> -[0000:00]-+-10.0 <- Bridge
>            +-11.0 <- Bridge
>            +-12.0 <- Bridge
> 
> The 'host bridge' isn't a bridge in the PCI-PCI sense, it is just a
> normal device at bus 0, device 0, function 0.

Ok, thanks I'll try this!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
