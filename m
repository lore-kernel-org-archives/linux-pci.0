Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021141.outbound.protection.outlook.com [40.107.74.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF6D3921C8;
	Wed, 13 May 2026 02:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778640591; cv=fail; b=GivLOXXSGgHkTmAWz8blhgaQ8HypH6m4qfMUHZBmUGQ2jX2oLsQ7KPqusbJT0VZD7XoXcn/Wo9VoUgCnoYygaKPrPyOKHA0zSDBOT7D0Z/YaW0ODY0IY7BiKm0J2ILFsvz0NkMysePfr55AyCShOTpatTCBv6gzKEmCUk/EEdaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778640591; c=relaxed/simple;
	bh=WjglBI3JqJxcOzocy6RXnF9bDxb5alQnNzUEOZBFD64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aqH066Lj9YAi1ZVWbZzYqHHZJGUz9Eo0KwTXRN91p3jcyEZFKkhOy2Fxne2yDL1DvBTEKW8FSz0Hf8LgqtX8ineCJvNQFQJMESWH9XBsrXRF7r0TqofLwECoGLQtmzpM2cntzUHb2ngTlyQDpajUBx0Qq2NvHFdSa43mkK+qIhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=T4QgNunX; arc=fail smtp.client-ip=40.107.74.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="T4QgNunX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bmPBcgm0DSe7nAUSOYx7+hv0fxlGeU7q2+LA4ggSUnJ9mJ2a15lkF9lbXtczFFenCWVYKYVC1Ud+VlakDxrF1Xb/n1T+d1Xs2Om2zCG3+uUwcsZmsbuTdkk7MoPKiP2MnDpUlDr1Jlil2jeXDSCYMt8tGjlEm0TXxPSVa0hR+x4yglfI4fcvRZZlbXVvPbyQkeRY3Qyk6l2K/qTL9HcGfdIi+KXPzNcqpPDyiZR1bmqG4t0X+DCnWv54OT7eTPbbMyxB9zhpV7uVS0GFk9S3z4Q+wyDsae/1SazoLlzYmL6+MdcHYqrudb0W8+pORM86nKazMBpU0+viXjBJCWUuUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZptvUX83CzAg/Zs850886lNM+IoulXKUFrzZKBGkB6o=;
 b=Jl+y7M3c6t7q1I1aX1phWOnlSdM5LdUUMfVjyO1EXRtsLy+37KkHfMTCpKJ7wrxPPzGbPshDy6UhBhV1kwxECmrj3ARGDgF3ANU8znwYD82Z+hLKSa4ru7UNYejmCgqXmzQ/a8UWtqmXXg1YoBat0ebJqIO3Y9RjnXykdwRABt1lRFA7AsUVYNf0LVyX5jluDxRZBHCyncXbi4+EgBJMMwSmmjnZKPYcHbkQDEl1fve0xkTgoSYfSTa4qVCQGduZIgWYYidbgCAlfOVJ54K2kjeEv/v90WXZN2abfjXzqby2sGp4JP8uYoAAIaIqB0ZHpMuea+GZdL0uYiyhIqjssw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZptvUX83CzAg/Zs850886lNM+IoulXKUFrzZKBGkB6o=;
 b=T4QgNunXCkdYF8K6roVg5PNU1akTGBr1nlAqS3DdyV+E2uxKRkcbabS1mzictjs532uC1S0KOFiMrCP85fwmr83PQ8BgJOPRnCrHH0ADdScE+QnH2PwiJXIirQNshBtPmhL6gsByUdYJWGCkMr+d69A0HtotPJrlPDINaq3sEqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5341.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:191::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 02:49:35 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9846.025; Wed, 13 May 2026
 02:49:35 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v4 11/12] NTB: epf: Fix doorbell bitmask and IRQ vector handling
