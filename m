Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020092.outbound.protection.outlook.com [52.101.228.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAD04457D8;
	Thu,  3 Sep 2026 08:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423912; cv=fail; b=oDLGJyIW+jFJgi/+DlTheOr3LUKRsg507S4tLLTSKhnNEoIicANoHpxmEpSWppfWaQ5ZAZciedOzipGs+vVgdIa6Ky4JI3+gFHtGLBpTTpJ3aKtsZ096mR2o9Gq9X3MjRDuyU3bD8CFU5DPH6dX7vVuukpaKguZR0GXdOXl8hOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423912; c=relaxed/simple;
	bh=tTNSbIp7NeeAHuPqL+hvH1jQdoj6MW3Z7mRYuCwN6y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P9TLkOklO8J76uLMJcJp8bqjpeP9/gk9M8QW3X94dHWvfhEOtJuWusW/wHQm+nIcBLy5PLaQyBjMnIlh/IMNagY3qVAuE7vPxmRvG1Wq0MztkV28chRlB2SJ/VWySFnEbc38+GWJXvAOZzR77Uplzle1vaiOsvDz/zMLHi3nosg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=wYpMIAOA; arc=fail smtp.client-ip=52.101.228.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="wYpMIAOA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4y+YR/63uO+4IL7HDsg9w9AETaxeNYrXCtH0RXLOmU1wZO/S/CImdoJKtB78AOpBKwGu+xO4B7gjbMZGALQPU4im7iNLZLqC1E/2jnCJnwuRUdNZ/y4cX6Dgi47qt/fhqtd5OyQr5xjXbaMSaLkx3PQDEq+RfSyzYWtfXkmO5h0RbrUGKQp9Sypah39OX+h4Zf4ySV/Zs4f6UiAlJBTmIU48QiwSp8uNG3wSRbMC6Jpw9oam3MXAjybOxfelACk0LxFboQvKyRiFwtwXnylD/H6z1hbRJChbXYZ3yzuEMQJqrnpr++eIIXA4zcjk5Nc8OR4JKPFwKhQ92Uva1WXSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzC6BiYN1MKRTusQHIDS31W4DqapSr4iXeuID+wE9Ok=;
 b=AXry47qMR/Wls5Pzk71nY8SdLj0tWfdyCvHaOqzSdR10mCZ2NUkEKLoNoJbQPr/N4+pC1ptbMGHbDi6BCPowlIy2GDM9mMl0aLy+6PVdaIlO+QKi+3JTsTbFLqnCxOKMVA+ej82YGZrkkv5r6UiBLlLT8Y16S4lRInd3BeHUKEE5VxxXJRNtL/ItS3pYi1LQz1vBrNta0c5SoMVfR8gn+2Fk5aYqb3kEIGkeG1/xtrCGOUx+PVp452pTBeQWlxdBogoXtqU5b7nDvqjzgtf6+k5jXsqQgP8PJ83q0xgA+AaVMNCsrO8lzYeDcVCqbkcCdLzl/TyeJfCB0oRTVM4ihw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzC6BiYN1MKRTusQHIDS31W4DqapSr4iXeuID+wE9Ok=;
 b=wYpMIAOA1UP/ucb8Jcy8uZzn33C3I/cMaqCeBYCBd78OMpoDYTF0l7+7KwtHrk8iUrTXXu51En/Skwj846pF2gOxCsjgCSbBreSjWoO5U6j1ePRXCjsJU00BB653MmSoqnR06VHse/62ZdHEXS7cE3w1BdWZzVhXrsL3IE7mMf0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB7060.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:320::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 08:25:01 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 08:25:01 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v4 4/7] PCI: endpoint: pci-epf-vntb: Export endpoint DMA channels
