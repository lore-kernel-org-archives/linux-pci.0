Return-Path: <SRS0=Nkm2=NM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9A0C6786F
	for <linux-pci@archiver.kernel.org>; Thu,  1 Nov 2018 19:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B3120820
	for <linux-pci@archiver.kernel.org>; Thu,  1 Nov 2018 19:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85B3120820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=esd.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbeKBEnr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 2 Nov 2018 00:43:47 -0400
Received: from mxpout02.htp-tel.de ([212.59.41.9]:64652 "EHLO
        mxpout02.htp-tel.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbeKBEnq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Nov 2018 00:43:46 -0400
Received: from mxpin01.htp-tel.de (a212594129.net-htp.de [212.59.41.29])
        by mxpout02.htp-tel.de with ESMTPS id wA1JMtmn021199
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Nov 2018 20:22:55 +0100 (CET)
Received: from esd-s3.esd.local (a81-14-233-218.net-htp.de [81.14.233.218])
        by mxpin01.htp-tel.de with ESMTPS id wA1JMsVO002900
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 1 Nov 2018 20:22:54 +0100 (CET)
Received: from esd-s9.esd.local (10.0.0.190) by esd-s3.esd.local (10.0.0.66)
 with Microsoft SMTP Server id 8.2.176.0; Thu, 1 Nov 2018 20:22:00 +0100
Received: by esd-s9.esd.local (Postfix, from userid 2044)       id 2F6061400CA; Thu,
  1 Nov 2018 20:22:54 +0100 (CET)
From:   =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC:     =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
Subject: [PATCH 1/1] PCI/ASPM: Add a fix for an erratum of the PI7C9X111SLB PCI-to-PCIe bridge
Date:   Thu, 1 Nov 2018 20:22:29 +0100
Message-ID: <20181101192229.48352-2-stefan.maetje@esd.eu>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181101192229.48352-1-stefan.maetje@esd.eu>
References: <20181101192229.48352-1-stefan.maetje@esd.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.4.3 (mxpin01.htp-tel.de [172.19.12.4]); Thu, 01 Nov 2018 20:22:55 +0100 (CET)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Due to an erratum in the Pericom PI7C9X111SLB bridge in reverse mode the
retrain link bit needs to be cleared again manually to allow the link
training to succeed.

If it is not cleared manually the link training is continuously restarted
and all devices below the PCI-to-PCIe bridge can't be accessed any more.
That means drivers for devices below the bridge will be loaded but won't
work or even crash because the driver is only reading 0xffff.

See also the Pericom Errata Sheet PI7C9X111SLB_errata_rev1.2_102711.pdf.

Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
---
 drivers/pci/pcie/aspm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 5326916715d2..89a245023aa9 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -268,6 +268,15 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
 	/* Retrain link */
 	reg16 |= PCI_EXP_LNKCTL_RL;
 	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
+	if (0x12d8 == parent->vendor && 0xe111 == parent->device) {
+		/*
+		 * Due to an erratum in the Pericom PI7C9X111SLB bridge in
+		 * reverse mode the retrain link bit needs to be cleared
+		 * again manually to allow the link training to succeed.
+		 */
+		reg16 &= ~PCI_EXP_LNKCTL_RL;
+		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
+	}
 
 	/* Wait for link training end. Break out after waiting for timeout */
 	start_jiffies = jiffies;
-- 
2.15.0

