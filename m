Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	"Will Deacon" <will.deacon@arm.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>
CC: Marc Zyngier <marc.zyngier@arm.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH 0/2] pci: generic: Add supports for ARM64
Date: Mon, 9 Feb 2015 23:22:28 +0800
Message-ID: <1423495350-12295-1-git-send-email-Suravee.Suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch series modifies the current PCI generic host controller
to support both ARM32 and ARM64. It has been tested on AMD Seattle
platform with the following patch series:

1. Marc Zyngier's patch series (for MSI supports):
[PATCH v2 0/8] Introducing per-device MSI domain
(http://lwn.net/Articles/628872/)

2. Murali Karicheri's patch series: 
[PATCH v6 0/7] PCI: get DMA configuration from parent device
(http://www.spinics.net/lists/linux-pci/msg38699.html)

Change from RFC:

  * In [PATCH 1/2] (https://lkml.org/lkml/2014/9/28/150),
    avoid the ugly #ifdef now that dependencies of pci_sys_data
    and pci_hw are removed.

  * In [PATCH 2/2] (https://lkml.org/lkml/2014/9/28/151),
    move tarch-specific check for PCI_PROBE_ONLY into driver/pci/pci.c


Suravee Suthikulpanit (2):
  pci: generic: Use the pci_scan_root_bus instead of pci_common_init_dev
  PCI: Do not call pci_enable_resource when specifying PCI_PROBE_ONLY

 arch/arm/kernel/bios32.c            | 12 ------------
 drivers/pci/host/Kconfig            |  2 +-
 drivers/pci/host/pci-host-generic.c | 33 ++++++++++-----------------------
 drivers/pci/pci.c                   |  3 +++
 4 files changed, 14 insertions(+), 36 deletions(-)

-- 
2.1.0

