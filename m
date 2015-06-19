Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:38885 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584AbbFSWmS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jun 2015 18:42:18 -0400
Received: by igblz2 with SMTP id lz2so22506310igb.1
        for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2015 15:42:17 -0700 (PDT)
Subject: [PATCH 0/6] PCI: Fix class code usage
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Dexuan Cui <dexuan.cui@intel.com>, Matthew Wilcox <matthew@wil.cx>,
	x86@kernel.org, Felipe Balbi <balbi@ti.com>,
	Yu Zhao <yu.zhao@intel.com>, Huang Rui <ray.huang@amd.com>,
	Krzysztof =?utf-8?q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Jason Chang <jason.chang@amd.com>
Date: Fri, 19 Jun 2015 17:42:15 -0500
Message-ID: <20150619223325.14626.66402.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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

---

Bjorn Helgaas (6):
      PCI: Use PCI_CLASS_SERIAL_USB instead of bare number
      PCI: Fix generic NCR 53c810 class code quirk
      PCI: Fix TI816X class code quirk
      PCI: Fix Intel generic reset quirk class code check
      PCI: Simplify reset_intel_generic_dev()
      PCI: Shift PCI_CLASS_NOT_DEFINED consistently with other classes


 arch/x86/pci/fixup.c |   13 ----------
 drivers/pci/probe.c  |    2 +-
 drivers/pci/quirks.c |   64 ++++++++++++++++++++++++++++----------------------
 3 files changed, 37 insertions(+), 42 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-pci" in
