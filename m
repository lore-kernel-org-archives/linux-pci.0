Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:13575 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751325AbcDSGYR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 19 Apr 2016 02:24:17 -0400
From: "Yong, Jonathan" <jonathan.yong@intel.com>
To: linux-pci@vger.kernel.org
Cc: jonathan.yong@intell.com, bhelgaas@google.com
Subject: [RFC v4] PCI: PTM Driver
Date: Tue, 19 Apr 2016 06:24:13 +0000
Message-Id: <1461047054-4692-1-git-send-email-jonathan.yong@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello LKML,

This is a preliminary implementation of the PTM[1] support driver. This driver
has only been tested against a virtual PCI bus since there are no known
endpoints utilizing it yet.

The drivers job is to get to every PTM capable device, set some PCI config
space bits, then go back to sleep [2].

PTM capable PCIe devices will get a new sysfs entry to allow PTM to be
enabled/disabled individually (enable by default).

Comments? Should I explain the PTM registers in more details?
Please CC me, thanks.

[1] Precision Time Measurement: A protocol for synchronizing PCIe endpoint
clocks against the host clock as specified in the PCI Express Base
Specification 3.1. It is identified by the 0x001f extended capability ID.

PTM capable devices are split into 3 roles, master, responder and requester.
Summary as follows:

A master holds the master clock that will be used for all devices under its
domain (not to be confused with PCI domains). There may be multiple masters
in a PTM hierarchy, in which case, the highest master closest to the root
complex will be selected for the PTM domain. A master is also always
responder capable. Clock precision is signified by a Local Clock
Granularity field, in nano-seconds.

A responder responds to any PTM synchronization requests from a downstream
device. A responder is typically a switch device. It may also hold a local
clock signified by a non-zero Local Clock Granularity field. A value of 0
signifies that the device simply propagates timing information from
upstream devices.

A requester is typically an endpoint that will request synchronization
updates from an upstream PTM capable time source. The driver will update
the Effective Clock Granularity field based on the same field from the
PTM domain master. The field should be programmed with a value of 0 if any
intervening responder has a Local Clock Granularity field value of 0.

[2] The software drivers never see the PTM packets, the PCI Express Base
Specification 3.1 reads:
        PTM capable components can make their PTM context available for
        inspection by software, enabling software to translate timing
        information between local times and PTM Master Time.

This isn't very informative.

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

Yong, Jonathan (1):
  PCI: PTM preliminary implementation

 drivers/pci/pci-sysfs.c       |   7 ++
 drivers/pci/pci.h             |  20 +++++
 drivers/pci/pcie/Kconfig      |   9 ++
 drivers/pci/pcie/Makefile     |   3 +
 drivers/pci/pcie/pcie_ptm.c   | 194 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c           |   3 +
 include/linux/pci.h           |  11 +++
 include/uapi/linux/pci_regs.h |  14 ++-
 8 files changed, 260 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/pcie/pcie_ptm.c

-- 
2.7.3

