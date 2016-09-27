Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58177 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932573AbcI0UMo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Sep 2016 16:12:44 -0400
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, Lukas Wunner <lukas@wunner.de>,
        Wei Zhang <wzhang@fb.com>, Keith Busch <keith.busch@intel.com>
Subject: [PATCHv3 0/5] PCI access on removed devices
Date: Tue, 27 Sep 2016 16:23:30 -0400
Message-Id: <1475007815-28354-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We observe that software's removing of a device generates potentially
1000's of MMIO and config space access when unbinding from the removed
hardware, and this reliance on hardware to handle this slows down
software's total tear down time for handling a removed device.

This series reduces the number of non-functional MMIO and config space
accesses on a hot removed device. In some cases, we measure device
unbinding that used to take 100's of milliseconds to complete in < 1ms.

v3 -> v4:

  Merged up to current pci/hotplug.

  The aer initialization is done only when CONFIG_PCIAER is enabled,
  similar to how ATS support is managed.

  Removed making "is_removed" sticky on the checking
  pci_device_is_present. Only pciehp and pcie-dpc set this state in
  this series.

  Added the MIPs dependency. This was okay'ed, but I don't see it in
  the linux-mips tree.

Keith Busch (5):
  mips/pci: Reduce stack frame usage
  pci: Add is_removed state
  pci: No config access for removed devices
  pcie/aer: Cache capability position
  pci/msix: Skip disabling removed devices

 arch/mips/txx9/generic/pci.c       |  6 +-----
 drivers/pci/hotplug/pciehp_pci.c   |  2 ++
 drivers/pci/msi.c                  |  7 ++++++-
 drivers/pci/pcie/aer/aerdrv.c      | 10 +++++-----
 drivers/pci/pcie/aer/aerdrv_core.c | 12 ++++++------
 drivers/pci/pcie/pcie-dpc.c        |  1 +
 drivers/pci/probe.c                |  2 ++
 include/linux/pci.h                | 20 ++++++++++++++++++++
 8 files changed, 43 insertions(+), 17 deletions(-)

-- 
2.7.2

