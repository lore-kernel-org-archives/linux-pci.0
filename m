Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47523 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750767AbbJUSnQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 21 Oct 2015 14:43:16 -0400
Subject: [PATCH v4 4/4] PCI: spear: Remove unused #defines
To: Fabio Estevam <festevam@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>,
	linux-pci@vger.kernel.org, pratyush.anand@gmail.com,
	m-karicheri2@ti.com, l.stach@pengutronix.de
Date: Wed, 21 Oct 2015 13:43:12 -0500
Message-ID: <20151021184312.28724.75489.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20151021183741.28724.71281.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20151021183741.28724.71281.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Fabio Estevam <fabio.estevam@freescale.com>

Remove unused #defines.

[bhelgaas: split into separate patch]
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-spear13xx.c |   70 -------------------------------------
 1 file changed, 70 deletions(-)

diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
index 98d2683..10e33ad 100644
--- a/drivers/pci/host/pcie-spear13xx.c
+++ b/drivers/pci/host/pcie-spear13xx.c
@@ -58,87 +58,17 @@ struct pcie_app_reg {
 };
 
 /* CR0 ID */
-#define RX_LANE_FLIP_EN_ID			0
-#define TX_LANE_FLIP_EN_ID			1
-#define SYS_AUX_PWR_DET_ID			2
 #define APP_LTSSM_ENABLE_ID			3
-#define SYS_ATTEN_BUTTON_PRESSED_ID		4
-#define SYS_MRL_SENSOR_STATE_ID			5
-#define SYS_PWR_FAULT_DET_ID			6
-#define SYS_MRL_SENSOR_CHGED_ID			7
-#define SYS_PRE_DET_CHGED_ID			8
-#define SYS_CMD_CPLED_INT_ID			9
-#define APP_INIT_RST_0_ID			11
-#define APP_REQ_ENTR_L1_ID			12
-#define APP_READY_ENTR_L23_ID			13
-#define APP_REQ_EXIT_L1_ID			14
-#define DEVICE_TYPE_EP				(0 << 25)
-#define DEVICE_TYPE_LEP				(1 << 25)
 #define DEVICE_TYPE_RC				(4 << 25)
-#define SYS_INT_ID				29
 #define MISCTRL_EN_ID				30
 #define REG_TRANSLATION_ENABLE			31
 
-/* CR1 ID */
-#define APPS_PM_XMT_TURNOFF_ID			2
-#define APPS_PM_XMT_PME_ID			5
-
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
 
-/* CR4 ID */
-#define CFG_MSI_EN_ID				18
-
 /* CR6 */
-#define INTA_CTRL_INT				(1 << 7)
-#define INTB_CTRL_INT				(1 << 8)
-#define INTC_CTRL_INT				(1 << 9)
-#define INTD_CTRL_INT				(1 << 10)
 #define MSI_CTRL_INT				(1 << 26)
 
-/* CR19 ID */
-#define VEN_MSI_REQ_ID				11
-#define VEN_MSI_FUN_NUM_ID			8
-#define VEN_MSI_TC_ID				5
-#define VEN_MSI_VECTOR_ID			0
-#define VEN_MSI_REQ_EN		((u32)0x1 << VEN_MSI_REQ_ID)
-#define VEN_MSI_FUN_NUM_MASK	((u32)0x7 << VEN_MSI_FUN_NUM_ID)
-#define VEN_MSI_TC_MASK		((u32)0x7 << VEN_MSI_TC_ID)
-#define VEN_MSI_VECTOR_MASK	((u32)0x1F << VEN_MSI_VECTOR_ID)
-
 #define EXP_CAP_ID_OFFSET			0x70
 
 #define to_spear13xx_pcie(x)	container_of(x, struct spear13xx_pcie, pp)

