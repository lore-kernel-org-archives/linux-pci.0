Return-Path: <SRS0=Q3uD=3E=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD38FC33CB3
	for <linux-pci@archiver.kernel.org>; Wed, 15 Jan 2020 09:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819DA2081E
	for <linux-pci@archiver.kernel.org>; Wed, 15 Jan 2020 09:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbgAOJIX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 15 Jan 2020 04:08:23 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9614 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729021AbgAOJIW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jan 2020 04:08:22 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 580B716EF065CC26F2A4;
        Wed, 15 Jan 2020 17:08:19 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Wed, 15 Jan 2020 17:08:09 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     <f.fangjian@huawei.com>
Subject: [PATCH 1/6] PCI: add 32 GT/s decoding in some macros
Date:   Wed, 15 Jan 2020 17:04:18 +0800
Message-ID: <1579079063-5668-2-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1579079063-5668-1-git-send-email-yangyicong@hisilicon.com>
References: <1579079063-5668-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Link speed 32.0 GT/s is supported in PCIe r5.0. Add in macro
PCIE_SPEED2STR and PCIE_SPEED2MBS_ENC to correctly decode.
This patch is a complementary to
commit de76cda215d5 ("PCI: Decode PCIe 32 GT/s link speed").

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/pci/pci.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a0a53bd..a88c316 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -291,7 +291,8 @@ void pci_bus_put(struct pci_bus *bus);

 /* PCIe link information */
 #define PCIE_SPEED2STR(speed) \
-	((speed) == PCIE_SPEED_16_0GT ? "16 GT/s" : \
+	((speed) == PCIE_SPEED_32_0GT ? "32 GT/s" : \
+	 (speed) == PCIE_SPEED_16_0GT ? "16 GT/s" : \
 	 (speed) == PCIE_SPEED_8_0GT ? "8 GT/s" : \
 	 (speed) == PCIE_SPEED_5_0GT ? "5 GT/s" : \
 	 (speed) == PCIE_SPEED_2_5GT ? "2.5 GT/s" : \
@@ -299,7 +300,8 @@ void pci_bus_put(struct pci_bus *bus);

 /* PCIe speed to Mb/s reduced by encoding overhead */
 #define PCIE_SPEED2MBS_ENC(speed) \
-	((speed) == PCIE_SPEED_16_0GT ? 16000*128/130 : \
+	((speed) == PCIE_SPEED_32_0GT ? 32000*128/130 : \
+	 (speed) == PCIE_SPEED_16_0GT ? 16000*128/130 : \
 	 (speed) == PCIE_SPEED_8_0GT  ?  8000*128/130 : \
 	 (speed) == PCIE_SPEED_5_0GT  ?  5000*8/10 : \
 	 (speed) == PCIE_SPEED_2_5GT  ?  2500*8/10 : \
--
2.8.1

