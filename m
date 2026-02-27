Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020083.outbound.protection.outlook.com [52.101.228.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9863A7F40;
	Fri, 27 Feb 2026 08:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772182210; cv=fail; b=uiv780TLp2AdgkjJko8oqvdS/EK25DnTmZnzqGv+U3KXAb5jHqe18sHxhTE5kZbo9opTevXaqpWdOG/9byjU/VTkm38Bxuf1VoUNNfWj5BALnN5KgCUBOr7Xh9EDAg1+cxWi53ysDdyfjpIylPnxob6VWIwWzHhRTyTw0t+K/fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772182210; c=relaxed/simple;
	bh=DQSLH26ddC1EMtwNntY7VcJBcfPHqAXdvkDaNeYWJsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nfw0jRpVdm1schvYCodb8Ru4PENuKoqwiGRF6XHWOhT5CKZKBm961K8YLYylM99WmuqE6A9r81gXIxONSM71gFofa2AvdU9EFTVPoErSDWgaSFF0Sn3ljyOl6zWUc6/UOdjMIG6+Cl6nW80zUMqzFyCvhEsdgrXBT09lwDDwH8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=gpokTMTP; arc=fail smtp.client-ip=52.101.228.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="gpokTMTP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JhI7p6Q+CVssFGYQSTmhpqhI4Ja2g2qpHdWsmNU+CHf8MW3jZXMQURIz/sE9kOpgfh8Jl4RuYGKEb6hfH6b01Gc8YHPoV/pBST9098iig/3ZE6/kU4WtwjPdNbfRAWcth5aoqV4C2nrFFPL1UzwW6nuY6hn+b7vGWJI8SfEzp0IQoOGMXyGjEtbbFysMpyLygAWUopZRoXrSojTTk2lkm6wQHM7rHncMC2W2ebPprM0OhaEx6d7JWxVxuJ6so32eR5SSbbhzGKdJJorxHXKxqI/11bCLafDuDT7SSLQe+clXrY1Pnb9tXj7YPl13jQW+pZW1Iv4F/P06vWmTbmJYnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwoJ4fD8ofZ+rV5jN+pcWS8DvxinyDUWYKMi2mIwnio=;
 b=kMq/l2RePHrNndX0trh42YtEKi4v9jbBy/Xw/G4KLSbWcXxu0TpEnZW3Aaq4P2MERNpjEZFAtKTIJOkIQw5WDUa0OPlYtm0q1s+KttTQf0bM5VR6EzseN4wrBTF0KtXjPc8JtmmvvyUknZ9AIIquVtoYAxV9jgKv8687xQ0wQarNDGG6xPXoAxcBFbZdvNHIwYF/u8qjWD0i7Y1bzaepkqVX2vJ6EGT6bLibw8Oo6kgSTHDG+85Nsynv0nRIYJDlPGuT0H1K8kGj8MExV+JJ+ya5OQgyDa8oivO3PE1ptw5yHCzNEx4Ie+PDP4pGtFldNGIzF2DXox92akZDXfgBJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwoJ4fD8ofZ+rV5jN+pcWS8DvxinyDUWYKMi2mIwnio=;
 b=gpokTMTPd8KROFWTMtUDyOBLGhrj8At9zAo4F7uiku+nPEAkaizJo2ORrW7Z90Azv2TfOIZREIV7efWj5Oot0UUNuR79bCLbwTA9Wj+W8jngXmhK4+IeVv0CA+B+7ug2yZN4zOL1uptl0KvRcc8n6kSdPPHepXiIu8/IHWdg8aU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS3P286MB2135.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:196::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Fri, 27 Feb
 2026 08:50:03 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9654.013; Fri, 27 Feb 2026
 08:50:03 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank.Li@nxp.com,
	dave.jiang@intel.com,
	kishon@kernel.org,
	jdmason@kudzu.us,
	mani@kernel.org,
	allenbh@gmail.com,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	jbrunet@baylibre.com,
	lpieralisi@kernel.org
Cc: linux-pci@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/10] NTB: epf: Document legacy doorbell slot offset in ntb_epf_peer_db_set()
Date: Fri, 27 Feb 2026 17:49:51 +0900
Message-ID: <20260227084955.3184017-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260227084955.3184017-1-den@valinux.co.jp>
References: <20260227084955.3184017-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0009.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS3P286MB2135:EE_
X-MS-Office365-Filtering-Correlation-Id: e77cda72-a1be-4cda-058a-08de75dd329a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|1800799024|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	EzcVcBdl6/Y4mxrkUie8kb8DfM9CFsGbDVUe0kCMXOMXzoD+jDpFSqE8vIRVtGYYtkFaHyQl48yKdmH9RIseNPks+kpIQU+J+yxi1aJ4ZSxSEmDq7cZoHjLnfzMtfySkQMJHbcl1CvF1OK45EmgS4B2PXRSOfBTCCGmcqGmFqlr8aEJmmA+az7IaLi3Uy/FkSGZUNt+Ho8b4eHjtugZUXXX2UTzk4ps1lR0JNcCNRSvVEBIhItLHyhGp8FKNfbOO0yTwVX691PHMuawP05zwWvvJpIog+40/PTbBRiz8sWSEGNybtZP20uYLqN/WJOOupkKCC+WTB7ukD1fIxmZyOipzNCwE5OB4/g1N5gT+6uXfyAMoYT2gvs9ujyTL7dED42v3iqqA+Rj3+cGpw0XipGFHiaJsWd31fU0wCay0PcY6FzQUWYjL+qcFA5qtRkxQYnSVHkAg4hkhLBebxO1uKBR0ILR8FWsYUkSlZbA8YXVTKLPvuUrXD/oH/15+BCHcivm3IYGopAmvuI87hOarn34SoRfSjcX8UUwRvGIMDecQLYQbqaJRVZObV2LyV9hcb9i0OQ+YLeaCqNesHiuclfbCxcLB3zqauWWf9Y2emgvC5eJhC0GbfC+S8CU2H7uJn0u+qsisupKMXyS+A+s+IZ4Xc6xi9mrpqqvSleC4r8zxpkfHcdUW0ZAyxxbTFISuVrXhZRiNqGF2McuSDAdDIb/7TsKFtURChyRrJ6bNzew63lXn/7ep13lO/B2zrzyTzdHxiQm0CNi8i09EDUNsJA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(1800799024)(376014)(921020)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GTwFzm6FheUh47+MNlWCuTtz+hbklg01CijPmOI0c1VtERdZeBDOMLc0VvG5?=
 =?us-ascii?Q?FqPutnO6OGCeGw/hMJueyzTxCC6E7kQMnX0eCpAr6bffD3JiYRlUavb417wJ?=
 =?us-ascii?Q?3BCBxfGplQ2r5kudsi1QgGW/eRoXD51ZX+fMrThhAUxjgwPn+CAs+hbrbSKr?=
 =?us-ascii?Q?pRmFDrwhZeq8PUiNurQvW7/RJsD5cqpXGndSKOCcv0ewAr/Udo7Im6gT4tbE?=
 =?us-ascii?Q?AZEv7oSN/UsINHgmOuk4NE1s/Bjxqv4Eh6uHwakT9P7pvKyDhZbbr+8uA14b?=
 =?us-ascii?Q?4Xy/zSoT/T5orwT7qNOtg6XvRO2chTNDZGFeq6lMQkFWizEWG3F48MCwzuLN?=
 =?us-ascii?Q?4i/RQlv6fR19aesYnSPvZ7OZ069JjG7q444gHKMI86uZi3qnqT3cDy9CFsg1?=
 =?us-ascii?Q?TqY+sEVYFZWCiWr4yHsMvCSr8m6aefBSqpQEp4ZSuMIJwWDrQYAa6Z7lO4Id?=
 =?us-ascii?Q?WO5n7fEBTVlBNB4uBZi1+T7Q0MHY7C9dnTN2kxAFfSksENfQlK2/gshXd/c+?=
 =?us-ascii?Q?sLs/V2hKWccml2i168bWzYY5XJPe/TupBjSMwCaDBqBqO0XFwvaQ0kXWEttW?=
 =?us-ascii?Q?kM3y7rwiCSBdGf4o7cohbwf8u0fw0PZtan7VJzOFTFw2gJXe6HB05oapGGK1?=
 =?us-ascii?Q?LL1lruulBkuz4rcxORIyUpDz7ULAznu6RcOKurpKIEu2HFp06ydIsoTANrA6?=
 =?us-ascii?Q?bFZPPvs12SVzhBoz/LiK9QXTWXfnBqOeCnXufw0WYxINaUWtUGDivQyAOq2b?=
 =?us-ascii?Q?7lJe5GIwcYPWcf+CGiSy8ZbQ65x0FUAsmRkh4mF6Rs/DOEAOcaJtfJbUfWE/?=
 =?us-ascii?Q?Bpvjjl1WzQ8ZCLeHYlJlCo8Qs0iqugz4/iKJv+X3qkiHu0mGFIsUACFwAfEk?=
 =?us-ascii?Q?D4dfqrWOAnoolS08l6z+EGbcdPcaucSnz0H6h54jq6PRGjqebwBsHbviIKqr?=
 =?us-ascii?Q?QKaaFrPOpkdc95g4rGclW7tLKEZAYzt5lbRj8nqVt8v6CynVD7oxC9JI09SO?=
 =?us-ascii?Q?uMejevemU0VGBHzDxNCVc8jkId1SeNUi6GnehXI7Ir+YhcGF7yVrBt61aMXW?=
 =?us-ascii?Q?rk3AgRbPDfLfH8unOyNEpUsps8j2FSizvWzMdSubqOf3mneX316B5b2Lr3Mp?=
 =?us-ascii?Q?NegiRL9/WBBH/pYN+JpeRDrnerlBM9WJ6o1oSuG27uADrwEXW7W/CyBAaY+7?=
 =?us-ascii?Q?LFoXooNqjiKsnUnq+LFaWQc7kktQkCbZAWq+fdNKZ0M9EY8UJy4Qgc8JfDX2?=
 =?us-ascii?Q?qy2eI68dl+DEVmX0s+xP1m13ni3lEGq1SPlyrk8H/xQ55RePe3/XEbHeLgND?=
 =?us-ascii?Q?S9OPFEKXQUAyKVWZPcI/fCiWtBapa+4Djd8EQZmiVBIF3R4uTXIp9A+7Suuh?=
 =?us-ascii?Q?FKluQujNF13meXmwxHfz4PG/PZI5qqBHE7VX3H3AU28Npchgs7X6PKvw0EqU?=
 =?us-ascii?Q?HvxV2RDktOZHX2lbrzIS05ai/gf/jbKauWc5P49oyxmTV4GobKWvT5RsSQIB?=
 =?us-ascii?Q?KJqM0b+vCc99Eg+r74j5ekxX7GAdIf7tn5YWGWSGmk2Euqp9GJa+G6TFzOJ8?=
 =?us-ascii?Q?8RGUsMyZwrU9vzd2eBeLSFGqo6gPiLdG7DstEC3sWdLv75diMbGjhbeUpRlN?=
 =?us-ascii?Q?MCqOW+IoEV3oO8xEK4w0OffRcJGmqIkr2A1Un1nXaAzka976CQQ16U77jGMH?=
 =?us-ascii?Q?5CIqJ5/dosKrFlLqWkbtdzgws1oK8wcPZ67Nef3+tuJkjhps02iCcJ+jmGIz?=
 =?us-ascii?Q?ZD8GcWs+2osCifx9VMlsn2qjbhLUgDas+8PDrn7XeHyq+nD3c7xv?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e77cda72-a1be-4cda-058a-08de75dd329a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 08:50:03.1163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C8hSwL6ZEttbV7vs1nZZ7FtCWJWAMJH5EhxjxC0EaINHCnw1onWnm0cqMZ9wuJ5TVsrrVWxKek3YN4OSTlLwww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2135

