Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:51850 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933191AbcHXU62 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Aug 2016 16:58:28 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <kristen.c.accardi@intel.com>, Marc Zyngier <marc.zyngier@arm.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Scott Murray <scott@spiteful.org>,
        =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Tom Long Nguyen <tom.l.nguyen@intel.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH 0/9] PCI: final demodularization of non-modular code
Date: Wed, 24 Aug 2016 16:57:43 -0400
Message-ID: <20160824205752.12024-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This final (assuming more new instances don't leak back in) series
ensures all the PCI code out there that remains using module.h is
actually modular or containing some use of modular infrastructure.

These last commits are slightly more involved than some of the
earlier ones since we are actually removing orphaned __exit functions
and some ".remove" functions as well.  So we can't claim binary
equivalence here, but the overall runtime should remain unchanged.

To that end, we have remained with the existing initcall levels
even though some of the hotplug infrastructural ones might make
better sense to be listed as subsys_initcall or similar.

Build tested with allmodconfig on all the major architectures.

Paul.
---

Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: kristen.c.accardi@intel.com
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Scott Murray <scott@spiteful.org>
Cc: "Sören Brinkmann" <soren.brinkmann@xilinx.com>
Cc: Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: Tom Long Nguyen <tom.l.nguyen@intel.com>
Cc: linux-omap@vger.kernel.org
Cc: linux-pci@vger.kernel.org

Paul Gortmaker (9):
  PCI: PCIe dpc: make it explicitly non-modular
  PCI: PCIe pme: make it explicitly non-modular
  PCI: PCIe aerdrv: make it explicitly non-modular
  PCI: dra7xx: make host code explicitly non-modular
  PCI: PCIe qcom: make host code explicitly non-modular
  PCI: PCIe xilinx: make host code explicitly non-modular
  PCI: PCIe xilinx-nwl: make host code explicitly non-modular
  PCI: hotplug_core: make it explicitly non-modular
  PCI: hotplug: make PCIe core code explicitly non-modular

 drivers/pci/host/pci-dra7xx.c           | 31 ++-----------------
 drivers/pci/host/pcie-qcom.c            | 28 +++++------------
 drivers/pci/host/pcie-xilinx-nwl.c      | 53 ++-------------------------------
 drivers/pci/host/pcie-xilinx.c          | 53 ++-------------------------------
 drivers/pci/hotplug/cpci_hotplug.h      |  2 --
 drivers/pci/hotplug/cpci_hotplug_core.c | 10 -------
 drivers/pci/hotplug/pci_hotplug_core.c  | 18 ++++-------
 drivers/pci/hotplug/pciehp_core.c       | 20 ++++---------
 drivers/pci/pcie/aer/aerdrv.c           | 18 +----------
 drivers/pci/pcie/pcie-dpc.c             | 18 +++--------
 drivers/pci/pcie/pme.c                  | 16 +---------
 11 files changed, 32 insertions(+), 235 deletions(-)

-- 
2.8.4

