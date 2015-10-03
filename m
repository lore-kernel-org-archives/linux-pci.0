Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:33340 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbbJCVL7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 3 Oct 2015 17:11:59 -0400
Received: by qgev79 with SMTP id v79so121362914qge.0
        for <linux-pci@vger.kernel.org>; Sat, 03 Oct 2015 14:11:59 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: bhelgaas@google.com
Cc: pratyush.anand@gmail.com, l.stach@pengutronix.de,
	linux-pci@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 1/2] PCI: spear: Move LTSSM state definitions to pcie-designware.h
Date: Sat,  3 Oct 2015 18:11:30 -0300
Message-Id: <1443906691-14642-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Fabio Estevam <fabio.estevam@freescale.com>

Move LTSSM state definitions to common pcie-designware.h so that other
drivers can make use of them.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/pci/host/pcie-designware.h | 34 ++++++++++++++++++++++++++++++++++
 drivers/pci/host/pcie-spear13xx.c  | 33 ---------------------------------
 2 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index 35123d9..97d6558 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -22,6 +22,40 @@
 #define MAX_MSI_IRQS			32
 #define MAX_MSI_CTRLS			(MAX_MSI_IRQS / 32)
 
+#define LTSSM_STATE_DETECT_QUIET	0x00
+#define LTSSM_STATE_DETECT_ACT		0x01
+#define LTSSM_STATE_POLL_ACTIVE		0x02
+#define LTSSM_STATE_POLL_COMPLIANCE	0x03
+#define LTSSM_STATE_POLL_CONFIG		0x04
+#define LTSSM_STATE_PRE_DETECT_QUIET	0x05
+#define LTSSM_STATE_DETECT_WAIT		0x06
+#define LTSSM_STATE_CFG_LINKWD_START	0x07
+#define LTSSM_STATE_CFG_LINKWD_ACEPT	0x08
+#define LTSSM_STATE_CFG_LANENUM_WAIT	0x09
+#define LTSSM_STATE_CFG_LANENUM_ACEPT	0x0A
+#define LTSSM_STATE_CFG_COMPLETE	0x0B
+#define LTSSM_STATE_CFG_IDLE		0x0C
+#define LTSSM_STATE_RCVRY_LOCK		0x0D
+#define LTSSM_STATE_RCVRY_SPEED		0x0E
+#define LTSSM_STATE_RCVRY_RCVRCFG	0x0F
+#define LTSSM_STATE_RCVRY_IDLE		0x10
+#define LTSSM_STATE_L0			0x11
+#define LTSSM_STATE_L0S			0x12
+#define LTSSM_STATE_L123_SEND_EIDLE	0x13
+#define LTSSM_STATE_L1_IDLE		0x14
+#define LTSSM_STATE_L2_IDLE		0x15
+#define LTSSM_STATE_L2_WAKE		0x16
+#define LTSSM_STATE_DISABLED_ENTRY	0x17
+#define LTSSM_STATE_DISABLED_IDLE	0x18
+#define LTSSM_STATE_DISABLED		0x19
+#define LTSSM_STATE_LPBK_ENTRY		0x1A
+#define LTSSM_STATE_LPBK_ACTIVE		0x1B
+#define LTSSM_STATE_LPBK_EXIT		0x1C
+#define LTSSM_STATE_LPBK_EXIT_TIMEOUT	0x1D
+#define LTSSM_STATE_HOT_RESET_ENTRY	0x1E
+#define LTSSM_STATE_HOT_RESET		0x1F
+#define LTSSM_STATE_MASK		0x3F
+
 struct pcie_port {
 	struct device		*dev;
 	u8			root_bus_nr;
diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
index 98d2683..920d399 100644
--- a/drivers/pci/host/pcie-spear13xx.c
+++ b/drivers/pci/host/pcie-spear13xx.c
@@ -84,39 +84,6 @@ struct pcie_app_reg {
 #define APPS_PM_XMT_PME_ID			5
 
 /* CR3 ID */
-#define XMLH_LTSSM_STATE_DETECT_QUIET		0x00
-#define XMLH_LTSSM_STATE_DETECT_ACT		0x01
-#define XMLH_LTSSM_STATE_POLL_ACTIVE		0x02
-#define XMLH_LTSSM_STATE_POLL_COMPLIANCE	0x03
-#define XMLH_LTSSM_STATE_POLL_CONFIG		0x04
-#define XMLH_LTSSM_STATE_PRE_DETECT_QUIET	0x05
-#define XMLH_LTSSM_STATE_DETECT_WAIT		0x06
-#define XMLH_LTSSM_STATE_CFG_LINKWD_START	0x07
-#define XMLH_LTSSM_STATE_CFG_LINKWD_ACEPT	0x08
-#define XMLH_LTSSM_STATE_CFG_LANENUM_WAIT	0x09
-#define XMLH_LTSSM_STATE_CFG_LANENUM_ACEPT	0x0A
-#define XMLH_LTSSM_STATE_CFG_COMPLETE		0x0B
-#define XMLH_LTSSM_STATE_CFG_IDLE		0x0C
-#define XMLH_LTSSM_STATE_RCVRY_LOCK		0x0D
-#define XMLH_LTSSM_STATE_RCVRY_SPEED		0x0E
-#define XMLH_LTSSM_STATE_RCVRY_RCVRCFG		0x0F
-#define XMLH_LTSSM_STATE_RCVRY_IDLE		0x10
-#define XMLH_LTSSM_STATE_L0			0x11
-#define XMLH_LTSSM_STATE_L0S			0x12
-#define XMLH_LTSSM_STATE_L123_SEND_EIDLE	0x13
-#define XMLH_LTSSM_STATE_L1_IDLE		0x14
-#define XMLH_LTSSM_STATE_L2_IDLE		0x15
-#define XMLH_LTSSM_STATE_L2_WAKE		0x16
-#define XMLH_LTSSM_STATE_DISABLED_ENTRY		0x17
-#define XMLH_LTSSM_STATE_DISABLED_IDLE		0x18
-#define XMLH_LTSSM_STATE_DISABLED		0x19
-#define XMLH_LTSSM_STATE_LPBK_ENTRY		0x1A
-#define XMLH_LTSSM_STATE_LPBK_ACTIVE		0x1B
-#define XMLH_LTSSM_STATE_LPBK_EXIT		0x1C
-#define XMLH_LTSSM_STATE_LPBK_EXIT_TIMEOUT	0x1D
-#define XMLH_LTSSM_STATE_HOT_RESET_ENTRY	0x1E
-#define XMLH_LTSSM_STATE_HOT_RESET		0x1F
-#define XMLH_LTSSM_STATE_MASK			0x3F
 #define XMLH_LINK_UP				(1 << 6)
 
 /* CR4 ID */
-- 
1.9.1

