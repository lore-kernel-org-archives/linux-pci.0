Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:33585 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750803AbbG2WTd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 29 Jul 2015 18:19:33 -0400
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bjorn Helgass <bhelgaas@google.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCH 0/3] PCI-e Max Payload Size configuration
Date: Wed, 29 Jul 2015 16:18:52 -0600
Message-Id: <1438208335-19457-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch series removes arch, driver, and hot-plug specific calls to
configure a PCI-e device's MPS setting. The device is instead configured
in the generic pci-core layer when the device is initially added, and
before it is bound to a driver.

The default policy is also changed from "do nothing" to update the
down stream port to match the upstream port if it is capable.

Dave Jiang (2):
  QIB: Removing usage of pcie_set_mps()
  PCIE: Remove symbol export for pcie_set_mps()

Keith Busch (1):
  pci: Default MPS tuning to match upstream port

 arch/arm/kernel/bios32.c             |   12 ------------
 arch/powerpc/kernel/pci-common.c     |    7 -------
 arch/tile/kernel/pci_gx.c            |    4 ----
 arch/x86/pci/acpi.c                  |    9 ---------
 drivers/infiniband/hw/qib/qib_pcie.c |   27 +--------------------------
 drivers/pci/bus.c                    |    4 ++++
 drivers/pci/hotplug/acpiphp_glue.c   |    1 -
 drivers/pci/hotplug/pciehp_pci.c     |    1 -
 drivers/pci/hotplug/shpchp_pci.c     |    1 -
 drivers/pci/pci.c                    |    1 -
 drivers/pci/probe.c                  |   22 ++++++++++++++++------
 include/linux/pci.h                  |    2 --
 12 files changed, 21 insertions(+), 70 deletions(-)

-- 
1.7.10.4

