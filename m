Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 9 Mar 2018 10:58:17 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Koen Vandeputte <koen.vandeputte@ncentric.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [GIT PULL] PCI fixes for v4.16
Message-ID: <20180309165817.GA8224@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI fixes:

  - fix sparc build issue when OF_IRQ not enabled (Guenter Roeck) 

  - fix enumeration of devices below switches on DesignWare-based
    controllers (Koen Vandeputte)


The following changes since commit c37406e05d1e541df40b8b81c4bd40753fcaf414:

  PCI: Allow release of resources that were never assigned (2018-02-26 14:51:13 -0600)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.16-fixes-3

for you to fetch changes up to fc110ebdd014dd1368c98e7685b47789c31fab42:

  PCI: dwc: Fix enumeration end when reaching root subordinate (2018-03-07 10:46:39 -0600)

----------------------------------------------------------------
pci-v4.16-fixes-3

----------------------------------------------------------------
Guenter Roeck (1):
      PCI: Move of_irq_parse_and_map_pci() declaration under OF_IRQ

Koen Vandeputte (1):
      PCI: dwc: Fix enumeration end when reaching root subordinate

 drivers/pci/dwc/pcie-designware-host.c |  2 +-
 include/linux/of_pci.h                 | 17 ++++++++++-------
 2 files changed, 11 insertions(+), 8 deletions(-)
