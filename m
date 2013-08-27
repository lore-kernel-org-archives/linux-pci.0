Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:40539 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602Ab3H0TAU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 Aug 2013 15:00:20 -0400
Received: by mail-pa0-f51.google.com with SMTP id lf1so5222174pab.10
        for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2013 12:00:20 -0700 (PDT)
Subject: [PATCH 0/5] PCIe capability #define tidyup
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lee Jones <lee.jones@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>
Date: Tue, 27 Aug 2013 13:00:17 -0600
Message-ID: <20130827185731.16595.52864.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These clean up some PCIe capability #defines and comments.

The first renames a few #defines that are used in drivers/mfd/rts5227.c.

The rest are whitespace and comment changes that should have no effect on
any users.

I propose to put these in v3.12 unless there are issues.

---

Bjorn Helgaas (5):
      PCI: Rename PCIe capability definitions to follow convention
      PCI: Clarify PCI_EXP_TYPE_PCI_BRIDGE comment
      PCI: Remove obsolete comment reference to pci_pcie_cap2()
      PCI: Tidy bitmasks and spacing of PCIe capability definitions
      PCI: Add offsets of PCIe capability registers


 drivers/mfd/rts5227.c         |    2 -
 drivers/pci/pci.c             |   31 ++++++-----
 include/uapi/linux/pci_regs.h |  113 +++++++++++++++++++++--------------------
 3 files changed, 77 insertions(+), 69 deletions(-)
