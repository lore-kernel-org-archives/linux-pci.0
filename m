Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56722 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751936AbbLaVVx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 31 Dec 2015 16:21:53 -0500
Date: Thu, 31 Dec 2015 15:21:49 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dongdong Liu <liudongdong3@huawei.com>
Subject: [GIT PULL] PCI fixes for v4.4
Message-ID: <20151231212149.GA22492@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Here's another fix for v4.4.  This fixes 32-bit config reads for the
HiSilicon driver.  Obviously the driver is completely broken without this
fix (apparently it actually was tested internally, but got broken somehow
in the process of upstreaming it).

Bjorn


The following changes since commit 99496bd2971fc378226ad4413e5b72c4545714bd:

  PCI: altera: Fix error when INTx is 4 (2015-12-04 16:21:21 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.4-fixes-3

for you to fetch changes up to 1dbe162d53e11665b48a1c122899ffc2c068bef4:

  PCI: hisi: Fix hisi_pcie_cfg_read() 32-bit reads (2015-12-04 16:32:25 -0600)

----------------------------------------------------------------
PCI updates for v4.4:

  HiSilicon host bridge driver
    Fix 32-bit config reads (Dongdong Liu)

----------------------------------------------------------------
Dongdong Liu (1):
      PCI: hisi: Fix hisi_pcie_cfg_read() 32-bit reads

 drivers/pci/host/pcie-hisi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
