Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021078.outbound.protection.outlook.com [40.107.74.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703BF340A47;
	Fri, 17 Jul 2026 05:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784265008; cv=fail; b=hS/CGtNH36LGQ0lElsdONFDUGGcBnNHS9CkfYva+Wn5cTILloWz6fEC0NtX3zfSI6/fG1/MgOk+16zCHUQqz4N/ZBZH+hLzgTt3DDpi+zpsvcPC5nkg6AM36P63Kj/thY1yaW+VBPQaC03o193D0Lc1jxwCBz8yPi4TV684EQsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784265008; c=relaxed/simple;
	bh=jS964S53loneTorscv9UN5qkD/4/FZA8vP+71c67ccw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bj/M1HehUYEj2GvmfEIzB9yx5NlxXqDma5prBMaHcKfqmeSy+VibegiwiA17Kl5pqlJ5jFQRdbX/x4cILV1hx/fMJUViXPukm0pxNJLKw98fsKH8Yy+gqfQNusEy/UXgKlsdsXv6yL2CbifU1WT5UKosHPDoOr8g9mbBD6UOVY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=VFyATBNW; arc=fail smtp.client-ip=40.107.74.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="VFyATBNW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3ZJ54/vxevMalcfpX6Y82F/9pOVfdB1t0fOqtbD1+t9tEGpoGn+b5LHLx3SBQzHZB09y6O+X0qxG8RGHcvsSOSi72+/J5+1gXmOSENfvsl09mp4Yep/XyFaFZNa9b+WN3PeZ6IFvRwNNQP87WhCsztkzoHEurfRtgzbseg2UyXF78UBtvKxf+f2e3AQus/WdTNuPcPRG4zR2pHT2ZmLmzm9mHoFXic/2QPODUHtf37woT99is9ys1h6tKdKDMwXHPhQfF71zQyjeHkndUrH6kLA5mFYtMPFe2KWoL6mtXC+11QgWSFKSdHo5tXTULNmhh4mrcp4hkrrvEHPPD4KrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CF5g7XQKvZT9vnNLpgvxr2SFndL+9Huym30thE1wadg=;
 b=EthhCwVA+zBnzxWDyjWWPG+5Ak/wUcU+UFMVTW/lR4z6RVVIM6CXj9NvqGvrtAj5fSqDrsQOqGvYyF0ueTEnokWw0kinLkdxjXW5VJY5lo8DpJKlpjgVwLh/MbC4oyo6eIEbJ0ReBJ8PuW1y+GCu6v/LUx/+umFZrbrdgEVc5u39tmAuNw1X15mt0pajFNzEai3lPeafRWfyqtavI1JxpBKn7B3OJYB87AQlGc537v8m7gQBZlokWfRe+pGDARpZwatKL7v/3lw9qO8srnywXtL5plrhKoFqcyuOaIe7WpUrotglzsjRHG7CSOCD3L0sYufzc3ejirnh3Va4ErmjEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CF5g7XQKvZT9vnNLpgvxr2SFndL+9Huym30thE1wadg=;
 b=VFyATBNW7ey9ojV3rXK6BMXkWLl6q9bJaadpgyKrRuWUbdeZr7kCztZg/1hvgWtBwfOUKWWdCUrWQk5zCF6NVFbHHA1Tvtu3181p82WJawLwj6bwyzvCIaQGBaOSZUe0pQLBCk0ri+rcxfqH4yKcorrvyz9X28Wr+W8W3F4D8SI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSOP286MB7889.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:47a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Fri, 17 Jul
 2026 05:10:02 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0223.008; Fri, 17 Jul 2026
 05:10:02 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH v5 1/3] dmaengine: dw-edma-pcie: Discover endpoint DMA metadata
