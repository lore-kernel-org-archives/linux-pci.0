Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:40918 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753727Ab3A3PhR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Jan 2013 10:37:17 -0500
Date: Wed, 30 Jan 2013 16:36:59 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Thierry Reding <thierry.reding@avionic-design.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>, linux-pci@vger.kernel.org,
	Stephen Warren <swarren@wwwdotorg.org>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130130163659.75360dba@skate>
In-Reply-To: <20130130151934.GK23505@n2100.arm.linux.org.uk>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
	<20130130113245.GH23505@n2100.arm.linux.org.uk>
	<20130130120344.GA29490@avionic-0098.mockup.avionic-design.de>
	<20130130150856.GJ23505@n2100.arm.linux.org.uk>
	<20130130151934.GK23505@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Russell King - ARM Linux,

On Wed, 30 Jan 2013 15:19:34 +0000, Russell King - ARM Linux wrote:
> diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
> index db9fedb..bba0cf3 100644
> --- a/arch/arm/include/asm/mach/pci.h
> +++ b/arch/arm/include/asm/mach/pci.h
> @@ -29,6 +29,7 @@ struct hw_pci {
>  	void		(*postinit)(void);
>  	u8		(*swizzle)(struct pci_dev *dev, u8 *pin);
>  	int		(*map_irq)(const struct pci_dev *dev, u8 slot, u8 pin);
> +	resource_size_t	(*window_align)(struct pci_bus *, unsigned long);
>  };

Didn't you say just yesterday that you would prefer a numerical value
rather than a hook that could do random things? :-)

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
