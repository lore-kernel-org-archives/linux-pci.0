Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:56736 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934635Ab3CZQdc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Mar 2013 12:33:32 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCHv6 00/17] PCIe support for the Armada 370 and Armada XP SoCs
Date: Tue, 26 Mar 2013 16:32:44 +0000
Cc: Bjorn Helgaas <bhelgaas@google.com>,
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
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Andrew Murray <andrew.murray@arm.com>
References: <1364314719-1049-1-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1364314719-1049-1-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201303261632.44955.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 26 March 2013, Thomas Petazzoni wrote:
> This series of patches introduces PCIe support for the Marvell Armada
> 370 and Armada XP. In the future, we plan to extend the driver to
> cover Kirkwood platforms, and possibly other Marvell EBU platforms as
> well.
> 
> As we are approaching 3.10, I would now like to get formal Acked-by,
> or disagreements from the following maintainers/developers :
> 
>  * Grant Likely, as the OF maintainer, for patches 1, 2 and 3
> 
>    [PATCH v5 01/17] of/pci: Provide support for parsing PCI DT ranges
>    [PATCH v5 02/17] of/pci: Add of_pci_get_devfn() function
>    [PATCH v5 03/17] of/pci: Add of_pci_parse_bus_range() function
> 
>  * Bjorn Helgaas, as the PCI maintainer, for patches 4 and 8
> 
>    [PATCH v5 04/17] pci: infrastructure to add drivers in drivers/pci/host
>    [PATCH v5 08/17] pci: PCIe driver for Marvell Armada 370/XP systems
> 
>  * Russell King, as the ARM maintainer, for patch 5
> 
>    [PATCH v5 05/17] arm: pci: add a align_resource hook
> 
>  * Arnd Bergmann, Mitch Bradley and Jason Gunthorpe, for patch 8 (the
>    PCIe driver itself), and specifically the Device Tree binding.
> 
>    [PATCH v5 08/17] pci: PCIe driver for Marvell Armada 370/XP systems
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
