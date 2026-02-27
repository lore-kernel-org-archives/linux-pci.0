Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020083.outbound.protection.outlook.com [52.101.228.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D416E3A4F2B;
	Fri, 27 Feb 2026 08:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772182225; cv=fail; b=QQtuMHChF3tmNWa98c756Rielg0QaOKVQOKKEajS9bo86skGcSxS4XEZISqNN+LngDqJ9RrkAwMf8D2rWSbcbVFUytwqAo8RI8VOxrF3r9ZAhmfSM0SxJKK/0gU0tRK2tqn3pLqTigarelhU66Ntg4G5mwkNAGwKAXmoCgtsC/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772182225; c=relaxed/simple;
	bh=kAkciJLkkV49DuqUiVs/lIlddw4yBQ48zUQdiAM8mOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kT/BiTrDpShxDyQ0jhL4NuBZ7zJSNy6VtFKgkLm1okcaFVP/AvLfHf0lsVx9BaYsXstV6Ye/Q+UZ7nzy9TapznwBOmGF9Wcl0vi0Kjait9WGnIQBgcg5EuACJxv++vEq8Gr9ZZjrAiRQ8oEx8UnsjYQI3Wv4DjxRqfaiTBJsAX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=bUU4vTRt; arc=fail smtp.client-ip=52.101.228.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="bUU4vTRt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=djttV1JXwHh9HmgbqqErh68KjmAgvjm3oWZX6lDxa29V+glGtA2lmzKvmSwla/VIWNVPfsBbxF5MdURv6EFNTguPwsAzsqyHo2M28+9uTb1TLXSXxnj1RBM+GqCWR7eGDbDWj1tKFvlQHFFZKGjbvZpN7rT4s3SZ47Oj8tAT5FE7ibellQ1OEC8aH33sgwuH2GcjQNWT9KI0ymG+0WyHG4emsR25M0UB5EyjT2mOCsyE4CzbQ0RVw4cW8MvrRbbx1Vydbb8p44l+G7OEoaSn0FxETd9jXAFYKnSh0Rl92CLckK2HYE94SJCfPhpBj7ZJ6HwRthTbH5FD1CTYioUJtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfamhXT5+lK6qNPenNuwWWw/vsKs0erujM6csx7Zjeg=;
 b=GE8VeREcCpzMftEmKoFBLRCFsGWOy6FFZirg5dTaNkWrnufeGh1SpEXCY0hp14PfzSZZ4V9b9f7ErXTBDhBZjAFlSOr5PxeJH4Ur2MfNoZ3oSLufLo06x9KoCNSvkltaVpVWrloSP9cBIMR0pVO4L96k7WAdj1fGqC7DwlXiYWG/pRfNaMUZuvN1PxfM5KrphWgWWZ/lB6T6vQbh/uJ7KqFar/Bp7C+2x1r/zK8qeA50WV5R/LCcKSds+KTNCtSSj/XIZ8/WWegz6vP3EvMs3LmScE2+198cCrkR1NBOUr1pSWRdrcfES5Po3O05Y7IBCMZi0gwJgbNOojvwzjS9ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfamhXT5+lK6qNPenNuwWWw/vsKs0erujM6csx7Zjeg=;
 b=bUU4vTRtYzc9YyiBRgPCMbOjz7GVWwQPnon7tUioyuBvYG/lYAmUXmg65L41lv8XQgsxfvd1rwGbxZWe4CKc1l+vqIYve+tvdAj+/GAXLyk7rxrqqjLqiWgDMkNv7ldv+FbvxHvJ4v6S/tnTwifru4RofgU7ZQXL85DmvPuOGLE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS3P286MB2135.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:196::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Fri, 27 Feb
 2026 08:50:07 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9654.013; Fri, 27 Feb 2026
 08:50:07 +0000
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
Subject: [PATCH v2 10/10] NTB: epf: Implement db_vector_count/mask for doorbells
Date: Fri, 27 Feb 2026 17:49:55 +0900
Message-ID: <20260227084955.3184017-11-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260227084955.3184017-1-den@valinux.co.jp>
References: <20260227084955.3184017-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0042.jpnprd01.prod.outlook.com
 (2603:1096:405:1::30) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS3P286MB2135:EE_
X-MS-Office365-Filtering-Correlation-Id: eef320be-24a3-460e-45cd-08de75dd34e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|1800799024|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	l8a66RAf3YkebcS0uc+k8BlAI2tmX/Hh+C4kTe8cWSiQfm2YSBotvqTiJf5gCDKxUqFZkgLTPQM0i2MFNRYnJ/b3V1Om4kTu0GWrUCe/+lMXOukiltmChSYZGTUdlfk3XGGSS7PQWowUImg3QzIVJCXpJrvuSZvVscQJiee4UKT0mmelBCwnZIzUdlNodmd261X4EX+PaJwQmMy20gMwYKsL66HSv10NUZ5AucvHAecWxqua2goNlrMp+dGrM3zP1TCozcNZHcT3UjwQydz0+AXSlpLE79A4gnR3LQTmt/xNoodoEXT0u3fu5bJy/nCr6ir6TegvbOg7GFA4HNvIKpfPyysE0Gewsb7d9xFgIyOanq205ZVhygp1yxJac2sVEcLBQp8VOa7zR8QlzoizJRPN1VftEHXGESrQ9+49rrJSUpgVFkieWqUi0YO3FrQc4Js8nkAHQ/JiLLNP/5ZnSPOvdbLI2+qRpNor3sz/xaw3pKRAtMOxRTgBZq70qPkGtc71EFiwKymXpfb17a7FpiddXWuhBLRdEswWQwUhLpFGoSLSNNlb/zyEC5AmdcFC79bSh8hpz7CA7+X4tfoF3wxPjh6VUjwg5z1KxTzApeiwPeLhtliQ/vxykD6EHZAjuHcPBhvptAJkaCUs6kElIH7Kr7rg8/kbMq72xrEsJbiBjVkyyVWstSfmFEgwQylwCORor3KPIqvw9rbR/8VCgRbF8N9L9BbC8va6p0H09kTU/CwsUuVcigUa13F+b+suTQ1mGeFrWWfyGssuTlU91A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(1800799024)(376014)(921020)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kmiJzjb361eyUDy8IZemKjs+D+vJaEbHRVeFomDXPUFt1je98tVJoCCuezDd?=
 =?us-ascii?Q?Mdjd0dubWjihlo+LJqx7worFTDg8j80yz+HMfFdQKEdxPLQvoVJAM4rZhyPV?=
 =?us-ascii?Q?33OzNdiw8efd8nqinCOybkRiw4uOwKc/9/w+fV0By0sJQoXKoGoI5d/CANAP?=
 =?us-ascii?Q?MM8/A868j8h26Xna5Js3KnVZryYU5nnFRnyeeKacJ5CsrWSIAG9Ro0xfgEO/?=
 =?us-ascii?Q?p7siXZuYt+RLv/L4IHweYG4dpDbEp0CLzcoNrv3SMdzjAYWVKFgsvKJdRyV3?=
 =?us-ascii?Q?9CTRgc+mlWuDTsYM3F+dUqxS5+TnHgRTzzgD8F5mpH99HCEsIS9OmMcdUd6u?=
 =?us-ascii?Q?j10IOCLFiIfV48qXB+X1HaPVHySXeWBinjCOyUmXPSU4rsu9gGQroXgI/D+0?=
 =?us-ascii?Q?Z7R6/ZwB3JB35W/lHjQxWH2ERmX0oUjzm4+sbFeT1IpKPC+sQQjdM+yZRJqD?=
 =?us-ascii?Q?mGJWsZAYIjPlkR06jpK/HdY1Mr2mCZMtQPaVXibPPe5l8jL5OozgVDmGptwA?=
 =?us-ascii?Q?SLZ2xdT/owz1JYTylqzbxQ4giWSCYxBr6IAXAwaeVNpBj2b4Gm0eCL+DHP1W?=
 =?us-ascii?Q?REQ770BV58MLJmKbav3EhqGClDVtrJRuDbzKvVXD9y1Lr/dMxUPXbKGTpr52?=
 =?us-ascii?Q?1DFrW+ICfgZPKh8q+2lzIqj0/KRk3Y7ZxvlPmCVFiOmH4ACLQih7rlVnRgQV?=
 =?us-ascii?Q?xvIeqctBBFQLoGLV+vO02B9/8YbWvjdV3L6RR6XkHB6OGv858/Jitq2krStk?=
 =?us-ascii?Q?J2KBgFVX2QI8T+VjNBxMfWkWjEd1Dq5cuanVbrIyjQM5tRmhdY7B1VaZeVzm?=
 =?us-ascii?Q?7hgu46hEZem81pdTwjqoqApd2I9B9qhWhfWn2+1/mWbOiZZfV1LJmF3VzP1s?=
 =?us-ascii?Q?EI3Z46BAL8+JslUHmWqab4iI9EVbUcwmLIbAZuBtoldduHyGLSlZm0ZfGCm1?=
 =?us-ascii?Q?EHwdEB6hnrqumoR9o6HH3ELWioFgiAeYFjNo/LlbmUXMzhDpkR6txwO7esyT?=
 =?us-ascii?Q?WCN2epCN98rI5m0E9d8rFeXQFJ3O0BH1/xYb5zGRDdRF69LnlIjtMJinEV1S?=
 =?us-ascii?Q?ODepP5r87nhK6dgI8P32JKLqxITjy6YrLbzkHEScobUW7OLxkT4FRRckKdLc?=
 =?us-ascii?Q?6ILekW2BbSpyDqOZLz643Sh47s7gCDoqobehvX58G6MEe//VAgfJVE8EVPFV?=
 =?us-ascii?Q?Ll8p3G9sdgY7CHIx7dMxutPnsrCvj6q2hCUKs6KBdEm3SZSTbuhOd1QOo3ye?=
 =?us-ascii?Q?YLfGC4qV8wYhiTBdpD9AZy036Y0YH0Vjo/RS/Aion4lBjYcF7uu5GujlMNu5?=
 =?us-ascii?Q?L/Ck9DKjpHEGB13tVRghpS4a0iDMvEYnIlne6zehyEbx/bcSMDPvPTPUh0zH?=
 =?us-ascii?Q?D9yVitB/8GO1bxjbCtqgDyiKUnKbpo6D3sV36w1StcuPKqHnbIlfVRBz7lsZ?=
 =?us-ascii?Q?mf/4svOSUBGJXfv4Okuc5hHOv58okrYjouwqxsgiB2CO5RknR8zZjaZahlxo?=
 =?us-ascii?Q?13SQeGEBTFtpCZhOxOq+GhtzGwbbWKANv1dGQ4nI1pv9suuMwtGmWr3vXqcN?=
 =?us-ascii?Q?mJ3C4S2HdOL//33cJZLT5hRqbcomIZO8vMZPyjFDBEcqGCFzKufhyqt2L+C9?=
 =?us-ascii?Q?Iwzy+PJT2bSY29bEIqNMlftUQELFMzRdxH0OXkOQmDrqDZyGJfR5k2uTHuah?=
 =?us-ascii?Q?oK0g+U34OtU/fSoKdl5hMvJ3DH4U2m0f6dZB7g0KAKFnsrPx+mTn99rQpKKo?=
 =?us-ascii?Q?PqBN4ZA+3xSAUg/1X8a0BhNCdGCcwlkkEsypkMlhXN5tNLgnU9c7?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: eef320be-24a3-460e-45cd-08de75dd34e9
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 08:50:06.9506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5B2OzLamVBXuc/pMBJbIGoXWH8TgBjp5JYir7mMWveyBcWKDE/EOlaDSrKJSBq1l8QjWUvdGZtDm4ri5zcaWAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2135

Implement .db_vector_count and .db_vector_mask so ntb core/clients can
map doorbell events to per-vector work.

Report vectors as 0..(db_count - 2) (skipping the unused slot) and
return BIT_ULL(db_vector) for the corresponding doorbell bit.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index 741d30821390..d420699ff7d6 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -420,6 +420,34 @@ static u64 ntb_epf_db_valid_mask(struct ntb_dev *ntb)
 	return ntb_ndev(ntb)->db_valid_mask;
 }
 
