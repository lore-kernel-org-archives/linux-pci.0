Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020085.outbound.protection.outlook.com [52.101.229.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C97E42BC56;
	Mon,  3 Aug 2026 18:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785780296; cv=fail; b=PIbK9CTP61mCd1lB3mxeI033k3GzeuMGtM4TSQdFPQAQUBGsssAxd+MNuHheyIx2pFpN5aPjiUR8e4j60iHJ8QvFGLubUqAFZe3ZngKpYoI5dBh8Ut0mOln5dyrgxBLBU9lgryWJnWD6OPFtAqnSSlEvsB8zxWx+1vzpP/GKoP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785780296; c=relaxed/simple;
	bh=fI/uHiWdrGexD16Dqz9pP2PIrxXXLeXAyQkMpLvSPVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NmtttnIVy5mh8h/nFPYSzaDcw3K5lNvD5VNr0T9QtSZtZg4c9D+HRuU3DXKaHV15OtwFhwKaJ5pF4TJ5tcfLMfkHBSGIqKankCUxMcgLqTP3zAwbXzDHFThwG0nhFvXzhpTeZZhXHu/m+9lknkL9+XWSPgzxzRjZ8b8gqAnWmFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=G49B3DNz; arc=fail smtp.client-ip=52.101.229.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="G49B3DNz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qa5thHgypz6LT73F8FWUH4tNSjcuqWqHX3Dl7scb3p2TT0ZCtDZ+WRMN0RxuBEnr324+WeCgZYthOakX/Z/73Wy4KnEBUlkpsyPHOEWWzBqxaR5XvZvgwuKbt89H1Xoh8qJb06EnhNJJsmteoGebjmepBsZLJftef8wMkylqV9QK4es3QysVeMUSt+jqM0jfbYvxuxtVVKsfp472IFaZ23qt/G8bJVFawMoYydSlmMGw0ug/gwgwOUV7Rq065LKYn+a8G0zckhHe4CxXFGzJBByt0KbAcmd0hNdrnALYjOzO26Zr2PP1+qd195/iPAbJwV1JCYwlZhFiT7rrtE/oYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpPn3KZ3bT/bK/LFfrptJSoP+/Jl5WPlvawKS7SKFyg=;
 b=sdoIOlE/6MYgrskVR0QZkpRi+BlV4+gJEMo5JtKalAkdQkotgsIwv7T1N+q2PoDoyOHUPejd1syQa9+eDIPqh7BQLck92NVknow/MXkL7M05fjKSrLHCmhjMXGX7WJTi1Ng7tm00L1C78UTbiMCo36ZrC9Wsosn1uOxWrOpe4yZD4hOWZCeC7XoMwGHDWAcVWEXgB27QTB8j1eEIiZNcDA43WiOk0CSEYebwRE7uwWmN4X8jFp0r8ZcrnkDstM8xbf4BfKJqPF9N/UvHA4GpBvyrRF9beEpN7nznUEYQ4QYFqpLstNKmAloCloDd9bjk4Mci16uc2sgEaRrnziXYqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpPn3KZ3bT/bK/LFfrptJSoP+/Jl5WPlvawKS7SKFyg=;
 b=G49B3DNzjGEek5toW9BXm+eGnxi3ZGStiZSE+zqoXWmdT3px17goM66ElW5HeS69DcM1inFae2IWCw7MSpp0HbChrpIcaYxT77Xi1qaITGgrgnglajzYW0FYDickuam2NzETXALMMM0EH40S84IWomSbVA3VkiWoZEXXFuigtnI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5249.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:115::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 18:04:47 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 18:04:47 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Jerome Brunet <jbrunet@baylibre.com>
Cc: linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH 07/11] NTB: epf: Implement MW group translation callbacks
Date: Tue,  4 Aug 2026 03:04:34 +0900
Message-ID: <20260803180439.1963864-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260803180439.1963864-1-den@valinux.co.jp>
References: <20260803180439.1963864-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0371.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5249:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ca8de15-7384-4e9d-781f-08def189b453
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|10070799003|921020|10067099003|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	u2sTH5wevqVilviI7wowhN/J3V4OXgcKzpmDr6nu8Zsy/ifSLV+TH3RnQh2Afytd2EMfmfMNPxePS2JBRxeUN/Y+0uRtig1sHwL18z27FyuRRYtxIKQk765wQlj8iyliqFMjWFiz0gl+6N6l7caUQksjJjr/OFUcysbSGoAOBRTWpItudpH5QB76FJlCOxIwgo++O0+DTVbihNoqe0+cERS1rBZFBZWUnaFHd072D/K61GHXUyTiRqxTselrHA2RxkYHID6h+nsl/aXonBKJyiFWdBZeLqhRIqPQVb4DBgsS7dFM3ecSrWN+knNaYkIdi59TRVZeXsb0PIhsCFl+uKXEfuOnkKgFJ4Wk8MUpeo3pWyPJ9KdWkylGuWjoN1OWV51L7ufm/IjHQzpywsOni0MAXPJgchyTbPw3bBWHMQ+DCBMeZBaDpLaOaKSVXj63AlEOAwfAyejsE/5bEaydJXm1AYHglvY2zUOsUjOdMgJVC9AkCwEf9RD8NZsMo5zZhiR+Li07g6N5EzlyonPXWm94mYxQnblqRey9IJ4K6Xm8JTnW1b+OZD6H60IIrYY3SPFWtPiikuOzMR+SiSCe7IoSjEO+e5XNCjhLdG31wst/Cugjyv8br3VxFx4Y8EpbyJSHYYZGvfWLuVrJUn2aKyp6SMPM4vuypciX0OeXJ85ffKZXx10hmoGR/Jadhp9uZvW5lED3ay8IlVYIFeIVTw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(10070799003)(921020)(10067099003)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AbNzYa/IbLJik6A9TeeNphxTnDpytfQAO5Gljgl1S7UFNnxM8u32qPK4SGdw?=
 =?us-ascii?Q?AaoxE/tbwbh1ujcRZxDgR47Fm7EdieCjUmSsfMtIvzIbp/OAhpos9blumrB2?=
 =?us-ascii?Q?Oru9F9kjKfl3Vls+pIm0DnDXPmM8NcDbbOMnFOBxayYctApv2WPjKCTPpish?=
 =?us-ascii?Q?tf8mNIvK2ayB6lXFUeCAV2xPmuFg70NXqa1AMO6feBHJRx07HPH61zXqIXyn?=
 =?us-ascii?Q?fC/kgqueW31/+HOEQeDLzVkSZdguB9ucUjq+IDRBptCsVKTzJocdWY+IOJBY?=
 =?us-ascii?Q?42lkgO7WmKPds689EfTmjyEeX1vrq4WtzPOQ5Wymsyet93V1G26jIR2dhaaA?=
 =?us-ascii?Q?GQ+oleqdF30p2KGeq4N1Y6ui6m5TVg3NnPrIaILWhHeEFU9ltxIQiAtFnfsD?=
 =?us-ascii?Q?pGwQT1hAkcA9epyjsEorIPVEgoZ0Q2HzsYU7T/ph2sKnBbSaOYjZZTfmpEQv?=
 =?us-ascii?Q?7diM4wUCJ+gv9K4weG7Waa6HvLau21HJdD+Fl05bEpsGAaervZvH39QxJxZ7?=
 =?us-ascii?Q?E8K9p0Des085IoKBInWZjhBJOffSw22jZN5nFR6QE1x9JYpVGKe3Ny0fqa0W?=
 =?us-ascii?Q?CS+kobUrDo9qVFPTBhkPeRAQlErqKTurj6shWO00O92rpAUinaLX9Deb/YO8?=
 =?us-ascii?Q?/l8w8iDjJIBVoSHA2tO4iLdv2BbVjUTMyH0eCcE0btarE8701UwthAm6nOc9?=
 =?us-ascii?Q?MHErYXPvlKFV4bILdvq38tY5MGXRt172XKMDCw3AEuLRvSIjOEXwk5jS2d3j?=
 =?us-ascii?Q?lVNzKeRTT7LpVxOdQnM/yMHhnGFI3DRivBAOznK83cF8Q5710lukcslqhsCd?=
 =?us-ascii?Q?ZexxP3x0VHkg4jdryYTCD+SuZGBjdGH1uVT+KoFWTuAsOR0VWBcfIJLh1UNb?=
 =?us-ascii?Q?GrdLIWZ1zDRe3/H6KI3/JczkauKUn55pVfU/Yw64mxrtw48Xm27FHSw9EcYa?=
 =?us-ascii?Q?WHJSTYXKr+4RxlGWH86Wk3szqxh0yz5PfJZNNkN8CVCKwuhsZ74E62q1xrtN?=
 =?us-ascii?Q?5Y3T14zgKLJCblmZ2NMiuqq5VSQBISnvpxkmSd3DkaP2ujziSsV3XkPnwVgk?=
 =?us-ascii?Q?HqK6wvUOP3IjU8u3WuvTsifWkpaLUm0UI6Fiv/2MlR+vRrjbT9b/AWymEeyX?=
 =?us-ascii?Q?MhurFBORscmX43YRa8fkp0xAscOlmqUKr5JMAxxX15Ng0QnkvUhgiyiuf6mn?=
 =?us-ascii?Q?YHjBt/sotTR99DSOJw0ZUbbLIJrR1zw/QRccKMfANqmQeGOk6mJgiL+Ur2G7?=
 =?us-ascii?Q?FRUMv60IfA0y5BJJRtfNMGOPWX0Aze/oy++0T+jgdQ9BNp3UBg36x1hC+5I5?=
 =?us-ascii?Q?E8vYYH+/D5gM88oNbhKoTJx3gejJkpjnJxsLfldwPJh21KSICBzt6qiG3TyQ?=
 =?us-ascii?Q?NnvD1I8yKqXp9IwdCW0JC/K7+OLKHzaQQAiO/HU253jTL3VXwQAzx4oyczxj?=
 =?us-ascii?Q?WAxYU+uXqxNhBM0JzaI8wjmdjix0DLnUzBBfrObEAzAjyRUdclo3L3wr2qzd?=
 =?us-ascii?Q?gQUz4S44GWyOSorfoTH0H4abaAvApkJb20iDuiWB1KSlD3HerEZnM1X5HFWs?=
 =?us-ascii?Q?liqo6Arw4PuQKhl/s6E714KSRrvH9efXC1rp/q2fY5s4GONbFh6PDnWjeuyA?=
 =?us-ascii?Q?AIYzreUZMp8rEuPZ0UpCRb4ETfQKarwWnQNGIfkKR1wirpi31O6I5BWuJsiV?=
 =?us-ascii?Q?DFKuQJjmrkhYHYoSnDXG3u198HHJ9C7c02CgKlTmsw3er6uUrum//r3pXh1g?=
 =?us-ascii?Q?nGmtthVvxqEJZXoEftrfcugaOCWyftK06u1TSMm6YViR78maUQLn?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca8de15-7384-4e9d-781f-08def189b453
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 18:04:47.1824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8+IoQSqYZCvfEx4uAn0WSHbILUv1UlonX62caIV3nygjx6z5D4ZqT59wGkE9vhaXsPBbU6SPA8iAeEkLYInPYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5249

