Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020110.outbound.protection.outlook.com [52.101.228.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF44B390221;
	Wed, 13 May 2026 02:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778640584; cv=fail; b=TBe8vqgwAkUYMadGWgQ6u+GSRYY/X6RWsHkNyb8+HDXPaPAAyhiv237vbgqfuHX6AkOChA4PkMdM/Ka/SBIJ6eOUm8Q82t+WtcjsyKChz14YwabsIFeITNKMPRzI+EQYDr/iszhx/ettjXafBud3sUQBy2nfjg4rjqjkyFf3Ks8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778640584; c=relaxed/simple;
	bh=7QiKz55ykc8zGmtzQZQfU9txn7cUo4ijR5M68FmYorM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p4cS36uKFz6E0uruToe+qi4fAOgqDiRTObGbcwXlz+ibtqTbZ4DRfMlFp7Org4G7ZBJ6GrlavAZ6ykbZGRPMP9fg1C75C57HH0PIs+HkAbA8N2n2x1P3MNrpePSOJUfAFPeIk7iamvdwPfAQsTqw5y1cle+v2CKzgDnvfgviRqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=mNJ3M7c0; arc=fail smtp.client-ip=52.101.228.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="mNJ3M7c0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nIUWPlwZP/C53VVHPCXQYtM+G9KjmnlceZOjqqTCam6Idak29IGMAXgejAA61EUXEjqAbdYLLM4MevqIxup8wy4NGMZT+ko+9F/VKVyEh2jj0mMPF0wYITEJm7v44AqYxMHuPrlXRx6KCBAMbWwZ6doH3RZQOh9uTU/01EqoMbSu/SwTy97Vr2TLChdk9sizOqYoI+Fo1ikncnuuEmpEA5NSeiQugnQsgVwF3l7SPaGTotIkhHTJaqdPJgOrkrGwHv/RCsQniaHS8SW1riOs7+pJXz5KrdQV9UnOF6ytzr22TsrLg3j1tNU7vyNiVbLt97kBno25dCavoeBN22sB6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7sDfVb/vE0GxGRLTFJPgUTns1EkhEBtekELiQRQdISA=;
 b=HxEBZtVPpelrtN6wkbMfwCM3O9WTq6fX6VzjTikR61VxhT9SlNEtZmv0C31Xjs34fvCh2ITNXYVIVVhPYIloSeIFsTAJWpM4oLM9JTuOmSmFK8g8vvlZ828qSIHb69bNZc9Suo1IkqToaPzkS5yXWLkhYWn+OPIRBsSzRwEs1YslhbPY+2rQusKLrTc7KtdyMABW4qjewZbz7qnfweCVc8XGbZwoQG60qFuCOsoI4Kxq26xxCs9ZhDe0QbaRDTVmBL9KIniadDjW7rcBb0QYwN4f2amDjNoWo3vUiobvxoiWcBHheahJBALa7mvlncXeTb8IShwXXB+IbGjcPBMbyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7sDfVb/vE0GxGRLTFJPgUTns1EkhEBtekELiQRQdISA=;
 b=mNJ3M7c0Xdl1hHUfHrcIAdLkMUdr/1pZ7k0Iq9NtThuEj2S5HM+Qrb8+xwEoCrhOv7zSz2ZCkWpF/OnJk5r9ujia111yO3Dpy9P2hdtBZyyRoV8SoBUvBskQH19gZoi4PExyE0uAVHIetBQvgBUiEgD5XcY86o/jcppJALjI6Q0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB5170.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:161::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 02:49:29 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9846.025; Wed, 13 May 2026
 02:49:29 +0000
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
Subject: [PATCH v4 03/12] PCI: endpoint: pci-epf-vntb: Report 0-based doorbell vector via ntb_db_event()
Date: Wed, 13 May 2026 11:49:14 +0900
Message-ID: <20260513024923.451765-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260513024923.451765-1-den@valinux.co.jp>
References: <20260513024923.451765-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0048.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB5170:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bcc0edd-e474-4365-37f2-08deb09a4102
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	f4eS7g1ODJDyJMnRDJLMPT6Os7wGXWjAzF3vBGMQzWprkVS/36rZTmPaaiLYTDhYg8qrjqGGt0D5AF3kUUDFvYU5Wv/Wi19P9qZHwMFEeoLNwJff2hBHniczc5pDK8gF033f7xZgVwyh9C0IsOEgYR0UJTJiHRnQwltJp1ibIX+0Q0HfU13Vu5uHUHZm6CbRUsvGbFum4Gj+RZoaXF4XdhtuMQ9tvMunr9JxykfznT0WEozeGOHY/o6p8uOpqa266VPq5+cVhT7WE5l2DCQmDRcko2Re7Gro/iYCxEIeExdzAAtYIv51aEWtv3Nc0I86EfrOmDYR30VRD60OZWKQoX1AZv5GaVb8M13x+LVOwZMnfnVV2FRtoEaLA26FLPzsT+6TwtJRo+8AlhIohNHV+G1Fn2+6/LqZWIM10s9+F1XNq0UzFb/XDeuSvEUSe3UJBjSt2TQLkr/uDMIbgZVPv4c1usP10tN62aMUdwpK6thF2VWqsiGyHPROy69msS468ty6I/rWODErN2gfDN4YM/r5jWpCoIQLdKJtf3rmZGUNpTCZt2q9/UUt1/msSUBiqWifKM9fDy2onXVgTi2UwmwZbhtaLHdct6aQrQZOzdhi5GJ4lZ884zYXeQPG+zZnDK6VHK76M002ZYlzkrqDhZuQqJ5FTiYfIyWXgHl7NEuUKyY7TcC7s+UsHYl+mOL8ILCeKUv7/1J4EOLMY2YQI3i+XCev2HsaaRXfxodis3c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bRkReWgbRc7rvxj5glPlkwgDAknvcWp6BxIGgkunNJy6RIX0AJiP/1acaoQv?=
 =?us-ascii?Q?U3dKm0XYUuiY/qi262rWq/kkuXMCy+SbDOnYUB4QE7t32/+LXenYOFEnPGX/?=
 =?us-ascii?Q?Qwz1hKSj3Z5nSyDqhFs9JwZ4hPxZgRwVGXexVGsVjGc1n3EUqUf2DSSLMgtV?=
 =?us-ascii?Q?gcsOXMwvip1rXlS+fqAuGFThAdDnFzkcANfFNr9fdYmIQfsoci50nQZUz8sn?=
 =?us-ascii?Q?bwV+lPap04kTPb5PXXPQxFcaOyLPxybBCFOWMmmas9yxrUB47xHDXEOB3jMs?=
 =?us-ascii?Q?bCTmSLBz3NNn+tG8/Ih8EiAffZBkSYwM0iNntIONoQ4faoie1ESM73gJWHEb?=
 =?us-ascii?Q?yXgypxL+hea+e/UkNoGWbd5Ga5db5T5tGKkFTXgj437gAI56GnyUr5DNV6U+?=
 =?us-ascii?Q?SpudnyzM6kOgClWvaJEIaPL9MqHweuh+URp2tH9XfGzts2YYlpovnhwbuBST?=
 =?us-ascii?Q?eNPReqqqaoSr5V7GgntKJwbt4yOSM4oWmIy/7nLfDxbbrS/eRBIAWFeewh+b?=
 =?us-ascii?Q?Jy7xjvctt0vkhcBqpU6YLiTzdeqZetjE8lCS+EGnBXUvrYOxLSDAzszrESpv?=
 =?us-ascii?Q?bMGaVFcAQntIK71zWujIAF+dNKx9z8AGvvQbg705pGH3TjwunS6n6Ov5wU3u?=
 =?us-ascii?Q?IepP4pw5/lNgm0PzTEt7ZFUpWEMqgczHi/1SvPFI+MiEfWDKvLX02PvePuA6?=
 =?us-ascii?Q?UQtZQD5jCHpAMITdVy40qXLqYZ8XkTwfAkrC9wrB3YNAmE+nKq3gFMeWQGyg?=
 =?us-ascii?Q?iP3G+rz/HImTZTQBAIFGU7zST2IpL6iUPSZCYSn7IUNtYmSI9Cs4V3XxakeL?=
 =?us-ascii?Q?s0FfrBBJ3FRm5YhVWe83/Q4mhOhCvw2ulyDj4e+UBOsiHgomLBO64fakrwKu?=
 =?us-ascii?Q?hZQHVxRTefYKRTUzxr2DfCVxN3WAX9ZChhaGECOuKnDEs+4GTU453zvQHBQn?=
 =?us-ascii?Q?4DQp9qdvOYD9EZxGLyGy2vs4vGLdKo/6ct52WHcVd46GOiATVYPg1Ki81mru?=
 =?us-ascii?Q?Ju2+7IzNRCGfY3K7rVSKvqfZOVyaxng/Iqq1cZYT3Lk2g/4Uu+mONMpMGNr1?=
 =?us-ascii?Q?l10KIOgnmiNqrir9QObrNFCg57+3jorh+Rw5gIpqVH2J3qtAqGZprUlHEHvO?=
 =?us-ascii?Q?UYit3c8Wa8cSQ0rhvKjLamWAnHKz9aS5jy9XiKZzZkQm+qCOi45UMYDs5ca+?=
 =?us-ascii?Q?sz0aTdIQk2un3TSoXKK4Soirx+bvxn5b0xBgJS0tu9CWvxUQVyopYRWXj8A1?=
 =?us-ascii?Q?1xoyNQIu90sbgd8cEL+NeIIKJV34ytPlOsF9hZNtbyI4qBlBVpFWTXVZ+Hxk?=
 =?us-ascii?Q?5yPmeZKUnKC2bzrG6R0sfIwMRsUGS6iiSweZmbJwyDixRqK72W7FGhqsJnFl?=
 =?us-ascii?Q?8SYF1CPG9kL9Oy8vAk3lBXOBc3S3oyaFo1Eh+YbZUi2vkhWyEVyOqwjCYQxW?=
 =?us-ascii?Q?1n/SIORKihWFLMWlJUqFb8nnuZolaSyf4KZjcIWU+gbbpxEYvcA8AV6U+IBv?=
 =?us-ascii?Q?//LcZ4J2Lg79Xuq1kc6CZvhDcGQkXqCVSP/6kPPYv8YopfPRqEdIEixXbmG3?=
 =?us-ascii?Q?DtWv1a5NV/VGI+RlJIjO/sJoBXVF3o9YnGA5aSe2Qp/+9niqyTkrcdGP0eif?=
 =?us-ascii?Q?BHzgW1bqTxzilKCRm+7Q+uYrImiiKB0+o7TMtXEXl6FKxAFy5i7h17bSKeVT?=
 =?us-ascii?Q?sXZXfcZ8EtpgPzRuFHMb4aHAoA5TTFMfpUXl48gpjOXb9SQG+dPcRRqU0kiV?=
 =?us-ascii?Q?1usv6cb1XNXm77wkSGponX6z2PC8VJLGoD0QyMhaoJVePbVM6F11?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bcc0edd-e474-4365-37f2-08deb09a4102
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 02:49:29.5933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /W+NfadT806ySZu48FSWV/9MSQWyrOKfpr5LEGxL7cT0LJXLPGl4LejrjgWGTWfP3y54s7UfMip53u0tHnp6Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB5170

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
Changes since v3:
  - Use EPF_IRQ_DB_START instead of a literal offset in deferred MSI handling.

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 25 ++++++++++++-------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index cc0b356973f3..d31e2eee0869 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -83,6 +83,12 @@ enum epf_ntb_bar {
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
@@ -272,10 +278,11 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 
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
@@ -341,10 +348,10 @@ static irqreturn_t epf_ntb_doorbell_handler(int irq, void *data)
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
@@ -1450,8 +1457,8 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
 		while (db_bits) {
 			/*
 			 * pci_epc_raise_irq() for MSI expects a 1-based
-			 * interrupt number. db_bit is zero-based, so add 3 to
-			 * preserve the historical slot offset.
+			 * interrupt number. The first usable doorbell starts
+			 * at EPF_IRQ_DB_START in the legacy slot layout.
 			 *
 			 * Legacy mapping (kept for compatibility):
 			 *
@@ -1465,7 +1472,7 @@ static void vntb_epf_peer_db_work(struct work_struct *work)
 			 * interoperability with older peers.
 			 */
 			db_bit = __ffs64(db_bits);
-			interrupt_num = db_bit + 3;
+			interrupt_num = db_bit + EPF_IRQ_DB_START + 1;
 			db_bits &= ~BIT_ULL(db_bit);
 
 			ret = pci_epc_raise_irq(epf->epc, func_no, vfunc_no,
-- 
2.51.0

