Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:51272 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753835Ab3H0TA2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 Aug 2013 15:00:28 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa1so5230715pad.33
        for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2013 12:00:27 -0700 (PDT)
Subject: [PATCH 1/5] PCI: Rename PCIe capability definitions to follow
 convention
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lee Jones <lee.jones@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>
Date: Tue, 27 Aug 2013 13:00:25 -0600
Message-ID: <20130827190025.16595.84911.stgit@bhelgaas-glaptop>
In-Reply-To: <20130827185731.16595.52864.stgit@bhelgaas-glaptop>
References: <20130827185731.16595.52864.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

All other PCIe capability register fields include "PCI_EXP" + <reg-name> +
<field-name>.  This renames PCI_EXP_OBFF_MASK, PCI_EXP_IDO_REQ_EN,
PCI_EXP_LTR_EN, and related fields using the same convention.
No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/mfd/rts5227.c         |    2 +-
 drivers/pci/pci.c             |   31 +++++++++++++++++--------------
 include/uapi/linux/pci_regs.h |   24 ++++++++++++------------
 3 files changed, 30 insertions(+), 27 deletions(-)

diff --git a/drivers/mfd/rts5227.c b/drivers/mfd/rts5227.c
index fc831dc..164b7fa 100644
--- a/drivers/mfd/rts5227.c
+++ b/drivers/mfd/rts5227.c
@@ -44,7 +44,7 @@ static int rts5227_extra_init_hw(struct rtsx_pcr *pcr)
 	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, OLT_LED_CTL, 0x0F, 0x02);
 	/* Configure LTR */
 	pcie_capability_read_word(pcr->pci, PCI_EXP_DEVCTL2, &cap);
-	if (cap & PCI_EXP_LTR_EN)
+	if (cap & PCI_EXP_DEVCTL2_LTR_EN)
 		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, LTR_CTL, 0xFF, 0xA3);
 	/* Configure OBFF */
 	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, OBFF_CFG, 0x03, 0x03);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 42e5f86..3d5d45c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2095,9 +2095,9 @@ void pci_enable_ido(struct pci_dev *dev, unsigned long type)
 	u16 ctrl = 0;
 
 	if (type & PCI_EXP_IDO_REQUEST)
-		ctrl |= PCI_EXP_IDO_REQ_EN;
+		ctrl |= PCI_EXP_DEVCTL2_IDO_REQ_EN;
 	if (type & PCI_EXP_IDO_COMPLETION)
-		ctrl |= PCI_EXP_IDO_CMP_EN;
+		ctrl |= PCI_EXP_DEVCTL2_IDO_CMP_EN;
 	if (ctrl)
 		pcie_capability_set_word(dev, PCI_EXP_DEVCTL2, ctrl);
 }
@@ -2113,9 +2113,9 @@ void pci_disable_ido(struct pci_dev *dev, unsigned long type)
 	u16 ctrl = 0;
 
 	if (type & PCI_EXP_IDO_REQUEST)
-		ctrl |= PCI_EXP_IDO_REQ_EN;
+		ctrl |= PCI_EXP_DEVCTL2_IDO_REQ_EN;
 	if (type & PCI_EXP_IDO_COMPLETION)
-		ctrl |= PCI_EXP_IDO_CMP_EN;
+		ctrl |= PCI_EXP_DEVCTL2_IDO_CMP_EN;
 	if (ctrl)
 		pcie_capability_clear_word(dev, PCI_EXP_DEVCTL2, ctrl);
 }
@@ -2147,7 +2147,7 @@ int pci_enable_obff(struct pci_dev *dev, enum pci_obff_signal_type type)
 	int ret;
 
 	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
-	if (!(cap & PCI_EXP_OBFF_MASK))
+	if (!(cap & PCI_EXP_DEVCAP2_OBFF_MASK))
 		return -ENOTSUPP; /* no OBFF support at all */
 
 	/* Make sure the topology supports OBFF as well */
@@ -2158,17 +2158,17 @@ int pci_enable_obff(struct pci_dev *dev, enum pci_obff_signal_type type)
 	}
 
 	pcie_capability_read_word(dev, PCI_EXP_DEVCTL2, &ctrl);
