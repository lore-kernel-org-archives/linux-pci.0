Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730852AbeG0Slu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Jul 2018 14:41:50 -0400
Date: Fri, 27 Jul 2018 12:18:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Tai <thomas.tai@oracle.com>
Subject: [GIT PULL] PCI fixes for v4.18
Message-ID: <20180727171858.GA16743@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI fixes:

  - Fix a use-after-free error in fatal error recovery (Thomas Tai)


The following changes since commit 270ed733e68955049b693bea8f4a1efb293a96ae:

  PCI: v3-semi: Fix I/O space page leak (2018-07-18 17:02:13 -0500)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.18-fixes-4

for you to fetch changes up to bd91b56cb3b27492963caeb5fccefe20a986ca8d:

  PCI/AER: Work around use-after-free in pcie_do_fatal_recovery() (2018-07-26 12:13:04 -0500)

----------------------------------------------------------------
pci-v4.18-fixes-4

----------------------------------------------------------------
Thomas Tai (1):
      PCI/AER: Work around use-after-free in pcie_do_fatal_recovery()

 drivers/pci/pcie/err.c | 2 ++
 1 file changed, 2 insertions(+)
