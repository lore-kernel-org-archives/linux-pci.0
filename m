Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020106.outbound.protection.outlook.com [52.101.228.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9374E43803F;
	Mon, 31 Aug 2026 18:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788200832; cv=fail; b=Ln7MzwNdglnFtWU/i+I731CtjQ6ULGc1Zip9bl3T9FKOie27pYqLU6ER5ZH1NP2ERbsmfpem28rX/1GgETPcPiKSoCU9S0vdmdI+wsOOv5SXNXhUyvgXbOrS4wyiNegUU5PkA69/sg7MUVESPddaO8ZY+EYpYPrMU2Z72Bu4JV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788200832; c=relaxed/simple;
	bh=Yijf+H2XRX/tl2KSwVkORH5VhPphsJfyOlS7oneNPxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uOugh1p1ZYPJrAp9bRWWfE+78z5J5PRBdD2fpcA3ai3+IuJOMoFH/ob/ZZ+p0QU9kKj80MqTbDolObeXQMhcQHC8PV3nsv/wXmIlmSVTXNEtHjybA2xStVy6NdUPvv89LudijTi0Bw4rZo8zkT2tObELw7n8EcbVbrlq1JNfg6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=KCh2UEfB; arc=fail smtp.client-ip=52.101.228.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="KCh2UEfB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M7INRxndmMwIJx6O3SPqktVaNKxx+g/zrGsgKOMT71Xr/z4eEvaSi2/GXeJN7xy1srQhl6QA5msXxmjds56dN+NPSc3uc0BgE1E6KoyaedSBWkQAEfi+jqxeAbNugcw6Nup8+MI8RyKzm74ev+IroNkl2z+Mj3LyOipqAhMFXfpCTW6W2LEtnDS0dUfb03e1fSdbQoJl1IFkub2J9g7RS5y18z7HBIQBjfXtp2VJ/743bHPvXzkH5LZmrS6fFUqT1PfUbJTxZYxNK4EGDAp5rnfkvJI5E7GpJxnONigm5lyoGkTMSbNKqK66nQMwGrwuI56IvSvhGVYjh6h5NN1JtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQAdZnDzhTzt92hDIdezkA+dsqizoVu7GHTFhRIKTTg=;
 b=RhRl3sicMCiFjTQCBWx3kYenO3czdYgCneCweuWn6dAxpGf5/fO3uGSfGe4FhQTFSLzulHCtsNvn3GGgFLybLgmL0JViJ0afM4wfkhe03IjyKNOnx+LciG8N6IxbSaSM6ezJOJ1XaW9JtOgibHa/2gXD2K62uHl/TftPJLoj0N2L/SQTH1wLtgpKPO8ZfDTCSdFicT67bv86jxopKRu0UvR/2cMyYG7oqUI6iG09sTBFdMm9seWxsWJn13+pDqDbkBSe5q8PGbLKrEWnfSbgWnoTyB6nMVY0fa2QJtNaywQrd/7tTD57eZV/2YUisgWUeZqldipJqT/yyLAbO6ajww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQAdZnDzhTzt92hDIdezkA+dsqizoVu7GHTFhRIKTTg=;
 b=KCh2UEfBAAYRf8sNmffyZ38PuCHDsMpzczqU7ZprC1iYCMlPeWXj0v/Z/le128nQ0cGwbmkn7AGyyddVNwN5rURNojAeFxzy/eXGJSXfbgjo0S0EZWmmytadIPAvP+OBdS0PlJxo1/yOYYsbBhjF/HpI4nhbqj/VfjLIyKTC9/g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB1802.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:11c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:27:04 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 18:27:04 +0000
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
Subject: [PATCH v3 5/7] PCI: endpoint: pci-epf-vntb: Allow DMA and MW to share a BAR
Date: Tue,  1 Sep 2026 03:26:55 +0900
Message-ID: <20260831182657.329614-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260831182657.329614-1-den@valinux.co.jp>
References: <20260831182657.329614-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0068.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB1802:EE_
X-MS-Office365-Filtering-Correlation-Id: 46c996d2-cb69-476d-79dc-08df078d74f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|1800799024|10070799003|366016|376014|22082099003|18002099003|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	V+e9CWrhRz2TAMlCCuzD5+mSOhWVhn3PCIIzBeINDYdwut52VWIyWIf5mHT82ZPoIRPhSbVap/wF0q3ZrYgabtsUwlLTgIjfiid1ykgGdcVlW4EStvNJfM3kpUPbg9ArRKRCLhHdDvlxJg9EUkbAbLwABKTw1b6ejXZ9AilchG1hzBqOC/nGVFCEnuhDQsQHPqty/w0YrlJsZbMyLHg7b3qXPilzF2Xmo7wG9YXvzKhtWHAGP3IgGo1VYW9IX7m2pLihoDaZgCOr0bnP/BUHc06ihQEe/rR5wPWrOMdXZlsfDjKKQH+cN/nYbjY8WJ/SnhnRngbFatjW54udDXJSyPn03x3/K5L5Hh3AspMPfmeJ39j0YUcwQoepG0cv3GR/pXV1Y2xQtV6LdJOHFP131DXIAzIeU1PYpk6rTR+3XZZufkGFQvBgnJCjgsN5KyVquqGVn6zKhBCiDJRV4P/WTtiFgNMlqU3sGFIo0pe6cXqBWm1t0ALjngEMph84moqLgcW2UGtbifJ/G04vKkKMyAnCAU9RPfMxZHa/ksL/Kf7bMJmEbZ+YV/uBbixhgKYGNdbsfSwNslUfpGRC/6DaJp6xb0af57qqLH8cQAgL4ADELx5o/2OsiAwv0m5u8wblwlwHSiVaYxAYWPFvsVBs0ovw0LiGwJpoxKvHMLdA0B4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(10070799003)(366016)(376014)(22082099003)(18002099003)(56012099006)(6133799003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8LrcX8ol7PLowe6L3DgtQVmAne1TlfdikxZzdZ+sC1ZMAXflro1GQWMqSE5b?=
 =?us-ascii?Q?q7YyKezLXUr/9LP9ACPhu7etWz8pRaxDNsjVsVGs19Xcnw4i0vsvSzwbVbgI?=
 =?us-ascii?Q?CiV6+Ugr3tVEwZy5NfEq9VKgm1wGa8Nt3ur4vxmuU3kL5YpCx5vzIxKbf3NV?=
 =?us-ascii?Q?Boigp53s+M0QaERQSLXnU94H1r75Jzp37gBasb5zLyDhrYi39pgliVgVLmPd?=
 =?us-ascii?Q?SMwTIiH2mW5BFxJqOuU2aTK/5GWnO7os54mk6jeRsU38sVgmmseN2jAckrae?=
 =?us-ascii?Q?JI1eFnJqFQ0CP/4X/1hD+vP0+dmszrftKJEfRuTAJF9BpheoebliJXQhNpfr?=
 =?us-ascii?Q?Nc0K+YZ8beqTGnqj0ePPvlISYmeRbjlmf7x7LdTmqa2vyGAhBDvsdDwBBQiT?=
 =?us-ascii?Q?/WJfbsWxSwl1S4UmGUymik8Lxlrl/XOU15xa1eTrFD/fBX3EbQ6mfznV8t6C?=
 =?us-ascii?Q?ZWrY03TaT8Byz5qW9Mj8pwGoc5XQxsPPOK20FJt9aWAaZzcaM1Ez//ZfklUW?=
 =?us-ascii?Q?POm78u5ZJQTNA6UjNp6cX68avvoZqCT57krOXydyqpLxpRVS4q1HyKf4NJ9y?=
 =?us-ascii?Q?i2C6PMd4vUX2yATCQcmvbGfStn3zGdvlsPOR4bSUwzOH6qjvy34pModUOi5n?=
 =?us-ascii?Q?2PnN74l6XJGFUhTQj612WsHI58W0xcZPHO5k/CpqddwJdlgzJWno4QCp+Nq4?=
 =?us-ascii?Q?kC2Siu91gyT5sSNix4m4+rAvPMwKN5aIzEmrw5Clr0BMM0eIe/jOpbnTktls?=
 =?us-ascii?Q?cxQYRh5CIZA0nXFgnMnIfFeqhOOi76RjHlZYudyRJijRJOdtpmKolV3Cb5rx?=
 =?us-ascii?Q?I/v7MlOVvjzm/0UwKKzzCoVT8S06tKlPNs0SpXpl0djqkDYLps40VAlr/+vU?=
 =?us-ascii?Q?Vm94YkMabZwCLU+tAHOzUTLZuqutPGOAkf8hrwR9c5eZCYx4VRZ/ZtBvlnE2?=
 =?us-ascii?Q?hiMByvTIkT4jjJn3QvndYcZ0dM278UkgyBTw2Ouv+8T0mARGCGUv2hAoYfB/?=
 =?us-ascii?Q?zGXxSwJ1LM39xcSjO5Ty3/n1g4JxulxrW07tH8uEc2rdL9uPlETpmw0QvgYv?=
 =?us-ascii?Q?3E7OktottUomBpipxUojDJyWUsAnHQcbLWZbArW0A1nMF4I/iFTo28wO22zk?=
 =?us-ascii?Q?jmP+d1FbIfgPMWm4mL/eAwkHD01qwZIqdZJY8M+ohY0yQb0Kw8Arkpr1ebhn?=
 =?us-ascii?Q?SaVRUigO4yaCtTP9FJGgHrNIdIy9cCVlI5uwcJtAuc3fKqeTODPf4VFEmI6o?=
 =?us-ascii?Q?IjdLFoNPW4RAHi+3CVWJxURWeGAT0zSnQrtpcjmrTBKSbL+1/mC/sXxSDQu7?=
 =?us-ascii?Q?gGmHVsaZXvdkzNbCL0zIw/QSIlp+uLTCsNAPjbmeWimGOZZa86o7a23M74ir?=
 =?us-ascii?Q?Xv+2A7aw3bUM+r3gehbl5bi0TFYmGGs/pWnOUd576VRhxcQKSNzpHw6csd1d?=
 =?us-ascii?Q?H0wGyXeF3mNN70tFVDI/zVDCdGp7Bk/5VbBbGfvRvlL+XR3rtjIMCSW6xylm?=
 =?us-ascii?Q?pEtM894chrktnmgIGzk+55uiqfqg2Xh6loau9N4Tt2DgC4IvUOhzqZgWL1nB?=
 =?us-ascii?Q?T5kKtSQztIUGGhP1axMJcajadLrs9ATasfIUkeeEZ8a1G3izFb7NlPGBAc7n?=
 =?us-ascii?Q?f6qiMB/myNtGbpIZwQK6eLEkd2F/Cf26v+/GZbvweTWYUwNmhA+ndqynzk+Q?=
 =?us-ascii?Q?eF57qRliLmIoChGe5Ov8rvIjTdf/e8aySGyZ38eJIk0mL8U0MZQc2p+P5XJ+?=
 =?us-ascii?Q?WrU1nW6VzwdzilYgX38vmzOnR1vqxI6WDxHNm/JuTQPkYSGJ0kor?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c996d2-cb69-476d-79dc-08df078d74f7
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:27:04.4563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f9jo9KtZBvtMY1NLH0NS/4lhwIAkusFSC6uv2Tu56/Bu42j/hWFxIa1xEDDoAm+MOJPAw109Ysm8o8PaMI2BWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1802

Some endpoint configurations have no spare BAR for DMA resources. Allow
dma_bar to select an MW BAR and place the DMA ranges after that MW.

BAR sharing requires ntb_hw_epf to parse the DMA extension, since older
versions treat the whole BAR as an MW.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - New patch split from the DMA export patch.
  - Set up a shared DMA BAR only once per bind. (Sashiko)
  - Preserve DMA submaps when updating a shared MW translation. (Sashiko)

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 133 +++++++++++++-----
 1 file changed, 94 insertions(+), 39 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 1842493c33b0..aa659ec62d93 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -44,6 +44,7 @@
 #include <linux/dmaengine.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/overflow.h>
 #include <linux/slab.h>
 
@@ -168,12 +169,13 @@ struct epf_ntb_ctrl {
 } __packed;
 
 struct epf_ntb_dma {
+	struct mutex lock; /* Serialize submap toggles and MW translation updates */
 	struct epf_ntb_dma_ctrl ctrl;
 	struct dma_chan *dchan[EDMA_MAX_RD_CH];
 	void *bar_scratch;
 	dma_addr_t bar_scratch_phys;
 	size_t bar_scratch_size;
-	struct pci_epf_bar_submap submap[EDMA_MAX_RD_CH + 2];
+	struct pci_epf_bar_submap submap[EDMA_MAX_RD_CH + 3];
 	struct pci_epf_bar_submap *reg_submap;
 	unsigned int num_submap;
 	u16 rd_ch_cnt;
@@ -269,18 +271,25 @@ static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
 	return false;
 }
 
-static int epf_ntb_dma_validate_bar(struct epf_ntb *ntb,
-				    const struct pci_epc_features *features)
+static u64 epf_ntb_dma_bar_offset(struct epf_ntb *ntb,
+				  enum pci_barno barno)
 {
-	enum pci_barno barno = ntb->epf_ntb_bar[BAR_DMA];
+	unsigned int i;
 
-	if (epf_ntb_is_bar_used(ntb, barno) ||
-	    pci_epc_get_next_free_bar(features, barno) != barno)
-		return -EINVAL;
+	for (i = 0; i < ntb->num_mws; i++)
+		if (ntb->epf_ntb_bar[BAR_MW1 + i] == barno)
+			return ntb->mws_size[i];
 
 	return 0;
 }
 
+static bool epf_ntb_dma_shares_bar(struct epf_ntb *ntb,
+				   enum pci_barno barno)
+{
+	return ntb->dma && ntb->dma->num_submap &&
+	       ntb->epf_ntb_bar[BAR_DMA] == barno;
+}
+
 struct epf_ntb_dma_filter {
 	struct device *dev;
 	int chan_id;
@@ -428,6 +437,7 @@ epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
 	enum pci_barno barno = ntb->epf_ntb_bar[BAR_DMA];
 	struct device *dma_dev;
 	bool needs_submap;
+	u64 offset;
 	unsigned int i;
 	size_t align;
 	u32 next = 0;
@@ -465,9 +475,24 @@ epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
 		if (!features->subrange_mapping ||
 		    !features->dynamic_inbound_mapping)
 			return -EOPNOTSUPP;
-		ret = epf_ntb_dma_validate_bar(ntb, features);
-		if (ret)
-			return ret;
+
+		offset = epf_ntb_dma_bar_offset(ntb, barno);
+		if (!offset &&
+		    (epf_ntb_is_bar_used(ntb, barno) ||
+		     pci_epc_get_next_free_bar(features, barno) != barno))
+			return -EINVAL;
+		if (offset > U32_MAX)
+			return -EOVERFLOW;
+		dma->ctrl.submap.offset = offset;
+		next = offset;
+		if (next) {
+			/*
+			 * submap[0] covers the fixed-size MW prefix. Leave its target
+			 * at zero until the MW translation is installed.
+			 */
+			dma->submap[0].size = next;
+			dma->num_submap = 1;
+		}
 	}
 
 	dma->ctrl.magic = EPF_NTB_DMA_MAGIC;
@@ -497,7 +522,7 @@ epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
 	}
 	if (dma->num_submap) {
 		dma->ctrl.submap.bar = barno;
-		dma->ctrl.submap.size = next;
+		dma->ctrl.submap.size = next - dma->ctrl.submap.offset;
 	}
 
 	dma_dev = ntb->epf->epc->dev.parent;
@@ -567,6 +592,8 @@ static int epf_ntb_dma_collect(struct epf_ntb *ntb)
 	if (!dma)
 		return -ENOMEM;
 
+	mutex_init(&dma->lock);
+
 	switch (ctrl->u.dma_ctrl.reg_layout) {
 	case PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA:
 		ret = epf_ntb_dw_edma_collect(ntb, dma, ctrl, resources, count);
@@ -621,17 +648,25 @@ static void epf_ntb_dma_release(struct epf_ntb *ntb, bool quiesce)
 	ntb->dma = NULL;
 }
 
-static int epf_ntb_dma_set_bar(struct epf_ntb *ntb, bool active)
+static int epf_ntb_dma_set_bar_locked(struct epf_ntb *ntb, bool active,
+				      const dma_addr_t *mw_addr)
 {
 	struct pci_epf_bar_submap *old_submap;
 	struct epf_ntb_dma *dma = ntb->dma;
 	struct pci_epf_bar *bar;
 	unsigned int old_num_submap;
+	dma_addr_t old_mw_addr;
 	int restore, ret;
 
+	lockdep_assert_held(&dma->lock);
+
 	bar = &ntb->epf->bar[ntb->epf_ntb_bar[BAR_DMA]];
 	old_submap = bar->submap;
 	old_num_submap = bar->num_submap;
+	if (mw_addr) {
+		old_mw_addr = dma->submap[0].phys_addr;
+		dma->submap[0].phys_addr = *mw_addr;
+	}
 	bar->submap = active ? dma->submap : NULL;
 	bar->num_submap = active ? dma->num_submap : 0;
 
@@ -641,13 +676,15 @@ static int epf_ntb_dma_set_bar(struct epf_ntb *ntb, bool active)
 		return 0;
 
 	/* A failed dynamic update may have already removed the old mapping. */
+	if (mw_addr)
+		dma->submap[0].phys_addr = old_mw_addr;
 	bar->submap = old_submap;
 	bar->num_submap = old_num_submap;
 	restore = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
 				  ntb->epf->vfunc_no, bar);
 	if (restore)
 		dev_warn(&ntb->epf->dev,
-			 "failed to restore DMA BAR mapping: %d\n", restore);
+			 "failed to restore DMA/MW BAR mapping: %d\n", restore);
 
 	return ret;
 }
