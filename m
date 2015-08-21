Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35297 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752608AbbHURPK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Aug 2015 13:15:10 -0400
Received: by pacdd16 with SMTP id dd16so48290701pac.2
        for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2015 10:15:09 -0700 (PDT)
Date: Fri, 21 Aug 2015 12:15:04 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meelis Roos <mroos@linux.ee>, Helge Deller <deller@gmx.de>,
	Yinghai Lu <yinghai@kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [GIT PULL] PCI fixes for v4.2
Message-ID: <20150821171504.GA12562@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

These are fixes for ASPM-related NULL pointer dereference crashes on Sparc
and PowerPC and 64-bit PCI address-related HPMC crashes on PA-RISC.  These
are both caused by things we merged in the v4.2 merge window.

Bjorn


The following changes since commit c9ddbac9c89110f77cb0fa07e634aaf1194899aa:

  PCI: Restore PCI_MSIX_FLAGS_BIRMASK definition (2015-07-14 18:27:46 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.2-fixes-2

for you to fetch changes up to 45ea2a5fed6dacb9bb0558d8b21eacc1c45d5bb4:

  PCI: Don't use 64-bit bus addresses on PA-RISC (2015-08-20 17:16:37 -0500)

----------------------------------------------------------------
PCI updates for v4.2:

  Resource management
    - Don't use 64-bit bus addresses on PA-RISC

  Miscellaneous
    - Tolerate hierarchies with no Root Port

----------------------------------------------------------------
Bjorn Helgaas (1):
      PCI: Don't use 64-bit bus addresses on PA-RISC

Yijing Wang (1):
      PCI: Tolerate hierarchies with no Root Port

 drivers/pci/Kconfig | 2 +-
 drivers/pci/probe.c | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)
