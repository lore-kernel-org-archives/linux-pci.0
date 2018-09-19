Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732652AbeISWJZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Sep 2018 18:09:25 -0400
From: Sinan Kaya <okaya@kernel.org>
To: linux-pci@vger.kernel.org
Cc: alex.williamson@redhat.com, Sinan Kaya <okaya@kernel.org>
Subject: [PATCH v4 0/6] PCI: Add reset type parameter to PCI reset functions
Date: Wed, 19 Sep 2018 16:30:31 +0000
Message-Id: <20180919163037.13497-1-okaya@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We want more control over what kind of reset PCI core can apply. Have the
application explicitly requested allowed reset types.

differences from v3:
- set default return value to -EINVAL in __pci_reset_function_locked()

Sinan Kaya (6):
  PCI: Expose reset_type to users of __pci_reset_function_locked()
  PCI: Expose reset_type to users of pci_reset_function()
  PCI: Expose reset_type to users of pci_reset_function_locked()
  PCI: Expose reset type to users of pci_try_reset_function()
  PCI: Expose reset type to users of pci_probe_reset_function()
  PCI: Expose reset type to users of pci_reset_bus()

 drivers/hid/intel-ish-hid/ipc/ipc.c           |   2 +-
 drivers/misc/genwqe/card_base.c               |   2 +-
 .../net/ethernet/cavium/liquidio/lio_main.c   |   2 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_ctx.c   |   2 +-
 drivers/net/ethernet/sfc/mcdi.c               |   2 +-
 drivers/pci/pci-sysfs.c                       |   2 +-
 drivers/pci/pci.c                             | 134 ++++++++++++------
 drivers/pci/pci.h                             |   2 +-
 drivers/pci/probe.c                           |   2 +-
 drivers/vfio/pci/vfio_pci.c                   |  13 +-
 drivers/vfio/pci/vfio_pci_config.c            |   4 +-
 drivers/xen/xen-pciback/pci_stub.c            |   6 +-
 include/linux/pci.h                           |  21 ++-
 13 files changed, 128 insertions(+), 66 deletions(-)

-- 
2.18.0
