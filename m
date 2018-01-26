Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751409AbeAZWzf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Jan 2018 17:55:35 -0500
Subject: [PATCH 0/8] PCI/DPC: Simplify RP PIO logging
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>
Date: Fri, 26 Jan 2018 16:55:30 -0600
Message-ID: <20180126225043.58614.99920.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These are almost all just cleanups.  

The only behavior change I intend is this: If a port does not support
the "RP Extensions for DPC" and it reports an "RP PIO error", we
previously read the RP PIO log registers.  I don't know if that's a
legal situation, but I couldn't find an explicit prohibition in the
spec.

Anyway, the rest is all cleanups and simplifications that are not
intended to change any behavior.

These are currently on my pci/dpc branch [1] on top of patches 3 and 5
from your v2 series [2], Keith:

  6b9045b34b57 PCI/DPC: Fix interrupt message number print
  eed85ff4c0da PCI/DPC: Enable DPC only if AER is available

Your patch 1 ("PCI/AER: Return correct value when AER is not
supported") is on pci/aer.  Patches 2 and 4 go together and I think
you're still working on those.

You don't need to worry about integrating your work with these
patches; I'm just kibbitzing and will drop these completely if you
don't like them, or I'll take care of putting the pieces back together
if you do.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/dpc
[2] https://lkml.kernel.org/r/20180117052206.7703-1-keith.busch@intel.com

---

Bjorn Helgaas (8):
      PCI/DPC: Rename interrupt_event_handler() to dpc_work()
      PCI/DPC: Add local variable for DPC capability offset
      PCI/DPC: Rename struct dpc_dev.rp to rp_extensions
      PCI/DPC: Read RP PIO Log Size once at probe
      PCI/DPC: Process RP PIO details only if RP PIO extensions supported
      PCI/DPC: Consolidate RP PIO get/print functions
      PCI/DPC: Add and use DPC Status register field definitions
      PCI/DPC: Reformat DPC register definitions


 drivers/pci/pcie/pcie-dpc.c   |  214 +++++++++++++++--------------------------
 include/uapi/linux/pci_regs.h |   24 ++---
 2 files changed, 91 insertions(+), 147 deletions(-)
