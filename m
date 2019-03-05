Return-Path: <SRS0=Jbu+=RI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB0DC43381
	for <linux-pci@archiver.kernel.org>; Tue,  5 Mar 2019 17:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D53420661
	for <linux-pci@archiver.kernel.org>; Tue,  5 Mar 2019 17:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfCERdj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 5 Mar 2019 12:33:39 -0500
Received: from mxpout02.htp-tel.de ([212.59.41.9]:46837 "EHLO
        mxpout02.htp-tel.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfCERdj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Mar 2019 12:33:39 -0500
Received: from mxpin02.htp-tel.de (a212594129.net-htp.de [212.59.41.29])
        by mxpout02.htp-tel.de with ESMTPS id x25HXIWJ027019
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Mar 2019 18:33:19 +0100 (CET)
Received: from esd-s3.esd.local (a81-14-233-218.net-htp.de [81.14.233.218])
        by mxpin02.htp-tel.de with ESMTPS id x25HXHta000858
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 5 Mar 2019 18:33:18 +0100 (CET)
Received: from esd-s9.esd.local (10.0.0.190) by esd-s3.esd.local (10.0.0.66)
 with Microsoft SMTP Server id 8.2.176.0; Tue, 5 Mar 2019 18:33:14 +0100
Received: by esd-s9.esd.local (Postfix, from userid 2044)       id 7DD781400CB; Tue,
  5 Mar 2019 18:33:17 +0100 (CET)
From:   =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To:     <bhelgaas@google.com>, <rafael.j.wysocki@intel.com>,
        <ptalbert@redhat.com>, <lukas@wunner.de>, <fred@fredlawl.com>,
        <andriy.shevchenko@linux.intel.com>, <bhull@redhat.com>,
        <linux-pci@vger.kernel.org>
CC:     =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
Subject: [PATCH V2 1/1] PCI/ASPM: Work around link retrain errata of Pericom PCIe-to-PCI bridges
Date:   Tue, 5 Mar 2019 18:31:22 +0100
Message-ID: <20190305173122.11875-2-stefan.maetje@esd.eu>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190305173122.11875-1-stefan.maetje@esd.eu>
References: <20190305173122.11875-1-stefan.maetje@esd.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.4.3 (mxpin02.htp-tel.de [172.19.12.5]); Tue, 05 Mar 2019 18:33:18 +0100 (CET)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Due to an erratum in some Pericom PCIe-to-PCI bridges in reverse mode the
retrain link bit needs to be cleared again manually to allow the link
training to complete successfully.

If it is not cleared manually the link training is continuously restarted
and all devices below the PCI-to-PCIe bridge can't be accessed any more.
That means drivers for devices below the bridge will be loaded but won't
work or even crash because the driver is only reading 0xffff.

See the Pericom Errata Sheet PI7C9X111SLB_errata_rev1.2_102711.pdf for
details.

Devices known as affected so far are: PI7C9X110, PI7C9X111SL, PI7C9X130

The patch introduces a new flag clear_retrain_link in the struct pci_dev. This
flag is set in quirk_enable_clear_retrain_link() for the affected devices in
the pci_fixup_header in quirks.c

The link retraining code is moved to pcie_retrain_link(). This function now
applies the work around to clear the PCI_EXP_LNKCTL_RL bit again if
clear_retrain_link bit is set in the pci_dev structure of the link parent
device.

Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
---
 drivers/pci/pcie/aspm.c | 49 ++++++++++++++++++++++++++++++++++---------------
 drivers/pci/quirks.c    | 20 ++++++++++++++++++++
 include/linux/pci.h     |  2 ++
 3 files changed, 56 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 727e3c1ef9a4..3cfd8d59bd2a 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -196,6 +196,39 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
 	link->clkpm_capable = (blacklist) ? 0 : capable;
 }