+static int ntb_epf_db_vector_count(struct ntb_dev *ntb)
+{
+	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
+
+	/*
+	 * ndev->db_count includes an extra skipped slot due to the legacy
+	 * doorbell layout. Expose only the real doorbell vectors.
+	 */
+	if (ndev->db_count < 1)
+		return 0;
+
+	return ntb_ndev(ntb)->db_count - 1;
+}
+
+static u64 ntb_epf_db_vector_mask(struct ntb_dev *ntb, int db_vector)
+{
+	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
+
+	/*
+	 * ndev->db_count includes one skipped slot in the legacy layout. Valid
+	 * doorbell vectors are therefore [0 .. (db_count - 2)].
+	 */
+	if (db_vector < 0 || db_vector >= ndev->db_count - 1)
+		return 0;
+
+	return BIT_ULL(db_vector);
+}
+
 static int ntb_epf_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
 {
 	return 0;
@@ -554,6 +582,8 @@ static const struct ntb_dev_ops ntb_epf_ops = {
 	.spad_count		= ntb_epf_spad_count,
 	.peer_mw_count		= ntb_epf_peer_mw_count,
 	.db_valid_mask		= ntb_epf_db_valid_mask,
+	.db_vector_count	= ntb_epf_db_vector_count,
+	.db_vector_mask		= ntb_epf_db_vector_mask,
 	.db_set_mask		= ntb_epf_db_set_mask,
 	.mw_set_trans		= ntb_epf_mw_set_trans,
 	.mw_clear_trans		= ntb_epf_mw_clear_trans,
-- 
2.51.0

