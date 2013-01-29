Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:33384 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413Ab3A2KEQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jan 2013 05:04:16 -0500
Date: Tue, 29 Jan 2013 11:04:11 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>, linux-pci@vger.kernel.org,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v2 02/27] of/pci: Add of_pci_get_devfn() function
Message-ID: <20130129110411.6b5f4210@skate>
In-Reply-To: <20130128221604.GA24858@avionic-0098.mockup.avionic-design.de>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1359399397-29729-3-git-send-email-thomas.petazzoni@free-electrons.com>
	<5106F4EA.20904@wwwdotorg.org>
	<20130128221604.GA24858@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thierry, Stephen,

On Mon, 28 Jan 2013 23:16:04 +0100, Thierry Reding wrote:

> That's already fixed up in my series. I was going to wait until I was
> done with the MSI rework but maybe posting an intermediate version is in
> order to share the latest state.

Thanks! Those first four patches are definitely shared between our
series.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
