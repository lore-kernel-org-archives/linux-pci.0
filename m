Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751384AbdGMWND (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Jul 2017 18:13:03 -0400
Date: Thu, 13 Jul 2017 17:12:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>
Subject: [GIT PULL] PCI fixes for v4.13
Message-ID: <20170713221258.GA7364@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI fixes:

  - fix a typo that broke Rockchip enumeration

  - fix a new memory leak in the ARM host bridge failure path


The following changes since commit af3c8d98508d37541d4bf57f13a984a7f73a328c:

  Merge tag 'drm-for-v4.13' of git://people.freedesktop.org/~airlied/linux (2017-07-09 18:48:37 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.13-fixes-1

for you to fetch changes up to 34d5ac2af644a10958e144b7bb937d289dfd158d:

  PCI: rockchip: Check for pci_scan_root_bus_bridge() failure correctly (2017-07-12 12:50:11 -0500)

----------------------------------------------------------------
pci-v4.13-fixes-1

----------------------------------------------------------------
Lorenzo Pieralisi (1):
      ARM/PCI: Fix pcibios_init_resource() struct pci_host_bridge leak

Shawn Lin (1):
      PCI: rockchip: Check for pci_scan_root_bus_bridge() failure correctly

 arch/arm/kernel/bios32.c         | 2 +-
 drivers/pci/host/pcie-rockchip.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