Date: Thu,  3 Sep 2026 17:23:24 +0900
Message-ID: <20260903082327.2345602-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260903082327.2345602-1-den@valinux.co.jp>
References: <20260903082327.2345602-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0031.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB7060:EE_
X-MS-Office365-Filtering-Correlation-Id: ace499ab-49d1-47e6-08da-08df0994d925
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|7416014|10070799003|366016|6133799003|10067099003|5023799004|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	wcYdKALB0eEAwNZPdD3M77t6RAA27IYQChYII5t769Xh0+ybngZDUU9vvC9j/G/vde3aDpiMGObK39e3IIeb9YD/u6nwjSX3F+Qs7xyzPZubMlXv/sCvu/Jf/dLms5wNnYiI5SZ7Ma6T+oaVLFaF/rV1wGMi720fi/7xER0USw9o0HBrsrq2WUdvNOghuvkP1lb/oYr1MEBk8i9m34DGC/HKz0GYvQBdx7az/ghV5Og0+1dDZ6ol95dDOwj3tUtcji9upYxw+wGwvywQ65w9Ut7FNxjNesdvqriEGVrvVyLpmwKtN5oE74LihNOkDZx+UVF1UfbbLes4JD0Acn8Kte2OukMsII0YiV1eMbCSnIqhRFuwzlENIU2Rsr2Z8pHX/o3CjqkdOz1gAOijA3pKXgxEt0lwlfMyH7nI1D+kslN9vSBXK9dn655GiF06fiUC7teBTR/E7wVO3kH/QO93TowsF5frF6qAeHiWTTVfHA1zAYZd67t1tdizrw9nCS771cafezlW4brPAPRThTspIPN+bjCOy2c6W+syljQtoiOUCIsSKj+tde3wjLgz0mazMALoEQNeHscH/5qf7VloW/b9f5goso6fHtR83RjcaUcamnM15gXzx6ZGPP32nPeMrvQgaHBo/uVlDwhRYTRd6+XFfJo8kRzD2Jl/ayzg5Nk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(7416014)(10070799003)(366016)(6133799003)(10067099003)(5023799004)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fcb5TU9hxm9AcgvNluEIZqzcVu2xbCrvoL7xpSOhYpo2xbAOBcKldcAmJx1e?=
 =?us-ascii?Q?cl/lH+6WR5xc7PlabeyF5DmkHuiEqpk1vAHYx8Vs3Sftn6DgZwFuLnjgAi1G?=
 =?us-ascii?Q?Hot1gpcu07bVchXDrjAIWt2v5/PyQIHSBZg2AD5w4iCqkWs5CwB/iH2mTprI?=
 =?us-ascii?Q?h9S84DOi/olkWZwapYsKlJhvDIdavF0aEV7fLGt2cJKOzPBSJOkFnuOiMsvx?=
 =?us-ascii?Q?ge79FLp3IdwoaSusjz8h37qj5DKBmyg7Mrkg4XKmcoFAVE+0oQJF49XQ0jsk?=
 =?us-ascii?Q?iTEwgHIUPtpmejgGw5vsZsh585XmUyYkpttxTZK912qHSb6tzgRf4wTFmaiw?=
 =?us-ascii?Q?SmyzX4j8gPnr4p5Dg7SysZMbSZpDW1g9BXQrbaBgh71C0rhi18rsJNxk4e+g?=
 =?us-ascii?Q?HHsSKbYLit8MMCq4hHKoOTK3k4T91gVr2edFZ3qabmEAqCBvM0ujpzrGjD0F?=
 =?us-ascii?Q?vI4Z6zZAouejd4BmsAXVhl9OvfaTlaweHOsH27v9oq9QMp13I9ZuUwJ0pxqg?=
 =?us-ascii?Q?tqmY4kkm+8ykoRCDrl4RGY5eZsdypE6c80XGwlo6jTlb8OYccdM0tkE1+91G?=
 =?us-ascii?Q?f6pJW5IQATq9awgBbLSzwji0jP7WlD6B6lr5ywXpO29rh/rPTFAwghsIbAKB?=
 =?us-ascii?Q?YH0kVVagVfDmu6wq0QzIeUqdOCikA2jo2h8FjCS327Be0787Y1ioqjujd9uD?=
 =?us-ascii?Q?Io5Vj6dIXb9srv+64xlmteHDS9QzHU81Traxvqx0dRsGZ3ihQWViUpRSCe6h?=
 =?us-ascii?Q?/bb8EkdYXLqGIo/HIytWkwKBL3CMr+Gpdq3+6QeR4Cb7Hc8SqxMYZcmTpqkh?=
 =?us-ascii?Q?a8YPornT2Vkm6rksHgGVi8lo98+Lg8TFIn+D9IquUDd3XIavkmkLbRbA1yOs?=
 =?us-ascii?Q?0jZsVA0Ftx+K/bBRmmpRPU/e78HhLRKp0awOpcgzjXBWMuKFaR/4CGlnjL1B?=
 =?us-ascii?Q?53ITqY+pfqfuHYvsVBbv+i27RzxBC8pjuSfQFan4Sv8cUG2GIJLfhLMGCEYu?=
 =?us-ascii?Q?AJSPJ20BnZaRqiwrOy8FTeUumFNyny+m+m6Pss3VqkZexIB6/PexcRXcrChB?=
 =?us-ascii?Q?Q/RF4tyLFd8LNQcB8jgPwnk8/YiLuXjWb1esm5Ob3ZWuHztFNSAxj9nI6t+X?=
 =?us-ascii?Q?7EZHdWCikY1doZ5SYpq3R9NnKkX7OY8GnNG/z0c6lk5VnmbZsJthgPn8MMGt?=
 =?us-ascii?Q?0dAhsXUzQJraHhTSyTarpawBJk9EflJZdYuoEuyjX9y+BvJHf+yS2dnki7D8?=
 =?us-ascii?Q?4pGhMZz0XjqKWEGx7GdtD0kX2GlcjfBFi5nw1tYo9ZTa8cMU9zLs3FPb0WXd?=
 =?us-ascii?Q?+r2uTaEDpIgWWH5xdyJDWaNyyjOvJbt5YzCwQmfSR3iDqgSi4Vi6EgjCENoc?=
 =?us-ascii?Q?NXZS+2CbghuRVi8rNqE+5SlyxJJWHgU3EVTquEF78IZwedJzjT7M0Lenu5Ak?=
 =?us-ascii?Q?hndI33QFKVouhw50ciBMDSEfj8rS8jjwUAlMUDR+4X4qwRSG49+HyPBsKDtl?=
 =?us-ascii?Q?hhGhzJnNfGAIGb/B7w+9go3ffnP2wZdljwccwDKhSRkLssMStV70Rw7CGsFT?=
 =?us-ascii?Q?Et/w7QGc10QvksdV3D/Kc7z85pIUT5xWJL94ZJOsVBQ1+WoM5InKybbKWkWy?=
 =?us-ascii?Q?Cs5z1dM5RkgyN0hIVMCKGLFrY3JZLV0P9VwXmdTNhENyR7wxnO38kROX3Y5M?=
 =?us-ascii?Q?TSuc+pO0rt1BEr5P5Li9UpAwNTGi/3wX6oHCI8X9m5yhFU1XzACh+SyY1Jzx?=
 =?us-ascii?Q?VVk3y4bX38MVzpcAPhSOfVAXBRmT+je6t/ebm3bAP3Ze6Jx/TPKH?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ace499ab-49d1-47e6-08da-08df0994d925
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 08:25:01.4675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9YKwXzNSSiSYr8fuy+KzqFtri+dsShG5zxSpcVf2ubVr0ULs+QlG8w9K6bAoeKJSHQOcDxCxgCnBLnfmM7+4lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB7060

