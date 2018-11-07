Return-Path: <SRS0=4zPb=NS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1782C0044C
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 07:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C54252081D
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 07:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C54252081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hxt-semitech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbeKGQyc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Nov 2018 11:54:32 -0500
Received: from mx01.hxt-semitech.com ([223.203.96.7]:41579 "EHLO
        barracuda.hxt-semitech.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728412AbeKGQyc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Nov 2018 11:54:32 -0500
X-ASG-Debug-ID: 1541575515-093b7e4bb117c50001-0c9NHn
Received: from HXTBJIDCEMVIW01.hxtcorp.net ([10.128.0.14]) by barracuda.hxt-semitech.com with ESMTP id Z4xFG4KDzuWTTTlg (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 07 Nov 2018 15:25:15 +0800 (CST)
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
Received: from y.localdomain (10.5.21.109) by HXTBJIDCEMVIW01.hxtcorp.net
 (10.128.0.14) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 7 Nov
 2018 15:24:42 +0800
From:   Shunyong Yang <shunyong.yang@hxt-semitech.com>
To:     <bhelgaas@google.com>
CC:     <okaya@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Shunyong Yang <shunyong.yang@hxt-semitech.com>,
        Joey Zheng <yu.zheng@hxt-semitech.com>
Subject: [PATCH v2 2/2] PCI: pciehp: Add HXT quirk for Command Completed errata
Date:   Wed, 7 Nov 2018 15:25:05 +0800
X-ASG-Orig-Subj: [PATCH v2 2/2] PCI: pciehp: Add HXT quirk for Command Completed errata
Message-ID: <5e88860c8426df537c5a5f2d0e6add6df8955a0f.1541574331.git.shunyong.yang@hxt-semitech.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <bcaf1d5d-23a6-d4e6-08e8-587daf6cca06@kernel.org>
References: <bcaf1d5d-23a6-d4e6-08e8-587daf6cca06@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.5.21.109]
X-ClientProxiedBy: HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) To
 HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14)
X-Barracuda-Connect: UNKNOWN[10.128.0.14]
X-Barracuda-Start-Time: 1541575515
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5088 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.61351
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The HXT SD4800 PCI controller does not set the Command Completed
bit unless writes to the Slot Command register change "Control"
bits.

This patch adds SD4800 to the quirk.

Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 7dd443aea5a5..91db67963aea 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -920,3 +920,5 @@ static void quirk_cmd_compl(struct pci_dev *pdev)
 			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_QCOM, 0x0401,
 			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_HXT, 0x0401,
+			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
-- 
1.8.3.1

