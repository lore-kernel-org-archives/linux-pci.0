Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:46396 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752824AbcJ1Wrh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Oct 2016 18:47:37 -0400
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>, Wei Zhang <wzhang@fb.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv4 next 0/3] Limiting pci access
Date: Fri, 28 Oct 2016 18:58:14 -0400
Message-Id: <1477695497-6207-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Here's version 3. Two of the patches from v2 have already been applied
upstream, so this is down to three patches now.

The main difference with v2 is setting subordinates to removed when
detected (patch 1/3).

Patch 2/3 short-cuts pci_device_is_present if is_removed is set.

Otherwise, the same as before. Just to restate the justification, this
significantly speeds up many device removals without relying on hardware.

Keith Busch (3):
  pci: Add is_removed state
  pci: No config access for removed devices
  pci/msix: Skip disabling removed devices

 drivers/pci/hotplug/pciehp_pci.c |  5 +++++
 drivers/pci/msi.c                |  7 ++++++-
 drivers/pci/pci.c                |  2 ++
 drivers/pci/pcie/pcie-dpc.c      |  4 ++++
 include/linux/pci.h              | 25 +++++++++++++++++++++++++
 5 files changed, 42 insertions(+), 1 deletion(-)

-- 
2.7.2

