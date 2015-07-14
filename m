Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:34794 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627AbbGNTeb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2015 15:34:31 -0400
Received: by obre1 with SMTP id e1so12671651obr.1
        for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2015 12:34:31 -0700 (PDT)
Subject: [PATCH v2 0/5] PCI: Fix class code usage
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>, x86@kernel.org,
	Felipe Balbi <balbi@ti.com>, Yu Zhao <yu.zhao@intel.com>,
	Huang Rui <ray.huang@amd.com>,
	Krzysztof =?utf-8?q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Matthew Wilcox <willy@linux.intel.com>,
	Jason Chang <jason.chang@amd.com>
Date: Tue, 14 Jul 2015 14:34:27 -0500
Message-ID: <20150714193153.13224.40528.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI class code management is confusing.  The pci_dev.class element contains
a three-byte value: base class/sub-class/interface.

The PCI_BASE_CLASS_* definitions are a single byte, i.e., dev->class >> 16.
The PCI_CLASS_* definitions are either two or three bytes, i.e., either
dev->class >> 8 or just dev->class.

We had several places where we used a two-byte PCI_CLASS_* definition but
forgot to shift it to the right place.  These patches fix that for NCR
53c810, TI816X, and Intel USB devices.

As far as I can tell, reset_intel_generic_dev() never worked, so I just
removed it completely.

Changes from v1 to v2:
  - Instead of trying to fix reset_intel_generic_dev(), drop it completely

---

Bjorn Helgaas (5):
      PCI: Use PCI_CLASS_SERIAL_USB instead of bare number
      PCI: Fix generic NCR 53c810 class code quirk
      PCI: Fix TI816X class code quirk
      PCI: Revert aeb30016fec3 ("PCI: add Intel USB specific reset method")
      PCI: Shift PCI_CLASS_NOT_DEFINED consistently with other classes


 arch/x86/pci/fixup.c |   13 ----------
 drivers/pci/probe.c  |    2 +-
 drivers/pci/quirks.c |   65 +++++++++++++++++++-------------------------------
 3 files changed, 26 insertions(+), 54 deletions(-)