An RC may use endpoint-local DMA read channels to transfer data directly
to an endpoint DMA address once both sides agree to use them. Quiescing
an unrolled eDMA channel disables its whole direction, so reserve the
complete read direction and route its interrupts to the RC when dma_bar
is configured.

Describe the controller and per-channel descriptor memory in a private
control-region extension.

Add a dma_bar configfs attribute. An explicit BAR selection enables DMA
export. Leaving it unassigned keeps the feature disabled.

Keep resources already assigned to a BAR in place, and map the rest
through the selected dma_bar.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - Keep DMA BAR submaps installed until EPF unbind and remove the runtime
    teardown command. (Sashiko)
  - Base the unbind path on the vNTB lifecycle fixes. (Sashiko)
  - Rename CONFIGURE_DMA to SETUP_DMA_BAR to distinguish this bind-lifetime
    BAR setup from CONFIGURE_MW's outbound mapping.
  - Do not clear the DMA BAR when setup fails before BAR assignment.

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 567 +++++++++++++++++-
 1 file changed, 559 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 73479b5e5d26..ad34530642fc 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -39,8 +39,12 @@
 #include <linux/atomic.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/dma/edma.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
 
 #include <linux/pci-ep-msi.h>
@@ -56,6 +60,7 @@ static struct workqueue_struct *kpcintb_workqueue;
 #define COMMAND_TEARDOWN_MW		4
 #define COMMAND_LINK_UP			5
 #define COMMAND_LINK_DOWN		6
+#define COMMAND_SETUP_DMA_BAR		7
 
 #define COMMAND_STATUS_OK		1
 #define COMMAND_STATUS_ERROR		2
@@ -69,6 +74,10 @@ static struct workqueue_struct *kpcintb_workqueue;
 #define MSIX_ENABLE			BIT(16)
 #define MAX_MW				4
 
+#define EPF_NTB_DMA_MAGIC		0x414d444e /* "NDMA": NTB DMA */
+#define EPF_NTB_DMA_REVISION		1
+#define EPF_NTB_DMA_TYPE_DW_EDMA	1
+
 /* Limit per-work execution to avoid monopolizing kworker on doorbell storms. */
 #define VNTB_PEER_DB_WORK_BUDGET	5
 
@@ -79,6 +88,7 @@ enum epf_ntb_bar {
 	BAR_MW2,
 	BAR_MW3,
 	BAR_MW4,
+	BAR_DMA,
 	VNTB_BAR_NUM,
 };
 
