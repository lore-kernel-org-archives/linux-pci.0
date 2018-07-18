Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729642AbeGRUXm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Jul 2018 16:23:42 -0400
Subject: [PATCH v3 0/7] Fix issues and cleanup for ERR_FATAL and ERR_NONFATAL
From: Bjorn Helgaas <helgaas@kernel.org>
To: Oza Pawandeep <poza@codeaurora.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@kernel.org>,
        Timur Tabi <timur@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Wed, 18 Jul 2018 14:44:18 -0500
Message-ID: <153194245964.191586.14782253252654776509.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a v3 of Oza's patches [1].  It's available at [2] if you prefer
git.

v3 changes:
  - Add pci_aer_clear_fatal_status() to clear ERR_FATAL bits, only called
    from pcie_do_fatal_recovery().  Moved to first in series to avoid a
    window where ERR_FATAL recovery only clears ERR_NONFATAL bits.  Visible
    only inside the PCI core.
  - Instead of having pci_cleanup_aer_uncorrect_error_status() do different
    things based on dev->error_state, use this only for ERR_NONFATAL bits.
    I didn't change the name because it's used by many drivers.
  - Rename pci_cleanup_aer_error_device_status() to
    pci_aer_clear_device_status(), make it void, and make it visible only
    inside the PCI core.
  - Remove pcie_portdrv_err_handler.slot_reset altogether instead of making
    it a stub function.  Possibly pcie_portdrv_err_handler could be removed
    completely?

[1] https://lkml.kernel.org/r/1529661494-20936-1-git-send-email-poza@codeaurora.org
[2] https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/?h=pci/06-22-oza-aer

---

Bjorn Helgaas (1):
      PCI/AER: Clear only ERR_FATAL status bits during fatal recovery

Oza Pawandeep (6):
      PCI/AER: Clear only ERR_NONFATAL bits during non-fatal recovery
      PCI/AER: Factor out ERR_NONFATAL status bit clearing
      PCI/AER: Remove ERR_FATAL code from ERR_NONFATAL path
      PCI/AER: Clear device status bits during ERR_FATAL and ERR_NONFATAL
      PCI/AER: Clear device status bits during ERR_COR handling
      PCI/portdrv: Remove pcie_portdrv_err_handler.slot_reset


 drivers/pci/pci.h              |    5 ++++
 drivers/pci/pcie/aer.c         |   47 +++++++++++++++++++++++++++-------------
 drivers/pci/pcie/err.c         |   15 +++++--------
 drivers/pci/pcie/portdrv_pci.c |   25 ---------------------
 4 files changed, 43 insertions(+), 49 deletions(-)
