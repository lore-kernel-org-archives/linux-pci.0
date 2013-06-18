Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:33644 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756039Ab3FRMLy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jun 2013 08:11:54 -0400
Date: Tue, 18 Jun 2013 14:11:41 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Maen Suleiman <maen@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Grant Likely <grant.likely@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/8] irqchip: armada-370-xp: implement MSI support
Message-ID: <20130618141141.614d08b7@skate>
In-Reply-To: <20130618112604.GD6322@mithrandir>
References: <1370536888-8871-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1370536888-8871-5-git-send-email-thomas.petazzoni@free-electrons.com>
	<20130612104207.GE30841@mithrandir>
	<20130618104338.584098e1@skate>
	<20130618112604.GD6322@mithrandir>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Thierry Reding,

On Tue, 18 Jun 2013 13:26:04 +0200, Thierry Reding wrote:

> > As I replied to Grant, of_find_device_by_node() returns NULL, I believe
> > because the all IRQ controller driver initialization is done pretty
> > early, before the of_platform_populate() call is made, so there is no
> > platform_device associated with the IRQ controller node at the time the
> > armada_370_xp_mpic_of_init() function is called.
> > 
> > Do you see another approach, especially in relation to your comment on
> > PATCH 2/8 ?
> 
> Hmmm, that's too bad. The only other possibility that I see is that you
> could associate the struct device at a later point when it becomes
> available, but looking at the irqchip driver it doesn't look like you
> get notification of that either. I suppose you could add a
> platform_driver to it and hook things up in its .probe() callback, but
> I'm not sure if that's in line with how the irqchip was designed. Adding
> Grant Likely and Thomas Gleixner on Cc, maybe they have better advice.

If we do hook the MSI stuff in a ->probe() callback, then we'd have a
dependency between the ->probe() of the PCIe driver and the ->probe()
of the IRQ controller driver. In order for the PCIe ->probe() to
succeed, it needs the MSI controller to be registered, which wouldn't
appear until the ->probe() of the IRQ controller driver gets called. A
typical case of platform device dependency where the two platform
devices don't have a bus -> child dependency. Could be handled by a
-EPROBE_DEFER trick, though.

> Looking at other irqchip drivers I find it a bit odd to see how they're
> structured, though. We've been preaching for years that drivers should
> be well-encapsulated and told everybody it was bad to use globals and
> they should be associating driver-specific data with each instance of a
> device. Then comes along irqchip and all of a sudden it's okay to use
> globals again. It feels a bit fragile.

Yes, I've seen this as well, and I'm thinking of doing some
improvements in this area if there's some interest. But I believe this
is fairly separate from the specific discussion of this patch set.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
