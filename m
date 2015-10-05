Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:36575 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961AbbJEDVl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 4 Oct 2015 23:21:41 -0400
Received: by qkcf65 with SMTP id f65so64861164qkc.3
        for <linux-pci@vger.kernel.org>; Sun, 04 Oct 2015 20:21:40 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: bhelgaas@google.com
Cc: m-karicheri2@ti.com, linux-pci@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [RFC] PCI: spear: Fix definition of LTSSM_STATE_MASK
Date: Mon,  5 Oct 2015 00:21:15 -0300
Message-Id: <1444015275-5668-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Fabio Estevam <fabio.estevam@freescale.com>

Designware PCI block uses 0x3f for the LTSSM_STATE_MASK.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Murali,

I am doing some consolidation on the PCI DW drivers and I noticed that
keystone uses a different LTSSM_STATE_MASK definition.

Could you please double check it?

 drivers/pci/host/pci-keystone-dw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/host/pci-keystone-dw.c
index 3cf55cd..78320e4 100644
--- a/drivers/pci/host/pci-keystone-dw.c
+++ b/drivers/pci/host/pci-keystone-dw.c
@@ -25,7 +25,7 @@
 
 /* Application register defines */
 #define LTSSM_EN_VAL		        1
-#define LTSSM_STATE_MASK		0x1f
+#define LTSSM_STATE_MASK		0x3f
 #define LTSSM_STATE_L0			0x11
 #define DBI_CS2_EN_VAL			0x20
 #define OB_XLAT_EN_VAL		        2
-- 
1.9.1

