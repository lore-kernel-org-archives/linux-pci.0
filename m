Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:36421 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758214AbaKUL3r (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Nov 2014 06:29:47 -0500
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof Halasa <khalasa@piap.pl>,
	Arnd Bergmann <arnd@arndb.de>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Mohit Kumar <mohit.kumar@st.com>
Subject: [PATCH v3 0/2] arm: pcibios: remove pci_sys_data domain
Date: Fri, 21 Nov 2014 11:29:24 +0000
Message-Id: <1416569367-29409-1-git-send-email-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patchset is a v3 of a previous posting:

http://www.spinics.net/lists/linux-pci/msg36502.html

v2 => v3

- Rebased on top of this patch dependency
  http://www.spinics.net/lists/linux-pci/msg36631.html

v1 => v2 changelog

- Removed stale hw_pci domain member
- Reworked pci-mvebu domain handling according to review
- Rebased against 3.18-rc3 and updated the logs
- Dropped RFC status

Original cover letter:
----
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
 arch/arm/include/asm/mach/pci.h    |  6 ------
 arch/arm/include/asm/pci.h         |  7 -------
 arch/arm/kernel/bios32.c           |  3 ---
 arch/arm/mach-cns3xxx/pcie.c       | 40 ++++++++++++++++----------------------
 drivers/pci/host/pci-mvebu.c       | 15 ++------------
 drivers/pci/host/pcie-designware.c |  3 ---
 drivers/pci/host/pcie-rcar.c       |  3 ---
 8 files changed, 22 insertions(+), 58 deletions(-)

-- 
2.1.2