-	if (cap & PCI_EXP_OBFF_WAKE)
-		ctrl |= PCI_EXP_OBFF_WAKE_EN;
+	if (cap & PCI_EXP_DEVCAP2_OBFF_WAKE)
+		ctrl |= PCI_EXP_DEVCTL2_OBFF_WAKE_EN;
 	else {
 		switch (type) {
 		case PCI_EXP_OBFF_SIGNAL_L0:
-			if (!(ctrl & PCI_EXP_OBFF_WAKE_EN))
-				ctrl |= PCI_EXP_OBFF_MSGA_EN;
+			if (!(ctrl & PCI_EXP_DEVCTL2_OBFF_WAKE_EN))
+				ctrl |= PCI_EXP_DEVCTL2_OBFF_MSGA_EN;
 			break;
 		case PCI_EXP_OBFF_SIGNAL_ALWAYS:
-			ctrl &= ~PCI_EXP_OBFF_WAKE_EN;
-			ctrl |= PCI_EXP_OBFF_MSGB_EN;
+			ctrl &= ~PCI_EXP_DEVCTL2_OBFF_WAKE_EN;
+			ctrl |= PCI_EXP_DEVCTL2_OBFF_MSGB_EN;
 			break;
 		default:
 			WARN(1, "bad OBFF signal type\n");
@@ -2189,7 +2189,8 @@ EXPORT_SYMBOL(pci_enable_obff);
  */
 void pci_disable_obff(struct pci_dev *dev)
 {
-	pcie_capability_clear_word(dev, PCI_EXP_DEVCTL2, PCI_EXP_OBFF_WAKE_EN);
+	pcie_capability_clear_word(dev, PCI_EXP_DEVCTL2,
+				   PCI_EXP_DEVCTL2_OBFF_WAKE_EN);
 }
 EXPORT_SYMBOL(pci_disable_obff);
 
@@ -2237,7 +2238,8 @@ int pci_enable_ltr(struct pci_dev *dev)
 			return ret;
 	}
 
-	return pcie_capability_set_word(dev, PCI_EXP_DEVCTL2, PCI_EXP_LTR_EN);
+	return pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
+					PCI_EXP_DEVCTL2_LTR_EN);
 }
 EXPORT_SYMBOL(pci_enable_ltr);
 
@@ -2254,7 +2256,8 @@ void pci_disable_ltr(struct pci_dev *dev)
 	if (!pci_ltr_supported(dev))
 		return;
 
-	pcie_capability_clear_word(dev, PCI_EXP_DEVCTL2, PCI_EXP_LTR_EN);
+	pcie_capability_clear_word(dev, PCI_EXP_DEVCTL2,
+				   PCI_EXP_DEVCTL2_LTR_EN);
 }
 EXPORT_SYMBOL(pci_disable_ltr);
 
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index c3cc01d..4b8f2e3 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -550,19 +550,19 @@
  * to use these fields safely.
  */
 #define PCI_EXP_DEVCAP2		36	/* Device Capabilities 2 */
-#define  PCI_EXP_DEVCAP2_ARI	0x20	/* Alternative Routing-ID */
-#define  PCI_EXP_DEVCAP2_LTR	0x800	/* Latency tolerance reporting */
-#define  PCI_EXP_OBFF_MASK	0xc0000 /* OBFF support mechanism */
-#define  PCI_EXP_OBFF_MSG	0x40000 /* New message signaling */
-#define  PCI_EXP_OBFF_WAKE	0x80000 /* Re-use WAKE# for OBFF */
+#define  PCI_EXP_DEVCAP2_ARI		0x20	/* Alternative Routing-ID */
+#define  PCI_EXP_DEVCAP2_LTR		0x800	/* Latency tolerance reporting */
+#define  PCI_EXP_DEVCAP2_OBFF_MASK	0xc0000 /* OBFF support mechanism */
+#define  PCI_EXP_DEVCAP2_OBFF_MSG	0x40000 /* New message signaling */
+#define  PCI_EXP_DEVCAP2_OBFF_WAKE	0x80000 /* Re-use WAKE# for OBFF */
 #define PCI_EXP_DEVCTL2		40	/* Device Control 2 */
-#define  PCI_EXP_DEVCTL2_ARI	0x20	/* Alternative Routing-ID */
-#define  PCI_EXP_IDO_REQ_EN	0x100	/* ID-based ordering request enable */
-#define  PCI_EXP_IDO_CMP_EN	0x200	/* ID-based ordering completion enable */
-#define  PCI_EXP_LTR_EN		0x400	/* Latency tolerance reporting */
-#define  PCI_EXP_OBFF_MSGA_EN	0x2000	/* OBFF enable with Message type A */
-#define  PCI_EXP_OBFF_MSGB_EN	0x4000	/* OBFF enable with Message type B */
-#define  PCI_EXP_OBFF_WAKE_EN	0x6000	/* OBFF using WAKE# signaling */
+#define  PCI_EXP_DEVCTL2_ARI		0x20	/* Alternative Routing-ID */
+#define  PCI_EXP_DEVCTL2_IDO_REQ_EN	0x100	/* ID-based ordering request enable */
+#define  PCI_EXP_DEVCTL2_IDO_CMP_EN	0x200	/* ID-based ordering completion enable */
+#define  PCI_EXP_DEVCTL2_LTR_EN		0x400	/* Latency tolerance reporting */
+#define  PCI_EXP_DEVCTL2_OBFF_MSGA_EN	0x2000	/* OBFF enable with Message type A */
+#define  PCI_EXP_DEVCTL2_OBFF_MSGB_EN	0x4000	/* OBFF enable with Message type B */
+#define  PCI_EXP_DEVCTL2_OBFF_WAKE_EN	0x6000	/* OBFF using WAKE# signaling */
 #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	44	/* v2 endpoints end here */
 #define PCI_EXP_LNKCAP2		44	/* Link Capability 2 */
 #define  PCI_EXP_LNKCAP2_SLS_2_5GB 0x02	/* Supported Link Speed 2.5GT/s */

