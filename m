Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:7796 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbeISFdx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Sep 2018 01:33:53 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 00/12] error handling and pciehp maintenance
Date: Tue, 18 Sep 2018 17:58:36 -0600
Message-Id: <20180918235848.26694-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I ran into a lot of trouble testing error handling, and this series is
just trying to simplify some things. The first 4 fix up aer_inject, and
the rest are cleanup to make better use of kernel APIs.

Keith Busch (12):
  PCI: Set PCI bus accessors to noinline
  PCI/AER: Covertly inject errors
  PCI/AER: Reuse existing service device lookup
  PCI/AER: Abstract AER interrupt handling
  PCI/AER: Remove dead code
  PCI/AER: Remove error source from aer struct
  PCI/AER: Use kfifo for tracking events
  PCI/AER: Use kfifo helper inserting locked elements
  PCI/AER: Don't read upstream ports below fatal errors
  PCI/AER: Use threaded IRQ for bottom half
  PCI/AER: Use managed resource allocations
  PCI/pciehp: Use device managed allocations

 drivers/pci/access.c              |   4 +-
 drivers/pci/hotplug/pciehp_core.c |  14 +-
 drivers/pci/hotplug/pciehp_hpc.c  |  48 ++----
 drivers/pci/pcie/Kconfig          |   2 +-
 drivers/pci/pcie/aer.c            | 219 ++++++---------------------
 drivers/pci/pcie/aer_inject.c     | 306 ++++++++++++++++++++------------------
 drivers/pci/pcie/portdrv.h        |   4 -
 drivers/pci/pcie/portdrv_core.c   |   1 +
 8 files changed, 227 insertions(+), 371 deletions(-)

-- 
2.14.4
