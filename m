Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751549AbeEVAab (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 May 2018 20:30:31 -0400
Subject: [PATCH v1 0/4] sparc/PCI: VGA resource and other fixes
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Meelis Roos <mroos@linux.ee>
Date: Mon, 21 May 2018 19:30:29 -0500
Message-ID: <152694888798.59585.8779818482732387864.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The main thing here is the first patch, a legacy VGA framebuffer fix for
issues reported by Meelis.

The others are to converge the pci_enable_device() path for LEON and PCIC
with other arches (including sparc64), and to convert some logging to use
dev_printk() and make it more consistent with the PCI core.

I propose to merge these via the PCI tree.

---

Bjorn Helgaas (4):
      sparc/PCI: Request legacy VGA framebuffer only for VGA devices
      sparc32/PCI/LEON: Converge device enable path
      sparc32/PCI/PCIC: Converge device enable path
      sparc/PCI: Use dev_printk() when possible


 arch/sparc/kernel/leon_pci.c   |   62 ++++++------------
 arch/sparc/kernel/pci.c        |  136 +++++++++++++++++++++++++---------------
 arch/sparc/kernel/pci_common.c |   31 ++-------
 arch/sparc/kernel/pci_msi.c    |   10 +--
 arch/sparc/kernel/pcic.c       |   86 ++++++++++++-------------
 5 files changed, 159 insertions(+), 166 deletions(-)