@@ -91,6 +101,30 @@ enum epf_irq_slot {
 #define MIN_DB_COUNT			(EPF_IRQ_DB_START + 1)
 #define MAX_DB_COUNT			32
 
+/* Private wire extension consumed by ntb_hw_epf. */
+struct epf_ntb_dma_region_ctrl {
+	u32 bar;
+	u32 offset;
+	u32 size;
+} __packed;
+
+struct epf_ntb_dma_chan_ctrl {
+	struct epf_ntb_dma_region_ctrl desc;
+	u32 desc_addr_lo;
+	u32 desc_addr_hi;
+} __packed;
+
+struct epf_ntb_dma_ctrl {
+	u32 magic;
+	u16 revision;
+	u16 length;
+	u32 type;
+	/* BAR range occupied by resources without a fixed BAR assignment. */
+	struct epf_ntb_dma_region_ctrl submap;
+	struct epf_ntb_dma_region_ctrl reg;
+	struct epf_ntb_dma_chan_ctrl chan[EDMA_MAX_RD_CH];
+} __packed;
+
 /*
  * +--------------------------------------------------+ Base
  * |                                                  |
@@ -129,8 +163,21 @@ struct epf_ntb_ctrl {
 	u32 db_entry_size;
 	u32 db_data[MAX_DB_COUNT];
 	u32 db_offset[MAX_DB_COUNT];
+	struct epf_ntb_dma_ctrl dma;
 } __packed;
 
+struct epf_ntb_dma {
+	struct epf_ntb_dma_ctrl ctrl;
+	struct dma_chan *dchan[EDMA_MAX_RD_CH];
+	void *bar_scratch;
+	dma_addr_t bar_scratch_phys;
+	size_t bar_scratch_size;
+	struct pci_epf_bar_submap submap[EDMA_MAX_RD_CH + 2];
+	struct pci_epf_bar_submap *reg_submap;
+	unsigned int num_submap;
+	u16 rd_ch_cnt;
+};
+
 struct epf_ntb {
 	struct ntb_dev *ntb;
 	struct pci_epf *epf;
@@ -159,6 +206,7 @@ struct epf_ntb {
 	enum pci_barno epf_ntb_bar[VNTB_BAR_NUM];
 
 	struct epf_ntb_ctrl *reg;
+	struct epf_ntb_dma *dma;
 
 	u32 *epf_db;
 
@@ -216,7 +264,8 @@ static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
 {
 	int i;
 
-	for (i = 0; i < VNTB_BAR_NUM; i++) {
+	/* BAR_DMA is checked separately because it may share an MW BAR. */
+	for (i = 0; i < BAR_DMA; i++) {
 		if (ntb->epf_ntb_bar[i] == barno)
 			return true;
 	}
@@ -224,6 +273,396 @@ static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
 	return false;
 }
 
