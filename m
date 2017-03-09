Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751415AbdCITqW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Mar 2017 14:46:22 -0500
Date: Thu, 9 Mar 2017 13:45:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yinghai Lu <yinghai@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Ethan Zhao <ethan.zhao@oracle.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        James Morse <james.morse@arm.com>
Subject: [GIT PULL] PCI fixes for v4.11
Message-ID: <20170309194548.GA19517@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI fixes:

  - fix NULL pointer dereference in Exynos driver

  - fix NULL pointer dereference in ASPM with pre-1.1 PCIe devices

  - blacklist QLogic ISP2722 to prevent panics while reading VPD


The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.11-fixes-2

for you to fetch changes up to 3bd7db63a841e8c5297bb18ad801df67d5e38ad2:

  PCI/ASPM: Always set link->downstream to avoid NULL dereference on remove (2017-03-07 14:23:30 -0600)

----------------------------------------------------------------
pci-v4.11-fixes-2

----------------------------------------------------------------
Ethan Zhao (1):
      PCI: Prevent VPD access for QLogic ISP2722

Jaehoon Chung (1):
      PCI: exynos: Initialize elbi_base even when using PHY framework

Yinghai Lu (1):
      PCI/ASPM: Always set link->downstream to avoid NULL dereference on remove

 drivers/pci/dwc/pci-exynos.c | 8 ++++----
 drivers/pci/pcie/aspm.c      | 5 ++---
 drivers/pci/quirks.c         | 1 +
 3 files changed, 7 insertions(+), 7 deletions(-)