Date: Wed, 13 May 2026 11:49:22 +0900
Message-ID: <20260513024923.451765-12-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260513024923.451765-1-den@valinux.co.jp>
References: <20260513024923.451765-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0094.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5341:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d2a6755-ae9e-4adb-4dbf-08deb09a44b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	oWNEBasdmYLn5dLzajq3ll7R0U2//iNVkTQzrMtFSevmoB0jvd3a1OoJNggqVCK5wHSQgTqBGdK+s8djzgyJgr4yJCX0pkDzdFE1UI01hcCg7AVcRill+RLxI78FVGe96ylJ+GFjEvaVgzNbouUZ4a8hsCJJiFmNf3s/jmUlnGtkf8tt2IyR3E6o4Fgw/wYmKLHjEpiMTLUeyEYh+9UGEuMsEq7m8oyHen4jBvlqoWx4cgZRlc6sEAohykFM1zJ86nd16q6e0VIP6mRs9eI0LAdt4Umlqc6sIDeLop++mV1w1baQpWAZYi2U980wT8cVl/Pmx6HI+oETplL8z2zPZTYGZH14frHyceQcBDU8p98uC/it5mpbhLFdfuoOK5wIpyBSbYCkAS5rrhTL27AHY8oAQ6ngdyXaI7KebJUQjP7w7zCoNgJsMxK1Z+8ofhLKhVFAtkoEynySecKXzpNTuS3RvvVV903w+UPkWHW/fvug5TOfON7d9KaMZ0Nam3H2Mvb/xf8BDEJc5caqqR9q04rl0LC98O7pan6wWTCI5FqhEEcsEDpDFCN7xLzoL2ZCIpS2UaEYgwlfw08Cjkk9Yrm+CSHkO0X9diyVukwYlhbLzELicEChpl05HX7D6ayPsNZrqP9e9YULo3Gei9ZFmwE7f9HTcKFPyojxv5ZT8G+MoJzGYhOzVcWPovq5MKXNc2yApFF2DycQoILcErwi4oB3rAF6DQ20XdwU3Z5xJ8w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a0fd+p5GGHN5ch7WBbFfabsCqVXd/Mx5efdS3TBAfIBpsfT3KQ+JcYxm8JmD?=
 =?us-ascii?Q?AOK4pgOPAmO+uU0GJiAhucX8niC8l27mq38SmTk3AwZWDM4W1sBdp/OMEM//?=
 =?us-ascii?Q?o7YYf9SF1rIv4ub7hbLF3m5SOV/mK0lAisoa2gHb2ZtGu8g2YCLXaG+M0REs?=
 =?us-ascii?Q?EP5eLhwKmL4/2b6Tr/ERUUokiVk70QL4dyUhVxl6FoYaRyNPL2Wf1A/okcty?=
 =?us-ascii?Q?aStlUB45nYjsTG7Hk603yTGXAA+ECVdh1rmQJOrRgulQ0fKZsOkUKgZMGyn4?=
 =?us-ascii?Q?bMweeY/Rc58TKPhOBsyABGYOS3iV/Q8ohSA1UsdI5AviMQM1biCluXJMt8HK?=
 =?us-ascii?Q?DWR7FvxztR2TDp1Vzhs1KPA2LyJLk3Q4kLiaiuHCBpc6yePaqsRcd2sQ89mD?=
 =?us-ascii?Q?O8umZDYazeAMduzYWBSWsldYN/iZfiAt5kx2Lyhu/qCPQzZZDedB5eEP9jqg?=
 =?us-ascii?Q?/fXXsh8yoWDEkbQ+UN4aI/kc/skkRTB8AHG+AQRtFUEr4rcphPy6R5Y8eVbs?=
 =?us-ascii?Q?NKFWVYJz1myFGWcxk73ukDfqyKkDAsKv2fCTi9taMgdzhtcTN68ruDSE8VBQ?=
 =?us-ascii?Q?Fo0xkNBoUUHIgQQZGt9LPTNkmWi8YThSfcIZEDF0SAyhcyIvKntDbibhF/r0?=
 =?us-ascii?Q?WYrtggRVPk4FFPwKixbzojvlTJwrKy/aZMO/7b4FbSC1EblYcRuytiwi6Qk+?=
 =?us-ascii?Q?Ko+Yrl9up1NOsh8pgzWXaB0Oszok0acTGUFJn9m9TknNcEkNh0PBxyRpwZNy?=
 =?us-ascii?Q?nz1FFCoal+0s1ExbEKj+oqz3kGHbmohnfVXyiwbZVCana0oV58q0+1PAOAjG?=
 =?us-ascii?Q?4AEzbW4RaO/Zo+0AjDEsHhST057AcgtYjn4U7CCl/DYCLhsHPDit7DDf+sCO?=
 =?us-ascii?Q?H2Qx4JYzd1dkBxll/dLNLdJdagjD+5TyxMsMsOGN1uwzbcfSQxLF620ie1Pn?=
 =?us-ascii?Q?ZbZ/qG892ZklE+hSVUsoLOQGh9UwoR87ZKVv/wkrG7nMSIPb5BGzva6pq+yS?=
 =?us-ascii?Q?n2QqlF5kxV9bmlHKZ1dyn5wYh+c0mQfYhY6aZ47eEs/NyK37n0YV1vgJwcWC?=
 =?us-ascii?Q?Q3K+57lPC51MOXzRNKkRtfkTaAazug8Ffw00FZQ9WWD07UySqyo39FOU3qID?=
 =?us-ascii?Q?nRciqNBpTkiYIvJ+Z5eYRdxDRwiMDyKQc1/7bFmi0b8Z7i5fi8MBAqY8r2ad?=
 =?us-ascii?Q?hlnwz+NRR8lsVfSXLnN3WIBTHcdf5Ubde/osSL/L0yZZYo0qNYOzC+hFonA2?=
 =?us-ascii?Q?y5PC5iGUEN1B3XXkBVyD3AqbyxUKvkVIxxR2RFfnSQpKwB/BVGNHOFuTYMgm?=
 =?us-ascii?Q?yX5Qh9PRys83xKg+tp2fqsR342IN5boJkWfx/Y20WdclaeUq810cQDeC4MGB?=
 =?us-ascii?Q?SwgacB/1jx3bsJm7i8vbV1TmQFktWghMPu/2tO7kWDHGH2Eyi1JRCBo0jdIW?=
 =?us-ascii?Q?PDm12VuRWl6DXLM8/CV1ADXCHVnjvDVgytDdaDjYnd7vWRztNMf1NKjMmix7?=
 =?us-ascii?Q?oPO+DknYhpHxL1nm7o1lZPTrhb2Q4IrY60aAIYJedJvjC47IWMExSe8Bakso?=
 =?us-ascii?Q?4bB2sFOrc4SwsJTfnqx70uu9WlCwwqtLzp8u4WZpk8ifdLqq7TIVbyy1n3UE?=
 =?us-ascii?Q?khXCmoDKEqvJJr5rodhNbdpZNa2PbR3opzhGyiY1t1RhAkPC3nxozYVw2KeT?=
 =?us-ascii?Q?1/R8yijuAmVsn1AvxKxHYhgi9WNz77iiwOOH449AV6tDy/IhDzfLc2WGrq1t?=
 =?us-ascii?Q?3yfGRQu+7umIKHklwE1OdufMy77IKwJ5wgiVM+oWM+3K/EM4mNB1?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2a6755-ae9e-4adb-4dbf-08deb09a44b8
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 02:49:35.8206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5vBgcb6+vxFZWuAZBcfZQF4ifQ/KlaNS5NOwe7kR+sD1huS9zvSj10avHSklH9ViNijmth0sfBuyX1eHJ2SHAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5341