+static int epf_ntb_dma_validate_bar(struct epf_ntb *ntb,
+				    const struct pci_epc_features *features)
+{
+	enum pci_barno barno = ntb->epf_ntb_bar[BAR_DMA];
+
+	if (epf_ntb_is_bar_used(ntb, barno) ||
+	    pci_epc_get_next_free_bar(features, barno) != barno)
+		return -EINVAL;
+
+	return 0;
+}
+
+struct epf_ntb_dma_filter {
+	struct device *dev;
+	int chan_id;
+};
+
+static bool epf_ntb_dma_filter(struct dma_chan *chan, void *data)
+{
+	struct epf_ntb_dma_filter *filter = data;
+
+	return chan->device->dev == filter->dev &&
+	       chan->chan_id == filter->chan_id;
+}
+
+static int epf_ntb_dma_add_region(struct epf_ntb_dma *dma,
+				  const struct pci_epc_aux_resource *resource,
+				  dma_addr_t target_addr,
+				  enum pci_barno barno, size_t align, u32 *next,
+				  struct epf_ntb_dma_region_ctrl *region)
+{
+	resource_size_t delta, map_size, size;
+	struct pci_epf_bar_submap *submap;
+	dma_addr_t base;
+
+	if (!resource->size || resource->size > U32_MAX)
+		return -EINVAL;
+
+	region->size = resource->size;
+	if (resource->bar != NO_BAR) {
+		if (resource->bar < BAR_0 || resource->bar > BAR_5 ||
+		    resource->bar_offset > U32_MAX)
+			return -EINVAL;
+
+		region->bar = resource->bar;
+		region->offset = resource->bar_offset;
+		return 0;
+	}
+	submap = &dma->submap[dma->num_submap];
+
+	/*
+	 * The RC is trusted with endpoint-local DMA. Map the aligned span
+	 * required by the EPC, but advertise only the resource itself.
+	 */
+	base = ALIGN_DOWN(target_addr, align);
+	delta = target_addr - base;
+	if (check_add_overflow(delta, resource->size, &size))
+		return -EOVERFLOW;
+	map_size = ALIGN(size, align);
+	if (map_size < size || map_size > U32_MAX - *next)
+		return -EOVERFLOW;
+
+	submap->phys_addr = base;
+	submap->size = map_size;
+	region->bar = barno;
+	region->offset = *next + delta;
+	*next += map_size;
+	dma->num_submap++;
+
+	return 0;
+}
+
+/* DW eDMA */
+
+static int epf_ntb_dw_edma_claim(struct device *dev, int chan_id,
+				 struct dma_chan **dchan)
+{
+	struct dw_edma_chan_config chan_config = {
+		.flags = DW_EDMA_CH_CONFIG_IRQ_MODE,
+		.irq_mode = DW_EDMA_CH_IRQ_REMOTE,
+	};
+	struct epf_ntb_dma_filter filter = {
+		.dev = dev,
+		.chan_id = chan_id,
+	};
+	struct dma_slave_config config = {
+		.peripheral_config = &chan_config,
+		.peripheral_size = sizeof(chan_config),
+	};
+	struct dma_chan *chan;
+	dma_cap_mask_t mask;
+	int ret;
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+	chan = dma_request_channel(mask, epf_ntb_dma_filter, &filter);
+	if (!chan)
+		return -EBUSY;
+
+	ret = dmaengine_slave_config(chan, &config);
+	if (ret) {
+		dma_release_channel(chan);
+		return ret;
+	}
+
+	*dchan = chan;
+
+	return 0;
+}
+
+static void epf_ntb_dw_edma_release_channels(struct epf_ntb *ntb,
+					     struct epf_ntb_dma *dma,
+					     bool quiesce)
+{
+	unsigned int i;
+	int ret;
+
+	if (quiesce) {
+		/*
+		 * RC programming has stopped and this EPF owns the complete
+		 * read direction, so one termination quiesces the direction.
+		 */
+		ret = dmaengine_terminate_sync(dma->dchan[0]);
+		if (ret)
+			dev_warn(&ntb->epf->dev,
+				 "failed to terminate remote DMA: %d\n", ret);
+	}
+
+	for (i = 0; i < dma->rd_ch_cnt; i++) {
+		if (!dma->dchan[i])
+			continue;
+
+		dma_release_channel(dma->dchan[i]);
+	}
+}
+
+static const struct pci_epc_aux_resource *
+epf_ntb_dw_edma_find_desc(const struct pci_epc_aux_resource *resources,
+			  unsigned int count, u16 chan_id)
+{
+	unsigned int i;
+
+	for (i = 0; i < count; i++)
+		if (resources[i].type == PCI_EPC_AUX_DMA_DESC_MEM &&
+		    resources[i].u.dma_desc.chan_id == chan_id)
+			return &resources[i];
+
+	return NULL;
+}
+
+static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
+				   struct epf_ntb_dma *dma,
+				   const struct pci_epc_aux_resource *ctrl,
+				   const struct pci_epc_aux_resource *resources,
+				   unsigned int count)
+{
+	const struct pci_epc_aux_resource *desc[EDMA_MAX_RD_CH];
+	enum pci_barno barno = ntb->epf_ntb_bar[BAR_DMA];
+	const struct pci_epc_features *features;
+	struct device *dma_dev;
+	bool needs_submap;
+	unsigned int i;
+	size_t align;
+	u32 next = 0;
+	int ret;
+
+	if (ctrl->u.dma_ctrl.reg_layout_data != EDMA_MF_EDMA_UNROLL)
+		return -EOPNOTSUPP;
+	if (ctrl->u.dma_ctrl.ep_to_rc_ch_cnt > EDMA_MAX_WR_CH ||
+	    !ctrl->u.dma_ctrl.rc_to_ep_ch_cnt ||
+	    ctrl->u.dma_ctrl.rc_to_ep_ch_cnt > EDMA_MAX_RD_CH)
+		return -EINVAL;
+
+	dma->rd_ch_cnt = ctrl->u.dma_ctrl.rc_to_ep_ch_cnt;
+
+	features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no,
+					ntb->epf->vfunc_no);
+	if (!features)
+		return -EOPNOTSUPP;
+
+	align = features->align ?: 1;
+	if (!is_power_of_2(align))
+		return -EINVAL;
+
+	needs_submap = ctrl->bar == NO_BAR;
+	/* DW eDMA static IDs place read channels after all write channels. */
+	for (i = 0; i < dma->rd_ch_cnt; i++) {
+		u16 chan_id = ctrl->u.dma_ctrl.ep_to_rc_ch_cnt + i;
+
+		desc[i] = epf_ntb_dw_edma_find_desc(resources, count, chan_id);
+		if (!desc[i])
+			return -EINVAL;
+		needs_submap |= desc[i]->bar == NO_BAR;
+	}
+	if (needs_submap) {
+		if (!features->subrange_mapping ||
+		    !features->dynamic_inbound_mapping)
+			return -EOPNOTSUPP;
+		ret = epf_ntb_dma_validate_bar(ntb, features);
+		if (ret)
+			return ret;
+	}
+
+	dma->ctrl.magic = EPF_NTB_DMA_MAGIC;
+	dma->ctrl.revision = EPF_NTB_DMA_REVISION;
+	dma->ctrl.type = EPF_NTB_DMA_TYPE_DW_EDMA;
+	dma->ctrl.submap.bar = U32_MAX;
+	dma->ctrl.length = offsetof(struct epf_ntb_dma_ctrl,
+				    chan[dma->rd_ch_cnt]);
+
+	if (ctrl->bar == NO_BAR)
+		dma->reg_submap = &dma->submap[dma->num_submap];
+	ret = epf_ntb_dma_add_region(dma, ctrl, ctrl->phys_addr,
+				     barno, align, &next, &dma->ctrl.reg);
+	if (ret)
+		return ret;
+	for (i = 0; i < dma->rd_ch_cnt; i++) {
+		struct epf_ntb_dma_chan_ctrl *chan = &dma->ctrl.chan[i];
+		dma_addr_t dma_addr = desc[i]->u.dma_desc.dma_addr;
+
+		ret = epf_ntb_dma_add_region(dma, desc[i], dma_addr, barno,
+					     align, &next, &chan->desc);
+		if (ret)
+			return ret;
+		chan->desc_addr_lo = lower_32_bits(dma_addr);
+		chan->desc_addr_hi = upper_32_bits(dma_addr);
+	}
+	if (dma->num_submap) {
+		dma->ctrl.submap.bar = barno;
+		dma->ctrl.submap.size = next;
+	}
+
+	dma_dev = ntb->epf->epc->dev.parent;
+	for (i = 0; i < dma->rd_ch_cnt; i++) {
+		u16 chan_id = ctrl->u.dma_ctrl.ep_to_rc_ch_cnt + i;
+
+		ret = epf_ntb_dw_edma_claim(dma_dev, chan_id, &dma->dchan[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/* Common endpoint DMA */
+
+static void epf_ntb_dma_release_channels(struct epf_ntb *ntb,
+					 struct epf_ntb_dma *dma,
+					 bool quiesce)
+{
+	switch (dma->ctrl.type) {
+	case EPF_NTB_DMA_TYPE_DW_EDMA:
+		epf_ntb_dw_edma_release_channels(ntb, dma, quiesce);
+		break;
+	}
+}
+
+static int epf_ntb_dma_collect(struct epf_ntb *ntb)
+{
+	const struct pci_epc_aux_resource *ctrl = NULL;
+	struct device *dma_dev;
+	dma_addr_t dma_addr;
+	unsigned int i;
+	int count, ret;
+
+	if (ntb->epf_ntb_bar[BAR_DMA] == NO_BAR)
+		return 0;
+
+	count = pci_epc_get_aux_resources_count(ntb->epf->epc,
+						ntb->epf->func_no,
+						ntb->epf->vfunc_no);
+	if (count <= 0)
+		return count ?: -ENODEV;
+
+	struct pci_epc_aux_resource *resources __free(kfree) =
+		kcalloc(count, sizeof(*resources), GFP_KERNEL);
+	if (!resources)
+		return -ENOMEM;
+
+	ret = pci_epc_get_aux_resources(ntb->epf->epc, ntb->epf->func_no,
+					ntb->epf->vfunc_no, resources, count);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < count; i++) {
+		if (resources[i].type != PCI_EPC_AUX_DMA_CTRL_MMIO)
+			continue;
+		if (ctrl)
+			return -EINVAL;
+		ctrl = &resources[i];
+	}
+	if (!ctrl)
+		return -ENODEV;
+
+	struct epf_ntb_dma *dma __free(kfree) =
+		kzalloc(sizeof(*dma), GFP_KERNEL);
+	if (!dma)
+		return -ENOMEM;
+
+	switch (ctrl->u.dma_ctrl.reg_layout) {
+	case PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA:
+		ret = epf_ntb_dw_edma_collect(ntb, dma, ctrl, resources, count);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+	if (ret) {
+		epf_ntb_dma_release_channels(ntb, dma, false);
+		return ret;
+	}
+
+	/*
+	 * CTRL_MMIO carries a CPU physical address, while DMA_DESC_MEM already
+	 * carries an endpoint DMA address. Convert only the former.
+	 */
+	if (dma->reg_submap) {
+		dma_dev = ntb->epf->epc->dev.parent;
+		dma_addr = dma_map_resource(dma_dev, dma->reg_submap->phys_addr,
+					    dma->reg_submap->size,
+					    DMA_BIDIRECTIONAL, 0);
+		if (dma_mapping_error(dma_dev, dma_addr)) {
+			epf_ntb_dma_release_channels(ntb, dma, false);
+			return -EIO;
+		}
+		dma->reg_submap->phys_addr = dma_addr;
+	}
+
+	ntb->dma = no_free_ptr(dma);
+
+	return 0;
+}
+
+static void epf_ntb_dma_release(struct epf_ntb *ntb, bool quiesce)
+{
+	struct epf_ntb_dma *dma = ntb->dma;
+	struct device *dev;
+
+	if (!dma)
+		return;
+
+	epf_ntb_dma_release_channels(ntb, dma, quiesce);
+	dev = ntb->epf->epc->dev.parent;
+	if (dma->reg_submap)
+		dma_unmap_resource(dev, dma->reg_submap->phys_addr,
+				   dma->reg_submap->size, DMA_BIDIRECTIONAL, 0);
+	if (dma->bar_scratch)
+		dma_free_coherent(dev, dma->bar_scratch_size,
+				  dma->bar_scratch, dma->bar_scratch_phys);
+	kfree(dma);
+	ntb->dma = NULL;
+}
+
+static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
+{
+	struct pci_epf_bar_submap *old_submap;
+	struct epf_ntb_dma *dma = ntb->dma;
+	struct pci_epf_bar *bar;
+	unsigned int old_num_submap;
+	int restore, ret;
+
+	if (!dma || !dma->num_submap)
+		return 0;
+
+	bar = &ntb->epf->bar[ntb->epf_ntb_bar[BAR_DMA]];
+	if (bar->submap == dma->submap &&
+	    bar->num_submap == dma->num_submap)
+		return 0;
+
+	old_submap = bar->submap;
+	old_num_submap = bar->num_submap;
+	bar->submap = dma->submap;
+	bar->num_submap = dma->num_submap;
+
+	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
+			      ntb->epf->vfunc_no, bar);
+	if (!ret)
+		return 0;
+
+	/* A failed dynamic update may have already removed the old mapping. */
+	bar->submap = old_submap;
+	bar->num_submap = old_num_submap;
+	restore = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
+				  ntb->epf->vfunc_no, bar);
+	if (restore)
+		dev_warn(&ntb->epf->dev,
+			 "failed to restore DMA BAR mapping: %d\n", restore);
+
+	return ret;
+}
+
 /**
  * epf_ntb_configure_mw() - Configure the Outbound Address Space for VHOST
  *   to access the memory window of HOST
@@ -344,6 +783,11 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 		epf_ntb_teardown_mw(ntb, argument);
 		ctrl->command_status = COMMAND_STATUS_OK;
 		break;
+	case COMMAND_SETUP_DMA_BAR:
+		ret = epf_ntb_dma_set_bar(ntb);
+		ctrl->command_status = ret ? COMMAND_STATUS_ERROR :
+					     COMMAND_STATUS_OK;
+		break;
 	case COMMAND_LINK_UP:
 		ntb->linkup = true;
 		ret = epf_ntb_link_up(ntb, true);
@@ -470,9 +914,8 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
  *   region
  * @ntb: NTB device that facilitates communication between HOST and VHOST
  *
- * Allocate the Local Memory mentioned in the above diagram. The size of
- * CONFIG REGION is sizeof(struct epf_ntb_ctrl) and size of SCRATCHPAD REGION
- * is obtained from "spad-count" configfs entry.
+ * Allocate the control and scratchpad regions, omitting the optional DMA
+ * extension when no channels are exported.
  *
  * Returns: Zero for success, or an error code in case of failure
  */
@@ -492,7 +935,9 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 	barno = ntb->epf_ntb_bar[BAR_CONFIG];
 	spad_count = ntb->spad_count;
 
-	ctrl_size = ALIGN(sizeof(struct epf_ntb_ctrl), sizeof(u32));
+	ctrl_size = ntb->dma ? sizeof(struct epf_ntb_ctrl) :
+			       offsetof(struct epf_ntb_ctrl, dma);
+	ctrl_size = ALIGN(ctrl_size, sizeof(u32));
 	spad_size = 2 * spad_count * sizeof(u32);
 
 	base = pci_epf_alloc_space(epf, ctrl_size + spad_size,
@@ -518,6 +963,9 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 		ntb->reg->db_offset[i] = 0;
 	}
 
+	if (ntb->dma)
+		ctrl->dma = ntb->dma->ctrl;
+
 	return 0;
 }
 
