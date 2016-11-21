Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752077AbcKUVpP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Nov 2016 16:45:15 -0500
Subject: [PATCH v2 0/9] PCI: Tidy up messages
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
Date: Mon, 21 Nov 2016 15:45:11 -0600
Message-ID: <20161121214006.21036.11599.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Remove a few messages that don't contain any useful information, e.g.,

  pcie_pme 0000:00:02.0:pcie01: service driver pcie_pme loaded
  pci_hotplug: PCI Hot Plug PCI Core version: 0.5
  pciehp 0000:80:02.0:pcie04: service driver pciehp loaded
  pciehp: PCI Express Hot Plug Controller Driver version: 0.4

NOTE: I added a patch to drop Root Complex Event Collector PME support.  I
suspect that we really want to keep that, but it looks like it's currently
broken.  I would welcome opinions and some help to test it if we fix the
current breakage.

Changes from v1->v2:
  - Drop Root Complex Event Collector PME support
  - Add PME IRQ to existing log message
  - Log PME message once per hierarchy, not once per device
  - Log AER probe errors with plain PCI device, not PCIe service device
  - Add new AER claim message, including IRQ
  - Remove unused AER version macros

---

Bjorn Helgaas (9):
      PCI/PME: Drop unused support for PMEs from Root Complex Event Collectors
      PCI/PME: Log PME IRQ when claiming Root Port
      PCI/AER: Remove unused version macros
      PCI/AER: Log errors with PCI device, not PCIe service device
      PCI/AER: Log AER IRQ when claiming Root Port
      PCI: Remove service driver load/unload messages
      PCI: hotplug: Remove hotplug core message
      PCI: pciehp: Remove loading message
      PCI: Expand "VPD access disabled" quirk message


 drivers/pci/hotplug/pci_hotplug_core.c |   10 +++-------
 drivers/pci/hotplug/pciehp_core.c      |    9 ++++-----
 drivers/pci/pcie/aer/aerdrv.c          |   18 ++++++------------
 drivers/pci/pcie/pme.c                 |   29 +++++++----------------------
 drivers/pci/pcie/portdrv_core.c        |    3 ---
 drivers/pci/quirks.c                   |    2 +-
 6 files changed, 21 insertions(+), 50 deletions(-)
