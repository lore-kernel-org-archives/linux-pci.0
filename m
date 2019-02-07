Return-Path: <SRS0=HpDZ=QO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB63C282CC
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 13:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D26DC21908
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 13:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfBGNaW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 Feb 2019 08:30:22 -0500
Received: from mga12.intel.com ([192.55.52.136]:45017 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbfBGNaV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Feb 2019 08:30:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 05:30:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,344,1544515200"; 
   d="scan'208";a="297960142"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 07 Feb 2019 05:30:18 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        stable@vger.kernel.org
Subject: [PATCH v2] PCI: Fixup the RTIT_BAR of Intel TH on Denverton
Date:   Thu,  7 Feb 2019 15:30:05 +0200
Message-Id: <20190207133005.67328-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Denverton's integration of the Intel(R) Trace Hub (for a reference
and overview see Documentation/trace/intel_th.txt) the reported size of
one of its resources (RTIT_BAR) doesn't match its actual size, which
leads to overlaps with other devices' resources.

In practice, it overlaps with XHCI MMIO space, which results in the xhci
driver bailing out after seeing its registers as 0xffffffff, and perceived
disappearance of all USB devices:

> intel_th_pci 0000:00:1f.7: enabling device (0004 -> 0006)
> xhci_hcd 0000:00:15.0: xHCI host controller not responding, assume dead
> xhci_hcd 0000:00:15.0: xHC not responding in xhci_irq, assume controller is dead
> xhci_hcd 0000:00:15.0: HC died; cleaning up
> usb 1-1: USB disconnect, device number 2
...

For this reason, we need to resize the RTIT_BAR on Denverton to its
actual size, which in this case is 4MB. The corresponding erratum is
DNV36 at the link below.

Link: https://www.intel.com/content/dam/www/public/us/en/documents/specification-updates/atom-c3000-family-spec-update.pdf
Fixes: 5118ccd34780 ("intel_th: pci: Add Denverton SOC support")
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/pci/fixup.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 30a5111ae5fd..527e69b12002 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -635,6 +635,22 @@ static void quirk_no_aersid(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
 			      PCI_CLASS_BRIDGE_PCI, 8, quirk_no_aersid);
 
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
+
 #ifdef CONFIG_PHYS_ADDR_T_64BIT
 
 #define AMD_141b_MMIO_BASE(x)	(0x80 + (x) * 0x8)
-- 
2.20.1

