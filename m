Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:53050 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422864Ab3FUHWY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jun 2013 03:22:24 -0400
Date: Fri, 21 Jun 2013 09:22:20 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	linux-arm-kernel@lists.infradead.org,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCHv3 05/11] irqchip: armada-370-xp: properly request
 resources
Message-ID: <20130621092220.1b335f95@skate>
In-Reply-To: <1371660979-21588-6-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1371660979-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1371660979-21588-6-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thomas Gleixner,

On Wed, 19 Jun 2013 18:56:13 +0200, Thomas Petazzoni wrote:
> Instead of using of_iomap(), we now use of_address_to_resource(),
> request_mem_region() and ioremap(). This allows the corresponding I/O
> regions to be properly requested and visible in /proc/iomem.
> 
> The main motivation for this change is that the introduction of the
> MSI support requires us to get the physical address of the main
> interrupt controller registers, so we will need the corresponding
> 'struct resource' anyway.
> 
> We also take this opportunity to change a panic() to BUG_ON(), in
> order to be consistent with the rest of the driver.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/irqchip/irq-armada-370-xp.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)

Any chance you could take this one for 3.11 ? It's independent of the
rest of the patch series, and it would reduce the amount of code
remaining to merge for the entire MSI feature.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
