Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:35745 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751379AbcEKIr1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 11 May 2016 04:47:27 -0400
From: "Yong, Jonathan" <jonathan.yong@intel.com>
To: linux-pci@vger.kernel.org
Cc: jonathan.yong@intel.com, bhelgaas@google.com
Subject: [PATCH v5] PCI: PTM Driver
Date: Wed, 11 May 2016 08:47:25 +0000
Message-Id: <1462956446-27361-1-git-send-email-jonathan.yong@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello LKML,

This is a preliminary implementation of the PTM support driver. This driver
has only been tested against a virtual PCI bus since there are no known
endpoints utilizing it yet.

Please CC me as I am not subscribed to the list.
Thanks.


Changes since v1:
* Moved register constants to pci_regs.h
* Use pci_dev to hold PTM status
* PTM initialization now done top-down hierarchy wise.

Changes since v2:
* Added missing void return in the pci_ptm_init inline stub.

Changes since v3:
* Clearing CONFIG_PCIE_PTM now completely prevents the driver from being built.
* Renamed pci_*_ptm_sysfs to pcie_ptm_*_sysfs_dev_files for consistency.
* Removed useless prototypes.
* Driver no longer checks PTM capability version
* PCI_EXT_CAP_ID_MAX updated to include PTM (0x1F)

Changes since v4:
* Using pci=noptm kernel parameter now disables ptm activation like other pci features.
* Module param to disable ptm driver at runtime removed.
* Sysfs file entries removed.

Yong, Jonathan (1):
  PCI: PTM preliminary implementation

 drivers/pci/pci.c             |   2 +
 drivers/pci/pci.h             |  13 ++++
 drivers/pci/pcie/Kconfig      |  10 +++
 drivers/pci/pcie/Makefile     |   3 +
 drivers/pci/pcie/pcie_ptm.c   | 170 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c           |   3 +
 include/linux/pci.h           |  13 ++++
 include/uapi/linux/pci_regs.h |  13 +++-
 8 files changed, 226 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/pcie/pcie_ptm.c

-- 
2.7.3

