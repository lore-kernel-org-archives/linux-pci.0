Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:32919 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751064AbdBCRrL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Feb 2017 12:47:11 -0500
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>, Wei Zhang <wzhang@fb.com>,
        Austin Bolen <Austin.Bolen@dell.com>,
        Christoph Hellwig <hch@infradead.org>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv5 0/5] Limiting PCI access
Date: Fri,  3 Feb 2017 12:55:50 -0500
Message-Id: <1486144555-5526-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Version 5 of attempting to limit accessing PCI devices we know to be
disconnected. The motivation for this is that we do not need or want to
start an operation that we know will fail, and this has demonstrated an
improvement in time to complete device removal.

v4 -> v5:

Greg was concerned about the method for observing the disconnected state
being visible to device drivers. We do not want device drivers relying
on this to handle their device specific operations when a device is
suddenly disconnected. Since the intended usage is internal to the PCI
driver itself, this series privatizes the state. As a consequence, I had
to move the inline pci device config accessors to exported functions so
they could access the private API for the disconnected state.

I've also split the short-cut for pci_device_is_present from the
pci_dev_config_<read|write>_<byte|word|dword> access short cut into two
different patches since they're not really the same thing.

This is otherwise the same as before.

Keith Busch (5):
  pci: Export pci device config accessors
  pci: Add device disconnected state
  pci: No config access for disconnected devices
  pci/msix: Skip disabling disconnected devices
  pci: Quick return for pci_device_is_present

 drivers/pci/access.c             | 56 ++++++++++++++++++++++++++++++++++++++++
 drivers/pci/hotplug/pciehp_pci.c |  5 ++++
 drivers/pci/msi.c                |  7 ++++-
 drivers/pci/pci.c                |  2 ++
 drivers/pci/pci.h                | 14 ++++++++++
 drivers/pci/pcie/pcie-dpc.c      |  4 +++
 include/linux/pci.h              | 34 ++++++------------------
 7 files changed, 95 insertions(+), 27 deletions(-)

-- 
2.7.2
