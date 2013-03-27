Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:33621 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914Ab3C0SFI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Mar 2013 14:05:08 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree-discuss@lists.ozlabs.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Andrew Murray <andrew.murray@arm.com>
Subject: [RFC PATCHv1 0/5] Use the mvebu PCIe driver on Kirkwood
Date: Wed, 27 Mar 2013 19:04:59 +0100
Message-Id: <1364407504-13524-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

Here is a set of five patches that demonstrate that the mvebu PCIe
driver can be used on Kirkwood with no modification at all. Those
patches are not meant to be applied yet, the Device Trees are not
completely correct yet (they don't take into account the fact that
6281 has one PCIe interface and 6282 has two PCIe interface).

It took less than two hours to enable PCIe on Kirkwood (and in those
two hours, the conversion of the DB-88F6281 board to the Device Tree
has been done as well), and the result works fine:

# /usr/sbin/lspci
00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 7846
00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 7846
01:00.0 SCSI storage controller: Marvell Technology Group Ltd. 88SX7042 PCI-e 4-port SATA-II (rev 02)
02:00.0 Ethernet controller: Intel Corporation 82572EI Gigabit Ethernet Controller (Copper) (rev 06)

# cat /proc/cpuinfo | grep ^Hardware
Hardware	: Marvell Kirkwood (Flattened Device Tree)

I've tested both the e1000e NIC card and the SATA 4 ports card and
they work fine.

Best regards,

Thomas

Thomas Petazzoni (5):
  pci: mvebu: enable driver usage on Kirkwood
  bus: mvebu: fix mistake in PCIe window target attribute for Kirkwood
  arm: mach-kirkwood: seperate PCIe window init from other windows
  arm: kirkwood: add SoC-level Device Tree data for PCIe interfaces
  arm: kirkwood: convert db-88f6281 to the Device Tree

 .../devicetree/bindings/pci/mvebu-pci.txt          |    1 +
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/kirkwood-db-88f6281.dts          |   96 +++++++++++++++++
 arch/arm/boot/dts/kirkwood.dtsi                    |   49 +++++++++
 arch/arm/mach-kirkwood/Kconfig                     |   12 +--
 arch/arm/mach-kirkwood/Makefile                    |    2 +-
 arch/arm/mach-kirkwood/board-db88f6281-bp.c        |   26 +++++
 arch/arm/mach-kirkwood/board-dt.c                  |   11 ++
 arch/arm/mach-kirkwood/common.c                    |    7 +-
 arch/arm/mach-kirkwood/common.h                    |    7 ++
 arch/arm/mach-kirkwood/db88f6281-bp-setup.c        |  108 --------------------
 drivers/bus/mvebu-mbus.c                           |    2 +-
 drivers/pci/host/Kconfig                           |    2 +-
 drivers/pci/host/pci-mvebu.c                       |    1 +
 14 files changed, 207 insertions(+), 118 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-db-88f6281.dts
 create mode 100644 arch/arm/mach-kirkwood/board-db88f6281-bp.c
 delete mode 100644 arch/arm/mach-kirkwood/db88f6281-bp-setup.c

-- 
1.7.9.5