The EPF driver currently stores the incoming doorbell as a vector number
(irq_no + 1) in db_val and db_clear() clears all bits unconditionally.
This breaks db_read()/db_clear() semantics when multiple doorbells are
used.

Store doorbells as a bitmask (BIT_ULL(vector)) and make
db_clear(db_bits) clear only the specified bits. Use atomic64 operations
as db_val is updated from interrupt context.

Once db_val is stored as a bitmask, the ISR's doorbell vector is used
not only for ntb_db_event(), but also as the bit index for BIT_ULL().
The existing ISR derives that vector by subtracting pci_irq_vector(pdev,
0) from the Linux IRQ number passed to the handler, but Linux IRQ
numbers are not guaranteed to be contiguous.

Pass per-vector context as request_irq() dev_id instead, so the ISR gets
the device vector directly.

Validate the doorbell vector before updating db_val or calling
ntb_db_event(), so an unexpected vector cannot create an invalid shift
or be reported to NTB clients.

While at it, read and validate mw_count before requesting interrupt
vectors. An unsupported memory-window count does not need IRQs, and
failing before ntb_epf_init_isr() keeps the probe error path simple.

Fixes: 812ce2f8d14e ("NTB: Add support for EPF PCI Non-Transparent Bridge")
Suggested-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v3:
  - Stop deriving the device vector from Linux IRQ numbers; pass
    per-vector request_irq() context instead.
  - Validate the doorbell vector before BIT_ULL() and ntb_db_event().
  - Check mw_count before requesting IRQs.
  - Drop a Reviewed-by tag due to the large changes.

 drivers/ntb/hw/epf/ntb_hw_epf.c | 61 +++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 22 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index 7b0fc7ef00c6..10618e462229 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -6,6 +6,7 @@
  * Author: Kishon Vijay Abraham I <kishon@ti.com>
  */
 
