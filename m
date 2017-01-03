Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35481 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934544AbdACGeo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jan 2017 01:34:44 -0500
Received: by mail-pf0-f181.google.com with SMTP id i88so75343340pfk.2
        for <linux-pci@vger.kernel.org>; Mon, 02 Jan 2017 22:34:44 -0800 (PST)
From: Rajat Jain <rajatja@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>,
        Andreas Ziegler <andreas.ziegler@fau.de>,
        Jonathan Yong <jonathan.yong@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        David Daney <david.daney@cavium.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Ram Amrani <Ram.Amrani@cavium.com>,
        Doug Ledford <dledford@redhat.com>,
        Wang Sheng-Hui <shhuiw@foxmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Rajat Jain <rajatja@google.com>, Rajat Jain <rajatxjain@gmail.com>,
        Brian Norris <briannorris@google.com>
Subject: [PATCH 4/6] PCI/ASPM: Calculate and save the L1.2 timing parameters
Date: Mon,  2 Jan 2017 22:34:13 -0800
Message-Id: <1483425255-101923-5-git-send-email-rajatja@google.com>
In-Reply-To: <1483425255-101923-1-git-send-email-rajatja@google.com>
References: <1483425255-101923-1-git-send-email-rajatja@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Calculate and save the timing parameters that need to be programmed
if we need to enable L1.2 substates later.

We use the same logic (and a constant value for 1 of the
parameters) as used by Intel's coreboot:

https://www.coreboot.org/pipermail/coreboot-gerrit/2015-March/021134.html
https://review.coreboot.org/#/c/8832/

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/pci/pcie/aspm.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 7a3ad85..a70afdf 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -42,6 +42,18 @@
 #define ASPM_STATE_ALL		(ASPM_STATE_L0S | ASPM_STATE_L1 |	\
 				 ASPM_STATE_L1SS)
 
+/*
+ * When L1 substates are enabled, the LTR L1.2 threshold is a timing parameter
+ * that decides whether L1.1 or L1.2 is entered (Refer PCIe spec for details).
+ * Not sure is there is a way to "calculate" this on the fly, but may be we
+ * could turn it into a parameter in future. This value has been taken from
+ * the following files from Intel's coreboot (which is the only code I found
+ * to have used this):
+ * https://www.coreboot.org/pipermail/coreboot-gerrit/2015-March/021134.html
+ * https://review.coreboot.org/#/c/8832/
+ */
+#define LTR_L1_2_THRESHOLD_BITS	((1 << 21) | (1 << 23) | (1 << 30))
+
 struct aspm_latency {
 	u32 l0s;			/* L0s latency (nsec) */
 	u32 l1;				/* L1 latency (nsec) */
@@ -76,6 +88,14 @@ struct pcie_link_state {
 	 * has one slot under it, so at most there are 8 functions.
 	 */
 	struct aspm_latency acceptable[8];
+
+	/* L1 PM Substate info */
+	struct {
+		u32 up_cap_ptr;		/* L1SS cap ptr in upstream dev */
+		u32 dw_cap_ptr;		/* L1SS cap ptr in downstream dev */
+		u32 ctl1;		/* value to be programmed in ctl1 */
+		u32 ctl2;		/* value to be programmed in ctl2 */
+	} l1ss;
 };
 
 static int aspm_disabled, aspm_force;
@@ -296,6 +316,22 @@ static u32 calc_l1_acceptable(u32 encoding)
 	return (1000 << encoding);
 }
 
+/* Convert L1SS T_pwr encoding to usec */
+static u32 calc_l1ss_pwron(struct pci_dev *pdev, u32 scale, u32 val)
+{
+	switch (scale) {
+	case 0:
+		return val * 2;
+	case 1:
+		return val * 10;
+	case 2:
+		return val * 100;
+	}
+	dev_err(&pdev->dev, "%s: Invalid T_PwrOn scale: %u\n",
+		__func__, scale);
+	return 0;
+}
+
 struct aspm_register_info {
 	u32 support:2;
 	u32 enabled:2;
@@ -392,6 +428,46 @@ static inline struct pci_dev *pci_function_0(struct pci_bus *linkbus)
 	return NULL;
 }
 
+/* Calculate L1.2 PM substate timing parameters */
+static void aspm_calc_l1ss_info(struct pcie_link_state *link,
+				struct aspm_register_info *upreg,
+				struct aspm_register_info *dwreg)
+{
+	u32 val1, val2, scale1, scale2;
+
+	link->l1ss.up_cap_ptr = upreg->l1ss_cap_ptr;
+	link->l1ss.dw_cap_ptr = dwreg->l1ss_cap_ptr;
+	link->l1ss.ctl1 = link->l1ss.ctl2 = 0;
+
+	if (!(link->aspm_support & ASPM_STATE_L1_2_MASK))
+		return;
+
+	/* Choose the greater of the two T_cmn_mode_rstr_time */
+	val1 = (upreg->l1ss_cap >> 8) & 0xFF;
+	val2 = (upreg->l1ss_cap >> 8) & 0xFF;
+	if (val1 > val2)
+		link->l1ss.ctl1 |= val1 << 8;
+	else
+		link->l1ss.ctl1 |= val2 << 8;
+	/*
+	 * We currently use LTR L1.2 threshold to be fixed constant picked from
+	 * Intel's coreboot.
+	 */
+	link->l1ss.ctl1 |= LTR_L1_2_THRESHOLD_BITS;
+
+	/* Choose the greater of the two T_pwr_on */
+	val1 = (upreg->l1ss_cap >> 19) & 0x1F;
+	scale1 = (upreg->l1ss_cap >> 16) & 0x03;
+	val2 = (dwreg->l1ss_cap >> 19) & 0x1F;
+	scale2 = (dwreg->l1ss_cap >> 16) & 0x03;
+
+	if (calc_l1ss_pwron(link->pdev, scale1, val1) >
+	    calc_l1ss_pwron(link->downstream, scale2, val2))
+		link->l1ss.ctl2 |= scale1 | (val1 << 3);
+	else
+		link->l1ss.ctl2 |= scale2 | (val2 << 3);
+}
+
 static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 {
 	struct pci_dev *child, *parent = link->pdev;
@@ -471,6 +547,9 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	if (upreg.l1ss_ctl1 & dwreg.l1ss_ctl1 & PCI_L1SS_CTL1_PCIPM_L1_2)
 		link->aspm_enabled |= ASPM_STATE_L1_2_PCIPM;
 
+	if (link->aspm_support & ASPM_STATE_L1SS)
+		aspm_calc_l1ss_info(link, &upreg, &dwreg);
+
 	/* Save default state */
 	link->aspm_default = link->aspm_enabled;
 
-- 
2.8.0.rc3.226.g39d4020