Date: Fri, 17 Jul 2026 14:09:51 +0900
Message-ID: <20260717050953.2145851-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260717050953.2145851-1-den@valinux.co.jp>
References: <20260717050953.2145851-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0143.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSOP286MB7889:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b103cd5-1f29-49b1-675a-08dee3c1a830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|10070799003|1800799024|376014|366016|23010399003|921020|22082099003|18002099003|10067099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	kCc+tAUZf/eAmRFPqZSOR3TMT8vXrRJCzYwZtCAfkRcQZmgLfpSEetGFpkv2rahx2yju/mlcIzpBPjPcRblJhaK/yiIos9Uo9bsoFemAEuGF5jEkWW6WuSnOyGS+VlEZszNIcVYilqOEZ4WEfEZuiG2pck3qUcRuyCbgnHbGFg6NZ35qCzCsuUL8SKr2VYuRL7V+A6WSeBRUNN45Yxzr8nrw/oU5HJQSoszGNUw/IQS/UD8MxSrfWkERitYX3tt7MH80vGFyZjo79qGLSuZcWy0vImXWrgsv6HWPUiTKaQ520zEKe3xUJnq71CaRq5kJEvls+aMQHNCVJE34mkd68/scvVFHslbwHFt8VlsX836vzjZfW1wjZ/9uX7P+pA9Rc246dQnzhbGh2KfPLseL67qIhIr3TdElnzWc2RKgNAEmE+8MWYw+gnrvDko1aeV5ryE0Z1GqZtLwV2GvzZDf9RMi9n06G3YfWqkaqVYfg8OdPOhXbW8aZKxZjYB1PpRp8Bp72WB9aotmtEzmqZT+4j7jxqS2TnvMttSQod+xWBrhJ24G31tMLocj7sM5dG/nwrMnBWZgz72P5SBZx133ORwMqxYGOE2q7bdffz2sUmgw2q9qppBlGMmSVCJEL03+20tWG0YKl6mWpYcJ5W+GoGbydCW94s4ZrZCKXUqOoVzzA2LbJC6GwS8ylJPlJm/41OW9AjJOizwH/dQrMqRuMA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(10070799003)(1800799024)(376014)(366016)(23010399003)(921020)(22082099003)(18002099003)(10067099003)(3023799007)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gcOr1aM9Frc1W2qsbJnSkTX9zvzjiPem/+NvR4TfFnj0CQ9tsvFizXEqo0bI?=
 =?us-ascii?Q?v7jDqVvTQvSISoLcb2K8/hXsu3b1+1oOBsjk4Wr+24AMA2WhLP2Xeikf5ktJ?=
 =?us-ascii?Q?AOJvFtSRjRI01Akux1sXmIFDenZWHr/CepuiDkD6pXn8q1qfnh12891e/TYC?=
 =?us-ascii?Q?PEWdoqjDqzj4aJ2PCv8l2CtR5uHYwlVLuH+wCZGTanH/Hp5/hmZRtKBxTY20?=
 =?us-ascii?Q?Dv4yLgNvrmDlkF5yFR64m9f6hLT4yymDW3UuIneXMvDGaXChjrXBKqV+Dbf4?=
 =?us-ascii?Q?YN+nPCpHtUwJiIsdl1l+lvIV3Ss9e4SobMWYupPmUKsjtllj448NJIk6GxML?=
 =?us-ascii?Q?bMznNkp5dEpf+Hol/LD6iXrE66JwYYeCW/YwFJ82wJdR7vbhPYLE9Lz/A/VT?=
 =?us-ascii?Q?91iOwV21y0PkjBj5v1u0qgqKR8DSChuThX3RB9v9goge5n0B1E28uCBP+lNf?=
 =?us-ascii?Q?pzes5GviI4/qN2bJuZcFvOeC20EOf06c9dl55rCsp3N8LZusK+dmShnobSOv?=
 =?us-ascii?Q?NO4Ndu5QQz3DmA14IOsjjp0vcgt4KOTIjcK8U3V6QKYJFm+/Wwakaryv8a8c?=
 =?us-ascii?Q?4Hz1gl9FeViwfPTZSoZl4ufi5m4QAqfBpm+mwwow7V9xgi59hQdywAVQb3Ga?=
 =?us-ascii?Q?mflieNygPcK9qe6l2BkyEte54Pui6l09XEyTyN2o1AQo3C20FEUKhWA6Nw1Z?=
 =?us-ascii?Q?kUfrEF4nzbZBBxnD7TS7ITnE/AizBrX6VqlsR60EsXaTNGNXAX32hML8Aq4o?=
 =?us-ascii?Q?Jo3GIQ2Lj63KqPpZ8y5mbApazgP2ClLkpybXQcr3zB2eIUkW/rVnU3GOAWRF?=
 =?us-ascii?Q?9u9nr0BOd7vvaW9UfUVi/pd574QZZeMxKmTqHZEPR2aIT6X3vXpPab257+gw?=
 =?us-ascii?Q?9u26L1oy+4NWfuJwhy5HGo0U9Tcdierqa2o2UxQBRNAB14ePT4PVx/1OHXw+?=
 =?us-ascii?Q?rc1B6D39YJ5dkuZTes2+pmyYefza3lPYpcueJnFQbuHuaUqmkbjKZSgFPra9?=
 =?us-ascii?Q?laxyPGLfTBQjG6m93bmj7uIt2UznmayZSprG4Y1dt4GTM1EZbMnL0sXr06SO?=
 =?us-ascii?Q?wZT/eULNXXOOmbUv8In7QacWx/pn0QfO25uTngts3+97hRyds+cTJJk9Sne9?=
 =?us-ascii?Q?GJjhqDX4T46gt70XOkZ4R8E+2lNCI/GkIi9lw6UYTz5WQn2dAo8ctYeAAxxm?=
 =?us-ascii?Q?FKKNX3XQ6gN4mWPgYCD/zsCnRDuHhDOJl3bfmTghTG5aFoJCUhT5rCuQcPTQ?=
 =?us-ascii?Q?Bgy779FllvOZCngp/7A2GpX0WZoMQWaX5UgwsBOSlqeZ1rYOonLaFLs45kP6?=
 =?us-ascii?Q?W2N00AFYB+YfH6tEJ/gLSj1QLKJuby+Scxr/HJ9UF7K2pFdwOPbqzNWlgAL4?=
 =?us-ascii?Q?sw4qbHsPup+2TMC/xuUjUSTmrpQ9xdmUFt23Kk02FRBBV0BKmPqKH0tExclQ?=
 =?us-ascii?Q?RXpjiRE3P4C3dXng/wFiZVqf+k+kamFZ/t6n4Y+1XpkpmG5LWHoH5+zU+tkJ?=
 =?us-ascii?Q?Z8gy8IjtZG6+FjOrUAdzFok9rcAXcqb2Z+mfY8OpBi3TwMTca0Jm2JI0V+Yr?=
 =?us-ascii?Q?l4FWLGhKGvJWmpWr2JfEYQQbw9AjxYoTZ0t6tSgCz9KZ3cPhfSDJ1xjhL7Lz?=
 =?us-ascii?Q?qTwlDBa8dcGTRaFWMLUPNPtITKdfTTw47aWWsJT4z1g4FHI/RtZu5sE+sN6k?=
 =?us-ascii?Q?wUnJYdVTB1WIEjOvwLEz+kXz5JQ4WRNYauN58GKRtuLQSzAByTxtJEkcR4mu?=
 =?us-ascii?Q?QHPr0eOHefheVaVax5MuiiJcJv+gMH3o9aAF1R7YI052XidJfQFB?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b103cd5-1f29-49b1-675a-08dee3c1a830
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 05:10:02.5360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tz5ewMwPJe8JZ7/QOrfJ4V6R8eqBgJkS6EhKAZfwQLV+1jkVEw43rfhLNth45gZncnhi5eDmGgIYTeppXOL8PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOP286MB7889

