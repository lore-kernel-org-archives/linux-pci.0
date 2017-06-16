Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750780AbdFPQsl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Jun 2017 12:48:41 -0400
Date: Fri, 16 Jun 2017 11:48:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [GIT PULL] PCI fixes for v4.12
Message-ID: <20170616164838.GA11129@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI fixes:

  - fix another PCI_ENDPOINT build error (merged for v4.12)

  - fix error codes added to config accessors for v4.12


The following changes since commit 4d071c3238987325b9e50e33051a40d1cce311cc:

  PCI/PM: Add needs_resume flag to avoid suspend complete optimization (2017-05-23 14:18:17 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci-v4.12-fixes-2

for you to fetch changes up to 98dbf5af4fdd142f6184dbb4e4164a8d1850d526:

  PCI: endpoint: Select CRC32 to fix test build error (2017-06-12 15:46:13 -0500)

----------------------------------------------------------------
pci-v4.12-fixes-2

----------------------------------------------------------------
Brian Norris (1):
      PCI: Make error code types consistent in pci_{read,write}_config_*

Randy Dunlap (1):
      PCI: endpoint: Select CRC32 to fix test build error

 drivers/pci/access.c                   | 12 ++++++------
 drivers/pci/endpoint/functions/Kconfig |  1 +
 2 files changed, 7 insertions(+), 6 deletions(-)
