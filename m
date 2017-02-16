Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail5.windriver.com ([192.103.53.11]:55654 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751191AbdBPJyI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Feb 2017 04:54:08 -0500
To: Ley Foon Tan <lftan@altera.com>
CC: <linux-pci@vger.kernel.org>, <rfi@lists.rocketboards.org>
From: yhu2 <yadi.hu@windriver.com>
Subject: PCI: altera: Fix TLP completion status
Message-ID: <a6d0bf66-d970-965d-9aae-667ec5e17fbf@windriver.com>
Date: Thu, 16 Feb 2017 17:54:01 +0800
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="------------5F31F11CDFCB091A55BF94A7"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--------------5F31F11CDFCB091A55BF94A7
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit

PCI: altera: Fix TLP completion status

'Completion Status' value in TLP should be b15:13 while the fix is
using b14:12

Signed-off-by: Hu Yadi<yadi.hu@windriver.com>
---
  drivers/pci/host/pcie-altera.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)


--------------5F31F11CDFCB091A55BF94A7
Content-Type: text/x-patch;
	name="0001-PCI-altera-Fix-TLP-completion-status.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-PCI-altera-Fix-TLP-completion-status.patch"

>From 6c7563a2bb2d46d60a089d5d326bf14a2d868d78 Mon Sep 17 00:00:00 2001
From: "Hu Yadi" <yadi.hu@windriver.com>
Date: Thu, 16 Feb 2017 01:50:11 -0800
Subject: [PATCH] PCI: altera: Fix TLP completion status

'Completion Status' value in TLP should be b15:13 while the fix is
using b14:12

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


--------------5F31F11CDFCB091A55BF94A7--
