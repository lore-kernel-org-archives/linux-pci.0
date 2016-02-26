Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50822 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933535AbcBZP7A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 26 Feb 2016 10:59:00 -0500
Subject: [PATCH v1 2/3] x86/PCI: Mark Broadwell-EP Home Agent & PCU as
 having non-compliant BARs
To: Andi Kleen <ak@linux.intel.com>,
	Jayachandran Chandrashekaran Nair
	<jayachandran.chandrashekaran@broadcom.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh@kernel.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	linux-pci@vger.kernel.org
Date: Fri, 26 Feb 2016 09:58:57 -0600
Message-ID: <20160226155857.9113.98179.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160226155334.9113.77645.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160226155334.9113.77645.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Home Agent and PCU PCI devices in Broadwell-EP have a non-BAR register
where a BAR should be.  We don't know what the side effects of sizing the
"BAR" would be, and we don't know what address space the "BAR" might appear
to describe.

Mark these devices as having non-compliant BARs so the PCI core doesn't
touch them.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/pci/fixup.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index e585655..0ae7e9f 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -540,3 +540,10 @@ static void twinhead_reserve_killing_zone(struct pci_dev *dev)
         }
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x27B9, twinhead_reserve_killing_zone);
+
+static void pci_bdwep_bar(struct pci_dev *dev)
+{
+	dev->non_compliant_bars = 1;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fa0, pci_bdwep_bar);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fc0, pci_bdwep_bar);

