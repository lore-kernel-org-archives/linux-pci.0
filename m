Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752816AbdHJVO5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Aug 2017 17:14:57 -0400
Date: Thu, 10 Aug 2017 16:14:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [GIT PULL] PCI fixes for v4.13
Message-ID: <20170810211455.GA529@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI fix:

  - work around Renesas uPD72020x 32-bit DMA issue


The following changes since commit 16f73eb02d7e1765ccab3d2018e0bd98eb93d973:

  Linux 4.13-rc3 (2017-07-30 12:40:36 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci-v4.13-fixes-2

for you to fetch changes up to 8466489ef5ba48272ba4fa4ea9f8f403306de4c7:

  xhci: Reset Renesas uPD72020x USB controller for 32-bit DMA issue (2017-08-02 12:05:07 -0500)

----------------------------------------------------------------
pci-v4.13-fixes-2

----------------------------------------------------------------
Marc Zyngier (2):
      PCI: Add pci_reset_function_locked()
      xhci: Reset Renesas uPD72020x USB controller for 32-bit DMA issue

 drivers/pci/pci.c             | 35 +++++++++++++++++++++++++++++++++++
 drivers/usb/host/pci-quirks.c | 20 ++++++++++++++++++++
 drivers/usb/host/pci-quirks.h |  1 +
 drivers/usb/host/xhci-pci.c   |  7 +++++++
 include/linux/pci.h           |  1 +
 5 files changed, 64 insertions(+)