@@ -660,11 +697,13 @@ static int epf_ntb_dma_set_active(struct epf_ntb *ntb, bool active)
 	if (!dma || !dma->num_submap)
 		return 0;
 
+	guard(mutex)(&dma->lock);
+
 	bar = &ntb->epf->bar[ntb->epf_ntb_bar[BAR_DMA]];
 	if (active == !!bar->num_submap)
 		return 0;
 
-	return epf_ntb_dma_set_bar(ntb, active);
+	return epf_ntb_dma_set_bar_locked(ntb, active, NULL);
 }
 
 /**
@@ -1214,7 +1253,7 @@ static int epf_ntb_dma_bar_init(struct epf_ntb *ntb)
 		return -EOPNOTSUPP;
 
 	barno = ntb->epf_ntb_bar[BAR_DMA];
-	mapped_size = dma->ctrl.submap.size;
+	mapped_size = dma->ctrl.submap.offset + dma->ctrl.submap.size;
 	/*
 	 * Submaps cannot be installed until the host assigns the BAR address.
 	 * Use address 0 for the temporary BAR Match Mode mapping, as is done
@@ -1312,6 +1351,7 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
  */
 static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 {
+	bool shared;
 	int ret = 0;
 	int i;
 	u64 size;
@@ -1321,22 +1361,25 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 	for (i = 0; i < ntb->num_mws; i++) {
 		size = ntb->mws_size[i];
 		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
-
-		ntb->epf->bar[barno].barno = barno;
-		ntb->epf->bar[barno].size = size;
-		ntb->epf->bar[barno].addr = NULL;
-		ntb->epf->bar[barno].phys_addr = 0;
-		ntb->epf->bar[barno].flags |= upper_32_bits(size) ?
-				PCI_BASE_ADDRESS_MEM_TYPE_64 :
-				PCI_BASE_ADDRESS_MEM_TYPE_32;
-
-		ret = pci_epc_set_bar(ntb->epf->epc,
-				      ntb->epf->func_no,
-				      ntb->epf->vfunc_no,
-				      &ntb->epf->bar[barno]);
-		if (ret) {
-			dev_err(dev, "MW set failed\n");
-			goto err_alloc_mem;
+		shared = epf_ntb_dma_shares_bar(ntb, barno);
+
+		if (!shared) {
+			ntb->epf->bar[barno].barno = barno;
+			ntb->epf->bar[barno].size = size;
+			ntb->epf->bar[barno].addr = NULL;
+			ntb->epf->bar[barno].phys_addr = 0;
+			ntb->epf->bar[barno].flags |= upper_32_bits(size) ?
+					PCI_BASE_ADDRESS_MEM_TYPE_64 :
+					PCI_BASE_ADDRESS_MEM_TYPE_32;
+
+			ret = pci_epc_set_bar(ntb->epf->epc,
+					      ntb->epf->func_no,
+					      ntb->epf->vfunc_no,
+					      &ntb->epf->bar[barno]);
+			if (ret) {
+				dev_err(dev, "MW set failed\n");
+				goto err_alloc_mem;
+			}
 		}
 
 		/* Allocate EPC outbound memory windows to vpci vntb device */
@@ -1353,10 +1396,11 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 	return ret;
 
 err_set_bar:
-	pci_epc_clear_bar(ntb->epf->epc,
-			  ntb->epf->func_no,
-			  ntb->epf->vfunc_no,
-			  &ntb->epf->bar[barno]);
+	if (!shared)
+		pci_epc_clear_bar(ntb->epf->epc,
+				  ntb->epf->func_no,
+				  ntb->epf->vfunc_no,
+				  &ntb->epf->bar[barno]);
 err_alloc_mem:
 	epf_ntb_mw_bar_clear(ntb, i);
 	return ret;
@@ -1374,10 +1418,11 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
 
 	for (i = 0; i < num_mws; i++) {
 		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
-		pci_epc_clear_bar(ntb->epf->epc,
-				  ntb->epf->func_no,
-				  ntb->epf->vfunc_no,
-				  &ntb->epf->bar[barno]);
+		if (!epf_ntb_dma_shares_bar(ntb, barno))
+			pci_epc_clear_bar(ntb->epf->epc,
+					  ntb->epf->func_no,
+					  ntb->epf->vfunc_no,
+					  &ntb->epf->bar[barno]);
 
 		pci_epc_mem_free_addr(ntb->epf->epc,
 				      ntb->vpci_mw_phy[i],
@@ -1974,6 +2019,16 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
 	dev = &ntb->ntb.dev;
 	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
 	epf_bar = &ntb->epf->bar[barno];
+	if (epf_ntb_dma_shares_bar(ntb, barno)) {
+		/* DMA submaps follow this MW, so its extent cannot be changed. */
+		if (size != ntb->mws_size[idx])
+			return -EINVAL;
+
+		guard(mutex)(&ntb->dma->lock);
+
+		return epf_ntb_dma_set_bar_locked(ntb, true, &addr);
+	}
+
 	epf_bar->phys_addr = addr;
 	epf_bar->barno = barno;
 	epf_bar->size = size;
-- 
2.51.0

