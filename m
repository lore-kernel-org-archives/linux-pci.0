Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020075.outbound.protection.outlook.com [52.101.228.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE683B52ED;
	Fri, 27 Feb 2026 08:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772182213; cv=fail; b=aKHGS7NYNHY2WcF3oID3N4Dy/Ut7zMExf2Uu6Efusb7I1RMQdKRdm0/S+3b3lAK7tbaNUTE1ggjCzwhz2d+KxvAY1kYL22Xsg18IWtQl/VDfxwv6YlF06p1EYLT+ERDYvpCfgPzvQaXEhb6jMqxjlXJZySha+7VJOL5TUz/OEg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772182213; c=relaxed/simple;
	bh=0Ol8H67LDaiJGn+eWUpKnLkL2iz+b7XEDzYi67N+NjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fzpRGwkl3ztd0alyABwq97eo4DW4MKSLTRWuyIPHJfTzbcQkrPqhE0dBkdI8SAP2lpUOvMzjCEDGXXfIQfuDeNkTvYWIrqp9U3PE+bVsNQAT5SzjkNRpTsO2TWLyNl7dvli5x3HSenMgSNiHALVU58+I208qwT+JQF1xYRYbBZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=OtfGqC9t; arc=fail smtp.client-ip=52.101.228.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="OtfGqC9t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFb2xrcocfr8PNLxiGxAiWNajuDcy8OkBkgbFH3BmDx7pS0BI+rXxH6tGTdm+LGwEvcGNFvUC1JOM+m8wLm4sh1JilGSAFGzOOP4WkybSBBCPBAfVk4YpReDKAOokp25OXJW2u9f1skmsu3rOp6QVvUhiwbXR7B8sqQsACMguwvVLAPrk8RIzrlo+bkhMxlsPU92XVmLuJa2u1DedTCGxFhwRRdaX6aiAdC9nzh1vArvDoq0wRHVBKyrnzwS1zNVe19gnwWZw4xRmesRMuhfmrii3YoS1jvrBLEUvFyMRKkzKRypZ+DZL+riMuAPIO34i1HW8+FQC5+xokQG5wuvGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M71eTLulOavbMaU5AeG0VBXuh74SEeZpwIefm29fQY0=;
 b=Oqe/512dlE13nlUqnmDJXZz5crl0OT2JKEpBZPEhYFpSHW44bULd+tuFVI1cAykEJ+Di9779WtsuIe4pOFDmHK/uQ0lUjoBmvwGwYSZ28nPs5BKD9sNag5zyV/SRCQac+e3sRnNHw6z7X4uLOUwjQtwrlMgaZYYJYJlfMbNorQV12dtSlPFvhsdB/vHRP365r36vAdK3ab9XLu0k+d1JR962MiIl932ElEJpr+LKchkH9XWpkU9hJ6h2brTjXbCLu81NNrUdbgWykpYVrLWHEe0A0VRBcRa5V8zcTyrt968P8n78f6cRH/bqpU+JlVs8zxXcoX5YsnWDGHnHCqTY2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M71eTLulOavbMaU5AeG0VBXuh74SEeZpwIefm29fQY0=;
 b=OtfGqC9tE/dv4+m/SSkNXKXhM1K932AYTp9+VeEvn/muK/QGdy6eKcz+FOYKn6ItupU4ulDadzZRPZ9hkUFU+9p75a0HKtlyGsyoLtkMOFSx1HIDjA7dKckcRWzMok3KbDiP/Mfne/xp4H5qrOvFnfZ/EPnewbzpicrIlSCSyHY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB4075.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Fri, 27 Feb
 2026 08:50:00 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9654.013; Fri, 27 Feb 2026
 08:50:00 +0000
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
Subject: [PATCH v2 03/10] PCI: endpoint: pci-epf-vntb: Report 0-based doorbell vector via ntb_db_event()
Date: Fri, 27 Feb 2026 17:49:48 +0900
Message-ID: <20260227084955.3184017-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260227084955.3184017-1-den@valinux.co.jp>
References: <20260227084955.3184017-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY1PR01CA0197.jpnprd01.prod.outlook.com (2603:1096:403::27)
 To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB4075:EE_
X-MS-Office365-Filtering-Correlation-Id: fc47dc0d-62f4-4581-c26d-08de75dd3121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	tN4+kyvPtlzghs8rOoc+sFBHNue7L8xrnIIJ061N5Hb+sDUL9HP960oa1wliP5nemWgJs+jThDjV2EJFXenwAKiIFTfFhvBMy2Ns5dZxZe2KVKr0A9SBo4Z6vKE7nPp58MTshyI3kVdeixo/q0ypOmkmW6XC7reMvM5FDuM9nAH80XwqoGCxteUUd1lfsKHASkSlbyH72Sj6paQm+d8PrsghdzwuWaxc+LOxGIZ7SDqHnvrFoP9mw+24V8ohV+2WXHoQbrM4VSbeeiwHNdxISXS0SSLCUcKft7UfsVe5lFKZ/dsnseW9osU4XRu0b8osjKrPC7X0gaB010pOOLKCgsZXQxGvrhCxJ6/hVpnlK9FuoRmcdwttlDSYbmFeF0fa63mJOn/0s4ZQUR9k3+GbkV+RGK42B8jXxKLgID5Ngkw9Yk4oUaUL5ahnMnmOCLZ85CSkBgMPNl7B/j5G6p9m89Uw1UFWBBWVagQX0LJjHfGBuXfrEWEkSqvWIK9i+QfnLJoEIPy063EmGRNICfgzS7otV22m+rDEtf1pANlrPRxzz6NztoV8PJWMHDvryjjV5xQmYCHz8XeYlW49H2p8Ml6MN7WdtijlsK1to5a1THREYNN4J1CSzw7wcqRNwgWjs/RzsfvQif3CThSojpUcx/pMpXj5+j+bIOLBhmISlEJz685zYkCm9rIKKrx72ywlolB5u/JMxm9j8Qis5/fTf3V0HkxFGQu2f0RJUCZzoH/kPIoLbOh93ziuaPdIcdto/WK2hnc28IXD82ZQpVRcuw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZpFFINeZsIxcKhicX3/LSY0WUgohgzz+BFphO//N7C30gCY47SpACs5/T60x?=
 =?us-ascii?Q?FbRkPkCKCnFQKX7m+uV3CO12gOZHViLoCy7Uu9SwtA2CTOlqA/6DVFaXEBhb?=
 =?us-ascii?Q?G3OX29GKoSeNU7ZJZ0u/b8jKfsrSj9cAnn+K0xc+gQ3R+VIagzJ5apih5uPd?=
 =?us-ascii?Q?+4N1h8RaaLbtYVGiD8BjoBZ+hhw5zqPja90NLBeCd0tzmJjAmtUh5tMC4odH?=
 =?us-ascii?Q?xjb+IdH2U7fI2fIQzYMnfod+axsr3aoe6omMQ4gvGqNBKCe4KWjI1sLPR3Bq?=
 =?us-ascii?Q?uwQJhSJLJaoEQvI5Zn0wm/p6LRzNLVe02o2B/yUPhclhPJK3JoTLUFl0lKIu?=
 =?us-ascii?Q?jV6BLX6qNhN9RdimJpyoX27GXVw6nJhjN8jlAVzJbuSZyIL7GwCPNuTPwZvU?=
 =?us-ascii?Q?uePEoLWutPGMTXwQyEV/LThrO8Hh2UpFUmiqw8xyVQ4HMA7wef9sQkZmAWY7?=
 =?us-ascii?Q?9loctPZCUNfL8xzjykr84ay+hT73cgITUMmyOIn0hceJskFP5kAZeyQEtQ5U?=
 =?us-ascii?Q?kjV8JnA7R7Uw1TEpUXIHCJqFIcO6oRR4EWj5xQyTnVPNdXKHghuDa2VQukFL?=
 =?us-ascii?Q?h7OY9TX98dH9iyhTK7iEM0u6MAsvNQNpUOS2BLqAjz9EbPCbTirDv2Co2s16?=
 =?us-ascii?Q?fNy3ALG4bqPTm6YTzZ03xO1vFomAWS06IMwe+hclsm2f3wubzk3kSklKbfZ6?=
 =?us-ascii?Q?HzffGfd6HWTHlx418XHMpz/We39x3hVjXoSLfZ53unGgWd6AvCgtSBlWOBnv?=
 =?us-ascii?Q?GuECgBhvWPaaUQtky/gfK63bTo6XmYog8jYvUSVNY1Q2mz4r6TsP590OTuf0?=
 =?us-ascii?Q?38VyNLXgq42uyY7VWO7IyTeqPvyoyv/55A4XXZFC9/Z1y1UPQyT/yU7YxmY9?=
 =?us-ascii?Q?a6z13dJ4Pw0ESRVud1qy01psCH+JRGRfKT3mpo5M6dJiz3YmJJoOlcj6XGAX?=
 =?us-ascii?Q?Yuw1NpYJOdH/datxcArSGiEG+1WXfDxuAzqpfIw08DZn3iWIMOhas449Bz8N?=
 =?us-ascii?Q?t+Cd296mTIuQiHCtj5dzE3NJXGjxfZQODe/J164u2FDc80cnuRwzabaia3nA?=
 =?us-ascii?Q?eVPk4dIeNarLHCXcKyivo9umSUbovTev4NLY74i6zDnhYEUNzHuUZGK4tVr/?=
 =?us-ascii?Q?FKTq84G/3pwstxn8WQAIv+B0YdLe057SrmuqppnQBJ6tJm1F+sMFxdwx5j5M?=
 =?us-ascii?Q?/Xwz1zUtRTUoKtmQ716du19eR0X1cDfzWarlJ1lO7un4I/NRsJ1CJviiCF37?=
 =?us-ascii?Q?VUfm5WO8pVunZpDHsBQtK1BvrSDM8f3tYg15LvPqtX2sH5CPOpnJ+8I9eYWI?=
 =?us-ascii?Q?OQdi1WoHSsP1sjSyu1VfenEJvA4qTQOLdXzwxgoMTI6Sa1N/xw6jU8BwwuVR?=
 =?us-ascii?Q?MtX2aNvQQkgbEvbm+oJMhikSX2nyG/my5JJ8FrcATg04aAgMNitxYeqziTkG?=
 =?us-ascii?Q?p1O3CCbo4V9Egxu50d/vuhFEjrynW/NJ2rVQC9xZyHokuMb6kZBzPTHnLxj4?=
 =?us-ascii?Q?xQo+E89slSYJZLuyJEIFDtX6QOYNfnUBbtjhj3Kx8aGI8yWmf9+13zU8dy/C?=
 =?us-ascii?Q?MXHhiubNMxLKx7N+EyVjHIBxT4L5sggZ4ncb5NpItsS18lBOmp3xavSkNnPq?=
 =?us-ascii?Q?4kN3OrYBsIQg7A4y9sMvsW/udPKQz8dGh6lGm/Z48nYPIfUnNq+Zl9nyx2Cf?=
 =?us-ascii?Q?4GZQcQaO6xRFZt4PpOcD7hpvCJ4siRKlG0t2Saq0s69X8q0dYutBXyNoQdHz?=
 =?us-ascii?Q?qW/K2BxmlrcD/WUpQSXZuTOQcjK2cAS16K6Ckso0Ys4TkSX3Kh+X?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: fc47dc0d-62f4-4581-c26d-08de75dd3121
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 08:50:00.6193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6n8mH2Xh6Wb+wS6I/iH2YfDLP0NRpHqpPHyLFoFnrjKV2ln720wKUGZGtXXCPZ/FSNed6kmCLZHDPthBPDOQWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4075

ntb_db_event() expects the vector number to be relative to the first
doorbell vector starting at 0.

pci-epf-vntb reserves vector 0 for link events and uses higher vector
indices for doorbells. By passing the raw slot index to ntb_db_event(),
it effectively assumes that doorbell 0 maps to vector 1.

However, because the host uses a legacy slot layout and writes doorbell
0 into the third slot, doorbell 0 ultimately appears as vector 2 from
the NTB core perspective.

Adjust pci-epf-vntb to:
  - skip the unused second slot, and
  - report doorbells as 0-based vectors (DB#0 -> vector 0).

This change does not introduce a behavioral difference until
.db_vector_count()/.db_vector_mask() are implemented, because without
those callbacks NTB clients effectively ignore the vector number.

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v1:
  - No functional changes.
  - Introduced enum epf_irq_slot and replaced hard-coded magic numbers,
    to be consistent with the change on Patch 8.

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index e2c0b6dba793..b13e0d2db6cd 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -82,6 +82,12 @@ enum epf_ntb_bar {
 	VNTB_BAR_NUM,
 };
 
+enum epf_irq_slot {
+	EPF_IRQ_LINK = 0,
+	EPF_IRQ_RESERVED_DB, /* Historically skipped slot */
+	EPF_IRQ_DB_START,
+};
+
 /*
  * +--------------------------------------------------+ Base
  * |                                                  |
@@ -266,10 +272,11 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 
 	ntb = container_of(work, struct epf_ntb, cmd_handler.work);
 
-	for (i = 1; i < ntb->db_count && !ntb->msi_doorbell; i++) {
+	for (i = EPF_IRQ_DB_START; i < ntb->db_count && !ntb->msi_doorbell;
+	     i++) {
 		if (ntb->epf_db[i]) {
-			atomic64_or(1 << (i - 1), &ntb->db);
-			ntb_db_event(&ntb->ntb, i);
+			atomic64_or(1 << (i - EPF_IRQ_DB_START), &ntb->db);
+			ntb_db_event(&ntb->ntb, i - EPF_IRQ_DB_START);
 			ntb->epf_db[i] = 0;
 		}
 	}
@@ -335,10 +342,10 @@ static irqreturn_t epf_ntb_doorbell_handler(int irq, void *data)
 	struct epf_ntb *ntb = data;
 	int i;
 
-	for (i = 1; i < ntb->db_count; i++)
+	for (i = EPF_IRQ_DB_START; i < ntb->db_count; i++)
 		if (irq == ntb->epf->db_msg[i].virq) {
-			atomic64_or(1 << (i - 1), &ntb->db);
-			ntb_db_event(&ntb->ntb, i);
+			atomic64_or(1 << (i - EPF_IRQ_DB_START), &ntb->db);
+			ntb_db_event(&ntb->ntb, i - EPF_IRQ_DB_START);
 		}
 
 	return IRQ_HANDLED;
-- 
2.51.0