Teach dw-edma-pcie to discover a PCI endpoint DMA function from
BAR-resident metadata. The metadata supplies the DMA register window,
channel counts, descriptor windows, optional auxiliary windows, and
endpoint-local descriptor and auxiliary addresses. Accept DesignWare
eDMA unroll, HDMA compatible, and HDMA native linked-list layouts.

Endpoint-provided DMA channels use raw slave addresses because the host
programs transfers against endpoint physical addresses, not PCI BAR
addresses. The host-side dw-edma-pcie instance is remote-routed by
default, so delegated channels report completions through IMWr/MSI.

Endpoint DMA metadata currently has no static PCI ID. Let an explicit
driver_override bind use the generic endpoint DMA metadata parser, but
do not treat arbitrary dynamic IDs without driver data as endpoint DMA
devices.

The endpoint polls HOST_REQ at a low idle rate before programming DMA
window submaps and setting READY. Let the host wait for several endpoint
poll periods before treating the READY handshake as timed out.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v5:
  - Correct the HOST_REQ error-path description; the bit has been cleared
    on errors since v4.

 drivers/dma/dw-edma/dw-edma-pcie.c | 401 ++++++++++++++++++++++++++++-
 1 file changed, 399 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 07ea237577d5..fa80e0428287 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -11,9 +11,13 @@
 #include <linux/pci.h>
 #include <linux/device.h>
 #include <linux/dma/edma.h>
