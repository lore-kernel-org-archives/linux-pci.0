Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:38108 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933284Ab3GPVnL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 16 Jul 2013 17:43:11 -0400
Date: Tue, 16 Jul 2013 23:43:07 +0200
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
Message-ID: <20130716234307.3d5ed229@skate>
In-Reply-To: <20130716210509.GA29318@dhcp-172-17-186-34.nvidia.com>
References: <1373889167-27878-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<51E4167B.4000208@wwwdotorg.org>
	<20130715162709.GA24625@dhcp-172-17-186-34.nvidia.com>
	<20130716103351.15b0fb50@skate>
	<20130716210509.GA29318@dhcp-172-17-186-34.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thierry,

On Tue, 16 Jul 2013 14:05:10 -0700, Thierry Reding wrote:

> > This is from:
> > 
> > Subject: Re: [PATCH v2 6/8] pci: mvebu: add support for MSI
> > Date: Tue, 18 Jun 2013 16:57:11 -0600
> 
> Yes, I'm aware of that discussion. However we currently need to have the
> custom root bus scan implementation anyway because pci_scan_root_bus()
> just doesn't work on ARM. So again, since we'll have to rework the
> driver anyway in order to use pci_scan_root_bus() once the issues have
> been resolved, it wouldn't hurt to postpone the transition to the new
> ARM pcibios_add_bus() support until that point.
> 
> All I was trying to do was reduce the list of common dependencies in an
> attempt to make merging it easier.

Understood. Bjorn, since you are the one who originally requested
the usage of pcibios_add_bus(), would you agree with the idea proposed
by Thierry? It would remove one dependency for both the Marvell MSI
support and Tegra PCIe support, which would help getting this code
merged.

As Thierry points out, this can easily be resolved at a later point,
once the new hooks are merged in the ARM PCI core.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
