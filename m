Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:53021 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758812Ab3FUHU6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jun 2013 03:20:58 -0400
Date: Fri, 21 Jun 2013 09:20:54 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	linux-arm-kernel@lists.infradead.org,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCHv3 04/11] of: pci: add registry of MSI chips
Message-ID: <20130621092054.4c3cb717@skate>
In-Reply-To: <1371660979-21588-5-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1371660979-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1371660979-21588-5-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Grant,

On Wed, 19 Jun 2013 18:56:12 +0200, Thomas Petazzoni wrote:
> This commit adds a very basic registry of msi_chip structures, so that
> an IRQ controller driver can register an msi_chip, and a PCIe host
> controller can find it, based on a 'struct device_node'.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/of/of_pci.c    | 22 ++++++++++++++++++++++
>  include/linux/msi.h    |  2 ++
>  include/linux/of_pci.h |  4 ++++
>  3 files changed, 28 insertions(+)

Any comments about this idea? It is quite fundamental for this patch,
which requires a way of connecting PCI busses (handled by a PCI
driver) and a msi_chip (handled by an IRQ controller driver).

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
