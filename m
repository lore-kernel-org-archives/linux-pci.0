Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021123.outbound.protection.outlook.com [40.107.74.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D323DEFE7;
	Fri,  9 Oct 2026 05:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522016; cv=fail; b=TUItgBorkgFc/XtbEZ2DIKPu4pfciAseFUyuix3ScCvpNyERrDrJ7iX8MzI19nyCYsGFghRb1T865su0Orf8udXUZs/tC2iRpNjpWa7m50AlBuq3TBwHDiFgFEI67QSViDRbnMDNbimcwdx5L3AtS5hz0F+QwX5iuN/TVqedAo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522016; c=relaxed/simple;
	bh=XnHF2LuaCSi0Jwvk8Qp+YlRPJSEFaN/g/iQcDSl3BFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OkXq5Vksd3QZ4SBuPkB6vfNaMR6u8wg3JAMBetiYsBYnI5QHX+C4bMKiZ+3X9LwaRZUC5KjQ2sXvwMmjX2f72xpYoOc6LifMkVZB1KBxZB+lihPxxNxnLSamrhdYLQlJQG6MeJ+k9NpE6TEojRcVauW5ShHSCJjEVlCG3K30NlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=pSawLohq; arc=fail smtp.client-ip=40.107.74.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="pSawLohq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cYWlQlVizPIBnMiSzK0GHszbTesb4/h/FmL0K/4oLFD/qkBU3JWUlr0pdo2LCGCc67jYhVu/SF5EysRAXl+/PyMVfErsGtNOycRlGP+AxT/Wh033qJXAe69Wa41HKKRlKA8awqRpaYXgszfxqVzdtcd/mTPZS88BMQH4PR26fbzoMWrVNHyEGlvBFZy3tCBY/71txYq1RI8SccS4S04ZmFhgD8NyQCh1GN9lVbTgMae65G+KqNDUMsMVSusPLdZxAL7owvoIAtO2yVkZpEGEI/6ZHw0GHO5+N8cBJbYCBn0Jp9wrpi9MU2t1k9ZLjBGtzpSMFpPLZ8RU9A9p1p1zfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UL9KonFv9ZksXkPAKPcWtS6EcLY5KO0FL9YmC8yawU=;
 b=sKJk0NCrDWOV1brYUKaFxubOiBSy3Ce1qo/0mXCZ5rLBJQh0FM815LJleXFUgpmTSnQsICDLcMTlKFVAct5VmshlwT5u0ezWDXRG75Lcy7VWpfdT3yud5WAD/WquZ3qBZ2evrMetZJ1zly0OwvueCW3EyL1hhRO9hLnqAFLm4xFnLdIK3G7TrNFvbX11rZr64OPQzx2Dhn4+A9xNkVFlicvE3kO9OFTzUor5Uu7KxcInp++NSr61tp7znS4O6sf7Iu8qhCTxFyvYTH6KSvrknzgIZ1tuInIkNCCNigp/fydQxMul2OdOVoUg5DpFan+4z+vukKqChHpkuOS2r+ZeeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UL9KonFv9ZksXkPAKPcWtS6EcLY5KO0FL9YmC8yawU=;
 b=pSawLohqaSOkuKfIYZn8GwYntsKpUURCxFaJaVioW0gP7IcmjDjCsgMqKYoveW47g90u0fuuSG2m54lcOizYCI5UGzLrwUrjrnjdoIN6r/yNTQ/iHsS3f5FwGQwmCt/32A1SuTOkzC+6tGBb6wj+OCHCZtzIJdG7Sk2tSeDV3CU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSOP286MB4369.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:309::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 05:00:08 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 05:00:08 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
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
Subject: [PATCH v5 4/7] PCI: endpoint: pci-epf-vntb: Export endpoint DMA channels
Date: Fri,  9 Oct 2026 13:59:46 +0900
Message-ID: <20261009045949.1109871-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261009045949.1109871-1-den@valinux.co.jp>
References: <20261009045949.1109871-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0298.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::12) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSOP286MB4369:EE_
X-MS-Office365-Filtering-Correlation-Id: cf2c69ac-026f-49e9-47e3-08df25c230dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|23010399003|7416014|376014|1800799024|56012099006|5023799004|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	3+jzmm2pZ/9eWSD1BO/TwWE4lPd+BClmrpitvFYopaXcLYWoRp7UR3av+JUbrlU+zMJ8R9waN3Gi7bSdPkhiswMg4CN6UG3DCakk8gWO9zjFMC1XissO5lw+0KR6RQOvR/Ix0QJ3rJCvECgw6ZleglD9rwvYtEfuqLCgr0V8s5w2i2aqFFsnOj2lw8QNr8GC7wcqP1jfKUifNEcWlTjWJO4r+SqByha63Aw8QxgNXGvNRPrPU1UlyQbTJ2VBScpikS12C49fUGrqAfL2XG5hsSBR3hMQiJrtxj8isqmBqEIyF0ve+alugPXp+S8OM5V9pEgyGy5GbOQSnTi4tQTSF73kdv2UT3DcIrl1qN0QOdxZ2PGuQQKwycrQIXUocHByi6/65bi8zecEHUT457b0SKJNwBRi0Ofa3ZAYkmQNKXKVRFBfLH6zabRz/ZO2D/fnHg2XSUAjB/pDaArfnH41v3fM/WUsWArpbanrqj9THmV2JqN7cSQL1V2z6hfve2ZSsilzdYhcQGnZ7xWWk0gOM/7amKGkx2XxwnqCUrKzt5q4FnDO6Otz/r4xm3wUhTtlIsmvwkwEMZF/KmCnRGdmZDiBWZkHoDRoJXYeF4XZSngqabFcVVuLyRWhEVKD2TE1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(23010399003)(7416014)(376014)(1800799024)(56012099006)(5023799004)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vu5UxXK5njER20+WPJuFSJhLHnlcMssp+fypdrcYktBBmqeVe2cvQ25wl4RR?=
 =?us-ascii?Q?jh0+cz9CpNpSO7Gg5wIaMlEEjFW1DidT2yHEXJmDE2+QHWsHzDgkf6riKfq7?=
 =?us-ascii?Q?tWbgZI7zk38vnIeSTkQ0Yeqo05PtV8YTvkZyMoYi1JbQ6caB26SrH9TtOeGb?=
 =?us-ascii?Q?i6mqxhRz5oHJCnsRMcQ2m7sJ8mCBwRyUtjzCBGFKCgHzClPt09ymIE89BT+K?=
 =?us-ascii?Q?GyRXRptLy4V/GAw76o1l0OCilBsbBcDDXrZb4yjR0oBAaHMHXOtFnz2rl9eK?=
 =?us-ascii?Q?ffK80aXPvFOBHXuTTqjJt7tlNG3qOb+vwLvePGRaXDRicOF5jSL8jcB8sMK9?=
 =?us-ascii?Q?FeqvR+ZU2yUszJOwUThLhhRB3yGAKiV15Hkx9dGGjA1uj00DnCuuAm0BSDgc?=
 =?us-ascii?Q?EZWGUbiMTyyk4N6WVPqb8iST2Zl7Y7QzrDOfU8zoDJs9k52BAVF+Qi90Nhp6?=
 =?us-ascii?Q?kL8HQbiTO6LW4yHV9hMVk0zI5q98S0KEyeHnUSI1UG39YqJxUOq1e0H7rmaF?=
 =?us-ascii?Q?Ust0HkPs6AAGoSPcJWz1oQOVtZnq5e4nlPS2cUQCBpruzXgydPWlKGTNPr2S?=
 =?us-ascii?Q?gxnP8ZQRt1bantE4hNND60aYc6AGudaKwX2UWXJz2zimf+BL3qIQn/z0g60w?=
 =?us-ascii?Q?N4JMvOzdbCuOt1QagKcd2NrlOhlhPM8defzox4hQ5y6FClINHNJFnp5gBVSu?=
 =?us-ascii?Q?D3aLIsFUgDVIZN0uQRCeVUc7PIHsQqOpTXrqfimnj+KWztjUSFIc4fwKRT41?=
 =?us-ascii?Q?z/1VA8pri1268H8ZqsYv8GadDbnmurnQQ2QeJ/B57VkxI8UxrE5odp6Y8FLW?=
 =?us-ascii?Q?lRzBmIof1MfvvktQ+ty62fRiAquzbKleqPGMzhVQxG1Pwv09RzzqVekI9/BJ?=
 =?us-ascii?Q?YqWa63ufeV2wfG5k5wbTBapyjAjoOpOo9UOZaWB/l3ZmUrvoyEav9CIMu3D9?=
 =?us-ascii?Q?VSXa/uKzR56EBng+Iz/ewGsI920O8eGP/rA+9eV/qXAAXqfiSwZG4niZsP3W?=
 =?us-ascii?Q?gJzD96KW+u9F15TzrNyAGLwuCqud3aJEM2DyGNkWl7TI+lNqhioaxcWqClbM?=
 =?us-ascii?Q?BvYZzNfLSAAnorgGVf3NhHjwhaQkqInVYqOgXOk/lqdt8pdTjRtYSnChu++O?=
 =?us-ascii?Q?bZKQTO7nAldYYvGmjriy1ZYa/SiWlT3dsl99rev5EmfNa5izAHHjHR4a0y4h?=
 =?us-ascii?Q?ZN5H3L4P+YND4oi2DKRj9pNcwNzbx1yj19X8peqBMICSyLbIkoOkPJbafYlk?=
 =?us-ascii?Q?OcQT95+7WmfyUtU3zmW8pfvgWFLeC4OirTNjQazV/eq71Ve+h2X52Ero6wbz?=
 =?us-ascii?Q?zegEmf2oU2RL9Chi4O/gmF4hnZoGGjvDcrXEcirW2j1m2q1yrjXyynj+Pt7C?=
 =?us-ascii?Q?oNAGtCU0TkY2jHpdqo9WEsDcCZzbg183ojFNVCjQFO9L8mLsStD+DaUi+U8/?=
 =?us-ascii?Q?5tsIeIvrylffEPETu6dWebCKamcbfPg80hKe3ViGb5+aDbB6fYLDyjfORw0F?=
 =?us-ascii?Q?4VPDnFFY9dAcfc0CjU3owmDWqGy00ZLnG7YAJaAObroWq1ykrd99UsmApvCQ?=
 =?us-ascii?Q?AtpYXMqt+4AGG2VtSKMM/PUsRoz/EJSvuWg72c0mBbKjp7+u33990hTCcCLA?=
 =?us-ascii?Q?R9o24Eo4N8jmbfyiJ3r+AFxd6qah4CrVJyKD/8NxCQH5tQFrGKcgC37VFfuG?=
 =?us-ascii?Q?R3KvpO6/CtIxD0+GfJ6iQJScpd7t9RdGaNjsOE2YOk5XI/FNlY3115YCJh1y?=
 =?us-ascii?Q?KtcpHR+PCY/Lf7ulMGMIxrW6fp5hCv0xkgwl1GUT5wMsUIJPfS/N?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2c69ac-026f-49e9-47e3-08df25c230dc
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 05:00:08.4480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: baYgueqfoEg139uckKhfweMdzI63o1+V0txPK0HytRS+pcoyKUMZmvWX3PXjfgMtRCH378qOWqSwXmNcCBc3Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOP286MB4369

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
Changes in v5:
  - Simplify the implementation by:
    * reserving all read channels before configuring interrupt routing
    * dropping the redundant terminate and quiesce argument on release
    * requiring subrange mappings and collecting descriptors in one pass
    * using memset() to reset fields in epf_ntb_dma_bar_clear()
    * refreshing DMA BAR mappings on setup to handle host BAR
      reassignment
  - Drop redundant channel count checks. (Frank, in v3)
    Missed this in v4. See the v3 thread:
    https://lore.kernel.org/r/3tgny5jkxjw3foqgkohlgmw4lh4trv63swgdc3kvi7qxzpf222@avh4tiacqn2a/

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 510 +++++++++++++++++-
 1 file changed, 502 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index b6b3f1b7406d..9b376ab87225 100644
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
@@ -224,6 +273,346 @@ static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
 	return false;
 }
 
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
+	struct epf_ntb_dma_filter filter = {
+		.dev = dev,
+		.chan_id = chan_id,
+	};
+	dma_cap_mask_t mask;
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+	*dchan = dma_request_channel(mask, epf_ntb_dma_filter, &filter);
+
+	return *dchan ? 0 : -EBUSY;
+}
+
+static void epf_ntb_dw_edma_release_channels(struct epf_ntb_dma *dma)
+{
+	unsigned int i;
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
+	struct dw_edma_chan_config chan_config = {
+		.flags = DW_EDMA_CH_CONFIG_IRQ_MODE,
+		.irq_mode = DW_EDMA_CH_IRQ_REMOTE,
+	};
+	struct dma_slave_config config = {
+		.peripheral_config = &chan_config,
+		.peripheral_size = sizeof(chan_config),
+	};
+	enum pci_barno barno = ntb->epf_ntb_bar[BAR_DMA];
+	const struct pci_epc_features *features;
+	struct device *dma_dev;
+	unsigned int i;
+	size_t align;
+	u32 next = 0;
+	int ret;
+
+	if (ctrl->u.dma_ctrl.reg_layout_data != EDMA_MF_EDMA_UNROLL)
+		return -EOPNOTSUPP;
+
+	dma->rd_ch_cnt = ctrl->u.dma_ctrl.rc_to_ep_ch_cnt;
+
+	features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no,
+					ntb->epf->vfunc_no);
+	/* DWC descriptor memory always needs subrange mappings. */
+	if (!features || !features->subrange_mapping ||
+	    !features->dynamic_inbound_mapping)
+		return -EOPNOTSUPP;
+
+	align = features->align ?: 1;
+	if (!is_power_of_2(align))
+		return -EINVAL;
+
+	if (epf_ntb_is_bar_used(ntb, barno) ||
+	    pci_epc_get_next_free_bar(features, barno) != barno)
+		return -EINVAL;
+
+	dma->ctrl.magic = EPF_NTB_DMA_MAGIC;
+	dma->ctrl.revision = EPF_NTB_DMA_REVISION;
+	dma->ctrl.type = EPF_NTB_DMA_TYPE_DW_EDMA;
+	dma->ctrl.submap.bar = barno;
+	dma->ctrl.length = offsetof(struct epf_ntb_dma_ctrl,
+				    chan[dma->rd_ch_cnt]);
+
+	if (ctrl->bar == NO_BAR)
+		dma->reg_submap = &dma->submap[dma->num_submap];
+	ret = epf_ntb_dma_add_region(dma, ctrl, ctrl->phys_addr,
+				     barno, align, &next, &dma->ctrl.reg);
+	if (ret)
+		return ret;
+
+	/* DW eDMA static IDs place read channels after all write channels. */
+	for (i = 0; i < dma->rd_ch_cnt; i++) {
+		u16 chan_id = ctrl->u.dma_ctrl.ep_to_rc_ch_cnt + i;
+		struct epf_ntb_dma_chan_ctrl *chan = &dma->ctrl.chan[i];
+		const struct pci_epc_aux_resource *desc;
+		dma_addr_t dma_addr;
+
+		desc = epf_ntb_dw_edma_find_desc(resources, count, chan_id);
+		if (!desc)
+			return -EINVAL;
+		dma_addr = desc->u.dma_desc.dma_addr;
+
+		ret = epf_ntb_dma_add_region(dma, desc, dma_addr, barno,
+					     align, &next, &chan->desc);
+		if (ret)
+			return ret;
+		chan->desc_addr_lo = lower_32_bits(dma_addr);
+		chan->desc_addr_hi = upper_32_bits(dma_addr);
+	}
+	dma->ctrl.submap.size = next;
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
+	for (i = 0; i < dma->rd_ch_cnt; i++) {
+		ret = dmaengine_slave_config(dma->dchan[i], &config);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/* Common endpoint DMA */
+
+static void epf_ntb_dma_release_channels(struct epf_ntb_dma *dma)
+{
+	switch (dma->ctrl.type) {
+	case EPF_NTB_DMA_TYPE_DW_EDMA:
+		epf_ntb_dw_edma_release_channels(dma);
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
+		epf_ntb_dma_release_channels(dma);
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
+			epf_ntb_dma_release_channels(dma);
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
+static void epf_ntb_dma_release(struct epf_ntb *ntb)
+{
+	struct epf_ntb_dma *dma = ntb->dma;
+	struct device *dev;
+
+	if (!dma)
+		return;
+
+	epf_ntb_dma_release_channels(dma);
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
+	unsigned int old_num_submap;
+	struct pci_epf_bar *bar;
+	int restore, ret;
+
+	if (!dma)
+		return 0;
+
+	bar = &ntb->epf->bar[ntb->epf_ntb_bar[BAR_DMA]];
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
@@ -344,6 +733,11 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
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
@@ -470,9 +864,8 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
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
@@ -492,7 +885,9 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 	barno = ntb->epf_ntb_bar[BAR_CONFIG];
 	spad_count = ntb->spad_count;
 
-	ctrl_size = ALIGN(sizeof(struct epf_ntb_ctrl), sizeof(u32));
+	ctrl_size = ntb->dma ? sizeof(struct epf_ntb_ctrl) :
+			       offsetof(struct epf_ntb_ctrl, dma);
+	ctrl_size = ALIGN(ctrl_size, sizeof(u32));
 	spad_size = 2 * spad_count * sizeof(u32);
 
 	base = pci_epf_alloc_space(epf, ctrl_size + spad_size,
@@ -518,6 +913,9 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 		ntb->reg->db_offset[i] = 0;
 	}
 
+	if (ntb->dma)
+		ctrl->dma = ntb->dma->ctrl;
+
 	return 0;
 }
 
@@ -749,6 +1147,79 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 
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
+	if (!dma)
+		return;
+
+	barno = ntb->epf_ntb_bar[BAR_DMA];
+	bar = &ntb->epf->bar[barno];
+	if (!bar->size)
+		return;
+
+	pci_epc_clear_bar(ntb->epf->epc, ntb->epf->func_no,
+			  ntb->epf->vfunc_no, bar);
+	memset(bar, 0, sizeof(*bar));
+}
+
 /**
  * epf_ntb_db_bar_clear() - Clear doorbell BAR and free memory
  *   allocated in peer's outbound address space
@@ -888,7 +1359,8 @@ static int epf_ntb_find_bar(struct epf_ntb *ntb,
 		 * Verify if the BAR found is not already assigned
 		 * through the provided configuration
 		 */
-		if (!epf_ntb_is_bar_used(ntb, barno))
+		if (ntb->epf_ntb_bar[BAR_DMA] != barno &&
+		    !epf_ntb_is_bar_used(ntb, barno))
 			ntb->epf_ntb_bar[bar] = barno;
 
 		barno += 1;
@@ -987,11 +1459,19 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
 		goto err_mw_bar_init;
 	}
 
+	if (ntb->dma) {
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
 
@@ -1002,7 +1482,8 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
 
 	return 0;
 
-err_write_header:
+err_dma_bar_init:
+	epf_ntb_dma_bar_clear(ntb);
 	epf_ntb_mw_bar_clear(ntb, ntb->num_mws);
 err_mw_bar_init:
 	epf_ntb_db_bar_clear(ntb);
@@ -1025,6 +1506,7 @@ static void epf_ntb_epc_cleanup(struct epf_ntb *ntb)
 	disable_delayed_work_sync(&ntb->cmd_handler);
 	disable_work_sync(&ntb->peer_db_work);
 	atomic64_set(&ntb->peer_db_pending, 0);
+	epf_ntb_dma_bar_clear(ntb);
 	epf_ntb_mw_bar_clear(ntb, ntb->num_mws);
 	epf_ntb_db_bar_clear(ntb);
 	epf_ntb_config_sspad_bar_clear(ntb);
@@ -1231,10 +1713,13 @@ EPF_NTB_BAR_R(mw3_bar, BAR_MW3)
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
@@ -1253,6 +1738,7 @@ static struct configfs_attribute *epf_ntb_attrs[] = {
 	&epf_ntb_attr_spad_count,
 	&epf_ntb_attr_db_count,
 	&epf_ntb_attr_num_mws,
+	&epf_ntb_attr_dma_bar,
 	&epf_ntb_attr_mw1,
 	&epf_ntb_attr_mw2,
 	&epf_ntb_attr_mw3,
@@ -1791,6 +2277,12 @@ static int epf_ntb_bind(struct pci_epf *epf)
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
@@ -1827,6 +2319,7 @@ static int epf_ntb_bind(struct pci_epf *epf)
 	epf_ntb_epc_cleanup(ntb);
 err_bar_alloc:
 	epf_ntb_config_spad_bar_free(ntb);
+	epf_ntb_dma_release(ntb);
 
 	return ret;
 }
@@ -1858,6 +2351,7 @@ static void epf_ntb_unbind(struct pci_epf *epf)
 
 	epf_ntb_epc_cleanup(ntb);
 	epf_ntb_config_spad_bar_free(ntb);
+	epf_ntb_dma_release(ntb);
 }
 
 // EPF driver probe
-- 
2.51.0

