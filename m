Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:35055 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756391Ab3A2PXn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jan 2013 10:23:43 -0500
Date: Tue, 29 Jan 2013 16:23:37 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v2 05/27] arm: pci: add a align_resource hook
Message-ID: <20130129162337.0121cbab@skate>
In-Reply-To: <20130129151501.GY23505@n2100.arm.linux.org.uk>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1359399397-29729-6-git-send-email-thomas.petazzoni@free-electrons.com>
	<20130129161211.7bb8cada@skate>
	<20130129151501.GY23505@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Russell,

Thanks for your quick feedback!

On Tue, 29 Jan 2013 15:15:01 +0000, Russell King - ARM Linux wrote:

> Given the description, I'd feel much happier with this if we specified
> the alignment numerically rather than allowing "some random code" to do
> something with the passed values.

So, you'd prefer to have two new members added in the hw_pci structure
to give the alignment requirements for I/O regions and memory regions?

Something like:

struct hw_pci {
	[...]
	unsigned long io_align;
	unsigned long mem_align;
};

If that's fine with you, I'll go ahead and change the implementation in
this direction. As long as I can express my special 64 KB alignment
requirement for I/O regions, I'm just fine :-)

Thanks again,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
