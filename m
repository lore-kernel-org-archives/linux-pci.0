Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:35183 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077AbbJEKxi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Oct 2015 06:53:38 -0400
Received: by qgt47 with SMTP id 47so145544745qgt.2
        for <linux-pci@vger.kernel.org>; Mon, 05 Oct 2015 03:53:37 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: bhelgaas@google.com
Cc: m-karicheri2@ti.com, linux-pci@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [RFC v2] PCI: keystone: Fix definition of LTSSM_STATE_MASK
Date: Mon,  5 Oct 2015 07:53:09 -0300
Message-Id: <1444042389-8036-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Fabio Estevam <fabio.estevam@freescale.com>

Designware PCI block uses 0x3f for the LTSSM_STATE_MASK.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Fix Subject

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

