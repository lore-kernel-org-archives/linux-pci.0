Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020092.outbound.protection.outlook.com [52.101.229.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9362939C625;
	Tue, 24 Feb 2026 13:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771940109; cv=fail; b=O2hZCVlsVsPYfCM6rKb/XS1wVQH2jHvprXevtFVLIuxdnz4TyjwXeODlOq+9/EFwythN7hCJ8vneSBf7Yf37DQG095q8VTcaP9ozbURzqjKpBgphVxksBPXVwWp4Sqx/c/q6muwwa2M9kLDjghR8RHrTlqZMeX8ODlmeIfI5iU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771940109; c=relaxed/simple;
	bh=xMEUHJmSx5IiASRX0DYd8sN+uUjRz5yfmLLeOYnzy8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bSb0kjgIeNF74nKQLNqkSvuSZls63jsMYcLw9Pas0xeFFwX9QeAKZL0IS4KWAjlCppgfKQe4vd8Rtal2YrLBx3xk43RRJJx3HuBfPSLuThAn24kueo1OcYbvZZGCwH6xFLkzZGU5BID9HLly0vU2Wr/USaK31iLU5+KX3Ianzvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=k5Ucyttj; arc=fail smtp.client-ip=52.101.229.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="k5Ucyttj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hDFWpvvHIrLA/NL+/l/EPiDN8Q5a7ipyw5I7Uw9NBRB4g2MMfyVCx098vvynyJXZ6EoJw2MnGAX0tKKOo8CRd1E/V0nXkvkNP3zUkw+R7iloTqx06OBvEqix5v0JFoMtYggqEk5c++Mhy1saXyDbN56997xFTaLJ2c5ESdBPQ7Z7v7hmvH4lbZzCDk/pu6FkgP9jbTMD1SiQDvAcUEnNlO13cPHCGKlTFE4rovGbF0/YxD2psKb4Ik8uXaOkNFRCRYnmQwmPmIVsfFiBMgJTkj0mBbLBrzam6x0LQwr3w9T81u0fJFEInvBB3SS6Khmy1C6IA94N0BIp3Mh1wyHflg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0kvHR/IsL3aOMsLp8XtJxVwOqUwIozh7K0wWwm64IA=;
 b=FcGCNxBzOkv2mdCZcrXQZFy0tomNflupUy2p29lTmcwWBrS4PFfrh1B2zVr0BRhf2U7EaZ1NbRAqsJ08SI7fjgvw2efNVhEBTgx2V+22DTbqRVa2EIJe/8qUlw9UPHR0EbipbaL7LOl3KSS9G+66LvGV1y0/eQ1ibEbNUbbYJW1OiNVnwq2xfeNnUDnaqA1SnHpddYi4a9DmMrXFM6C249JU9RQPr4FL9NtUxeOYwX5t1CahUN57rwtAg4TwHSFmQuEuIzJudnIbjq8Mx3nf+M9QSuf9Qb+9bu1jxfUmyZbHhgu+YMkFEpkF9kuqRi7Z+WATAejtbLkOKMNgI8W7yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0kvHR/IsL3aOMsLp8XtJxVwOqUwIozh7K0wWwm64IA=;
 b=k5UcyttjbH82NcW7SHR/e35BXaJJRzniWQvNlHMyWrhdiDqiSqlTLk3A7YLmEsyXmU+EmPBt7QZQR5ayIhO+EDWU+Yqv3ZlnLGcCqDmvMceQVHBKtT8d/cTs+7gMRs6LPs2rKfbKvpoRJUNPUUXCrDhtD14TUi8KDnJYG1CMt6Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6278.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:410::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 13:35:05 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 13:35:05 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank.Li@nxp.com,
	kishon@kernel.org,
	jdmason@kudzu.us,
	mani@kernel.org,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	jbrunet@baylibre.com,
	lpieralisi@kernel.org
Cc: linux-pci@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] PCI: endpoint: pci-epf-vntb: Exclude reserved slots from db_valid_mask
Date: Tue, 24 Feb 2026 22:34:53 +0900
Message-ID: <20260224133459.1741537-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260224133459.1741537-1-den@valinux.co.jp>
References: <20260224133459.1741537-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0065.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: 08e8d736-d7a7-442e-3efa-08de73a98555
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S8LkiVwX77zszbNmA3tViZt3b7fyhkEGXy9M9mEgojivypFPzDpeuP2pJDzy?=
 =?us-ascii?Q?SIbnlRlS6X1CoO6bW2afUrecRo5WP+LqOCuULrWhrV6uGKOREplg5q67o0h2?=
 =?us-ascii?Q?C/o43NHstZcOON/Z6OmHHQCciL1rLEs88sBUDTvYcmSiIme7K0Cz/3IMBLxD?=
 =?us-ascii?Q?qErY2wdbwMb1XtBEvacO56qHGgMu2jsSQNI/JHEGbvsDQnVWzvvzuGYvVVBg?=
 =?us-ascii?Q?g5e6UUcdK0En6TqaaBWVAQfBJg+r1pOrym+TaqegfKtZhHd0e6CCt4L9G2ft?=
 =?us-ascii?Q?M7dUHWVZ0ObQL3/PuDPnHfHbBzRMaUujhVPA2PLwILuE8EIF7u3k+O7S7+87?=
 =?us-ascii?Q?KwIG+xTSytyNFHb9H0AtNxlqLZwQoyP8R8dtzIDXegZOOPRu6+r0nHuzrZrj?=
 =?us-ascii?Q?sogE9vFok7OB7bjsGjV+TiNe+HOkqATMhG5Lfyp/wdcRBzbfD3Nay4ifUkwK?=
 =?us-ascii?Q?DMKYRsbQxznRRNWfDqjeEodx8vVaVBdsZ5DrRIhvKbgiKKuzW5eWmdVMwnoA?=
 =?us-ascii?Q?D1jckob1J28Ymhb0aJOd9Nr1ZELZ/XZDoRmX83C2hpaZbmRUAlISf7iWrFa9?=
 =?us-ascii?Q?simtmH0vu3SOuRgzQbfAux4xl6wwlx2gVAHEhiMnFuVOZ+rYzBKvAhy8B598?=
 =?us-ascii?Q?wzjvKMZs5n5G5/dw64sOwMwi7VgbCs5G8H/2pNNXIA0gUDJ9smQuKZfKh8gD?=
 =?us-ascii?Q?+z2zt//kFVFnkO6lGAtroKyTt16B9nrQaUhxTs1Sd2CE9VpTs+5Zt5g+2a8e?=
 =?us-ascii?Q?qygrvM0jQAs+YF3oPztXTuhpmAkMGQa6AQieeG/8lL7fYLsYgVsn2qpYxyAw?=
 =?us-ascii?Q?6yZ3NqX/9jGKwZRCx57bK2ESXu9MtUupQkFCnFs/DDr7WSLeoatq2Zskev/G?=
 =?us-ascii?Q?ieTBE/AJ4Y4e0MVtjahaqbTqevQD0K1mxdYBBUhq88lXExMl+Uz5pR31447C?=
 =?us-ascii?Q?scbc8rEPukWoTEMNYXA+iWY2T0rD7HQoOTcRCh/iLvBV4u25eIMAg2O2EcmT?=
 =?us-ascii?Q?ZzCvWmebZddzBoGKZ3lnNvpE/dTqwraiIaJmaSjt7VoWkyaiQtVcX9pPKBdq?=
 =?us-ascii?Q?t9vQcITebyn7FiyAwIu7DTOWshlq9Dbe7/JFAlfdKJeWrwY0v8ooY9wChUR6?=
 =?us-ascii?Q?66R61l3wpTNdxhKzuhWBzDPhqfn51hDOBmX+9DOnfr6kCSMkRkiuYWZBCLV/?=
 =?us-ascii?Q?uxSCymvRDGCRIF+O88WLwW8az6QZJKlxUhk8G+bGv6gDXZzvk4L6F9qRDR4u?=
 =?us-ascii?Q?ZOubqhDx+/fQAWYjFWPMkDPJLMhtLqbek7vQi5QD5PcwYpGh0ZOrpqK+q45A?=
 =?us-ascii?Q?leNIT3wVbH9aqc6A4joQO+sy5uqi/z1COKQfEFnH1JNIfDdTOq+WAVwm9Nbm?=
 =?us-ascii?Q?k+RPpJx654CfI9n4cYaAKB4ds6IdzJ834Piri1hGITVbbsyds7Z8YhwRzvtV?=
 =?us-ascii?Q?/0YPNgRgvJJLUVogP30C5L3l2/jZjosavBJnhXkxRqo2kX1CdNVNYkJlld0s?=
 =?us-ascii?Q?lidVTORuPmUfIJrX+j4ortwnB5KETaS7179bCYW85f+UYJxzcMQwANcT8e42?=
 =?us-ascii?Q?rLK8OGoMTGw7LQGy35JjtnNlDfwnJ6huWxvEZVQibA3ukOv5rPhtdLQEg6Zc?=
 =?us-ascii?Q?kw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z1AOuV7gmqOXie5y/kTl+xvo+hMih8gBT+5iMuomoOp3T2xP6DiC5h33BIHx?=
 =?us-ascii?Q?Pdp0g5nd6s45lh/2/bbToXrp6YHBT7tWHxHI7e4KwTLoau4/6/IBq+Gz7zeT?=
 =?us-ascii?Q?TORWB8rHc5M8rUe0yzVrgxXsZruG1/DdlA7Le6tYqbB1YKRfUnh9nOKNaiFm?=
 =?us-ascii?Q?XaMkFKSbpRZ4A7e4ktGh11nf4b94eKL8rzOi9ZyxkWsB46a5SAQHA6BuMTGA?=
 =?us-ascii?Q?7f4pKo6B95oyh90NHXOobzx9oNMQNIOy4virZzMhFd08FwsiOteZRRauW/pO?=
 =?us-ascii?Q?BiF0ATvR8FniVY6VhVorck2dXyShGZXhijOJ9xH4Om/sqko5PACzPQLEjeug?=
 =?us-ascii?Q?yRlkBsffmYU9ywUq8DmD2m3BvDq2TgEJFXDhltUTanwluA1x0wKWUnFPhRLt?=
 =?us-ascii?Q?Mv+60GlHAx3S096D8xjBg8EqqsnrNK3zZtTLNErEvHynshrgxLQDX1cOaLtE?=
 =?us-ascii?Q?oSsKSSuStbfr6QPWg7QrmC3OyC0yYBEK31SYj2cyAJACrcXcPA7XJas3mlWj?=
 =?us-ascii?Q?vpdCyvKnQg780KDhupcJzjbbroaOQsNW+20EN44qiwZGXKPGrL0msTdTcpmk?=
 =?us-ascii?Q?ubqjcGj3mxt2C0r5H1MNgc4ZpDvY/eqg5VjLMDt/Bfrf1zsSe7wNpx5vgysP?=
 =?us-ascii?Q?gdml2/9RUCau4WRMHC33idx2OtZlXRR/WkWJ/Lur2kQuKw40Ubldqkv4OGZ7?=
 =?us-ascii?Q?jAj6HyZ8yUVY3X975ysqXElEFmWCNQ9Ap8JLsXVBuwR3n+bPY4Is/aHBuJGk?=
 =?us-ascii?Q?waLgz97ABJMfzGDYiegl26Oc2aJJs+nFIxx+J7Nty/Or1Ma/wL/iFcIWzOY3?=
 =?us-ascii?Q?EsBY90k6XwpQuKCJNIyXbY/gRtpN/HZ0uVkG0FzVqC0FNKF5hbUGr2A1MgtQ?=
 =?us-ascii?Q?sYyvpSRDUwIPvMOQhqptmbeY2RcsbqMeCTNwmaOOq6NCmGV/BKi1x4TfY4lf?=
 =?us-ascii?Q?5CpgV1H6MVR/EFy/DyttREyCLgkiKh9lBIlttoPpAlrqDptijhu/ILQ65cfN?=
 =?us-ascii?Q?DGgS9c0ZVsTvTmORNtH/xUH8D2n+AN7Z0SEXmNW5yL/H/awjJT3R63DsANZE?=
 =?us-ascii?Q?fsJMLHCZH4mJtm5IjA7EMmdC9mmHNw7KUR/2vuzDhzRYwZb0y27PTpOEB/Sn?=
 =?us-ascii?Q?iRVO7yD5a8Pc9EkvUp2fmcUt1lVspjEcul9XZqkYPw898ZS0GwBas51//7Wl?=
 =?us-ascii?Q?C8Ce8oS7p7XbQyC1gGPqB5ETK9viI2+h/JwsCbi41SxqdrfOtbkVWLXZmAiu?=
 =?us-ascii?Q?kkR8jEJfcdpKKFtGY3D6pQWD2GJDU9Kd5gxNG6ScL83IoRjlF6Yc+uRenBqq?=
 =?us-ascii?Q?oRtvdYw1CiliR4luyJcQvQrlOYmZE0p8U4Jdb9u6F7x7tgYexlCbUVl0p/M5?=
 =?us-ascii?Q?+fyWUrpmdXBg3lgrEHrKfSbj+Z+YfzoJJKj85LhdF16w96qTb5Qjui9JuNlO?=
 =?us-ascii?Q?9yKpBuJ3eiDmnNI7eUlXF5TD0E39h0BAiBiIe3MOMY0Vqy485xQvOfn7yTkS?=
 =?us-ascii?Q?KurODQo3tDKfc4HDd+OLTH8iUEhJY56vI/yDoPxzp5l5b+JyxvOuzJ4dxsxa?=
 =?us-ascii?Q?1mm78fkmiTREbNDeLgz6wXp4iHQxwZ7ysGCoYtn9riQ246GwQUPDoAvZ4kC1?=
 =?us-ascii?Q?8HugHX1lnwQNrmtKgS2LmcuZre+IidIEDsBTfSDVtA1uSS7BwgrOT/d9ANYm?=
 =?us-ascii?Q?loBjsNr4izPiTw1u9fqE8Z6Mk+fF2mXGaMw8nzYFXVZYqoOE7l0TZIzsgqPS?=
 =?us-ascii?Q?Gl27rcQUiRU0a6r+crAfVpLvqefGBYaqr5oWKcQKxPDqWEX2bCzE?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e8d736-d7a7-442e-3efa-08de73a98555
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 13:35:05.7420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 63xeAaCy8DppVULmw2DK8eV0UX4kxSBn2zBPwzX4xbP3Tl84cNXe5CdeT1vOsh1tKBPL/omVM/G10AKtd80MWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6278

In pci-epf-vntb, db_count represents the total number of doorbell slots
exposed to the peer, including:
  - slot #0 reserved for link events, and
  - slot #1 historically unused (kept for compatibility).

Only the remaining slots correspond to actual doorbell bits. The current
db_valid_mask() exposes all slots as valid doorbells.

Limit db_valid_mask() to the real doorbell bits by returning
BIT_ULL(db_count - 2) - 1, and guard against db_count < 2.

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index cbce50afc4dc..2eb3db035644 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1269,7 +1269,10 @@ static int vntb_epf_peer_mw_count(struct ntb_dev *ntb)
 
 static u64 vntb_epf_db_valid_mask(struct ntb_dev *ntb)
 {
-	return BIT_ULL(ntb_ndev(ntb)->db_count) - 1;
+	if (ntb_ndev(ntb)->db_count < 2)
+		return 0;
+
+	return BIT_ULL(ntb_ndev(ntb)->db_count - 2) - 1;
 }
 
 static int vntb_epf_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
-- 
2.51.0

