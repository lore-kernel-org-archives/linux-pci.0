Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:56845 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483Ab3CZWET (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Mar 2013 18:04:19 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [RFCv1 07/11] irqchip: armada-370-xp: add MSI support to interrupt controller driver
Date: Tue, 26 Mar 2013 22:04:05 +0000
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree-discuss@lists.ozlabs.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Maen Suleiman <maen@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Andrew Murray <andrew.murray@arm.com>
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com> <20130326221654.34bce6d7@skate> <20130326215546.GA8650@obsidianresearch.com>
In-Reply-To: <20130326215546.GA8650@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201303262204.05546.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 26 March 2013, Jason Gunthorpe wrote:
> > I'll let Arnd answer this one, but I'm pretty sure that using IRQ
> > domains is the way to go. The fact that a number of drivers don't yet
> > use IRQ domains is maybe just because they haven't been converted yet.
> 
> Maybe, but they have irq domain code as well.. I'm curious about the
> answer too :)

To expand on my previous answer: irq_alloc_descs can require a lot of
memory if you have a lot of MSIs. If the driver only has 16 MSIs,
there is probably no reason to not assign all of them at once, but if
you have 2048 MSIs, creating the mapping only when you need it is
much more space efficient.

	Arnd
