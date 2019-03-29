Return-Path: <SRS0=8ruR=SA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B36C43381
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 17:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9692184D
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 17:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbfC2RIx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 29 Mar 2019 13:08:53 -0400
Received: from mxpout01.htp-tel.de ([212.59.41.8]:41533 "EHLO
        mxpout01.htp-tel.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729746AbfC2RIx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Mar 2019 13:08:53 -0400
Received: from mxpin02.htp-tel.de (a212594129.net-htp.de [212.59.41.29])
        by mxpout01.htp-tel.de with ESMTPS id x2TH8MkU015922
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 18:08:22 +0100 (CET)
Received: from esd-s3.esd.local (a81-14-233-218.net-htp.de [81.14.233.218])
        by mxpin02.htp-tel.de with ESMTPS id x2TH8MMI004339
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Fri, 29 Mar 2019 18:08:22 +0100 (CET)
Received: from esd-s9.esd.local (10.0.0.190) by esd-s3.esd.local (10.0.0.66)
 with Microsoft SMTP Server id 8.2.176.0; Fri, 29 Mar 2019 18:08:20 +0100
Received: by esd-s9.esd.local (Postfix, from userid 2044)       id E97231400CD; Fri,
 29 Mar 2019 18:08:21 +0100 (CET)
From:   =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To:     <bhelgaas@google.com>, <andriy.shevchenko@linux.intel.com>,
        <bhull@redhat.com>, <linux-pci@vger.kernel.org>
CC:     <rafael.j.wysocki@intel.com>, <ptalbert@redhat.com>,
        <lukas@wunner.de>, <fred@fredlawl.com>,
        =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
Subject: [PATCH v3 2/3] PCI/ASPM: Work around link retrain errata of Pericom PCIe-to-PCI bridges
Date:   Fri, 29 Mar 2019 18:07:35 +0100
Message-ID: <20190329170736.1648-3-stefan.maetje@esd.eu>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190329170736.1648-1-stefan.maetje@esd.eu>
References: <20190329170736.1648-1-stefan.maetje@esd.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.4.3 (mxpin02.htp-tel.de [172.19.12.5]); Fri, 29 Mar 2019 18:08:22 +0100 (CET)
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

The patch introduces a new flag clear_retrain_link in the struct pci_dev.
This flag is set in quirk_enable_clear_retrain_link() for the affected
devices in the pci_fixup_header in quirks.c

In preparation to this patch the link retraining code was moved to
pcie_retrain_link(). This function now applies the work around to clear the
PCI_EXP_LNKCTL_RL bit again if clear_retrain_link bit is set in the pci_dev
structure of the link parent device.

Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
---
 drivers/pci/pcie/aspm.c | 10 ++++++++++
 drivers/pci/quirks.c    | 20 ++++++++++++++++++++
 include/linux/pci.h     |  2 ++
 3 files changed, 32 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index bb203f1e095d..53c34f50f419 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -205,6 +205,16 @@ static bool pcie_retrain_link(struct pcie_link_state *link)
 	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
 	reg16 |= PCI_EXP_LNKCTL_RL;
 	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
+	if (parent->clear_retrain_link) {
+		/*
+		 * Due to an erratum in some devices the retrain link bit
+		 * needs to be cleared again manually to allow the link
+		 * training to succeed.
+		 */
+		reg16 &= ~PCI_EXP_LNKCTL_RL;
+		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
+		pci_info(parent, "Apply PCIe clear link retrain bit workaround\n");
+	}
 
 	/* Wait for link training end. Break out after waiting for timeout */
 	start_jiffies = jiffies;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index a59ad09ce911..5bf490771ed5 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2245,6 +2245,26 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x10f1, quirk_disable_aspm_l0s);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x10f4, quirk_disable_aspm_l0s);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1508, quirk_disable_aspm_l0s);
 
+#ifdef CONFIG_PCIEASPM
+/*
+ * Some Pericom PCIe-to-PCI bridges in reverse mode expose the erratum that
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
+	pci_info(dev, "Enable PCIe link retrain quirk\n");
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
index 77448215ef5b..21424d91ed38 100644
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

