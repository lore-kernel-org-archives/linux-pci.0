Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36932 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751255AbcFXCgz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 23 Jun 2016 22:36:55 -0400
Date: Thu, 23 Jun 2016 21:36:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Meelis Roos <mroos@linux.ee>,
	Anatoly Pugachev <matorola@gmail.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: [GIT PULL] PCI fixes for v4.7
Message-ID: <20160624023649.GA14990@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Here's a small fix for v4.7.  This problem was actually introduced in v4.6
when we unified Kconfig, making PCIe support available everywhere including
sparc, where config reads into unaligned buffers cause warnings.  This fix
is from Dave Miller.

As a reminder, any future PCI fixes for v4.7 will probably come from Alex
Williamson, since I'll be on vacation for most of the rest of this cycle.
I should be back about the time the merge window opens.

Bjorn


The following changes since commit af8c34ce6ae32addda3788d54a7e340cad22516b:

  Linux 4.7-rc2 (2016-06-05 14:31:26 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.7-fixes-1

for you to fetch changes up to ef0dab4aae14e25efddf1577736f8450132800c5:

  PCI: Fix unaligned accesses in VC code (2016-06-20 13:24:20 -0500)

----------------------------------------------------------------
PCI updates for v4.7:

  Miscellaneous
    Fix unaligned accesses in VC code (David Miller)

----------------------------------------------------------------
David Miller (1):
      PCI: Fix unaligned accesses in VC code

 drivers/pci/vc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