@@ -749,6 +1197,86 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 
 static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws);
 
+static int epf_ntb_dma_bar_init(struct epf_ntb *ntb)
+{
+	struct device *dev = ntb->epf->epc->dev.parent;
+	const struct pci_epc_features *features;
+	struct epf_ntb_dma *dma = ntb->dma;
+	struct pci_epf_bar *bar;
+	enum pci_barno barno;
+	size_t backing_size;
+	u32 mapped_size;
+	int ret;
+
+	features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no,
+					ntb->epf->vfunc_no);
+	if (!features)
+		return -EOPNOTSUPP;
+
+	barno = ntb->epf_ntb_bar[BAR_DMA];
+	mapped_size = dma->ctrl.submap.size;
+	/*
+	 * Submaps cannot be installed until the host assigns the BAR address.
+	 * Use address 0 for the temporary BAR Match Mode mapping, as is done
+	 * for regular vNTB MW BARs.
+	 */
+	ret = pci_epf_assign_bar_space(ntb->epf, mapped_size, barno, features,
+				       PRIMARY_INTERFACE, 0);
+	if (ret)
+		return ret;
+
+	bar = &ntb->epf->bar[barno];
+	if (bar->size > U32_MAX)
+		return -EOVERFLOW;
+
+	backing_size = bar->size - mapped_size;
+	if (backing_size) {
+		/* Back the BAR tail added by the power-of-two size rounding. */
+		dma->bar_scratch = dma_alloc_coherent(dev, backing_size,
+						      &dma->bar_scratch_phys,
+						      GFP_KERNEL);
+		if (!dma->bar_scratch)
+			return -ENOMEM;
+		dma->bar_scratch_size = backing_size;
+		if (!IS_ALIGNED(dma->bar_scratch_phys, features->align ?: 1))
+			return -EINVAL;
+
+		dma->submap[dma->num_submap++] = (struct pci_epf_bar_submap) {
+			.phys_addr = dma->bar_scratch_phys,
+			.size = backing_size,
+		};
+	}
+
+	return pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
+			       ntb->epf->vfunc_no, bar);
+}
+
+static void epf_ntb_dma_bar_clear(struct epf_ntb *ntb)
+{
+	struct epf_ntb_dma *dma = ntb->dma;
+	struct pci_epf_bar *bar;
+	enum pci_barno barno;
+
+	if (!dma || !dma->num_submap)
+		return;
+
+	barno = ntb->epf_ntb_bar[BAR_DMA];
+	bar = &ntb->epf->bar[barno];
+	if (!bar->size)
+		return;
+
+	pci_epc_clear_bar(ntb->epf->epc, ntb->epf->func_no,
+			  ntb->epf->vfunc_no, bar);
+	bar->submap = NULL;
+	bar->num_submap = 0;
+	bar->phys_addr = 0;
+	bar->addr = NULL;
+	bar->size = 0;
+	bar->mem_size = 0;
+	bar->barno = 0;
+	bar->flags = 0;
+}
+
 /**
  * epf_ntb_db_bar_clear() - Clear doorbell BAR and free memory
  *   allocated in peer's outbound address space
@@ -888,7 +1416,8 @@ static int epf_ntb_find_bar(struct epf_ntb *ntb,
 		 * Verify if the BAR found is not already assigned
 		 * through the provided configuration
 		 */
