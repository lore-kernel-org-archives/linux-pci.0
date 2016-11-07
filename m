Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35969 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752767AbcKGJWl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2016 04:22:41 -0500
From: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        tom_tsai@fintek.com.tw, peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH 2/2] PCI: Add quirk for Fintek F81504/508/512 D3 issue
Date: Mon,  7 Nov 2016 17:22:32 +0800
Message-Id: <1478510552-4883-3-git-send-email-hpeter+linux_kernel@gmail.com>
In-Reply-To: <1478510552-4883-1-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1478510552-4883-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Fintek F81504/508/512 PCIe-to-UART/GPIO will failed to work on Intel
Skylake platform PEG PCIe port after D0->D3->D0.

This patch will prevent it into D3 mode.

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
 drivers/pci/quirks.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 182712e..ee9402f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4497,3 +4497,18 @@ static void quirk_aer_report(struct pci_dev *pdev)
 			quirk_aer_report);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_FINTEK, PCI_DEVICE_ID_F81512,
 			quirk_aer_report);
+
+/*
+ * Fintek F81504/508/512 PCIe-to-UART/GPIO will failed to work on Intel Skylake
+ * platform PEG PCIe port after D0->D3->D0.
+ */
+static void quirk_no_d3(struct pci_dev *pdev)
+{
+	pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_FINTEK, PCI_DEVICE_ID_F81504,
+			quirk_no_d3);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_FINTEK, PCI_DEVICE_ID_F81508,
+			quirk_no_d3);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_FINTEK, PCI_DEVICE_ID_F81512,
+			quirk_no_d3);
-- 
1.9.1

