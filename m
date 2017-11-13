Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751188AbdKMXLr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Nov 2017 18:11:47 -0500
Subject: [PATCH v1 0/4] PCI/ASPM: Fix some L1 substate configuration
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Rajat Jain <rajatja@google.com>, linux-kernel@vger.kernel.org,
        Vidya Sagar <vidyas@nvidia.com>
Date: Mon, 13 Nov 2017 17:11:45 -0600
Message-ID: <20171113230937.4120.68038.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The first two patches fix typos that cause incorrect L1 substate
configuration.  The last two are cosmetic for maintainability.

These are minor enough that I'd like to squeeze them into v4.15 unless
anybody objects.

---

Bjorn Helgaas (4):
      PCI/ASPM: Account for downstream device's Port Common_Mode_Restore_Time
      PCI/ASPM: Use correct capability pointer to program LTR_L1.2_THRESHOLD
      PCI/ASPM: Reformat ASPM register definitions
      PCI/ASPM: Add L1 Substates definitions


 drivers/pci/pcie/aspm.c       |   38 ++++++++++++++++++++++----------------
 include/uapi/linux/pci_regs.h |   34 ++++++++++++++++++++--------------
 2 files changed, 42 insertions(+), 30 deletions(-)
