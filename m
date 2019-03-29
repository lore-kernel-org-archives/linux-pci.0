Return-Path: <SRS0=8ruR=SA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1CCC10F05
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 17:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34DCD218AC
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 17:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbfC2RIu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 29 Mar 2019 13:08:50 -0400
Received: from mxpout02.htp-tel.de ([212.59.41.9]:60983 "EHLO
        mxpout02.htp-tel.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729766AbfC2RIu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Mar 2019 13:08:50 -0400
Received: from mxpin02.htp-tel.de (a212594129.net-htp.de [212.59.41.29])
        by mxpout02.htp-tel.de with ESMTPS id x2TH8MGW004515
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 18:08:22 +0100 (CET)
Received: from esd-s3.esd.local (a81-14-233-218.net-htp.de [81.14.233.218])
        by mxpin02.htp-tel.de with ESMTPS id x2TH8MMJ004339
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Fri, 29 Mar 2019 18:08:22 +0100 (CET)
Received: from esd-s9.esd.local (10.0.0.190) by esd-s3.esd.local (10.0.0.66)
 with Microsoft SMTP Server id 8.2.176.0; Fri, 29 Mar 2019 18:08:20 +0100
Received: by esd-s9.esd.local (Postfix, from userid 2044)       id E689E1400CA; Fri,
 29 Mar 2019 18:08:21 +0100 (CET)
From:   =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To:     <bhelgaas@google.com>, <andriy.shevchenko@linux.intel.com>,
        <bhull@redhat.com>, <linux-pci@vger.kernel.org>
CC:     <rafael.j.wysocki@intel.com>, <ptalbert@redhat.com>,
        <lukas@wunner.de>, <fred@fredlawl.com>,
        =?UTF-8?q?Stefan=20M=C3=83=C2=A4tje?= <stefan.maetje@esd.eu>
Subject: [PATCH v3 1/3] PCI/ASPM: Prepare stand-alone pcie_retrain_link() function
Date:   Fri, 29 Mar 2019 18:07:34 +0100
Message-ID: <20190329170736.1648-2-stefan.maetje@esd.eu>
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

From: Stefan MÃ¤tje <stefan.maetje@esd.eu>

Prepare stand-alone pcie_retrain_link() function for the
Pericom retrain link quirk patch.

Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
---
 drivers/pci/pcie/aspm.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 727e3c1ef9a4..bb203f1e095d 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -196,6 +196,29 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
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
@@ -205,7 +228,6 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
 {
 	int same_clock = 1;
 	u16 reg16, parent_reg, child_reg[8];
-	unsigned long start_jiffies;
 	struct pci_dev *child, *parent = link->pdev;
 	struct pci_bus *linkbus = parent->subordinate;
 	/*
@@ -264,20 +286,7 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
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
--
2.15.0

