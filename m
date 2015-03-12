Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:42044 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754151AbbCLRfW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Mar 2015 13:35:22 -0400
Received: by obbnt9 with SMTP id nt9so15483840obb.9
        for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2015 10:35:21 -0700 (PDT)
Subject: [PATCH v1 0/4] Unassigned resource fixes
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-acpi@vger.kernel.org
Date: Thu, 12 Mar 2015 12:35:19 -0500
Message-ID: <20150312173201.1052.28341.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These are some minor resource fixes related to unassigned PCI BARs.  We
should:

  - Mark BARS as unassigned when we can figure that out
  - Not complain about "overlaps" with unassigned BARs
  - Prevent pci_ioremap_bar() on unassigned BARs
  - Give better error messages when pci_ioremap_bar() fails

I don't think these will actually fix any bugs, other than getting rid of
some annoying messages and improving some others.

Comments welcome.

---

Bjorn Helgaas (4):
      PNP: Don't check for overlaps with unassigned PCI BARs
      PCI: Mark invalid BARs as unassigned
      PCI: Show driver, BAR#, and resource on pci_ioremap_bar() failure
      PCI: Fail pci_ioremap_bar() on unassigned resources


 drivers/pci/pci.c       |    9 +++++----
 drivers/pci/setup-res.c |    2 ++
 drivers/pnp/quirks.c    |    9 ++++++---
 3 files changed, 13 insertions(+), 7 deletions(-)

-- 
Bjorn
