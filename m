Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:59345 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754498AbdBGTX6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Feb 2017 14:23:58 -0500
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>, Wei Zhang <wzhang@fb.com>,
        Austin Bolen <Austin.Bolen@dell.com>,
        Christoph Hellwig <hch@infradead.org>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv6 0/5] Limiting PCI access
Date: Tue,  7 Feb 2017 14:32:32 -0500
Message-Id: <1486495957-26177-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The code is functionally equivalent to v5. I've fixed the style
points mentioned in review on line warpping, adjusted the change log
on the msi/msix skippage to not exclude mentioning msi, and added the
accumulated Reviewed-by's.

Keith Busch (5):
  pci: Export pci device config accessors
  pci: Add device disconnected state
  pci: No config access for disconnected devices
  pci/msix: Skip disabling disconnected devices
  pci: Quick return for pci_device_is_present

 drivers/pci/access.c             | 56 ++++++++++++++++++++++++++++++++++++++++
 drivers/pci/hotplug/pciehp_pci.c |  6 +++++
 drivers/pci/msi.c                |  7 ++++-
 drivers/pci/pci.c                |  2 ++
 drivers/pci/pci.h                | 14 ++++++++++
 drivers/pci/pcie/pcie-dpc.c      |  5 ++++
 include/linux/pci.h              | 34 ++++++------------------
 7 files changed, 97 insertions(+), 27 deletions(-)

-- 
2.7.2
