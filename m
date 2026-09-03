Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020104.outbound.protection.outlook.com [52.101.229.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA8742902C;
	Thu,  3 Sep 2026 08:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423907; cv=fail; b=VccuxX6xCBnzPui1MFwh2eZx8ikX+pShgh4EegDxsw5gO1Eqs1bJZrGSzlzegpQsUGMdo7zbEWNlXZELGMb/OhNaOGzb8C+nJtRoutV9VroSQ4YooALLzzc+eKJCfeePxZslywlvTjhNKHUu8OTxTvFW1gAy7fevyAlwX2MGrsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423907; c=relaxed/simple;
	bh=SqBJVIeMqF6tNbiJvhOYRITczbGkKHYbIaktkMBbntE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ugSeja6XqCMsSEH3qs2fXKByrJ9EW9fWnIGiSlYobfbAUlqupPoP9RknCRIXdLfXGx1nSS3Xs9c+TzA1T4+2ORRuqodELIL/17FiLXDtDOumzpfpzK70KzyDAFyPk1jblHXbzLIZT2FVhYUKuExydwB75cXBBrkvNKKDA65GVHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=pxCLrYe3; arc=fail smtp.client-ip=52.101.229.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="pxCLrYe3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNadHu2QSPxRwouiOBSvPoL6/J1OGl+QiaFXP7+M4cL0CrM5uYpyTF27z4QbRhBSBDcTS7rI7sXJXRG4R4jl/coHg7trh/73c4LzhPFkroFnqBImdZs27rZbtsPpVsPYZVbQP06YRMJ2scYc7g8VjHpUepBrmeBs4BaiJJrJetK6wpFRNU/BTlOtRl0Vh0meZ5Tk0CsGRzj5UTEJpU2Qj3yVvQGyKBgy0BXMKnQ0uo6AmQ+C/7ta4IIHp3O6V36mRJwP+Fy6hqsreO3cUAtt+CwM7I2yPZAJojWKXwyClpbZPM1UgJiyAM9TsBZrpX45SbqcIrXGnr6qBZcv5KICWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5PWJg2Y2KiapKOcdXaSdA3Nd2YtYKPMfNCE2l6bcPQ=;
 b=TYI7vj4lc0N6+FqCyF1gFnV2xVePP8SgNSpwYc8lHDLPAimokx0SMrtcGyRxQP09c3KSAUuGq+LNCoXne6jX86yeXBQjFiUGK/TW5dUZZbGpc7YrV531p6oXRSEKBrvh/I2nyJ540UKMrcKWWLMRBcJlxgcTK9McBJnYLtmoox3j59QZj14MocIdixwDBgiDQu78quPPLFCl9zm6/3jPDYoPxmXba109MgXJjIHwHX3xlENWuY4mEDl4GGzoYwHYMFf/OpctipWFSRdcTX0tSLvTN0MSEtuTuK00amXZeGm5WA4krwF1fQ7XKwiYhoX4XcwWK3hLQWrdeFI0AXLRpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5PWJg2Y2KiapKOcdXaSdA3Nd2YtYKPMfNCE2l6bcPQ=;
 b=pxCLrYe3LpKKLxaRgIOIPID4QgDQZggvrTRimejuOLTxtuqAknkYbfnmjaq0f3PtBa7EOqFXAFA3m1hI/xr1BSPDVJa/yJQIMTrM/fD/L1zxcO4RhZ1WJJtJS0JXl4z6PzVg7Yo7CeOI7mr5NW4KHcSY/bIA6SIIfujIQUDpBOw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB6382.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:41c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 08:25:02 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 08:25:02 +0000
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
Subject: [PATCH v4 5/7] PCI: endpoint: pci-epf-vntb: Allow DMA and MW to share a BAR
Date: Thu,  3 Sep 2026 17:23:25 +0900
Message-ID: <20260903082327.2345602-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260903082327.2345602-1-den@valinux.co.jp>
References: <20260903082327.2345602-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0019.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: 4605d72f-f725-4435-05a6-08df0994d9c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|7416014|10070799003|366016|6133799003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	mqX26Rv51qiXYCH3f2WPp4Mi6KNWYHxHe1+l80i+gNm26EEBJ/5UUkxiomPP5FY1h9Y4lx5d3xpPbRzBphk2pDnsC3AsbSSPojBde9kkMo0w7jV5wxdkSfMGOyN26HU7I6AU+JQZ0sE5GhJDLgP5xoIgQYj+ZhZAsdFsBkjH+vcNHrJx04Kzh0V8e4nnEW3bUOnwGOnnPvOtKMd+jWNvtGWTrm9mQ4uEZU/yq9sKp2pihr4i5AYpshNRwAl7uCeNnse4krjIJXgEDy8FzR0SACekqqX1auobdi3oDAwZSMJUYSResZLKoMwkUMHXh7h7cWIiPyomcx3haoLfxD0MvnBFwksoK66ihMOOR6SgDCQW+w4aSFZN6Zt6iPeyocvo0z5RJVtWPJUXz52d7F8kwtpKyv4UvexFg0tvBv9xIefXbvDtieAJnTh3ezcTSXvU2JvJ/7U5Z2uHDS5NTEovqc6ieUrEmyvuSfHvU7nXF0U11UvtcjNR7CbIKk3o0PFu3krCn45Kc54EC24Zgx9rHLLbyn/LTfYW/vWat+MzdTYKwYlmeH/zRDOjbmVJoc8FXw+Rkg6Y8f8rWzj68aDpliQ52yJ9992dyXJPvVctGUoS3p94s9gK9qSyZyUd1LcxOtQ70qoRkZzHxIOaGmOkKlVTkiePoivUxOepO0Jz0nI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(7416014)(10070799003)(366016)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EibRHaQfY+nTxrecUduQ6RQchezLsER2AmVT95HHUw+Saq07NHt4nJ0u512M?=
 =?us-ascii?Q?WwucSIbbQFiVjFRo82shog6qIrctoRzbZXsullyPgziyl7Rm4AnSXiPb+k7V?=
 =?us-ascii?Q?DVlXAhbCaPn22BWTjVGZsNKOxYWSI+2EcsGEkz5ytiSsAtFUwaSIxf9FhddK?=
 =?us-ascii?Q?oDnm9B3AZFYH0GrgN1tROvF2FIzpfbigSfpo6HsCRq60q7eSRjCGLoWQbz2A?=
 =?us-ascii?Q?Ul11o4+Qo4/C8f1mN/1v84Ey780SQYpgHdFZxFx1FQVuCP+rdDYk8I6QA0l2?=
 =?us-ascii?Q?jdh7QsZj9/uGCflpCvZdvqndPKisBVJL8h3aeuRSemdlSlAEcSG1e72TxwPu?=
 =?us-ascii?Q?PdmAJtVf1XWh2UajY0g3ZUhP7kK6svMAG3Ssrk5alDvAB+/P3c5qOAnCWJks?=
 =?us-ascii?Q?uMKZB//z7mTydxNzSPHM3xuigY3UpDRWlbz7bEl30OPxDu5u6M8ifOa1pmi2?=
 =?us-ascii?Q?CwI2o8kOpm7FVkkpxVzBPclB5LJgaCWOkyaP/MNPnjSVvDUIk+CWya+BTQ/t?=
 =?us-ascii?Q?omPew71YqGfc1SRnpb7sMHx08UaztsOTVdlg3JmASEgLpsxjUCu36dIPdrVW?=
 =?us-ascii?Q?D7vIzEjJMpFPhJsKLw3RL1OxSaa71Y65UpAfVhC/qV6MaS3Fvq917OPEcaPJ?=
 =?us-ascii?Q?HMs4z/PvOoa23Xqhz0o+HJi41U1LHGAeFQ0dz4cwK36kdVwd4vBMZw9imByb?=
 =?us-ascii?Q?VK7v7N8Ne2OM/6eOdb7NCOaUQxe+QaB6Rakj7xuC4FSXm/FQ9/w8FhEDGjX+?=
 =?us-ascii?Q?rZLSpga3GNDsRQGeplSnH5Vlli6aoVzQQp/2L2MPIzo9gEivMZrUZpG33flF?=
 =?us-ascii?Q?z1a6hqUIgTUJlmbwbZ7wMmnDjqk0td+XTdZByQktTHAohex8pgPEO+E3ZWZJ?=
 =?us-ascii?Q?rxI2sPJYgo8pKKxwGesGJ5NQj9vLw6sv+ye7u/XxkPwKtwnXU4DhMzZTovgm?=
 =?us-ascii?Q?Ii847lAglphjcDCF2RYsLwNJXDUKoYgiqOMPe8lJVTYpIJWECcTbR30eJsPb?=
 =?us-ascii?Q?bSDGjvWcED18sD7vVngqg7esoKkNDZ7pnB+Wcb6QXrkqmPleqfsbdZ7amhWY?=
 =?us-ascii?Q?hBXF9SIbVxKSjzRuqItlXIbDbduFpwn69jSMK5Fjzhn1/1381fH3GdwqX7nR?=
 =?us-ascii?Q?ZrQHALDBIE+w7PElqEmg7bzoQQZ1uTpfU+EUpY2o350dtsF3L1gnyJDrciKy?=
 =?us-ascii?Q?6i3Z8mRP57ufaCldFpaqnAK/lt8FzCnSONoVUbKRw4sTqJ8poeCl193nMKEV?=
 =?us-ascii?Q?Al1JEptxJW3f0x45oVjY5exedSwc+fY2FgO4TlqLy7hWWq1LL+BefyVjif5L?=
 =?us-ascii?Q?pM4I/wuNKag2wCaH4M4lMQq1WZjuVgYyWW9NNws/NEIPhdYmZ2uJRr9+V+Yi?=
 =?us-ascii?Q?il7xpJxomwU8O7aTPIi3pHON38URBE2TJdAsMKvg1uD4G46ASLSDr3ilmLzI?=
 =?us-ascii?Q?sowDKgFxfh0Hm1PLw9A6qXb3S+QX8/M+cAYEBx/Tjj8vAzYB99qWjJkxXEED?=
 =?us-ascii?Q?yBS93xFP7A3bP4F1XyplfIuahcwJItQOhdCetdCFr3SvxNLP7mzZmybPm82x?=
 =?us-ascii?Q?X28J03gnt8V1dULTrwGE+y4wPWMUEMhuPDzu7ZEpTQurLFirmBtmoM8U9p+J?=
 =?us-ascii?Q?/50NcCCmALnSE9OqzTs+wH2KJ2vTiU6xkxYKk9zOEHLMpba8x8Gm1lx8olPA?=
 =?us-ascii?Q?Sh8VoJOoWyWvLFEAFIblgA1/tGJ/uE3Cc569RatDe6z5ghgNQPWFXuPXjzYH?=
 =?us-ascii?Q?a+nwXbLu8Tu/b60Dn1OrTfh8NiiS7hRbq5eyn33rhyP0JrZeIBVJ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4605d72f-f725-4435-05a6-08df0994d9c8
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 08:25:02.4664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p96K2zS/AAtf23wMsY+CYS22StjuxIAJDjJO+58Ji7H6jdYEGE6hXN1/kwO/vPp3iI/xctKTNN6lldR6OYjHEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6382

Some endpoint configurations have no spare BAR for DMA resources. Allow
dma_bar to select an MW BAR and place the DMA ranges after that MW.

DMA submaps have fixed BAR offsets, so a shared MW translation must cover
its configured size. Report the configured MW size as its size alignment
and require it to be a power of two.

BAR sharing requires ntb_hw_epf to parse the DMA extension, since older
versions treat the whole BAR as an MW.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - Keep the shared BAR mapping installed until EPF unbind. (Sashiko)
  - Advertise and validate the full-size shared MW translation.
  - Reject dma_bar values that overlap the control or doorbell BAR.

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 162 +++++++++++++-----
 1 file changed, 117 insertions(+), 45 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index ad34530642fc..e800a317f059 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -44,6 +44,7 @@
 #include <linux/dmaengine.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/overflow.h>
 #include <linux/slab.h>
 
@@ -167,12 +168,13 @@ struct epf_ntb_ctrl {
 } __packed;
 
 struct epf_ntb_dma {
+	struct mutex lock; /* Serialize DMA submap and MW updates */
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
@@ -273,18 +275,23 @@ static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
 	return false;
 }
 
-static int epf_ntb_dma_validate_bar(struct epf_ntb *ntb,
-				    const struct pci_epc_features *features)
+static u64 epf_ntb_dma_bar_offset(struct epf_ntb *ntb, enum pci_barno barno)
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
 
+static bool epf_ntb_dma_shares_bar(struct epf_ntb *ntb, enum pci_barno barno)
+{
+	return ntb->dma && ntb->dma->num_submap &&
+	       ntb->epf_ntb_bar[BAR_DMA] == barno;
+}
+
 struct epf_ntb_dma_filter {
 	struct device *dev;
 	int chan_id;
@@ -437,6 +444,7 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
 	unsigned int i;
 	size_t align;
 	u32 next = 0;
+	u64 offset;
 	int ret;
 
 	if (ctrl->u.dma_ctrl.reg_layout_data != EDMA_MF_EDMA_UNROLL)
@@ -471,9 +479,28 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
 		if (!features->subrange_mapping ||
 		    !features->dynamic_inbound_mapping)
 			return -EOPNOTSUPP;
-		ret = epf_ntb_dma_validate_bar(ntb, features);
-		if (ret)
-			return ret;
+		if (barno == ntb->epf_ntb_bar[BAR_CONFIG] ||
+		    barno == ntb->epf_ntb_bar[BAR_DB])
+			return -EINVAL;
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
+			 * submap[0] covers the MW prefix. Keep its temporary
+			 * target at address 0 until the MW translation is
+			 * installed.
+			 */
+			dma->submap[0].size = next;
+			dma->num_submap = 1;
+		}
 	}
 
 	dma->ctrl.magic = EPF_NTB_DMA_MAGIC;