Connect the NTB group callbacks to the version 1 group commands so
ntb_hw_epf can program packed MWs. Singleton MWs keep using the legacy
commands.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 41 +++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index 46f37c2dea7b..8b00550eea04 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -20,6 +20,8 @@
 #define CMD_TEARDOWN_MW		4
 #define CMD_LINK_UP		5
 #define CMD_LINK_DOWN		6
+#define CMD_CONFIGURE_MW_GROUP	7
+#define CMD_TEARDOWN_MW_GROUP	8
 
 #define NTB_EPF_ARGUMENT	0x4
 #define MSIX_ENABLE		BIT(16)
@@ -509,6 +511,43 @@ static int ntb_epf_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
 	return 0;
 }
 
+static int
+ntb_epf_mw_set_trans_group(struct ntb_dev *ntb, int pidx, int widx,
+			   dma_addr_t addr, resource_size_t size)
+{
+	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
+	resource_size_t group_size;
+
+	if (ndev->ctrl_version < NTB_EPF_CTRL_V1)
+		return -EOPNOTSUPP;
+	if (pidx != NTB_DEF_PEER_IDX || widx)
+		return -EINVAL;
+
+	group_size = (resource_size_t)ndev->mw_size * ndev->mw_count;
+	if (!IS_ALIGNED(addr, SZ_4K) || size != group_size)
+		return -EINVAL;
+
+	writel(lower_32_bits(addr), ndev->ctrl_reg + NTB_EPF_LOWER_ADDR);
+	writel(upper_32_bits(addr), ndev->ctrl_reg + NTB_EPF_UPPER_ADDR);
+	writel(lower_32_bits(size), ndev->ctrl_reg + NTB_EPF_LOWER_SIZE);
+	writel(upper_32_bits(size), ndev->ctrl_reg + NTB_EPF_UPPER_SIZE);
+
+	return ntb_epf_send_command(ndev, CMD_CONFIGURE_MW_GROUP, widx);
+}
+
+static int ntb_epf_mw_clear_trans_group(struct ntb_dev *ntb, int pidx,
+					int widx)
+{
+	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
+
+	if (ndev->ctrl_version < NTB_EPF_CTRL_V1)
+		return -EOPNOTSUPP;
+	if (pidx != NTB_DEF_PEER_IDX || widx)
+		return -EINVAL;
+
+	return ntb_epf_send_command(ndev, CMD_TEARDOWN_MW_GROUP, widx);
+}
+
 static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
 				dma_addr_t addr, resource_size_t size)
 {
@@ -648,6 +687,8 @@ static const struct ntb_dev_ops ntb_epf_ops = {
 	.db_vector_mask		= ntb_epf_db_vector_mask,
 	.db_set_mask		= ntb_epf_db_set_mask,
 	.mw_get_trans_group	= ntb_epf_mw_get_trans_group,
+	.mw_set_trans_group	= ntb_epf_mw_set_trans_group,
+	.mw_clear_trans_group	= ntb_epf_mw_clear_trans_group,
 	.mw_set_trans		= ntb_epf_mw_set_trans,
 	.mw_clear_trans		= ntb_epf_mw_clear_trans,
 	.peer_mw_get_addr	= ntb_epf_peer_mw_get_addr,
-- 
2.51.0

