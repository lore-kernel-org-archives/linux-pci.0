Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:3761 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933490AbcIFWA1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Sep 2016 18:00:27 -0400
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Jon Derrick <jonathan.derrick@intel.com>,
        Wei Zhang <wzhang@fb.com>, Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 0/4] Limiting pci access requsets
Date: Tue,  6 Sep 2016 16:00:15 -0600
Message-Id: <1473199219-3369-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Here's version two of this, and is even more aggressive than before
about reducing access that we know will end in failure.

The first two patches are new. It attempts to completely remove config
space access on removed devices.

Patch 1/4 adds a new state to pci_dev called "is_removed" that's set
when the device is detected to be inaccessible.

Patch 2/4 returns immediately from any config space access request on
devices in such a state so we don't rely on hardware to handle this.

I dropped the patch to abort searching pcie extended capabilities. Caching
the AER capability obviates any immediate need for that.

Patch 3/4 moves the cached aer_cap from the aer driver's private structure
to the pci_dev structure so all devices in the sub-tree know about this
capability postition.

Patch 4/4 is still skipping disabling MSI-x when removed, and I added a
new check prior to writing any MSI messages as well. The criteria being
checked is the new "is_removed" state rather than verifying the VID/DID is
valid, which potentially just introduces additional config space access.

This series reduces the number of non-functional MMIO and config space
accesses on a hot removed device from ~1000 commands to ~1, improving
software's time to teardown surprise removed devices.

Keith Busch (4):
  pci: Add is_removed state
  pci: No config access for removed devices
  pcie/aer: Cache capability position
  pci/msix: Skip disabling removed devices

 drivers/pci/hotplug/pciehp_pci.c   |  2 ++
 drivers/pci/msi.c                  |  7 ++++++-
 drivers/pci/pci.c                  |  9 ++++++++-
 drivers/pci/pcie/aer/aerdrv.c      | 10 +++++-----
 drivers/pci/pcie/aer/aerdrv_core.c | 12 ++++++------
 drivers/pci/pcie/pcie-dpc.c        |  1 +
 drivers/pci/probe.c                |  2 ++
 include/linux/pci.h                | 20 ++++++++++++++++++++
 8 files changed, 50 insertions(+), 13 deletions(-)

-- 
2.7.2

