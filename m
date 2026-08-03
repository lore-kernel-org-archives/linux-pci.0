Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020095.outbound.protection.outlook.com [52.101.228.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FDC432BD9;
	Mon,  3 Aug 2026 18:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785780299; cv=fail; b=j1YHXlNeI3pxdcTzGv10wHH9DmOrovy2lxYls5anwn61TXQAu367UfbJsyEGLSOC/wTIhODIoGS+/J1TWClGviLbAr5CFCcV7KBXZTIfyrl57vYJzV6PoAXI4IM+Y7nCr9s4XJLK8ZA3YrlTCTI8a/UzkaI/Xd3C9uNnw714Bf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785780299; c=relaxed/simple;
	bh=Ia3vbf/smnF5VZ9KnQ0CzkS0Msryk3YwaOIeaAki1OM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YoGt8V6fIfLbRVR5LWa4+PSb1X5Xq/vLyOsMfuvjyQ8p9VhFBdvhbpltdzQTCGJjmefzXhRW3iQWpFhsbMd5yttq6pFDJd0z8RxAmZsjph/CRXcGWCrnKVrwmk+ajSDx+MxG9Dp5LIL9xM5Hc/EzZZ/BQmhNICt6tc6NAP4wZHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=cWVLhpnb; arc=fail smtp.client-ip=52.101.228.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="cWVLhpnb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PAzFM90NRIVueLaCGuC7EB8yv0n8/wy/Fz8w8ldJeqvPg9BuaF5uOSZ/iGV+TP6hsq/CPKjmax376zkOGlhvT3knJGmABYishI0QBiCblo7jMi0e090BUcsEJzjNSAHl5vT89i5dZJ1YwCYUUcE8s6cx90W9q/5smvh9CfqvaAIFuCe19fsLpt/8WytoNllwWD2U8ByVTQKAvHVpnsXTACH1jsF6DjugWLleED1tmRUAdbJMujTwbnlAE++Di6bsUSpuEMt6ymBd6AB/6pJdt0dem4bTPirfNoQwLqGp5T8ZJ7d5pEJ8ZHD8/kb+Fqazubrbv6ABPilEZwX6DQvJIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBzVNACEMTqUzkFigAMwxxReFHIKP5hWLZK7RcOFxyc=;
 b=iC0km9B1KBa9zXFs7m5B+Hbmgoo76qSd64pA0YNyspT9BtY8uL4ea5eYaBfVT5wQ8GDOvG98apUs2QpxAXIqPdX5Kk3Y0Xvw1yXneHuS7fMXRPAb/+67vuqf0krPVV0Cs9nehppe8qkkKPmvXZ73P7S+mmHPlbDulQZRgSxHmRNoQ8maYGH1J7r1EvmqCeb9uJdDVLS0OzWAWQGbXbTiqoLJUhFDbJz9VY/jXAzWce1w08IJ2aqrSuReUiAOm9KcwX9vX5o4p/At+np1ZpGIQ6p/nIkxtyJpC8RRF7LN1mgq/m29w8J8ueIHvHPc4yiTTX5a8OCuJztvw5UA8sRkIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBzVNACEMTqUzkFigAMwxxReFHIKP5hWLZK7RcOFxyc=;
 b=cWVLhpnbZB/16a8cWboBlo9T32LPNRzr6RLCOH1PGZeOmt+xnwGbZNn5MNU7h9Kg8MDR0pFnf8PLj3KVpo41WYk2uN3DJgtkT6oxVpBfu1TwoXIV+ZCXliRQ6drnWqx4vsSNiRhXwBtx4QPbAuCOi0qcNRtdtR1wnkdBonQ8PKU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5249.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:115::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 18:04:49 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 18:04:49 +0000
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
Subject: [PATCH 10/11] NTB: ntb_transport: Use atomic MW translation groups
Date: Tue,  4 Aug 2026 03:04:37 +0900
Message-ID: <20260803180439.1963864-11-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260803180439.1963864-1-den@valinux.co.jp>
References: <20260803180439.1963864-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6PR01CA0010.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5249:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fbe9e7d-24c1-4461-d2f9-08def189b5a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|10070799003|921020|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	71u9V6G/YK6kKHyT9ulg3r76xkI5KJ6num3faFb9guFPNOIYRj4drtNL2uialZYmbKsBTofAFqFj80JAbnC5GofNpSEoLrrPrX0cjiGrCeYBuuhIYFBvUXzpE7GBWnst5jazbXW93zNyXu2jEODgzRGDhm9EH3d9OAFhP5b8cBgIeFIUcD4pd9tSXo1Bh0jBH+BFL4jttOiPxi6zDRdWxXQ6bK/AFSxbzE1YVT2xA4ds5VUM1CveKmbVK+F5XSafS+wyzij3ussksBfYcVkNUrpEETu9Ncd/HZ5AZ0lhwDOYmF3QStLPB+4Lvk8QCqvvY3+1P/3m/KgcE7+qgbiOstumCES9vZq2+sCo3ymP668Hz4oSzUGfpRu7p1yuTfDmsqcMSARmvE1bmYvKzopdJjDvb1jjxhQZu0LIa6+OSEmdaM1cxTALQz1hmQOBtSCqH2RuJZLNYgonHecpEZO3v3XRNs6hPl7vs6Yklqd1SO9MoD3NESX+kL1JP1fhMI0dHw/I8pl0FhT2LXTu9J/EKFsMT0Wb5HTpLsnqVC7dQPtnO8g0wh0omQxXjo1oghJO8bq2Pp8V5ZYuYfF7wn8jZ/S51kqZ08WTuXuJW0nPw+lKsiCGqYeDlwQRpabNg2zfaiy2TCwxJ69i25os/ET+GeP0ogwnj+DBiV2hrdgso+sHvoIjfW9UiIcdm0OIChRwjWSq3gEGgNfD/mDjfnnQvA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(10070799003)(921020)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gj9YXfPOyZTi2hnUHZj+nqeENZf3AA277P8BM8KpqHwEVKNhvpFieVj/XiAf?=
 =?us-ascii?Q?hSpr3EyzAFIDmjcDyMuwlJiQb1v3OGal2ALuSau6w84VDhZaW4rYYM176LOI?=
 =?us-ascii?Q?CsRtgf89a1PebTP1qb1P5gOmhQ0CYipCjwOpRu7iutPHIqA4Se5ruHxg+CAr?=
 =?us-ascii?Q?zcFOnigBExGBCTz4fn/e7dZqjhXn4dIjuuk/hwuQ0ovhAT4lJXxb1YjQN5ug?=
 =?us-ascii?Q?4Qw8B+P0XqG7Js9YLuJz5muICWkxk7axXmTRkH9ewm2LqMjoQZ7Vk3B+mGkH?=
 =?us-ascii?Q?o4QUGVCeW07xZWhrPYjkW0GWCrHsKRs/I6X3U7c5aYeWnJWZbmHjLkhzkMKD?=
 =?us-ascii?Q?4kofoCjQ26KTAPN261DFtbUEtD/J6iq8p9LOWKxrbsKiCGNoDAwK+ERfRUfs?=
 =?us-ascii?Q?2MW75ei3bkfejJGXUudPp+Ca1wrxWDoduVaKBH5X3UYolD/x1QFSjjasZnKF?=
 =?us-ascii?Q?jF+od8YDGEigTHYfVaBU95cWvCrrIFZ+2XIK2WBJzNe/W0Gt5VKfOkkf/mmQ?=
 =?us-ascii?Q?pihoE2Bjad75Lw09Eeibj7idG6n9nMaOGLli7zqDLNYNVvQcq02QRdOtSmsl?=
 =?us-ascii?Q?A4bONRUDABeO5c3LTeFa6/v8FlYSc/SJGTbgV+J+tm3bvMFvDv7VBfIlkCxM?=
 =?us-ascii?Q?7gPjQ+Xqf1ZOZyU0RLTAX6GCau9FAlGaTndJXHxOPGZsG9M/dDg64TaHycKj?=
 =?us-ascii?Q?jdN11DfmnK2eWFETarsoKRbj4qscp+raKsFu+bfPYnqrVPF2woay8AW3Dm/X?=
 =?us-ascii?Q?t+FTSSwfFgNwn1vxmZpo/vd6DxJavP2O3RhCbWFPjSKXoqJO1jE4e0i92ISx?=
 =?us-ascii?Q?yLQFGg7HYghV+t6mEX9C+s0u7u0kBrLXtayyV6K10MltTXIXSHteSOzHwEyb?=
 =?us-ascii?Q?jAwDz+ykxTLlRYuSNVe2D/8bqEwNhJCIUu45NLzW3lkj3QmGtf/FWHPL6RnM?=
 =?us-ascii?Q?5MxRlQFXBW2EKR2CVVC7Ah0i3dRkfMKKroakDSrAo5qWQoJ6bUr09LoWI1fC?=
 =?us-ascii?Q?Fu6btMaQpsiuK3Ns5YlGDtXOSg2su87b8WnIyHGZ5e/6WhsSyuObgnGHO8Oc?=
 =?us-ascii?Q?BFg3CloKJgppyPv8+s8j0S6Biw5rydDJfUa9BCX7+sjEnoBxhdJUsjflMDce?=
 =?us-ascii?Q?5eKtj4508JGocAMlvwx6P15aJW4yXEueFg7ZrpoG2Qi7uCK/zZAHXZY1MMG+?=
 =?us-ascii?Q?It/jMl9nbbX5Jjx7Brlrohqw4fnJQ9aKw4PbtRWCksVRZBCfZOJ3A61+rf0M?=
 =?us-ascii?Q?yTGDtEfAlA45tnWq7N0HNaOcXE1Hzrshmz16Jab4wYLvbS2hFufiZFHLVjsS?=
 =?us-ascii?Q?8397cTmAYhixcOW1yyJZ3FWzl+XPdxL10fk9iPtsNfSZ1jcVzJz7yAjhAxW/?=
 =?us-ascii?Q?f3VPz44xVABpeS/q9rsH4cxp2bJgAQZQNULfuOy8oWrxKB6dpZhLrxjrfBSi?=
 =?us-ascii?Q?8Xih0wvyfRe9cSyDgoKifToeKx++bRmxad8Dv1XfBsi6H6yNLxo3low23xfP?=
 =?us-ascii?Q?AyQSprObpVUdpOV2U9jaxTWRmW55ueOaXw+y8JyZpXL777Rsoyvj6oA8+Eb7?=
 =?us-ascii?Q?BbYbSxiIR6A/dZoVNQQXe6hEpMQO3r4+yHR1b+GrMUebX9aj2Jyt9aV3pN2Q?=
 =?us-ascii?Q?HUd6031LOZ3Sb8p/Ns9wZGm6kXFIhM6YtYT9hYro5ZkbrnyMGTtwNxjBWvdv?=
 =?us-ascii?Q?94v384UUqvosPO8UcA/4z8TA1PkAjzJnCktHLlkY16nOaHG8+Mp3eEp3thfx?=
 =?us-ascii?Q?FWPLfy6wuhTF0pXltLxoXk/eYeP/P0ib2Ev3mQ3dcjQXxnf8UGzo?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fbe9e7d-24c1-4461-d2f9-08def189b5a2
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 18:04:49.3950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H1oAHVYGrypLO3avinqUhkPhD1ZVjrGo9Z+InzhVBuzrtM5Gxhl0B364ZmP08xVjSyM0rMohV1+O7pVNg3BljA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5249

ntb_transport currently allocates and programs each MW on its own. MWs
in a translation group instead need one contiguous allocation and must
be set or cleared as one unit.

Query each group, allocate its backing once, and use the group set and
clear operations. Reject a scratchpad limit that would split a group.
Singleton MWs keep the existing path.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 127 +++++++++++++++++++++++++++++++-----
 1 file changed, 109 insertions(+), 18 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index f59f926d4bfa..2c7728898890 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -56,6 +56,7 @@
 #include <linux/interrupt.h>
 #include <linux/kthread.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/seq_file.h>
@@ -757,22 +758,65 @@ static void ntb_transport_msi_desc_changed(void *data)
 	ntb_peer_db_set(nt->ndev, nt->msi_db_mask);
 }
 
