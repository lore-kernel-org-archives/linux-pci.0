Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:12064 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932234AbdJZOdH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Oct 2017 10:33:07 -0400
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        stable@vger.kernel.org
Subject: [PATCH v1] PCI: Fixup the RTIT_BAR of Intel TH on Denverton
Date: Thu, 26 Oct 2017 17:28:17 +0300
Message-Id: <20171026142817.17791-1-alexander.shishkin@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On some integrations of the Intel(R) Trace Hub (for a reference and
overview see Documentation/trace/intel_th.txt) the reported size of
one of its resources (RTIT_BAR) doesn't match its actual size, which
leads to overlaps with other devices' resources.

On a Denverton platform it overlaps with XHCI MMIO space, which results
in the xhci driver bailing out after seeing its registers as 0xffffffff,
and perceived disappearance of all USB devices:

> intel_th_pci 0000:00:1f.7: enabling device (0004 -> 0006)
> xhci_hcd 0000:00:15.0: xHCI host controller not responding, assume dead
> xhci_hcd 0000:00:15.0: xHC not responding in xhci_irq, assume controller is dead
> xhci_hcd 0000:00:15.0: HC died; cleaning up
> usb 1-1: USB disconnect, device number 2
...

For this reason, we need to resize the RTIT_BAR on Denverton to its
actual size, which in this case is 4MB.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Link: https://software.intel.com/sites/default/files/managed/d3/3c/intel-th-developer-manual.pdf
Fixes: 5118ccd34780 ("intel_th: pci: Add Denverton SOC support")
Cc: stable@vger.kernel.org
---
 drivers/pci/quirks.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index a4d33619a7bb..d321ea6427b8 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4799,3 +4799,19 @@ static void quirk_no_ats(struct pci_dev *pdev)
 /* AMD Stoney platform GPU */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x98e4, quirk_no_ats);
 #endif /* CONFIG_PCI_ATS */
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
2.14.2