-		if (!epf_ntb_is_bar_used(ntb, barno))
+		if (ntb->epf_ntb_bar[BAR_DMA] != barno &&
+		    !epf_ntb_is_bar_used(ntb, barno))
 			ntb->epf_ntb_bar[bar] = barno;
 
 		barno += 1;
@@ -987,11 +1516,19 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
 		goto err_mw_bar_init;
 	}
 
+	if (ntb->dma && ntb->dma->num_submap) {
+		ret = epf_ntb_dma_bar_init(ntb);
+		if (ret) {
+			dev_err(dev, "DMA BAR init failed\n");
+			goto err_dma_bar_init;
+		}
+	}
+
 	if (vfunc_no <= 1) {
 		ret = pci_epc_write_header(epc, func_no, vfunc_no, epf->header);
 		if (ret) {
 			dev_err(dev, "Configuration header write failed\n");
-			goto err_write_header;
+			goto err_dma_bar_init;
 		}
 	}
 
@@ -1002,7 +1539,8 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
 
 	return 0;
 
-err_write_header:
+err_dma_bar_init:
+	epf_ntb_dma_bar_clear(ntb);
 	epf_ntb_mw_bar_clear(ntb, ntb->num_mws);
 err_mw_bar_init:
 	epf_ntb_db_bar_clear(ntb);
