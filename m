Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org,
        cov@codeaurora.org, alex.williamson@redhat.com,
        vikrams@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/5] PCI: error handling clean up and add CRS support
Date: Fri, 16 Sep 2016 16:06:29 -0400
Message-Id: <1474056395-21843-1-git-send-email-okaya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Device states on the bus are not saved and restored for some of the bus
reset paths as:

1. IB/hfi1 via pci_reset_bridge_secondary_bus
2. PCI/AER via pci_reset_bridge_secondary_bus
3. PCI: dev_reset via parent bus reset

Changing the external API usage to pci_reset_bus outside of PCI code and
adding save/restore into pci_parent_bus_reset function. Note that
pci_parent_bus_reset is called with a device lock held.

A PCIe endpoint is allowed to issue CRS following an FLR request to
indicate that it is not ready to accept new requests. Changing the polling
mechanism in FLR wait function to go read the vendor ID instead of the
command/status register. A CRS indication will only be given if the address
to be read is vendor ID.

v1:
http://www.spinics.net/lists/linux-pci/msg53596.html
* initial implementation

Sinan Kaya (5):
  PCI/AER: replace pci_reset_bridge_secondary_bus with pci_reset_bus
  IB/hfi1: replace pci_reset_bridge_secondary_bus with pci_reset_bus
  PCI: save and restore bus on parent bus reset
  PCI: add CRS support to error handling path
  PCI: handle CRS returned by device after FLR

 drivers/infiniband/hw/hfi1/pcie.c  |  4 +---
 drivers/pci/pci.c                  | 28 +++++++++++++++++++++++++++-
 drivers/pci/pcie/aer/aerdrv.c      |  2 +-
 drivers/pci/pcie/aer/aerdrv_core.c |  2 +-
 4 files changed, 30 insertions(+), 6 deletions(-)

-- 
1.9.1
