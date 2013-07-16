Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:34059 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151Ab3GPIeT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 16 Jul 2013 04:34:19 -0400
Date: Tue, 16 Jul 2013 10:33:51 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Russell King <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Maen Suleiman <maen@marvell.com>, linux-pci@vger.kernel.org,
	Rob Herring <rob.herring@calxeda.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv5 00/11] MSI support for Marvell EBU PCIe driver
Message-ID: <20130716103351.15b0fb50@skate>
In-Reply-To: <20130715162709.GA24625@dhcp-172-17-186-34.nvidia.com>
References: <1373889167-27878-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<51E4167B.4000208@wwwdotorg.org>
	<20130715162709.GA24625@dhcp-172-17-186-34.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Thierry Reding,

On Mon, 15 Jul 2013 09:27:10 -0700, Thierry Reding wrote:

> We need at least patches 2, 4 and 8 for Tegra.

Are you sure you don't want patch 1 ? It allows to replace the
allocation of MSI interrupt numbers for the MSI driver by a generic
facility based on irq domains.

> There's still the option
> of working around patch 8 by using the custom root bus scan function
> that we have to use anyway, so I guess we could even trim the
> requirement down to patches 2 and 4 if we really need.

Bjorn said he didn't like having the msi chip assignment in the middle
of the root bus scan function, because he was hoping someday to
refactor this function. Quoting Bjorn:

"""
> +	bus->msi = pcie->msi;  

Ideally, arches could use pci_scan_root_bus(), which does the
pci_scan_child_bus() itself, so I never like to add arch-specific code
between pci_create_root_bus() and pci_scan_child_bus().

But you should be able to accomplish this by setting bus->msi in a
pcibios_add_bus() hook.  There is a corresponding pcibios_remove_bus()
hook that might be useful for deallocating the msi_chip.  I'm not too
clear on how you manage the msi_chip lifetime -- I see the alloc in
armada_370_xp_msi_init(), but I'm not sure whether you ever deallocate
it or how you know when it would be safe to do so.
"""

This is from:

Subject: Re: [PATCH v2 6/8] pci: mvebu: add support for MSI
Date: Tue, 18 Jun 2013 16:57:11 -0600

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
