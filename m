Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387464AbeHBQTk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Aug 2018 12:19:40 -0400
Date: Thu, 2 Aug 2018 09:28:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hari Vyas <hari.vyas@broadcom.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Subject: [GIT PULL] PCI fixes for v4.18
Message-ID: <20180802142811.GA6155@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI fixes:

  - Fix integer overflow in new mobiveil driver (Dan Carpenter)

  - Fix race during NVMe removal/rescan (Hari Vyas)


The following changes since commit bd91b56cb3b27492963caeb5fccefe20a986ca8d:

  PCI/AER: Work around use-after-free in pcie_do_fatal_recovery() (2018-07-26 12:13:04 -0500)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.18-fixes-5

for you to fetch changes up to 44bda4b7d26e9fffed6d7152d98a2e9edaeb2a76:

  PCI: Fix is_added/is_busmaster race condition (2018-07-31 11:27:54 -0500)

----------------------------------------------------------------
pci-v4.18-fixes-5

----------------------------------------------------------------
Dan Carpenter (1):
      PCI: mobiveil: Avoid integer overflow in IB_WIN_SIZE

Hari Vyas (1):
      PCI: Fix is_added/is_busmaster race condition

 arch/powerpc/kernel/pci-common.c          |  4 +++-
 arch/powerpc/platforms/powernv/pci-ioda.c |  3 ++-
 arch/powerpc/platforms/pseries/setup.c    |  3 ++-
 drivers/pci/bus.c                         |  6 +++---
 drivers/pci/controller/pcie-mobiveil.c    |  2 +-
 drivers/pci/hotplug/acpiphp_glue.c        |  2 +-
 drivers/pci/pci.h                         | 11 +++++++++++
 drivers/pci/probe.c                       |  4 ++--
 drivers/pci/remove.c                      |  5 +++--
 include/linux/pci.h                       |  1 -
 10 files changed, 28 insertions(+), 13 deletions(-)
