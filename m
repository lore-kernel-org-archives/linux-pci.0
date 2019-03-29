Return-Path: <SRS0=8ruR=SA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE26FC4360F
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 17:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E92A21871
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 17:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbfC2RIu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 29 Mar 2019 13:08:50 -0400
Received: from mxpout01.htp-tel.de ([212.59.41.8]:42298 "EHLO
        mxpout01.htp-tel.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729771AbfC2RIu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Mar 2019 13:08:50 -0400
Received: from mxpin02.htp-tel.de (a212594129.net-htp.de [212.59.41.29])
        by mxpout01.htp-tel.de with ESMTPS id x2TH8Moi015928
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 18:08:23 +0100 (CET)
Received: from esd-s3.esd.local (a81-14-233-218.net-htp.de [81.14.233.218])
        by mxpin02.htp-tel.de with ESMTPS id x2TH8MMK004339
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Fri, 29 Mar 2019 18:08:22 +0100 (CET)
Received: from esd-s9.esd.local (10.0.0.190) by esd-s3.esd.local (10.0.0.66)
 with Microsoft SMTP Server id 8.2.176.0; Fri, 29 Mar 2019 18:08:20 +0100
Received: by esd-s9.esd.local (Postfix, from userid 2044)       id 00D7E1400CE; Fri,
 29 Mar 2019 18:08:21 +0100 (CET)
From:   =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To:     <bhelgaas@google.com>, <andriy.shevchenko@linux.intel.com>,
        <bhull@redhat.com>, <linux-pci@vger.kernel.org>
CC:     <rafael.j.wysocki@intel.com>, <ptalbert@redhat.com>,
        <lukas@wunner.de>, <fred@fredlawl.com>,
        =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
Subject: [PATCH v3 3/3] PCI/ASPM: Trivial rework wait code in pcie_retrain_link()
Date:   Fri, 29 Mar 2019 18:07:36 +0100
Message-ID: <20190329170736.1648-4-stefan.maetje@esd.eu>
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

Transform wait code to a "do {} while (time_before())" loop as recommended
by reviewer.

Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
---
 drivers/pci/pcie/aspm.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 53c34f50f419..94e3499e4c1b 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -199,7 +199,7 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
 static bool pcie_retrain_link(struct pcie_link_state *link)
 {
 	struct pci_dev *parent = link->pdev;
-	unsigned long start_jiffies;
+	unsigned long end_jiffies;
 	u16 reg16;
 
 	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
@@ -217,15 +217,13 @@ static bool pcie_retrain_link(struct pcie_link_state *link)
 	}
 
 	/* Wait for link training end. Break out after waiting for timeout */
-	start_jiffies = jiffies;
-	for (;;) {
+	end_jiffies = jiffies + LINK_RETRAIN_TIMEOUT;
+	do {
 		pcie_capability_read_word(parent, PCI_EXP_LNKSTA, &reg16);
 		if (!(reg16 & PCI_EXP_LNKSTA_LT))
 			break;
-		if (time_after(jiffies, start_jiffies + LINK_RETRAIN_TIMEOUT))
-			break;
 		msleep(1);
-	}
+	} while (time_before(jiffies, end_jiffies));
 	return !(reg16 & PCI_EXP_LNKSTA_LT);
 }
 
-- 
2.15.0