ntb_epf_peer_db_set() uses ffs(db_bits) to select a doorbell to ring.
ffs() returns a 1-based bit index (bit 0 -> 1).

Entry 0 is reserved for link events, so doorbell bit 0 must map to entry
1. However, since the initial commit 812ce2f8d14e ("NTB: Add support for
EPF PCI Non-Transparent Bridge"), the implementation has been adding an
extra +1, ending up using entry 2 for bit 0. Fixing the extra increment
would break interoperability with peers running older kernels.

Keep the legacy behavior and document the offset and the resulting slot
layout to avoid confusion when enabling per-db-vector handling.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index d3ecf25a5162..bce7130fec39 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -43,6 +43,18 @@
 #define NTB_EPF_DB_DATA(n)	(0x34 + (n) * 4)
 #define NTB_EPF_DB_OFFSET(n)	(0xB4 + (n) * 4)
 
+/*
+ * Legacy doorbell slot layout when paired with pci-epf-*ntb:
+ *
+ *   slot 0 : reserved for link events
+ *   slot 1 : unused (historical extra offset)
+ *   slot 2 : DB#0
+ *   slot 3 : DB#1
+ *   ...
+ *
+ * Thus, NTB_EPF_MIN_DB_COUNT=3 means that we at least create vectors for
+ * doorbells DB#0 and DB#1.
+ */
 #define NTB_EPF_MIN_DB_COUNT	3
 #define NTB_EPF_MAX_DB_COUNT	31
 
@@ -473,6 +485,14 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
 static int ntb_epf_peer_db_set(struct ntb_dev *ntb, u64 db_bits)
 {
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
+	/*
+	 * ffs() returns a 1-based bit index (bit 0 -> 1).
+	 *
+	 * With slot 0 reserved for link events, DB#0 would naturally map to
+	 * slot 1. Historically an extra +1 offset was added, so DB#0 maps to
+	 * slot 2 and slot 1 remains unused. Keep this mapping for
+	 * backward-compatibility.
+	 */
 	u32 interrupt_num = ffs(db_bits) + 1;
 	struct device *dev = ndev->dev;
 	u32 db_entry_size;
-- 
2.51.0