+static bool pcie_retrain_link(struct pcie_link_state *link)
+{
+	struct pci_dev *parent = link->pdev;
+	unsigned long start_jiffies;
+	u16 reg16;
+
+	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
+	reg16 |= PCI_EXP_LNKCTL_RL;
+	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
+	if (parent->clear_retrain_link) {
+		/*
+		 * Due to an erratum in some devices the retrain link bit
+		 * needs to be cleared again manually to allow the link
+		 * training to succeed.
+		 */
+		reg16 &= ~PCI_EXP_LNKCTL_RL;
+		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
+		pci_info(parent, "Apply clear link retrain bit workaround\n");
+	}
+
+	/* Wait for link training end. Break out after waiting for timeout */
+	start_jiffies = jiffies;
+	for (;;) {
+		pcie_capability_read_word(parent, PCI_EXP_LNKSTA, &reg16);
+		if (!(reg16 & PCI_EXP_LNKSTA_LT))
+			break;
+		if (time_after(jiffies, start_jiffies + LINK_RETRAIN_TIMEOUT))
+			break;
+		msleep(1);
+	}
+	return !(reg16 & PCI_EXP_LNKSTA_LT);
+}
+
 /*
  * pcie_aspm_configure_common_clock: check if the 2 ends of a link
  *   could use common clock. If they are, configure them to use the
@@ -205,7 +238,6 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
 {
 	int same_clock = 1;
 	u16 reg16, parent_reg, child_reg[8];
-	unsigned long start_jiffies;
 	struct pci_dev *child, *parent = link->pdev;
 	struct pci_bus *linkbus = parent->subordinate;
 	/*
@@ -264,20 +296,7 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
 	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);

 	/* Retrain link */
-	reg16 |= PCI_EXP_LNKCTL_RL;
-	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
-
-	/* Wait for link training end. Break out after waiting for timeout */
-	start_jiffies = jiffies;
-	for (;;) {
-		pcie_capability_read_word(parent, PCI_EXP_LNKSTA, &reg16);
-		if (!(reg16 & PCI_EXP_LNKSTA_LT))
-			break;
-		if (time_after(jiffies, start_jiffies + LINK_RETRAIN_TIMEOUT))
-			break;
-		msleep(1);
-	}
-	if (!(reg16 & PCI_EXP_LNKSTA_LT))
+	if (pcie_retrain_link(link))
 		return;

 	/* Training failed. Restore common clock configurations */
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b0a413f3f7ca..798ffbcd7922 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2244,6 +2244,26 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x10f1, quirk_disable_aspm_l0s);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x10f4, quirk_disable_aspm_l0s);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1508, quirk_disable_aspm_l0s);

+#ifdef CONFIG_PCIEASPM
+/*
+ * Some Pericom PCIe-to-PCI brigdes in reverse mode expose the erratum that
+ * they need the PCIe link retrain bit cleared after starting the link retrain
+ * process to allow this process to finish.
+ *
+ * Affected devices: PI7C9X110, PI7C9X111SL, PI7C9X130
+ *
+ * See also the Pericom Errata Sheet PI7C9X111SLB_errata_rev1.2_102711.pdf.
+ */
+static void quirk_enable_clear_retrain_link(struct pci_dev *dev)
+{
+	dev->clear_retrain_link = 1;
+	pci_info(dev, "Enable Pericom link retrain quirk\n");
+}
+DECLARE_PCI_FIXUP_HEADER(0x12d8, 0xe110, quirk_enable_clear_retrain_link);
+DECLARE_PCI_FIXUP_HEADER(0x12d8, 0xe111, quirk_enable_clear_retrain_link);
+DECLARE_PCI_FIXUP_HEADER(0x12d8, 0xe130, quirk_enable_clear_retrain_link);
+#endif /* CONFIG_PCIEASPM */
+
 static void fixup_rev1_53c810(struct pci_dev *dev)
 {
 	u32 class = dev->class;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 65f1d8c2f082..7de0d9c0c567 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -355,6 +355,8 @@ struct pci_dev {
 	struct pcie_link_state	*link_state;	/* ASPM link state */
 	unsigned int	ltr_path:1;	/* Latency Tolerance Reporting
 					   supported from root to here */
+	unsigned int	clear_retrain_link:1;	/* Need to clear link retrain
+						   bit to succeed retraining */
 #endif
 	unsigned int	eetlp_prefix_path:1;	/* End-to-End TLP Prefix */

--
2.15.0

