Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f74.google.com ([209.85.213.74]:55238 "EHLO
	mail-yw0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760899Ab1LPWba (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 16 Dec 2011 17:31:30 -0500
Received: by yhjj51 with SMTP id j51so578074yhj.1
        for <linux-pci@vger.kernel.org>; Fri, 16 Dec 2011 14:31:29 -0800 (PST)
Subject: [PATCH 0/6] use list_for_each_entry() for bus->devices traversal
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 16 Dec 2011 15:31:29 -0700
Message-ID: <20111216223043.5963.87534.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These are pretty trivial; just replacing open-coded or list_for_each()
traversals with list_for_each_entry().

Most don't change any behavior, but parisc had what looks like a bug:
it enabled FBB/PERR/SERR repeatedly on the same device instead of on all
devices on the bus.

I finally built some cross-compilers, so these have all been compiled.

---

Bjorn Helgaas (6):
      frv/PCI: use list_for_each_entry() for bus->devices traversal
      MIPS: PCI: use list_for_each_entry() for bus->devices traversal
      sh/PCI: use list_for_each_entry() for bus->devices traversal
      sunhme/PCI: use list_for_each_entry() for bus->devices traversal
      de4x5/PCI: use list_for_each_entry() for bus->devices traversal
      parisc/PCI: use list_for_each_entry() for bus->devices traversal


 arch/frv/mb93090-mb00/pci-vdk.c        |    4 +---
 arch/mips/pci/pci.c                    |    5 +----
 arch/mips/pmc-sierra/yosemite/ht-irq.c |   10 ----------
 arch/sh/drivers/pci/pci.c              |    5 +----
 drivers/net/ethernet/dec/tulip/de4x5.c |    9 ++-------
 drivers/net/ethernet/sun/sunhme.c      |    9 ++-------
 drivers/parisc/dino.c                  |    6 ++----
 drivers/parisc/lba_pci.c               |    7 +++----
 8 files changed, 12 insertions(+), 43 deletions(-)

-- 
Bjorn
