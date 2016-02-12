Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38393 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750987AbcBLWlo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 12 Feb 2016 17:41:44 -0500
Date: Fri, 12 Feb 2016 16:41:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Simon Horman <horms+renesas@verge.net.au>,
	Ray Jui <rjui@broadcom.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [GIT PULL] PCI fixes for v4.5
Message-ID: <20160212224140.GA8096@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

These are some Renesas binding updates for PCI host controllers, a
Broadcom fix for a regression we added in v4.5-rc1, and a fix for
an AER use-after-free problem that can cause memory corruption.

Bjorn


The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.5-fixes-1

for you to fetch changes up to 0cf1337e0b83c16de4e7e98dad3a6afce6043fea:

  PCI: rcar: Add device tree support for r8a7793 (2016-02-05 14:13:53 -0600)

----------------------------------------------------------------
PCI updates for v4.5:

  AER
    Flush workqueue on device remove to avoid use-after-free (Sebastian Andrzej Siewior)

  Broadcom iProc host bridge driver
    Allow multiple devices except on PAXC (Ray Jui)

  Renesas R-Car host bridge driver
    Add gen2 device tree support for r8a7793 (Simon Horman)
    Add device tree support for r8a7793 (Simon Horman)

----------------------------------------------------------------
Ray Jui (1):
      PCI: iproc: Allow multiple devices except on PAXC

Sebastian Andrzej Siewior (1):
      PCI/AER: Flush workqueue on device remove to avoid use-after-free

Simon Horman (2):
      PCI: rcar: Add gen2 device tree support for r8a7793
      PCI: rcar: Add device tree support for r8a7793

 .../devicetree/bindings/pci/pci-rcar-gen2.txt      |  1 +
 Documentation/devicetree/bindings/pci/rcar-pci.txt |  1 +
 drivers/pci/host/pcie-iproc.c                      | 29 ++++++++--------------
 drivers/pci/pcie/aer/aerdrv.c                      |  4 +--
 drivers/pci/pcie/aer/aerdrv.h                      |  1 -
 drivers/pci/pcie/aer/aerdrv_core.c                 |  2 --
 6 files changed, 14 insertions(+), 24 deletions(-)