+#include <linux/iopoll.h>
 #include <linux/pci-epf.h>
 #include <linux/msi.h>
 #include <linux/bitfield.h>
+#include <linux/io.h>
+#include <linux/overflow.h>
+#include <linux/pci-ep-dma.h>
 #include <linux/sizes.h>
 
 #include "dw-edma-core.h"
@@ -45,6 +49,9 @@
 #define DW_PCIE_XILINX_MDB_DT_OFF_GAP		0x100000
 #define DW_PCIE_XILINX_MDB_DT_SIZE		0x800
 
+#define DW_PCIE_EP_DMA_READY_POLL_US		1000
+#define DW_PCIE_EP_DMA_READY_TIMEOUT_US		2000000
+
 #define DW_BLOCK(a, b, c) \
 	{ \
 		.bar = a, \
@@ -94,6 +101,12 @@ struct dw_edma_pcie_match_data {
 #define DW_EDMA_PCIE_F_DEVMEM_PHYS_OFF	BIT(0)
 #define DW_EDMA_PCIE_F_REG_OFFSET	BIT(1)
 
+struct dw_edma_pcie_ep_dma_view {
+	struct pci_dev *pdev;
+	void __iomem *base;
+	resource_size_t limit;
+};
+
 static const struct dw_edma_pcie_data snps_edda_data = {
 	/* eDMA registers location */
 	.rg.bar				= BAR_0,
@@ -158,6 +171,13 @@ static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
 	.rd_ch_cnt			= 8,
 };
 
+static const struct dw_edma_pcie_data ep_dma_data = {
+	.mf				= EDMA_MF_EDMA_UNROLL,
+	.irqs				= EDMA_MAX_WR_CH + EDMA_MAX_RD_CH,
+	.wr_ch_cnt			= EDMA_MAX_WR_CH,
+	.rd_ch_cnt			= EDMA_MAX_RD_CH,
+};
+
 static void dw_edma_set_chan_region_offset(struct dw_edma_pcie_data *pdata,
 					   enum pci_barno bar, off_t start_off,
 					   off_t ll_off_gap, size_t ll_size,
@@ -227,6 +247,96 @@ static const struct dw_edma_plat_ops dw_edma_pcie_plat_ops = {
 	.pci_address = dw_edma_pcie_address,
 };
 
+static const struct dw_edma_plat_ops dw_edma_pcie_raw_addr_plat_ops = {
+	.irq_vector = dw_edma_pcie_irq_vector,
+};
+
+static bool dw_edma_pcie_valid_bar(enum pci_barno bar)
+{
+	return bar >= BAR_0 && bar <= BAR_5;
+}
+
+static bool dw_edma_pcie_valid_bar_range(struct pci_dev *pdev,
+					 enum pci_barno bar, u64 off,
+					 size_t sz)
+{
+	resource_size_t bar_len;
+
+	if (!dw_edma_pcie_valid_bar(bar) || !sz)
+		return false;
+
+	bar_len = pci_resource_len(pdev, bar);
+
+	return off <= bar_len && sz <= bar_len - off;
+}
+
+static bool dw_edma_pcie_valid_block(struct pci_dev *pdev,
+				     const struct dw_edma_block *block)
+{
+	return dw_edma_pcie_valid_bar_range(pdev, block->bar, block->off,
+					    block->sz);
+}
+
+static bool dw_edma_pcie_ep_dma_bar_scannable(struct pci_dev *pdev,
+					      enum pci_barno bar)
+{
+	unsigned long flags = pci_resource_flags(pdev, bar);
+
+	if (!(flags & IORESOURCE_MEM))
+		return false;
+
+	if (flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED))
+		return false;
+
+	return pci_resource_len(pdev, bar) >= PCI_EP_DMA_METADATA_HDR_LEN;
+}
+
+static u32 dw_edma_pcie_ep_dma_readl(struct dw_edma_pcie_ep_dma_view *view,
+				     u16 off)
+{
+	return readl(view->base + off);
+}
+
+static void dw_edma_pcie_ep_dma_writel(struct dw_edma_pcie_ep_dma_view *view,
+				       u16 off, u32 val)
+{
+	writel(val, view->base + off);
+}
+
+static void
+dw_edma_pcie_ep_dma_clear_host_req(struct dw_edma_pcie_ep_dma_view *view)
+{
+	u32 ctrl;
+
+	ctrl = dw_edma_pcie_ep_dma_readl(view, PCI_EP_DMA_METADATA_CTRL);
+	ctrl &= ~PCI_EP_DMA_METADATA_CTRL_HOST_REQ;
+	dw_edma_pcie_ep_dma_writel(view, PCI_EP_DMA_METADATA_CTRL, ctrl);
+}
+
+static u64 dw_edma_pcie_ep_dma_read64(struct dw_edma_pcie_ep_dma_view *view,
+				      u16 lo, u16 hi)
+{
+	u64 val;
+
+	val = dw_edma_pcie_ep_dma_readl(view, hi);
+
+	return (val << 32) | dw_edma_pcie_ep_dma_readl(view, lo);
+}
+
+static int dw_edma_pcie_ep_dma_read_off(struct dw_edma_pcie_ep_dma_view *view,
+					u16 lo, u16 hi, off_t *off)
+{
+	u64 val;
+
+	val = dw_edma_pcie_ep_dma_read64(view, lo, hi);
+	if (val > type_max(*off))
+		return -EINVAL;
+
+	*off = val;
+
+	return 0;
+}
+
 static void dw_edma_pcie_get_synopsys_dma_data(struct pci_dev *pdev,
 					       struct dw_edma_pcie_data *pdata)
 {
@@ -328,6 +438,273 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
 	pdata->devmem_phys_off = off;
 }
 
+static int
+dw_edma_pcie_parse_ep_dma_ch_table(struct dw_edma_pcie_ep_dma_view *view,
+				   struct dw_edma_pcie_data *pdata,
+				   u16 table_off, u16 entry_size, u16 ch_cnt,
+				   bool write)
+{
+	struct dw_edma_block *desc_blocks = write ? pdata->ll_wr : pdata->ll_rd;
+	struct dw_edma_block *data_blocks = write ? pdata->dt_wr : pdata->dt_rd;
+	u32 ctrl;
+	u16 i;
+	int ret;
+
+	for (i = 0; i < ch_cnt; i++) {
+		struct dw_edma_block *desc_block = &desc_blocks[i];
+		struct dw_edma_block *data_block = &data_blocks[i];
+		u16 off = table_off + i * entry_size;
+		u16 field, lo, hi;
+
+		field = off + PCI_EP_DMA_METADATA_CH_CTRL;
+		ctrl = dw_edma_pcie_ep_dma_readl(view, field);
+		if (FIELD_GET(PCI_EP_DMA_METADATA_CH_CTRL_HW_CH, ctrl) != i)
+			return -EOPNOTSUPP;
+
+		desc_block->bar =
+			FIELD_GET(PCI_EP_DMA_METADATA_CH_CTRL_DESC_BAR, ctrl);
+		lo = off + PCI_EP_DMA_METADATA_CH_DESC_OFF_LO;
+		hi = off + PCI_EP_DMA_METADATA_CH_DESC_OFF_HI;
+		ret = dw_edma_pcie_ep_dma_read_off(view, lo, hi,
+						   &desc_block->off);
+		if (ret)
+			return ret;
+		field = off + PCI_EP_DMA_METADATA_CH_DESC_SIZE;
+		desc_block->sz = dw_edma_pcie_ep_dma_readl(view, field);
+		lo = off + PCI_EP_DMA_METADATA_CH_DESC_ADDR_LO;
+		hi = off + PCI_EP_DMA_METADATA_CH_DESC_ADDR_HI;
+		desc_block->paddr =
+			dw_edma_pcie_ep_dma_read64(view, lo, hi);
+		desc_block->paddr_valid = true;
+		if (!dw_edma_pcie_valid_block(view->pdev, desc_block))
+			return -EINVAL;
+
+		*data_block = (struct dw_edma_block) { .bar = NO_BAR };
+		if (!(ctrl & PCI_EP_DMA_METADATA_CH_CTRL_AUX_VALID))
+			continue;
+
+		data_block->bar =
+			FIELD_GET(PCI_EP_DMA_METADATA_CH_CTRL_AUX_BAR, ctrl);
+		lo = off + PCI_EP_DMA_METADATA_CH_AUX_OFF_LO;
+		hi = off + PCI_EP_DMA_METADATA_CH_AUX_OFF_HI;
+		ret = dw_edma_pcie_ep_dma_read_off(view, lo, hi,
+						   &data_block->off);
+		if (ret)
+			return ret;
+		field = off + PCI_EP_DMA_METADATA_CH_AUX_SIZE;
+		data_block->sz = dw_edma_pcie_ep_dma_readl(view, field);
+		lo = off + PCI_EP_DMA_METADATA_CH_AUX_ADDR_LO;
+		hi = off + PCI_EP_DMA_METADATA_CH_AUX_ADDR_HI;
+		data_block->paddr =
+			dw_edma_pcie_ep_dma_read64(view, lo, hi);
+		data_block->paddr_valid = true;
+		if (!dw_edma_pcie_valid_block(view->pdev, data_block))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int
+dw_edma_pcie_ep_dma_wait_ready(struct dw_edma_pcie_ep_dma_view *view)
+{
+	u32 val;
+
+	/*
+	 * The host cannot build a usable eDMA instance until the endpoint has
+	 * pinned and published the channel submaps, so keep the handshake
+	 * synchronous and bounded during probe.
+	 */
+	return read_poll_timeout(dw_edma_pcie_ep_dma_readl, val,
+				 val & PCI_EP_DMA_METADATA_CTRL_READY,
+				 DW_PCIE_EP_DMA_READY_POLL_US,
+				 DW_PCIE_EP_DMA_READY_TIMEOUT_US, false,
+				 view, PCI_EP_DMA_METADATA_CTRL);
+}
+
+static int
+dw_edma_pcie_validate_ep_dma_metadata(struct dw_edma_pcie_ep_dma_view *view,
+				      u32 *metadata_ctrl, u8 *reg_layout_data)
+{
+	size_t table_size, table_end;
+	enum pci_barno reg_bar;
+	u16 len, entry_size;
+	u16 wr_ch_cnt, rd_ch_cnt;
+	u8 layout, layout_data;
+	u32 val;
+
+	val = dw_edma_pcie_ep_dma_readl(view, 0);
+	if (val != PCI_EP_DMA_METADATA_MAGIC)
+		return -ENODEV;
+
+	val = dw_edma_pcie_ep_dma_readl(view, PCI_EP_DMA_METADATA_HDR);
+	if (FIELD_GET(PCI_EP_DMA_METADATA_HDR_REV, val) !=
+	    PCI_EP_DMA_METADATA_REV)
+		return -EINVAL;
+
+	len = FIELD_GET(PCI_EP_DMA_METADATA_HDR_LEN_FIELD, val);
+	if (len < PCI_EP_DMA_METADATA_HDR_LEN)
+		return -EINVAL;
+	if (len > view->limit)
+		return -EINVAL;
+
+	val = dw_edma_pcie_ep_dma_readl(view, PCI_EP_DMA_METADATA_REG_LAYOUT);
+	layout = FIELD_GET(PCI_EP_DMA_METADATA_REG_LAYOUT_ID, val);
+	if (layout != PCI_EP_DMA_METADATA_REG_LAYOUT_DW_EDMA)
+		return -EOPNOTSUPP;
+
+	layout_data = FIELD_GET(PCI_EP_DMA_METADATA_REG_LAYOUT_DATA, val);
+	if (layout_data == EDMA_MF_EDMA_LEGACY)
+		return -EOPNOTSUPP;
+	if (layout_data != EDMA_MF_EDMA_UNROLL &&
+	    layout_data != EDMA_MF_HDMA_COMPAT &&
+	    layout_data != EDMA_MF_HDMA_NATIVE)
+		return -EINVAL;
+
+	val = dw_edma_pcie_ep_dma_readl(view, PCI_EP_DMA_METADATA_CTRL);
+	reg_bar = FIELD_GET(PCI_EP_DMA_METADATA_CTRL_REG_BAR, val);
+	if (!dw_edma_pcie_valid_bar(reg_bar))
+		return -EINVAL;
+
+	wr_ch_cnt = FIELD_GET(PCI_EP_DMA_METADATA_CTRL_WR_CH_COUNT, val);
+	rd_ch_cnt = FIELD_GET(PCI_EP_DMA_METADATA_CTRL_RD_CH_COUNT, val);
+	if (!wr_ch_cnt && !rd_ch_cnt)
+		return -EINVAL;
+	if (wr_ch_cnt > EDMA_MAX_WR_CH || rd_ch_cnt > EDMA_MAX_RD_CH)
+		return -EINVAL;
+
+	entry_size = FIELD_GET(PCI_EP_DMA_METADATA_CTRL_CH_ENTRY_SIZE, val);
+	if (entry_size < PCI_EP_DMA_METADATA_CH_ENTRY_SIZE ||
+	    entry_size % sizeof(u32))
+		return -EINVAL;
+
+	if (check_mul_overflow((size_t)(wr_ch_cnt + rd_ch_cnt),
+			       (size_t)entry_size, &table_size) ||
+	    check_add_overflow((size_t)PCI_EP_DMA_METADATA_HDR_LEN,
+			       table_size, &table_end) ||
+	    table_end > len)
+		return -EINVAL;
+
+	if (metadata_ctrl)
+		*metadata_ctrl = val;
+	if (reg_layout_data)
+		*reg_layout_data = layout_data;
+
+	return 0;
+}
+
+static int
+dw_edma_pcie_parse_ep_dma_data(struct dw_edma_pcie_ep_dma_view *view,
+			       struct dw_edma_pcie_data *pdata)
+{
+	u32 ctrl, reg_sz;
+	u8 reg_layout_data;
+	u64 reg_off;
+	u16 wr_table, rd_table, entry_size;
+	u16 wr_ch_cnt, rd_ch_cnt;
+	int ret;
+
+	ret = dw_edma_pcie_validate_ep_dma_metadata(view, &ctrl,
+						    &reg_layout_data);
+	if (ret)
+		return ret;
+
+	pci_dbg(view->pdev, "Detected PCI endpoint DMA BAR metadata\n");
+
+	pdata->mf = reg_layout_data;
+	pdata->rg.bar = FIELD_GET(PCI_EP_DMA_METADATA_CTRL_REG_BAR, ctrl);
+
+	wr_ch_cnt = FIELD_GET(PCI_EP_DMA_METADATA_CTRL_WR_CH_COUNT, ctrl);
+	rd_ch_cnt = FIELD_GET(PCI_EP_DMA_METADATA_CTRL_RD_CH_COUNT, ctrl);
+	pdata->wr_ch_cnt = min_t(u16, pdata->wr_ch_cnt, wr_ch_cnt);
+	pdata->rd_ch_cnt = min_t(u16, pdata->rd_ch_cnt, rd_ch_cnt);
+	pdata->irqs = pdata->wr_ch_cnt + pdata->rd_ch_cnt;
+	reg_off = dw_edma_pcie_ep_dma_read64(view,
+					     PCI_EP_DMA_METADATA_REG_OFF_LO,
+					     PCI_EP_DMA_METADATA_REG_OFF_HI);
+	reg_sz = dw_edma_pcie_ep_dma_readl(view, PCI_EP_DMA_METADATA_REG_SIZE);
+	if (reg_off > type_max(pdata->rg.off) ||
+	    !dw_edma_pcie_valid_bar_range(view->pdev, pdata->rg.bar,
+					  reg_off, reg_sz))
+		return -EINVAL;
+	pdata->rg.off = reg_off;
+	pdata->rg.sz = reg_sz;
+
+	entry_size = FIELD_GET(PCI_EP_DMA_METADATA_CTRL_CH_ENTRY_SIZE, ctrl);
+	wr_table = PCI_EP_DMA_METADATA_HDR_LEN;
+	rd_table = PCI_EP_DMA_METADATA_HDR_LEN + wr_ch_cnt * entry_size;
+
+	ret = dw_edma_pcie_parse_ep_dma_ch_table(view, pdata, wr_table,
+						 entry_size, pdata->wr_ch_cnt,
+						 true);
+	if (ret)
+		return ret;
+
+	return dw_edma_pcie_parse_ep_dma_ch_table(view, pdata, rd_table,
+						  entry_size,
+						  pdata->rd_ch_cnt, false);
+}
+
+static int
+dw_edma_pcie_parse_ep_dma_caps(struct pci_dev *pdev,
+			       struct dw_edma_pcie_data *pdata)
+{
+	struct dw_edma_pcie_ep_dma_view metadata_view;
+	void __iomem *base;
+	resource_size_t bar_len;
+	enum pci_barno bar;
+	u32 ctrl;
+	int ret;
+
+	for (bar = BAR_0; bar < PCI_STD_NUM_BARS; bar++) {
+		if (!dw_edma_pcie_ep_dma_bar_scannable(pdev, bar))
+			continue;
+
+		bar_len = pci_resource_len(pdev, bar);
+		base = pci_iomap_range(pdev, bar, 0, 0);
+		if (!base)
+			continue;
+
+		metadata_view = (struct dw_edma_pcie_ep_dma_view) {
+			.pdev = pdev,
+			.base = base,
+			.limit = bar_len,
+		};
+		ret = dw_edma_pcie_validate_ep_dma_metadata(&metadata_view,
+							    NULL, NULL);
+		if (ret == -ENODEV) {
+			pci_iounmap(metadata_view.pdev, base);
+			continue;
+		}
+		if (ret) {
+			pci_iounmap(metadata_view.pdev, base);
+			return ret;
+		}
+
+		ctrl = dw_edma_pcie_ep_dma_readl(&metadata_view,
+						 PCI_EP_DMA_METADATA_CTRL);
+		ctrl |= PCI_EP_DMA_METADATA_CTRL_HOST_REQ;
+		dw_edma_pcie_ep_dma_writel(&metadata_view,
+					   PCI_EP_DMA_METADATA_CTRL, ctrl);
+
+		ret = dw_edma_pcie_ep_dma_wait_ready(&metadata_view);
+		if (ret) {
+			dw_edma_pcie_ep_dma_clear_host_req(&metadata_view);
+			pci_iounmap(metadata_view.pdev, base);
+			return ret;
+		}
+
+		ret = dw_edma_pcie_parse_ep_dma_data(&metadata_view, pdata);
+		if (ret)
+			dw_edma_pcie_ep_dma_clear_host_req(&metadata_view);
+		pci_iounmap(metadata_view.pdev, base);
+
+		return ret;
+	}
+
+	return -ENODEV;
+}
+
 static int
 dw_edma_pcie_parse_synopsys_caps(struct pci_dev *pdev,
 				 struct dw_edma_pcie_data *pdata)
@@ -367,6 +744,14 @@ dw_edma_pcie_parse_xilinx_caps(struct pci_dev *pdev,
 	return 0;
 }
 
+static const struct dw_edma_pcie_match_data ep_dma_match_data = {
+	.data = &ep_dma_data,
+	.plat_ops = &dw_edma_pcie_raw_addr_plat_ops,
+	.parse_caps = dw_edma_pcie_parse_ep_dma_caps,
+	.flags = DW_EDMA_PCIE_F_REG_OFFSET,
+	.chip_flags = DW_EDMA_CHIP_PARTIAL,
+};
+
 static u64 dw_edma_get_phys_addr(struct pci_dev *pdev,
 				 const struct dw_edma_pcie_match_data *match,
 				 struct dw_edma_pcie_data *pdata,
@@ -400,8 +785,17 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	int err, nr_irqs;
 	int i, mask;
 
-	if (!match)
-		return -ENODEV;
+	if (!match) {
+		/*
+		 * The endpoint DMA metadata path has no static PCI ID yet.
+		 * Accept it only for an explicit driver_override bind, not for
+		 * arbitrary dynamic IDs without driver data.
+		 */
+		if (!device_has_driver_override(&pdev->dev))
+			return -ENODEV;
+
+		match = &ep_dma_match_data;
+	}
 	pdata = match->data;
 
 	if (!pdata)
@@ -662,6 +1056,9 @@ static struct pci_driver dw_edma_pcie_driver = {
 	.id_table	= dw_edma_pcie_id_table,
 	.probe		= dw_edma_pcie_probe,
 	.remove		= dw_edma_pcie_remove,
+	.driver		= {
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
 };
 
 module_pci_driver(dw_edma_pcie_driver);
-- 
2.51.0

