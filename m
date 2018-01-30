Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751452AbeA3SZW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jan 2018 13:25:22 -0500
Subject: [PATCH v2 00/14] PCI/DPC: Simplify RP PIO logging
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>
Date: Tue, 30 Jan 2018 12:25:19 -0600
Message-ID: <20180130182235.106875.70588.stgit@bhelgaas-glaptop.roam.corp.google.com>
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

These are currently on my pci/dpc branch.

Changes from v1 to v2:
  - Split up the "Consolidate RP PIO get/print functions" patch to
    make it more reviewable.  The resulting git diff is empty except
    for a trival local variable declaration.

---

Bjorn Helgaas (14):
      PCI/DPC: Rename interrupt_event_handler() to dpc_work()
      PCI/DPC: Add local variable for DPC capability offset
      PCI/DPC: Rename struct dpc_dev.rp to rp_extensions
      PCI/DPC: Read RP PIO Log Size once at probe
      PCI/DPC: Process RP PIO details only if RP PIO extensions supported
      PCI/DPC: Squash dpc_rp_pio_print_tlp_header() into dpc_rp_pio_print_error()
      PCI/DPC: Rename local "status" to "dpc_status"
      PCI/DPC: Make RP PIO log size check more generic
      PCI/DPC: Squash dpc_rp_pio_print_error() into dpc_rp_pio_get_info()
      PCI/DPC: Push dpc->rp_pio_status assignment into dpc_rp_pio_get_info()
      PCI/DPC: Remove unnecessary RP PIO register structs
      PCI/DPC: Squash dpc_rp_pio_get_info() into dpc_process_rp_pio_error()
      PCI/DPC: Add and use DPC Status register field definitions
      PCI/DPC: Reformat DPC register definitions


 drivers/pci/pcie/pcie-dpc.c   |  214 +++++++++++++++--------------------------
 include/uapi/linux/pci_regs.h |   24 ++---
 2 files changed, 91 insertions(+), 147 deletions(-)