+static int ntb_mw_get_group(struct ntb_transport_ctx *nt, unsigned int widx,
+			    unsigned int *first, unsigned int *count)
+{
+	int gidx, gcount;
+	int rc;
+
+	rc = ntb_mw_get_trans_group(nt->ndev, PIDX, widx, &gidx, &gcount);
+	if (rc)
+		return rc;
+	if (gidx < 0 || gcount <= 0)
+		return -EINVAL;
+
+	*first = gidx;
+	*count = gcount;
+	if (*first >= nt->mw_count || *count > nt->mw_count - *first ||
+	    widx < *first || widx >= *first + *count)
+		return -EINVAL;
+
+	return 0;
+}
+
 static void ntb_free_mw(struct ntb_transport_ctx *nt, int num_mw)
 {
 	struct ntb_transport_mw *mw = &nt->mw_vec[num_mw];
 	struct device *dma_dev = ntb_get_dma_dev(nt->ndev);
+	dma_addr_t original_dma_addr;
+	void *alloc_addr;
+	size_t alloc_size;
+	unsigned int first, count;
+	unsigned int i;
+	int rc;
 
 	if (!mw->virt_addr)
 		return;
 
-	ntb_mw_clear_trans(nt->ndev, PIDX, num_mw);
-	dma_free_attrs(dma_dev, mw->alloc_size, mw->alloc_addr,
-		       mw->original_dma_addr, DMA_ATTR_FORCE_CONTIGUOUS);
-	mw->xlat_size = 0;
-	mw->buff_size = 0;
-	mw->alloc_size = 0;
-	mw->alloc_addr = NULL;
-	mw->virt_addr = NULL;
+	rc = ntb_mw_get_group(nt, num_mw, &first, &count);
+	if (rc || num_mw != first)
+		return;
+
+	if (count > 1)
+		ntb_mw_clear_trans_group(nt->ndev, PIDX, first);
+	else
+		ntb_mw_clear_trans(nt->ndev, PIDX, first);
+
+	alloc_addr = mw->alloc_addr;
+	alloc_size = mw->alloc_size;
+	original_dma_addr = mw->original_dma_addr;
+	for (i = first; i < first + count; i++) {
+		mw = &nt->mw_vec[i];
+		mw->xlat_size = 0;
+		mw->buff_size = 0;
+		mw->alloc_size = 0;
+		mw->alloc_addr = NULL;
+		mw->virt_addr = NULL;
+		mw->dma_addr = 0;
+	}
+
+	dma_free_attrs(dma_dev, alloc_size, alloc_addr, original_dma_addr,
+		       DMA_ATTR_FORCE_CONTIGUOUS);
 }
 
 static int ntb_alloc_mw_buffer(struct ntb_transport_mw *mw,
@@ -838,9 +882,11 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 {
 	struct ntb_transport_mw *mw = &nt->mw_vec[num_mw];
 	struct device *dma_dev = ntb_get_dma_dev(nt->ndev);
-	size_t xlat_size, buff_size;
+	size_t xlat_size, buff_size, group_size;
 	resource_size_t xlat_align;
 	resource_size_t xlat_align_size;
+	unsigned int first, count;
+	unsigned int i;
 	int rc;
 
 	if (!size)
@@ -861,15 +907,30 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 	if (mw->buff_size)
 		ntb_free_mw(nt, num_mw);
 
+	rc = ntb_mw_get_group(nt, num_mw, &first, &count);
+	if (rc)
+		return rc;
+	if (count > 1) {
+		if (first != num_mw)
+			return -EINVAL;
+		if (xlat_size != buff_size)
+			return -EINVAL;
+		if (check_mul_overflow(xlat_size, count, &group_size))
+			return -EOVERFLOW;
+	} else {
+		group_size = buff_size;
+	}
+
 	/* Alloc memory for receiving data.  Must be aligned */
-	mw->xlat_size = xlat_size;
-	mw->buff_size = buff_size;
-	mw->alloc_size = buff_size;
+	mw->buff_size = group_size;
+	mw->alloc_size = group_size;
 
 	rc = ntb_alloc_mw_buffer(mw, dma_dev, xlat_align);
 	if (rc) {
-		mw->alloc_size *= 2;
-		rc = ntb_alloc_mw_buffer(mw, dma_dev, xlat_align);
+		if (check_mul_overflow(mw->alloc_size, 2, &mw->alloc_size))
+			rc = -EOVERFLOW;
+		else
+			rc = ntb_alloc_mw_buffer(mw, dma_dev, xlat_align);
 		if (rc) {
 			dev_err(dma_dev,
 				"Unable to alloc aligned MW buff\n");
@@ -880,15 +941,28 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 		}
 	}
 
+	for (i = 0; i < count; i++) {
+		mw = &nt->mw_vec[first + i];
+		mw->xlat_size = xlat_size;
+		mw->buff_size = buff_size;
+		mw->virt_addr = (u8 *)nt->mw_vec[first].virt_addr +
+				 i * xlat_size;
+		mw->dma_addr = nt->mw_vec[first].dma_addr + i * xlat_size;
+	}
+
 	/* Notify HW the memory location of the receive buffer */
-	rc = ntb_mw_set_trans(nt->ndev, PIDX, num_mw, mw->dma_addr,
-			      mw->xlat_size);
+	if (count > 1)
+		rc = ntb_mw_set_trans_group(nt->ndev, PIDX, first,
+					    nt->mw_vec[first].dma_addr,
+					    group_size);
+	else
+		rc = ntb_mw_set_trans(nt->ndev, PIDX, num_mw, mw->dma_addr,
+				      mw->xlat_size);
 	if (rc) {
 		dev_err(dma_dev, "Unable to set mw%d translation", num_mw);
-		ntb_free_mw(nt, num_mw);
+		ntb_free_mw(nt, first);
 		return -EIO;
 	}
-
 	return 0;
 }
 
@@ -1238,6 +1312,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 	struct ntb_transport_ctx *nt;
 	struct ntb_transport_mw *mw;
 	unsigned int mw_count, qp_count, spad_count, max_mw_count_for_spads;
+	int group_first, group_count;
 	u64 qp_bitmap;
 	int node;
 	int rc, i;
@@ -1291,6 +1366,22 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 
 	max_mw_count_for_spads = (spad_count - MW0_SZ_HIGH) / 2;
 	nt->mw_count = min(mw_count, max_mw_count_for_spads);
+	if (nt->mw_count) {
+		rc = ntb_mw_get_trans_group(ndev, PIDX, nt->mw_count - 1,
+					    &group_first, &group_count);
+		if (rc)
+			goto err;
+
+		if (group_first < 0 || group_count <= 0 ||
+		    (unsigned int)group_first >= nt->mw_count ||
+		    (unsigned int)group_count !=
+		    nt->mw_count - (unsigned int)group_first) {
+			dev_err(&ndev->dev,
+				"Scratchpad limit splits an MW translation group\n");
+			rc = -EOPNOTSUPP;
+			goto err;
+		}
+	}
 
 	nt->msi_spad_offset = nt->mw_count * 2 + MW0_SZ_HIGH;
 
-- 
2.51.0

