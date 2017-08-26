Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752480AbdHZMLF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 26 Aug 2017 08:11:05 -0400
Date: Sat, 26 Aug 2017 07:11:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Meelis Roos <mroos@linux.ee>
Subject: [GIT PULL] PCI fixes for v4.13
Message-ID: <20170826121102.GA23614@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI fix:

  - remove needlessly alarming MSI affinity warning (this is not actually a
    bug fix, but the warning prompts unnecessary bug reports)


The following changes since commit 8466489ef5ba48272ba4fa4ea9f8f403306de4c7:

  xhci: Reset Renesas uPD72020x USB controller for 32-bit DMA issue (2017-08-02 12:05:07 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci-v4.13-fixes-3

for you to fetch changes up to 8e1101d251647802d0a4ae19eb3d0e1453eaeff4:

  PCI/MSI: Don't warn when irq_create_affinity_masks() returns NULL (2017-08-25 18:58:42 -0500)

----------------------------------------------------------------
pci-v4.13-fixes-3

----------------------------------------------------------------
Christoph Hellwig (1):
      PCI/MSI: Don't warn when irq_create_affinity_masks() returns NULL

 drivers/pci/msi.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)