@@ -502,7 +529,7 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
 	}
 	if (dma->num_submap) {
 		dma->ctrl.submap.bar = barno;
-		dma->ctrl.submap.size = next;
+		dma->ctrl.submap.size = next - dma->ctrl.submap.offset;
 	}
 
 	dma_dev = ntb->epf->epc->dev.parent;
@@ -572,6 +599,8 @@ static int epf_ntb_dma_collect(struct epf_ntb *ntb)
 	if (!dma)
 		return -ENOMEM;
 
+	mutex_init(&dma->lock);
+
 	switch (ctrl->u.dma_ctrl.reg_layout) {
 	case PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA:
 		ret = epf_ntb_dw_edma_collect(ntb, dma, ctrl, resources, count);
@@ -625,24 +654,28 @@ static void epf_ntb_dma_release(struct epf_ntb *ntb, bool quiesce)
 	ntb->dma = NULL;
 }
 
-static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
+static int epf_ntb_dma_set_bar_locked(struct epf_ntb *ntb,
+				      const dma_addr_t *mw_addr)
 {
 	struct pci_epf_bar_submap *old_submap;
 	struct epf_ntb_dma *dma = ntb->dma;
-	struct pci_epf_bar *bar;
 	unsigned int old_num_submap;
+	struct pci_epf_bar *bar;
+	dma_addr_t old_mw_addr;
 	int restore, ret;
-
-	if (!dma || !dma->num_submap)
-		return 0;
+	lockdep_assert_held(&dma->lock);
 
 	bar = &ntb->epf->bar[ntb->epf_ntb_bar[BAR_DMA]];
-	if (bar->submap == dma->submap &&
+	if (!mw_addr && bar->submap == dma->submap &&
 	    bar->num_submap == dma->num_submap)
 		return 0;
 
 	old_submap = bar->submap;
 	old_num_submap = bar->num_submap;
+	if (mw_addr) {
+		old_mw_addr = dma->submap[0].phys_addr;
+		dma->submap[0].phys_addr = *mw_addr;
+	}
 	bar->submap = dma->submap;
 	bar->num_submap = dma->num_submap;
 
@@ -652,17 +685,31 @@ static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
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
 
+static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
+{
+	struct epf_ntb_dma *dma = ntb->dma;
+
+	if (!dma || !dma->num_submap)
+		return 0;
+
+	guard(mutex)(&dma->lock);
+
+	return epf_ntb_dma_set_bar_locked(ntb, NULL);
+}
+
 /**
  * epf_ntb_configure_mw() - Configure the Outbound Address Space for VHOST
  *   to access the memory window of HOST
@@ -1205,6 +1252,7 @@ static int epf_ntb_dma_bar_init(struct epf_ntb *ntb)
 	struct pci_epf_bar *bar;
 	enum pci_barno barno;
 	size_t backing_size;
+	unsigned int i;
 	u32 mapped_size;
 	int ret;
 
@@ -1214,7 +1262,13 @@ static int epf_ntb_dma_bar_init(struct epf_ntb *ntb)
 		return -EOPNOTSUPP;
 
 	barno = ntb->epf_ntb_bar[BAR_DMA];
-	mapped_size = dma->ctrl.submap.size;
+	for (i = 0; i < ntb->num_mws; i++) {
+		if (ntb->epf_ntb_bar[BAR_MW1 + i] == barno &&
+		    !is_power_of_2(ntb->mws_size[i]))
+			return -EINVAL;
+	}
+
+	mapped_size = dma->ctrl.submap.offset + dma->ctrl.submap.size;
 	/*
 	 * Submaps cannot be installed until the host assigns the BAR address.
 	 * Use address 0 for the temporary BAR Match Mode mapping, as is done
@@ -1315,6 +1369,7 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
  */
 static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 {
+	bool shared;
 	int ret = 0;
 	int i;
 	u64 size;
@@ -1324,22 +1379,25 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
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
@@ -1356,10 +1414,11 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
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
@@ -1377,10 +1436,11 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
 
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
@@ -1982,6 +2042,16 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
 	dev = &ndev->dev;
 	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
 	epf_bar = &ntb->epf->bar[barno];
+	if (epf_ntb_dma_shares_bar(ntb, barno)) {
+		/* DMA submaps start after the configured MW size. */
+		if (size != ntb->mws_size[idx])
+			return -EINVAL;
+
+		guard(mutex)(&ntb->dma->lock);
+
+		return epf_ntb_dma_set_bar_locked(ntb, &addr);
+	}
+
 	epf_bar->phys_addr = addr;
 	epf_bar->barno = barno;
 	epf_bar->size = size;
@@ -2159,15 +2229,17 @@ static int vntb_epf_mw_get_align(struct ntb_dev *ndev, int pidx, int idx,
 			resource_size_t *size_max)
 {
 	struct epf_ntb *ntb = ntb_ndev(ndev);
+	enum pci_barno barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
+	u64 size = ntb->mws_size[idx];
 
 	if (addr_align)
 		*addr_align = SZ_4K;
 
 	if (size_align)
-		*size_align = 1;
+		*size_align = epf_ntb_dma_shares_bar(ntb, barno) ? size : 1;
 
 	if (size_max)
-		*size_max = ntb->mws_size[idx];
+		*size_max = size;
 
 	return 0;
 }
-- 
2.51.0

