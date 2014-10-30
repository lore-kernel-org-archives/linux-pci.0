Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:50838 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758922AbaJ3Lo7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Oct 2014 07:44:59 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Cc: liviu.dudau@arm.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof Halasa <khalasa@piap.pl>,
	Anton Vorontsov <avorontsov@mvista.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Mohit Kumar <mohit.kumar@st.com>
Subject: [RFC PATCH 0/2] arm: pcibios: remove pci_sys_data domain
Date: Thu, 30 Oct 2014 11:44:46 +0000
Message-Id: <1414669490-1217-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patchset is a first RFC stab at removing the dependency on pci_sys_data
domain field on ARM platforms and by replacing it with generic code that
stashes the domain value in the pci_bus control structure, introduced in

commit 41e5c0f81d3e676d671d96a0a1fafb27abfbd9
("of/pci: Add pci_get_new_domain_nr() and of_get_pci_domain_nr()")

commit 670ba0c8883b576d0aec28bd7a838358a4be1
("PCI: Add generic domain handling")

All the drivers converted (apart from PCIe designware, tested on iMX6SL)
were only compile tested for lack of HW, so along some comments, testing
and verifying that patchset does not break any existing platform are
very appreciated.

Code in drivers/pci/pci-mvebu.c has been changed to add a domain
number to PCI resources by using the nr value coming from the setup
pcibios32 callback, which may not be correct and should be considered
a temporary solution waiting for review comments.

The patchset removes entirely the pci_sys_data.domain field, since its
usage is removed at the same time in the respective host controllers
and ARM is made to select the configuration option
CONFIG_PCI_DOMAINS_GENERIC by default, which compiles a domain_nr in the
pci_bus structure so that the pci_domain_nr() look-up can rely on it.

Lorenzo Pieralisi (2):
  arm: cns3xxx: pci: remove artificial dependency on pci_sys_data domain
  arm: pcibios: move to generic PCI domains

 arch/arm/Kconfig                   |  3 +++
 arch/arm/include/asm/mach/pci.h    |  3 ---
 arch/arm/include/asm/pci.h         |  7 -------
 arch/arm/kernel/bios32.c           | 26 ++++++++++++++++++++++---
 arch/arm/mach-cns3xxx/pcie.c       | 40 ++++++++++++++++----------------------
 drivers/pci/host/pci-mvebu.c       | 10 ++--------
 drivers/pci/host/pcie-designware.c |  3 ---
 drivers/pci/host/pcie-rcar.c       |  3 ---
 8 files changed, 45 insertions(+), 50 deletions(-)

-- 
2.1.2

