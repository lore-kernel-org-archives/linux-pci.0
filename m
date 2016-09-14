Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1765192AbcINUL3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Sep 2016 16:11:29 -0400
Date: Wed, 14 Sep 2016 15:11:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Prarit Bhargava <prarit@redhat.com>,
        Myron Stowe <myron.stowe@redhat.com>
Subject: [GIT PULL] PCI fixes for v4.8
Message-ID: <20160914201124.GA12386@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Here are two changes for v4.8.  The first fixes a "[Firmware Bug]: reg
0x10: invalid BAR (can't size)" warning on Haswell, and the second fixes a
problem in some new runtime suspend functionality we merged for v4.8.

Bjorn


The following changes since commit 21c80c9fefc3db10b530a96eb0478c29eb28bf77:

  x86/PCI: VMD: Fix infinite loop executing irq's (2016-08-23 16:36:42 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.8-fixes-2

for you to fetch changes up to 035ee288ae7ade4152f1c3cf23a587b04fdc526c:

  PCI: Fix bridge_d3 update on device removal (2016-09-13 16:00:18 -0500)

----------------------------------------------------------------
PCI updates for v4.8:

  Enumeration
    Mark Haswell Power Control Unit as having non-compliant BARs (Bjorn Helgaas)

  Power management
    Fix bridge_d3 update on device removal (Lukas Wunner)

----------------------------------------------------------------
Bjorn Helgaas (1):
      PCI: Mark Haswell Power Control Unit as having non-compliant BARs

Lukas Wunner (1):
      PCI: Fix bridge_d3 update on device removal

 arch/x86/pci/fixup.c | 20 +++++++++++++-------
 drivers/pci/remove.c |  3 +--
 2 files changed, 14 insertions(+), 9 deletions(-)