+#include <linux/atomic.h>
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -89,6 +90,13 @@ enum epf_irq_slot {
 
 #define NTB_EPF_MAX_MW_COUNT	(NTB_BAR_NUM - BAR_MW1)
 
+struct ntb_epf_dev;
+
+struct ntb_epf_irq_ctx {
+	struct ntb_epf_dev *ndev;
+	unsigned int irq_no;
+};
+
 struct ntb_epf_dev {
 	struct ntb_dev ntb;
 	struct device *dev;
@@ -108,9 +116,9 @@ struct ntb_epf_dev {
 	unsigned int self_spad;
 	unsigned int peer_spad;
 
-	int db_val;
+	atomic64_t db_val;
 	u64 db_valid_mask;
-	int irq_base;
+	struct ntb_epf_irq_ctx irq_ctx[NTB_EPF_MAX_DB_COUNT + 1];
 };
 
 #define ntb_ndev(__ntb) container_of(__ntb, struct ntb_epf_dev, ntb)
@@ -334,11 +342,10 @@ static int ntb_epf_link_disable(struct ntb_dev *ntb)
 
 static irqreturn_t ntb_epf_vec_isr(int irq, void *dev)
 {
-	struct ntb_epf_dev *ndev = dev;
-	int irq_no;
-
-	irq_no = irq - ndev->irq_base;
-	ndev->db_val = irq_no + 1;
+	struct ntb_epf_irq_ctx *ctx = dev;
+	struct ntb_epf_dev *ndev = ctx->ndev;
+	unsigned int db_vector;
+	unsigned int irq_no = ctx->irq_no;
 
 	if (irq_no == EPF_IRQ_LINK) {
 		ntb_link_event(&ndev->ntb);
@@ -346,7 +353,17 @@ static irqreturn_t ntb_epf_vec_isr(int irq, void *dev)
 		dev_warn_ratelimited(ndev->dev,
 				     "Unexpected reserved doorbell slot IRQ received\n");
 	} else {
-		ntb_db_event(&ndev->ntb, irq_no - EPF_IRQ_DB_START);
+		db_vector = irq_no - EPF_IRQ_DB_START;
+		if (ndev->db_count < NTB_EPF_MIN_DB_COUNT ||
+		    db_vector >= ndev->db_count - 1) {
+			dev_warn_ratelimited(ndev->dev,
+					     "Unexpected doorbell vector %u (db_count %u)\n",
+					     db_vector, ndev->db_count);
+			return IRQ_HANDLED;
+		}
+
+		atomic64_or(BIT_ULL(db_vector), &ndev->db_val);
+		ntb_db_event(&ndev->ntb, db_vector);
 	}
 
 	return IRQ_HANDLED;
@@ -373,18 +390,18 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
 		argument &= ~MSIX_ENABLE;
 	}
 
-	ndev->irq_base = pci_irq_vector(pdev, 0);
+	ndev->db_count = irq - 1;
 	for (i = 0; i < irq; i++) {
+		ndev->irq_ctx[i].ndev = ndev;
+		ndev->irq_ctx[i].irq_no = i;
 		ret = request_irq(pci_irq_vector(pdev, i), ntb_epf_vec_isr,
-				  0, "ntb_epf", ndev);
+				  0, "ntb_epf", &ndev->irq_ctx[i]);
 		if (ret) {
 			dev_err(dev, "Failed to request irq\n");
 			goto err_free_irq;
 		}
 	}
 
-	ndev->db_count = irq - 1;
-
 	ret = ntb_epf_send_command(ndev, CMD_CONFIGURE_DOORBELL,
 				   argument | irq);
 	if (ret) {
@@ -396,7 +413,7 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
 
 err_free_irq:
 	while (i--)
-		free_irq(pci_irq_vector(pdev, i), ndev);
+		free_irq(pci_irq_vector(pdev, i), &ndev->irq_ctx[i]);
 	pci_free_irq_vectors(pdev);
 
 	return ret;
@@ -529,7 +546,7 @@ static u64 ntb_epf_db_read(struct ntb_dev *ntb)
 {
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
 
-	return ndev->db_val;
+	return atomic64_read(&ndev->db_val);
 }
 
 static int ntb_epf_db_clear_mask(struct ntb_dev *ntb, u64 db_bits)
@@ -541,7 +558,7 @@ static int ntb_epf_db_clear(struct ntb_dev *ntb, u64 db_bits)
 {
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
 
-	ndev->db_val = 0;
+	atomic64_and(~db_bits, &ndev->db_val);
 
 	return 0;
 }
@@ -582,6 +599,12 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
 	struct device *dev = ndev->dev;
 	int ret;
 
+	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_MW_COUNT);
+	if (ndev->mw_count > NTB_EPF_MAX_MW_COUNT) {
+		dev_err(dev, "Unsupported MW count: %u\n", ndev->mw_count);
+		return -EINVAL;
+	}
+
 	/* One Link interrupt and rest doorbell interrupt */
 	ret = ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + 1,
 			       NTB_EPF_MAX_DB_COUNT + 1);
@@ -595,14 +618,8 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
 	 * doorbell layout, hence -1.
 	 */
 	ndev->db_valid_mask = BIT_ULL(ndev->db_count - 1) - 1;
-	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_MW_COUNT);
 	ndev->spad_count = readl(ndev->ctrl_reg + NTB_EPF_SPAD_COUNT);
 
-	if (ndev->mw_count > NTB_EPF_MAX_MW_COUNT) {
-		dev_err(dev, "Unsupported MW count: %u\n", ndev->mw_count);
-		return -EINVAL;
-	}
-
 	return 0;
 }
 
@@ -696,7 +713,7 @@ static void ntb_epf_cleanup_isr(struct ntb_epf_dev *ndev)
 	ntb_epf_send_command(ndev, CMD_TEARDOWN_DOORBELL, ndev->db_count + 1);
 
 	for (i = 0; i < ndev->db_count + 1; i++)
-		free_irq(pci_irq_vector(pdev, i), ndev);
+		free_irq(pci_irq_vector(pdev, i), &ndev->irq_ctx[i]);
 	pci_free_irq_vectors(pdev);
 }
 
-- 
2.51.0

