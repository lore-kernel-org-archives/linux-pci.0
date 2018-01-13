Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:37005 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965242AbeAMB3F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Jan 2018 20:29:05 -0500
Received: by mail-ot0-f196.google.com with SMTP id a24so6558375otd.4
        for <linux-pci@vger.kernel.org>; Fri, 12 Jan 2018 17:29:05 -0800 (PST)
From: Frederick Lawler <fred@fredlawl.com>
To: linux-pci@vger.kernel.org
Cc: Frederick Lawler <fred@fredlawl.com>
Subject: [PATCH v2 0/2] PCI: Add and use pci_<level>: dev_<level> equivalents
Date: Fri, 12 Jan 2018 19:28:48 -0600
Message-Id: <1515806930-2935-1-git-send-email-fred@fredlawl.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace current uses of dev_<level> with pci_<level> by adding and using
PCI specific fuctions. 

V2:
* Replace static inline varadic functions with macros instead
* Convert hotplug, AER, ASPM, PME, PTM

Frederick Lawler (2):
  PCI: Create  minor pci_dev log wrapper functions
  PCI: Replace calls from dev_<level> to pci_<level>

 drivers/pci/access.c                   |   8 +-
 drivers/pci/bus.c                      |   4 +-
 drivers/pci/hotplug/cpqphp_core.c      |   2 +-
 drivers/pci/hotplug/pnv_php.c          |  40 +++----
 drivers/pci/hotplug/sgi_hotplug.c      |  36 +++---
 drivers/pci/hotplug/shpchp.h           |   8 +-
 drivers/pci/hotplug/shpchp_core.c      |   2 +-
 drivers/pci/iov.c                      |  10 +-
 drivers/pci/irq.c                      |   7 +-
 drivers/pci/msi.c                      |   7 +-
 drivers/pci/pci-acpi.c                 |   2 +-
 drivers/pci/pci-stub.c                 |   2 +-
 drivers/pci/pci-sysfs.c                |  10 +-
 drivers/pci/pci.c                      |  82 +++++++-------
 drivers/pci/pcie/aer/aer_inject.c      |  15 +--
 drivers/pci/pcie/aer/aerdrv.c          |   2 +-
 drivers/pci/pcie/aer/aerdrv_core.c     |  21 ++--
 drivers/pci/pcie/aer/aerdrv_errprint.c |  22 ++--
 drivers/pci/pcie/aspm.c                |   9 +-
 drivers/pci/pcie/pme.c                 |   6 +-
 drivers/pci/pcie/ptm.c                 |   2 +-
 drivers/pci/probe.c                    |  75 ++++++-------
 drivers/pci/quirks.c                   | 200 ++++++++++++++++-----------------
 drivers/pci/rom.c                      |   4 +-
 drivers/pci/setup-bus.c                |  44 ++++----
 drivers/pci/setup-irq.c                |   4 +-
 drivers/pci/setup-res.c                |  40 ++++---
 drivers/pci/vc.c                       |  18 ++-
 drivers/pci/xen-pcifront.c             |  19 ++--
 include/linux/pci.h                    |  27 +++++
 30 files changed, 363 insertions(+), 365 deletions(-)

-- 
2.7.4