@@ -1025,6 +1563,7 @@ static void epf_ntb_epc_cleanup(struct epf_ntb *ntb)
 	disable_delayed_work_sync(&ntb->cmd_handler);
 	disable_work_sync(&ntb->peer_db_work);
 	atomic64_set(&ntb->peer_db_pending, 0);
+	epf_ntb_dma_bar_clear(ntb);
 	epf_ntb_mw_bar_clear(ntb, ntb->num_mws);
 	epf_ntb_db_bar_clear(ntb);
 	epf_ntb_config_sspad_bar_clear(ntb);
@@ -1231,10 +1770,13 @@ EPF_NTB_BAR_R(mw3_bar, BAR_MW3)
 EPF_NTB_BAR_W(mw3_bar, BAR_MW3)
 EPF_NTB_BAR_R(mw4_bar, BAR_MW4)
 EPF_NTB_BAR_W(mw4_bar, BAR_MW4)
+EPF_NTB_BAR_R(dma_bar, BAR_DMA)
+EPF_NTB_BAR_W(dma_bar, BAR_DMA)
 
 CONFIGFS_ATTR(epf_ntb_, spad_count);
 CONFIGFS_ATTR(epf_ntb_, db_count);
 CONFIGFS_ATTR(epf_ntb_, num_mws);
+CONFIGFS_ATTR(epf_ntb_, dma_bar);
 CONFIGFS_ATTR(epf_ntb_, mw1);
 CONFIGFS_ATTR(epf_ntb_, mw2);
 CONFIGFS_ATTR(epf_ntb_, mw3);
@@ -1253,6 +1795,7 @@ static struct configfs_attribute *epf_ntb_attrs[] = {
 	&epf_ntb_attr_spad_count,
 	&epf_ntb_attr_db_count,
 	&epf_ntb_attr_num_mws,
+	&epf_ntb_attr_dma_bar,
 	&epf_ntb_attr_mw1,
 	&epf_ntb_attr_mw2,
 	&epf_ntb_attr_mw3,
@@ -1790,6 +2333,12 @@ static int epf_ntb_bind(struct pci_epf *epf)
 		return ret;
 	}
 
+	ret = epf_ntb_dma_collect(ntb);
+	if (ret) {
+		dev_err(dev, "Failed to prepare NTB DMA export\n");
+		return ret;
+	}
+
 	ret = epf_ntb_config_spad_bar_alloc(ntb);
 	if (ret) {
 		dev_err(dev, "Failed to allocate BAR memory\n");
@@ -1826,6 +2375,7 @@ static int epf_ntb_bind(struct pci_epf *epf)
 	epf_ntb_epc_cleanup(ntb);
 err_bar_alloc:
 	epf_ntb_config_spad_bar_free(ntb);
+	epf_ntb_dma_release(ntb, false);
 
 	return ret;
 }
@@ -1857,6 +2407,7 @@ static void epf_ntb_unbind(struct pci_epf *epf)
 
 	epf_ntb_epc_cleanup(ntb);
 	epf_ntb_config_spad_bar_free(ntb);
+	epf_ntb_dma_release(ntb, true);
 }
 
 // EPF driver probe
-- 
2.51.0

