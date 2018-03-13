Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752729AbeCMWfZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Mar 2018 18:35:25 -0400
Subject: [PATCH v1 0/2] PCI: Clean up whitespace
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Date: Tue, 13 Mar 2018 17:35:21 -0500
Message-ID: <152098048688.43178.2089454526004328425.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Clean up the Makefiles and some comments.  No functional change intended.

---

Bjorn Helgaas (2):
      PCI: Tidy Makefiles
      PCI: Tidy comments


 drivers/pci/Makefile                   |   59 +++++++++++---------------------
 drivers/pci/access.c                   |   12 ++++---
 drivers/pci/ats.c                      |   10 ++---
 drivers/pci/bus.c                      |    2 -
 drivers/pci/host-bridge.c              |    2 +
 drivers/pci/iov.c                      |    8 ++--
 drivers/pci/mmap.c                     |    2 +
 drivers/pci/msi.c                      |    3 +-
 drivers/pci/pci-acpi.c                 |    3 +-
 drivers/pci/pci-driver.c               |    2 -
 drivers/pci/pci-label.c                |    5 ++-
 drivers/pci/pci-stub.c                 |    3 +-
 drivers/pci/pci-sysfs.c                |    3 --
 drivers/pci/pci.c                      |    9 +++--
 drivers/pci/pcie/Makefile              |   16 +++------
 drivers/pci/pcie/aer/aerdrv.c          |    9 ++---
 drivers/pci/pcie/aer/aerdrv.h          |    1 -
 drivers/pci/pcie/aer/aerdrv_acpi.c     |    1 -
 drivers/pci/pcie/aer/aerdrv_core.c     |   11 ++----
 drivers/pci/pcie/aer/aerdrv_errprint.c |    3 --
 drivers/pci/pcie/aer/ecrc.c            |    4 +-
 drivers/pci/pcie/aspm.c                |    3 +-
 drivers/pci/pcie/portdrv.h             |    1 -
 drivers/pci/pcie/portdrv_core.c        |    1 -
 drivers/pci/pcie/portdrv_pci.c         |    2 -
 drivers/pci/probe.c                    |    2 +
 drivers/pci/proc.c                     |    4 +-
 drivers/pci/quirks.c                   |   14 ++++----
 drivers/pci/rom.c                      |    4 +-
 drivers/pci/search.c                   |    8 ++--
 drivers/pci/setup-bus.c                |    6 +--
 drivers/pci/setup-irq.c                |    4 +-
 drivers/pci/setup-res.c                |   10 ++---
 drivers/pci/slot.c                     |    1 -
 drivers/pci/syscall.c                  |    9 ++---
 drivers/pci/vpd.c                      |    3 +-
 drivers/pci/xen-pcifront.c             |    4 +-
 37 files changed, 89 insertions(+), 155 deletions(-)
