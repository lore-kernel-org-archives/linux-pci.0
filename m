Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:45683 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752902AbdBQA1Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2017 19:27:25 -0500
From: Yadi Hu <yadi.hu@windriver.com>
To: <yadi.hu@windriver.com>, <lftan@altera.com>
CC: <linux-pci@vger.kernel.org>, <rfi@lists.rocketboards.org>
Subject: [PATCH] PCI: altera: Fix TLP completion status
Date: Fri, 17 Feb 2017 08:27:10 +0800
Message-ID: <1487291230-21495-2-git-send-email-yadi.hu@windriver.com>
In-Reply-To: <1487291230-21495-1-git-send-email-yadi.hu@windriver.com>
References: <1487291230-21495-1-git-send-email-yadi.hu@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "Hu Yadi" <yadi.hu@windriver.com>

the driver does not use exactly 'Completion Status' value in TLP,
these bits should be b15:13 not b14:12.

Signed-off-by: Hu Yadi<yadi.hu@windriver.com>
---
 drivers/pci/host/pcie-altera.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index dbac6fb..650862e 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -56,7 +56,7 @@
 #define TLP_CFG_DW2(bus, devfn, offset)	\
 				(((bus) << 24) | ((devfn) << 16) | (offset))
 #define TLP_REQ_ID(bus, devfn)		(((bus) << 8) | (devfn))
-#define TLP_COMP_STATUS(s)		(((s) >> 12) & 7)
+#define TLP_COMP_STATUS(s)		(((s) >> 13) & 7)
 #define TLP_HDR_SIZE			3
 #define TLP_LOOP			500
 #define RP_DEVFN			0
-- 
2.9.3
