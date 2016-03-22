Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36760 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759418AbcCVOca (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 22 Mar 2016 10:32:30 -0400
Date: Tue, 22 Mar 2016 09:32:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sekhar Nori <nsekhar@ti.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Tero Roponen <tero.roponen@gmail.com>
Subject: [GIT PULL] PCI fixes for v4.6
Message-ID: <20160322143227.GA23108@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Here are two fixes for v4.6:

  - You merged a fix for a TI DRA7xx reset issue from another source, so
    Sekhar removed the "broken" tag from the driver, and

  - I botched a Kconfig merge and broke hotplug configuration for
    everybody, so Tero fixed that.

Bjorn


The following changes since commit 643ad15d47410d37d43daf3ef1c8ac52c281efa5:

  Merge branch 'mm-pkeys-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2016-03-20 19:08:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.6-fixes-1

for you to fetch changes up to 9188269a2e8ea5b32affef99d42c5eda91c07fdf:

  Revert "PCI: dra7xx: Mark driver as broken" (2016-03-22 07:50:11 -0500)

----------------------------------------------------------------
PCI updates for v4.6:

  TI DRA7xx host bridge driver
    Revert "PCI: dra7xx: Mark driver as broken" (Sekhar Nori)

  Miscellaneous
    Restore inclusion of pci/hotplug Kconfig (Tero Roponen)

----------------------------------------------------------------
Sekhar Nori (1):
      Revert "PCI: dra7xx: Mark driver as broken"

Tero Roponen (1):
      PCI: Restore inclusion of pci/hotplug Kconfig

 drivers/pci/Kconfig      | 1 +
 drivers/pci/host/Kconfig | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)
