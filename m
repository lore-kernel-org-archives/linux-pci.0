Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41772 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754490AbcAIPTp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 9 Jan 2016 10:19:45 -0500
Date: Sat, 9 Jan 2016 09:19:42 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Russell King <linux@arm.linux.org.uk>,
	Tony Lindgren <tony@atomide.com>, Dan Murphy <dmurphy@ti.com>,
	Suman Anna <s-anna@ti.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] PCI fixes for v4.4
Message-ID: <20160109151942.GA30623@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Sorry about this last-minute pull request.  This marks the TI DRA7xx host
bridge driver as broken.  Apparently it has never worked without some
additional out-of-tree code, so I'm going to mark it broken now and remove
it completely next cycle unless it's fixed.

Bjorn


The following changes since commit 1dbe162d53e11665b48a1c122899ffc2c068bef4:

  PCI: hisi: Fix hisi_pcie_cfg_read() 32-bit reads (2015-12-04 16:32:25 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.4-fixes-4

for you to fetch changes up to 5c3b99d057525fe2befe6a7db9b1309035d93eee:

  PCI: dra7xx: Mark driver as broken (2016-01-08 09:58:31 -0600)

----------------------------------------------------------------
PCI updates for v4.4:

  TI DRA7xx host bridge driver
    Mark driver as broken (Richard Cochran)

----------------------------------------------------------------
Richard Cochran (1):
      PCI: dra7xx: Mark driver as broken

 drivers/pci/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)
