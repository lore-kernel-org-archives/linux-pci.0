Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:14165 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750862AbdISOvu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Sep 2017 10:51:50 -0400
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        stable@vger.kernel.org
Subject: [PATCH] PCI: Fixup the RTIT_BAR of Intel TH on Denverton
Date: Tue, 19 Sep 2017 17:51:36 +0300
Message-Id: <20170919145136.13527-1-alexander.shishkin@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On some intergrations of the Intel TH the reported size of RTIT_BAR
doesn't match its actual size, which leads to overlaps with other
devices' resources.

For this reason, we need to resize the RTIT_BAR on Denverton where
it would overlap with XHCI MMIO space.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Fixes: 5118ccd347 ("intel_th: pci: Add Denverton SOC support")
Cc: stable@vger.kernel.org
---
 drivers/pci/quirks.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 6967c6b4cf..08a1e6629f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4681,3 +4681,19 @@ static void quirk_intel_no_flr(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_intel_no_flr);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_intel_no_flr);
+
+static void quirk_intel_th_dnv(struct pci_dev *dev)
+{
+	struct resource *r = &dev->resource[4];
+
+	/*
+	 * Denverton reports 2k of RTIT_BAR (intel_th resource 4), which
+	 * appears to be 4 MB in reality.
+	 */
+	if (r->end == r->start + 0x7ff) {
+		r->start = 0;
+		r->end   = 0x3fffff;
+		r->flags |= IORESOURCE_UNSET;
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x19e1, quirk_intel_th_dnv);
-- 
2.14.1
