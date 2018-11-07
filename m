Return-Path: <SRS0=4zPb=NS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66522C0044C
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 07:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F352086B
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 07:25:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F352086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hxt-semitech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbeKGQyT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Nov 2018 11:54:19 -0500
Received: from mx01.hxt-semitech.com ([223.203.96.7]:41553 "EHLO
        barracuda.hxt-semitech.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726642AbeKGQyS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Nov 2018 11:54:18 -0500
X-ASG-Debug-ID: 1541575491-093b7e4bb117c20001-0c9NHn
Received: from HXTBJIDCEMVIW01.hxtcorp.net ([10.128.0.14]) by barracuda.hxt-semitech.com with ESMTP id aI9BYTm0sNHL8xVp (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 07 Nov 2018 15:24:53 +0800 (CST)
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
Received: from y.localdomain (10.5.21.109) by HXTBJIDCEMVIW01.hxtcorp.net
 (10.128.0.14) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 7 Nov
 2018 15:24:18 +0800
From:   Shunyong Yang <shunyong.yang@hxt-semitech.com>
To:     <bhelgaas@google.com>
CC:     <okaya@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Shunyong Yang <shunyong.yang@hxt-semitech.com>,
        Joey Zheng <yu.zheng@hxt-semitech.com>
Subject: [PATCH v2 1/2] PCI: Add HXT vendor ID and ACS quirk
Date:   Wed, 7 Nov 2018 15:24:12 +0800
X-ASG-Orig-Subj: [PATCH v2 1/2] PCI: Add HXT vendor ID and ACS quirk
Message-ID: <ccf67e5f70f2d09d07268a5735ac6cee801eb9ca.1541574331.git.shunyong.yang@hxt-semitech.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <bcaf1d5d-23a6-d4e6-08e8-587daf6cca06@kernel.org>
References: <bcaf1d5d-23a6-d4e6-08e8-587daf6cca06@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.5.21.109]
X-ClientProxiedBy: HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) To
 HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14)
X-Barracuda-Connect: UNKNOWN[10.128.0.14]
X-Barracuda-Start-Time: 1541575493
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 0.9527 1.0000 3.8023
X-Barracuda-Spam-Score: 3.80
X-Barracuda-Spam-Status: No, SCORE=3.80 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.61351
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the HXT vendor ID to pci_ids.h and use it in quirks. As the
design of HXT SD4800 ACS feature is the same as QCOM QDF2xxx,
pci_quirk_qcom_rp_acs() is reused for SD4800 quirk.

cc: Joey Zheng <yu.zheng@hxt-semitech.com>
Reviewed-by: Sinan Kaya <okaya@kernel.org>
Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>

---
v2:
  Add Reviewed-by: Sinan Kaya.

v1:
  Initial version.
---

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 4700d24e5d55..1e00ef6a88f4 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4495,6 +4495,8 @@ static int pci_quirk_mf_endpoint_acs(struct pci_dev *dev, u16 acs_flags)
 	/* QCOM QDF2xxx root ports */
 	{ PCI_VENDOR_ID_QCOM, 0x0400, pci_quirk_qcom_rp_acs },
 	{ PCI_VENDOR_ID_QCOM, 0x0401, pci_quirk_qcom_rp_acs },
+	/* HXT SD4800 root ports. The ACS design is same as QCOM QDF2xxx */
+	{ PCI_VENDOR_ID_HXT, 0x0401, pci_quirk_qcom_rp_acs },
 	/* Intel PCH root ports */
 	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_intel_pch_acs },
 	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_intel_spt_pch_acs },
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 69f0abe1ba1a..e60a6bc38298 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2565,6 +2565,8 @@
 
 #define PCI_VENDOR_ID_HYGON		0x1d94
 
+#define PCI_VENDOR_ID_HXT		0x1dbf
+
 #define PCI_VENDOR_ID_TEKRAM		0x1de1
 #define PCI_DEVICE_ID_TEKRAM_DC290	0xdc29
 
-- 
1.8.3.1

