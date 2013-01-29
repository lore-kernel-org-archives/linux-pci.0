Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:34723 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755998Ab3A2O3o (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jan 2013 09:29:44 -0500
Date: Tue, 29 Jan 2013 15:29:37 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Andrew Murray <andrew.murray@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130129152937.53ec9a9b@skate>
In-Reply-To: <20130129142015.GA23640@avionic-0098.mockup.avionic-design.de>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
	<20130129132204.GA23886@arm.com>
	<20130129144522.44ed7373@skate>
	<20130129140522.GA24310@arm.com>
	<20130129142015.GA23640@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Thierry Reding,

On Tue, 29 Jan 2013 15:20:15 +0100, Thierry Reding wrote:

> If at all possible I think the right thing to do is reuse the generic
> pcibios_get_phb_of_node() implementation. On Tegra this turned out to
> require a minimal change to the DT bindings of the root port nodes to
> make sure they provide the correct address in the reg property.

Could you detail the change that was needed? The DT bindings I use for
the Marvell PCIe driver are very, very similar to the ones you use for
Tegra, since I basically inspired my entire DT binding on your work.
And still, I think of_irq_map_pci() wasn't working for me.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
