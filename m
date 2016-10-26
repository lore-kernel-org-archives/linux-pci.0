Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50150 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932199AbcJZSBM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Oct 2016 14:01:12 -0400
Subject: [PATCH 0/5] PCI: ACS enable quirk for link balancing switches
From: Alex Williamson <alex.williamson@redhat.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Date: Wed, 26 Oct 2016 12:01:11 -0600
Message-ID: <20161026175156.23495.12980.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A series exposing and extracting bits of things that the kernel
already does, culminating in an ACS enabling quirk to work around an
errata where data through a Pericom PCIe switch gets stuck when the
upstream and downstream ports are running at different link speeds and
P2P Request Redirection is enabled.

If you have a Syba SD-PEX24033 or card making use of this PCIe switch
in a similar way, and find that it doesn't work right when installed
into a 5.0GT/s+ slot and the IOMMU is enabled, you want this series.
Thanks,

Alex

---

Alex Williamson (5):
      PCI: Make pci_std_enable_acs() non-static
      PCI: Extract link speed & width retrieval from pcie_get_minimum_link()
      PCI: Extract link retraining from pcie_aspm_configure_common_clock()
      iommu: Move REQ_ACS_FLAGS out to header and rename
      PCI: Balance ports to avoid ACS errata on Pericom switches


 drivers/iommu/iommu.c   |   18 ++----
 drivers/pci/pci.c       |   57 ++++++++++++++++--
 drivers/pci/pcie/aspm.c |   17 -----
 drivers/pci/quirks.c    |  147 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h   |   11 ++++
 include/linux/pci.h     |    4 +
 6 files changed, 218 insertions(+), 36 deletions(-)
