Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020101.outbound.protection.outlook.com [52.101.229.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8D02F5328;
	Sun, 15 Feb 2026 16:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771173554; cv=fail; b=OqwxBHPSGDRFLuDW0sVzIjEw4ZHAWIfv+QKBF6mzreuRYyDFHmd6LhpBnKbiB/fAjoHOUt/iJ8GiTkoYanR8BIwCJppqJav9R8Ed0Z6uienbqYxiqimb3Mr/SevuGBRjZMIYjvSzytaZiL1JcHcDMHDZsMWWUbtxXvPhC+mAX8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771173554; c=relaxed/simple;
	bh=QcbxfgbbvUXUnpMBeg/Oa33wKMzX6DgysD/SyX7UKiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XCeuL29Prbt4BqAOQGyVB0tJhEjlfATdymeBj7cmNhZXRdC76Snox5UsZB2BJ4ssXeInfB4R6b/BLhSP/4lxaQudRaPX+f5Zle5Crgd4QFE8OSLRyv9mdF+bbbIcAv+NaIekh3AtiqV/bpOS+53tzmMgXrEsR3Uy3jMapNznXSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=giLtC9hO; arc=fail smtp.client-ip=52.101.229.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="giLtC9hO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Be3cz45O4c1KR+3XUflqlj2V3S464U81kzAKgk/c0+2/b3iQUJQuIfxHSyi2yx6HbITdCpACINj9rI+wd8v28goUGwI8MppGErxVnsb0AoAYYe1Inzmt12BSrJYTYA6SSaw76gvMo77FEVPoI4mfc5uUL96wHHzyqmJI/Ltn46gcXF/uJJlVJFZBXoI6kSnpmK2PySZfcOgOtebHI7zmOIneNZt0ojB6cFz5A0RxpD4q+0ChJjHs2F9AVK1m46IJ9EEAaGvL5H1sF56PS3Z54syftgyFUkfadQ1yPWp+KKAF6EhdaCw0l+xqGqC0PNEqCNMKYQGo2aV0FNBkNEtPhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04ePWOerBr97ddJ4O89veffYXwDywyEvkQuXQcQjPK4=;
 b=KbG6mCJWnjZnUHBqk+m/EHVn1dX9E7X4c8eBaREMUfNHyc3FvYjV7Aojhls2yEDM7tpS3RowArlvsz9vrB1Q1vkFhx3vk3hcuix03/uNiJdHEkXvVKUdh47S9LxrghXJz9zL9FnCZN4SMoklI1A9xLVraIhSFXme4HXg5LWkbAq5YL4klN76XvWwmkGB+IWF7B0Vb0i0CZCmvww2a+hdgQhyO3uhVgYY9ZU91HnfnhiiLYA+jpTx7fLEGu5Z1tqq8uR0PYa81NI2LCUi1nHZvx6AR6pRB6abtko+wmPn/iv0GCfV50Aov4Z9rhz6/PX7FR9nsZjT7HVqviA2sFGtaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04ePWOerBr97ddJ4O89veffYXwDywyEvkQuXQcQjPK4=;
 b=giLtC9hOurA/jAl3ahPOj22Fltbuq13SGmLrmiBxfsLwa0w7E2MCOWogiiQ19DTV8yth0YbBxod1SeFgK7XhO6LW8qwrkjEzWQ5uBzsvkMe2PZe8W7j+85BaL5waG7kHkBCC0E1+HFMM0f8rDH7OnpuZGH+mkAPfOxAYscrSSvI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSCP286MB5196.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:34b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Sun, 15 Feb
 2026 16:39:07 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.013; Sun, 15 Feb 2026
 16:39:07 +0000
From: Koichiro Den <den@valinux.co.jp>
To: jingoohan1@gmail.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	heiko@sntech.de,
	kishon@kernel.org,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	cassel@kernel.org,
	shawn.lin@rock-chips.com,
	Frank.Li@nxp.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	ntb@lists.linux.dev
Subject: [PATCH v7 7/9] PCI: endpoint: pci-epf-vntb: Reuse pre-exposed doorbells and IRQ flags
Date: Mon, 16 Feb 2026 01:38:45 +0900
Message-ID: <20260215163847.3522572-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260215163847.3522572-1-den@valinux.co.jp>
References: <20260215163847.3522572-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0005.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSCP286MB5196:EE_
X-MS-Office365-Filtering-Correlation-Id: 399e6cb3-f615-4708-7b0e-08de6cb0bd2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xJ1TOBDZvfVxUe31sk2+yl0lqpYlNwEaHYTO+nWedb5V5bWEHzD1+Rvmdu7S?=
 =?us-ascii?Q?PlUswRF2jHaV65aT34q07VVFNv56MsxpWf4AvxxU1mgijB6WRwB6EBEqCLfd?=
 =?us-ascii?Q?H/koKocvyOSyc2Nj25vjg5hOlueAzU+3L46gi8ZewcrLQKKYAuPKBT8LXnJr?=
 =?us-ascii?Q?Ath5zWaqgBdFLB8LFxGSmi/9Jv8btsXVn5fA+l/rsBrpRbhxp7L1FpQYeJig?=
 =?us-ascii?Q?RP1C0TM8/ZeKwndgSZ8raAMye+2N/pON1TUW86oknMVhZ9P+NJvyx0+TS3IW?=
 =?us-ascii?Q?AJt/OWkQB46SnR5owomTTrWRP2LT4Q2XJmFJWTboSwzqMk6ObgclAL+70rGW?=
 =?us-ascii?Q?pYfYp3MPXDiY84jPm/UumHBXGwwUnpf+6uPmkhPSL3M8po+HdKiDIGhNpSZj?=
 =?us-ascii?Q?hYHzAglv4bP87L9fv7mVLcU3uiQIEnQvOOrIofH6RasrmcL8gc1CdEo6kb14?=
 =?us-ascii?Q?UYtWkhPOZLFK1wnSnI6zeKItNuVrT/JhFEDuJaWWf4Hw7h2ooXyekz0MpMT1?=
 =?us-ascii?Q?ip1BpB72sfJ/QJ1zEs1gNgoEHd9wxrkWBl1TQFvxgouJiHrXPrUjgFEOi/cM?=
 =?us-ascii?Q?zs8hFPCghMC8GPzRi2UPeKo7KWoNw31ibSUx5BirJzD+oLsDHjkNBjRAEvC0?=
 =?us-ascii?Q?tEh5PjypwrGIsAbxZDkishxJwfb3R73mHLOSxGYM81NubJ3wjL17LIXnA4pR?=
 =?us-ascii?Q?CasCG9XBBtUhxJwB37jINpUqUB4lNKQ7Q6QTHdiSoc0xD48hCABGPKP5FwPO?=
 =?us-ascii?Q?EOf6vaeaUU+wjpbN1cGIG6U1CE4EHNZIrzdra75Efbqo6WsSn6l7kcIWRNNC?=
 =?us-ascii?Q?L+0E/0/WZskQ3ESLgkBzqS/xMld3RENZ2sCe6rTzQ1jtM2A0qrRxusPu1g1p?=
 =?us-ascii?Q?onHfFv89prQJuaXbFu1yM3xC3chzOCJDhPjiWzSKA8GuKEYYEunQtHMajhsl?=
 =?us-ascii?Q?w5Yyjnb1tvnA7LMJqZ23yPhx1o6UozNUIR+ghghX2BLm+DLXT+daCCv/Jw8I?=
 =?us-ascii?Q?c3/BFJ8lmw2TvjE/en92BiRovWFhjKrLw6VSAmU+dwsx5bqczWxd8gj2KEmK?=
 =?us-ascii?Q?V3tNSadCje+uBi+aEbgNwKHp9xtxnNTXhoiYczkwYNdeRvKuZU7apoLK1Wk3?=
 =?us-ascii?Q?p/XZB9g5TbmV2VjB9j3ZyDwkiCj/7+oxNnYJB7XGrHLCrC9RpW6niDy/qxBk?=
 =?us-ascii?Q?rqlZbVQbJgKgBrB/xSL4DvNd4xqIdrv1tlefio/jnywOifvrqMnuTFF/9wgO?=
 =?us-ascii?Q?YATzdwq1cQSNNOxO3YeH3LXnSlqivk7QjEU0n1wpx2Jk15AqdXlWidopwppJ?=
 =?us-ascii?Q?gPFKbGh//XHE0jF9YncqQLBnZBCJ7+IEuLovYVh8aI8YjCSESruCjXUM+p8F?=
 =?us-ascii?Q?bcuIBE6EvpRFgHhTKsso+ef+CDYkEf9T3XQHz/Mb2wqz6c1/Zv2dJ1wzYIA4?=
 =?us-ascii?Q?wwM7xqYCHDnwQgHVaUzXYyTVEM1IysVgteev7xsuDk7rkMod46epHg/VtdE8?=
 =?us-ascii?Q?TafiqmkNxu7+Wk7fc7dP40jrGOfbckkCC9woOZBO/45o3f2vPqYiC4GkvHVM?=
 =?us-ascii?Q?wuyhUBsoHizzWFpEQ8eKP4q46/xsPrrB9zq0ZNy4pKUxhFB6mfdCO6Y0rmKt?=
 =?us-ascii?Q?kw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O5h8ywKMkKKzioooDUqJ561GOqCggzImgIy/6gZpKXftWgZx5uJwL7T0WpIx?=
 =?us-ascii?Q?aPAQk3iQNNHvl/o4TwWQAPOAJjEzgcFzMFPuAVsStnrn2Tv0Z614z4at7Q8K?=
 =?us-ascii?Q?MaOjXKZIwvHnJh1VXAjjr8tQf1Q1zQFnKjMdnACdFTzF723VN3Pb1b7MVhJf?=
 =?us-ascii?Q?cXgve6mKpteQ7iqLI7z4mvJCB3c0h/BcrZp0wzeywWE7kf6eWANIiOj4V0Gt?=
 =?us-ascii?Q?/0q/efylMH5CxaBJ2G7J3jSKCmzDCdm2NvTJ2ciqCxP1GWjeNtFwI+XrchOH?=
 =?us-ascii?Q?kMlrdyMq+kEE8h4yoEDF2jwQjBECihTl8UmPLNLFEGJgvSZ7VIG5MQcMcxBz?=
 =?us-ascii?Q?yZLbZDZqM2pb5na5P5enlQLkDMIpiQDL8oyo2Oq3UxQNzz6zhUscZRfDs/Bn?=
 =?us-ascii?Q?Ky7AvO4tqR45se0k5vR10UVNLc/OtPXXH+u3tB2PriIj53FT5+eHjwxC6mBq?=
 =?us-ascii?Q?GtttIi9WInkAdC+F8XnakO+XZYrq9hv4yMGNGFj6utTk0c7KXOHtatcVTWdR?=
 =?us-ascii?Q?ZY4Fxsk24QBMYhqMGZs6Q9g15g2sTSvurp3GZXhDxEVVXCyjRTzUCOdfijLT?=
 =?us-ascii?Q?cNTxF2xTeGz7gR+ZvKycjKuUw142KIOIsJ03e5Y2at70aFJfaHdvwGjdUftf?=
 =?us-ascii?Q?q0RuPoqifc4ewaMPB26IRgtiEsUc8Dw4VfOZhPuqNsknusHTsYMNMlUZgDL+?=
 =?us-ascii?Q?FUuDnu/V93pC6LsKcCAhVJLU2z+Xi767WHDVGnICKtwlObHlIJFr+q+PfbQ3?=
 =?us-ascii?Q?Cs9VqVaa+iKt1DzjqjEOFX0OSdtOpeWBa1RNH8IWKJE+pkKf6yUW49308GxW?=
 =?us-ascii?Q?viFevJJYyXTtKgvItwGMLvqpg6P9DJR/dLRqcSZA25j9ZvboNyBvFe84ejJG?=
 =?us-ascii?Q?6ENqDl0GoyyDLLYLjmehzepeJ5MHix8AnqDUsCdhkX+uPNMaogvVUt97Layp?=
 =?us-ascii?Q?oKfNR0SScExT/5XVlyIyG8V9IrkhBbffTxTGJD8ePS3glK2OQ9cs+r7Q3tzk?=
 =?us-ascii?Q?RBSFiyHvdA9b57peLafWLLJwsUXIqhBw+Sjn/jxkIKdaBw6xgQCNAfqzVmoi?=
 =?us-ascii?Q?USk2a4+KqaWkdNG6hsyKOxETYugBU1C5SycRtrerJ9bQoEi0sg+W11ky1M20?=
 =?us-ascii?Q?JFlnZlSIi6MTFbr2dN2LFPvgBf3t3daLF4NgscVjS63cIokJF7lh0+pFCj6e?=
 =?us-ascii?Q?uBL+P0CQzJMW5+xB38k3i+f7C53+/dpfKdPJWhy6TW0Jm70ufasbOkDUxyQp?=
 =?us-ascii?Q?dniEIBu9pNS01anPDEkVjtwX3V3h9Pz8esuJF5Wf+DwJgRmdmGdkfWsRpMSh?=
 =?us-ascii?Q?a3/oiPjOjfsud5YzKGG7DbNbfeEcZovnjiTTNglwUWFNtqjU3DWHrdOAR1/O?=
 =?us-ascii?Q?zSj+G1bHSHFuA55KY7HWWYH1KcMbP0m0Pr8dCagFEWfurWvNwm237t6sau7Q?=
 =?us-ascii?Q?Y1wAzXwdsv/xXhBOX8hJqz29brJnOxyPIdfT4Aa72Wt0OccVtBNjDZLMFlqK?=
 =?us-ascii?Q?ZgfIaalVVu2qLnDlDaUaQwpTczpzRmq0Jhp/ix52DbV6tVOrv7TAWE/BGc49?=
 =?us-ascii?Q?TDysCDI7heZ7iwRpP4y8VvLBqhpNGYqhQ3ZGbJRVUU/SWKwUHP05fuctX1te?=
 =?us-ascii?Q?66d1peQZ1VnfnhcQGDs8BxWZN0nW8aTPKSfGS4Ci9Js/uplMKdq6dwtlhy8H?=
 =?us-ascii?Q?EdOGxSsHa+tBrjFC8ZyTGoiifLxsBn6MQaxpHZwmYALYpzA3pgwdz//ekdso?=
 =?us-ascii?Q?TMBzE/b/w/8byEJRpkWGX2w9+Kh8RHIpjESRVHHH6lyVqTccZ9ZA?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 399e6cb3-f615-4708-7b0e-08de6cb0bd2d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 16:39:07.7504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCCBtbSh+cXZr/xSjLC3o6UOqc5YdLnUypQyKBwBmi7lEFNBg096dwe4VDXQDW5i8wmb9eXV036fmc7YWw3SCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5196

Support doorbell backends where the doorbell target is already exposed
via a platform-owned fixed BAR mapping and/or where the doorbell IRQ
must be requested with specific flags.

When pci_epf_alloc_doorbell() provides db_msg[].bar/offset, reuse the
pre-exposed BAR window and skip programming a new inbound mapping. Also
honor db_msg[].irq_flags when requesting the doorbell IRQ.

For embedded doorbells (e.g. interrupt-emulation), multiple doorbells
may share a single address/data pair and a single Linux IRQ. Avoid
requesting duplicate handlers by requesting only one IRQ in that case.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 57 +++++++++++++++++--
 1 file changed, 52 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 20efa27325f1..39ba4d6b7d8d 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -134,6 +134,11 @@ struct epf_ntb {
 	u16 vntb_vid;
 
 	bool linkup;
+
+	/*
+	 * True when doorbells are interrupt-driven (MSI or embedded), false
+	 * when polled.
+	 */
 	bool msi_doorbell;
 	u32 spad_size;
 
@@ -523,7 +528,7 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
 					    enum pci_barno barno)
 {
 	struct pci_epf *epf = ntb->epf;
-	unsigned int req;
+	unsigned int req, cnt;
 	dma_addr_t low, high;
 	struct msi_msg *msg;
 	size_t sz;
@@ -534,9 +539,29 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
 	if (ret)
 		return ret;
 
-	for (req = 0; req < ntb->db_count; req++) {
+	/*
+	 * The doorbell target may already be exposed by a platform-owned fixed
+	 * BAR. In that case, we must reuse it and the requested db_bar must
+	 * match.
+	 */
+	if (epf->db_msg[0].bar != NO_BAR && epf->db_msg[0].bar != barno) {
+		ret = -EINVAL;
+		goto err_free_doorbell;
+	}
+
+	/*
+	 * For PCI_EPF_DOORBELL_EMBEDDED, the backend may provide a single MMIO
+	 * address/data pair and a single Linux IRQ even if multiple doorbells
+	 * were requested. Avoid requesting duplicate handlers in that case.
+	 */
+	cnt = ntb->db_count;
+	if (epf->db_msg[0].type == PCI_EPF_DOORBELL_EMBEDDED)
+		cnt = 1;
+
+	for (req = 0; req < cnt; req++) {
 		ret = request_irq(epf->db_msg[req].virq, epf_ntb_doorbell_handler,
-				  0, "pci_epf_vntb_db", ntb);
+				  epf->db_msg[req].irq_flags, "pci_epf_vntb_db",
+				  ntb);
 
 		if (ret) {
 			dev_err(&epf->dev,
@@ -546,6 +571,22 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
 		}
 	}
 
+	if (epf->db_msg[0].bar != NO_BAR) {
+		for (i = 0; i < ntb->db_count; i++) {
+			msg = &epf->db_msg[i].msg;
+
+			if (epf->db_msg[i].bar != barno) {
+				ret = -EINVAL;
+				goto err_free_irq;
+			}
+
+			ntb->reg->db_data[i] = msg->data;
+			ntb->reg->db_offset[i] = epf->db_msg[i].offset;
+		}
+		goto out;
+	}
+
+	/* Program inbound mapping for the doorbell */
 	msg = &epf->db_msg[0].msg;
 
 	high = 0;
@@ -592,6 +633,7 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
 		ntb->reg->db_offset[i] = offset;
 	}
 
+out:
 	ntb->reg->db_entry_size = 0;
 
 	ntb->msi_doorbell = true;
@@ -602,6 +644,7 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
 	while (req)
 		free_irq(epf->db_msg[--req].virq, ntb);
 
+err_free_doorbell:
 	pci_epf_free_doorbell(ntb->epf);
 	return ret;
 }
@@ -665,9 +708,13 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
 	enum pci_barno barno;
 
 	if (ntb->msi_doorbell) {
-		int i;
+		unsigned int cnt = ntb->db_count;
+		unsigned int i;
 
-		for (i = 0; i < ntb->db_count; i++)
+		if (ntb->epf->db_msg[0].type == PCI_EPF_DOORBELL_EMBEDDED)
+			cnt = 1;
+
+		for (i = 0; i < cnt; i++)
 			free_irq(ntb->epf->db_msg[i].virq, ntb);
 	}
 
-- 
2.51.0

