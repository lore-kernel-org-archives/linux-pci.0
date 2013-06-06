Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:15994 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752756Ab3FFSvq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jun 2013 14:51:46 -0400
Date: Thu, 6 Jun 2013 14:51:10 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	linux-arm-kernel@lists.infradead.org,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>
Subject: Re: [PATCH v2 0/8] MSI support for Marvell EBU PCIe driver
Message-ID: <20130606185110.GP23859@titan.lakedaemon.net>
References: <1370536888-8871-1-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1370536888-8871-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thomas,

On Thu, Jun 06, 2013 at 06:41:20PM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> This set of patches introduces Message Signaled Interrupt support in
> the Marvell EBU PCIe driver. It has been successfully tested on the
> Armada XP GP platform with an Intel e1000e PCIe network card that
> supports MSI.
> 
> This version 2 follows the RFC version sent on March, 26th 2013. This
> is based on work done by Lior Amsalem <alior@marvell.com>.
> 
> The patches do the following:
> 
>  * Patch 1 comes from Thierry Redding, and adds a minimal msi_chip
>    infrastructure.
> 
>    This needs to be reviewed/acked by Bjorn Helgaas.
> 
>  * Patch 2 extends the msi_chip infrastructure with a small registry,
>    so that one driver can register an msi_chip, and another driver can
>    find the msi_chip associated to a particular Device Tree node.
> 
>    This needs to be reviewed/acked by Bjorn Helgaas.
> 
>  * Patch 3 makes some not very interesting preparation in the Armada
>    370/XP IRQ controller driver.
> 
>  * Patch 4 implements the MSI support in the Armada 370/XP IRQ
>    controller driver. It registers an msi_chip using the
>    msi_chip_add() function added in PATCH 2.
> 
>  * Patch 5 adjust the Armada 370/XP Device Tree to indicate that the
>    MPIC is not only an interrupt-controller, but also an
>    msi-controller.
> 
>  * Patch 6 adds MSI support in the Marvell PCIe host controller
>    driver. The work to do here is minimal: get a reference to the
>    msi-parent controller thanks to msi_chip_find_by_of_node(), and
>    link it to the pci_bus structure before the bus gets enumerated.
> 
>    This needs to be reviewed/acked by Bjorn Helgaas.
> 
>  * Patch 7 tunes Kconfig to indicate that Armada 370/XP supports MSI.
> 
>  * Patch 8 adjusts the Armada 370/XP Device Tree to add the msi-parent
>    properties in the PCIe controller nodes.
> 
> This set of patches currently applies on top of the current "for-next"
> branch of Jason Cooper's repository.
> 
> The Device Tree binding documentation updates will be added once the
> general approach is agreed on.
> 
> Thanks,
> 
> Thomas
> 
> Thierry Reding (1):
>   PCI: Introduce new MSI chip infrastructure
> 
> Thomas Petazzoni (7):
>   PCI: Add registry of MSI chips
>   irqchip: armada-370-xp: properly request resources
>   irqchip: armada-370-xp: implement MSI support
>   arm: mvebu: the MPIC now provides MSI controller features
>   pci: mvebu: add support for MSI
>   arm: mvebu: indicate that this platform supports MSI
>   arm: mvebu: link PCIe controllers to the MSI controller
> 

Is there a reason why the following breakdown wouldn't work?

>  arch/arm/boot/dts/armada-370-xp.dtsi     |   1 +
>  arch/arm/boot/dts/armada-370.dtsi        |   1 +
>  arch/arm/boot/dts/armada-xp-mv78230.dtsi |   1 +
>  arch/arm/boot/dts/armada-xp-mv78260.dtsi |   1 +
>  arch/arm/boot/dts/armada-xp-mv78460.dtsi |   1 +

through mvebu/arm-soc

>  arch/arm/mach-mvebu/Kconfig              |   1 +

through mvebu/arm-soc after the other three have landed (v3.11-rc1)

>  drivers/irqchip/irq-armada-370-xp.c      | 186 ++++++++++++++++++++++++++++++-

through tglx

>  drivers/pci/host/pci-mvebu.c             |  21 ++++
>  drivers/pci/msi.c                        |  59 +++++++++-
>  drivers/pci/probe.c                      |   1 +
>  include/linux/msi.h                      |  22 ++++
>  include/linux/pci.h                      |   1 +

through Bjorn

I think we should view the manner in which we brought in the initial
mvebu-pcie series (all through arm-soc) as the exception, not the rule.
I have no problem, and in fact, prefer to have them reviewed as a
series, but if at *all* possible, the series should be structured so
relevant maintainers can pick up the relevant patches into their trees.

thx,

Jason.
