Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020136.outbound.protection.outlook.com [52.101.229.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912693822AB;
	Fri, 18 Sep 2026 03:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789701653; cv=fail; b=sgYFphXw1f0jv23eD3m8bOR7HKZc836YxCoZlF7mmwAz/u8yCEQt4hz1RtmWHmT6noxGGT1/PUKLtRzncSWkAnvQqjJQoDIGhfEtOqJpIn+C6xWui4Fa66gipcL3xZ+pgDMfZyzTOo569ZnNe2MnWWmv4cPENMlYZYb0kbhAY0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789701653; c=relaxed/simple;
	bh=rYS4FvgJnAo+CPqxmjYVr7aDnZRlXvF4vEIMBO9awqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bS0OrpHnpR028BJzawFQD6zlZjSaYj90VrGXbCApEd4jxa2/19nQPpWihm8CKROwWOkvpys2mZj9VdXJC20ScFirhpsSSYS2y1boSaD1ryB/QJBNBAICPsBU0dejqSRz/j31Ry4LDWI2rdVe6WSR675MrLulXNaFbYwI5VuThVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=b/+WTcqL; arc=fail smtp.client-ip=52.101.229.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="b/+WTcqL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNgtLB5p07uO8qQffPNjWqDpHRpqszNFQRZyi+GQs7mcC7LkBkQEhC3VAAosaSUw7RB1ezJuvZ3Ef0EEZxbuufCTirYxkMqva61ajK+RkxKPlG7sBD1xBMDk+kfH3AqCDb1aVN6aNyUj4/2ZbGEv4BrIas+mcSSLeezSv/uW+yK7fz/kyZg+DuAx5uWTTtaqR4g6gCGWx3zxDrJxbhylvKmf7Xw1B7zTCNMoHNK4L3pyvZXoxb4aQXXGDwLMWjAYofCTviiwNJGExNg7Z8pE0ji9hVdsJIqzPJ/Ms/ySXGItfHq+hN3tE5e7AI69sV049otgdh8g9DKdCnx5sj2VKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8Ery4wQBgr3N5FISdI+vyy7NBewcW1BXqJnnC5Fl/k=;
 b=CE2g/+REcoCRBpAbcWISEe3+QcW33Sbl2DmKJ/xyLrcs1ZVu+WO5/zUr3xHjSBFI3YSKNtm5kwQ1he47HYf0pL13kCDp7c8ugesMBluG3OwybOEr+v/9+bKUF4qfv/a5i2s1efT6Zh7T+y+37M9bGiJuYsueFWEcKdkoc8a2a5Bhw9xPpesmBflVA2jUD7PMfZ4Ax5lK9+NmxtN+XkoNCw7yeC3iLh2s3p3PJMS+Ay56oZ9z6mC++JQ0OAfGGul5Lj3FolAJPwHaimwOFnY89hIwFZB3CWpSl08wyvMBf8/6Tyo/dhhephi0QraS5SlgIsMwT1H7jquufwT/n7z4jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8Ery4wQBgr3N5FISdI+vyy7NBewcW1BXqJnnC5Fl/k=;
 b=b/+WTcqLW8I+IdoOEteGA65IRxI/fYdoz9A1vjFHKPtPey6APvw47JhR4+V5Q6m03RYV0HZnukvgwjTxN/r8DOWfAfCZKNOTTNH7UfHU3fA5dSTKO5cin9N7Xha6iwzVv22bX4R8EnmfCtCcctuNRVBNm1MvleQlCqxguATYdzc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB5141.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:350::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 03:20:46 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 03:20:46 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] dt-bindings: PCI: rcar-gen4: Add optional "aer" interrupt
Date: Fri, 18 Sep 2026 12:20:30 +0900
Message-ID: <20260918032038.2216471-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260918032038.2216471-1-den@valinux.co.jp>
References: <20260918032038.2216471-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0013.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::15) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB5141:EE_
X-MS-Office365-Filtering-Correlation-Id: 62aa2728-fce2-4b41-128c-08df1533d47c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|376014|1800799024|7416014|366016|56012099006|10067099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	is+Ja0VKMMYKNz0l0L9ln3fZI7AkgUZFB/j2psqRG/B9mafA76DPk5sVbQgPHvcorG7exxbN8RDaGiZuxt9V8jfAnnbiC0HDBK/jRtEp46of7iynDAIp7nQ2duBLvCv4SJMen2e2O9EZIo988debPIDOn0pnoKnhcmSU0/baIWwbhB9USFQA05nzSYKOv6FQW/1zkK34exbDc8K+dwZ4a6vHqO3eHXfx5yi7RAUzLSg74eg1tvay1w6k1t5bM1mbNCJn5R+V6e5NU7qMkXG+MBm8/Zzivgd4k7Y9FjPGQYGpLKGHynIFKLTZCK5+bk95g0/wJnYB+EYgGo2S2XfuhTTUt9r4qkS1tu2HnI71lVW8ou2DPp79yW6Yj9HRV5UKfUfCalZBKxyWOQi/iAmR8i/SJGPUA9mFB+1dFrMjX4CJRbPGtmRlP7L5eYbKtsvYKym2gpNSBOPORfJU0zCmb0rhbYU0xfYVrbLbHtgld8qlKExRdjOOif6qYdosH2Bi1YUotSpdGzPaXb5j8gYEy9sTbJHf2OIUmR98AtkVjnHYldubHuqAs810Wj5IDHur34PF5fM0r88RTpLh93zheQo1wB8StoPR1G8ei8wY6ez4sfIIGg3q9Fi34SdPw4PBtdeHIDxOz1WmVROo+tl/cDQw1SoEQxJ/9Lq/XTTZ4L8tfeD1p2CZNfuZPmIK/T64vGjatZvv4Towf1W5m8xSWA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(376014)(1800799024)(7416014)(366016)(56012099006)(10067099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s1QiRmmKSccddrpTVsAW0paY5bRQWimyuvgWXipGJ4oo/E9N/e7Kfr4qTAv3?=
 =?us-ascii?Q?pVr6IwSCIf+a3G0z8OnwaV0X86dJUwD69iNY9BaO7mup8x62koZGrBIqsXXX?=
 =?us-ascii?Q?aj25RK4fpBU5yTwTfAfGaf08Z8SkA1LxAkjHH1wc29+I8DoOQ5P2bI1lG2/W?=
 =?us-ascii?Q?PGAZN9PezeYdUGsmYiBECzDkSi0WkwJ2a32DkrptXTJWzpLT8xcDsehmRe11?=
 =?us-ascii?Q?737BkMz+JAyvcMHo9eMo03aSqdXBmDMQEBVQeHomcPblhCCGKuUULRQ82ivT?=
 =?us-ascii?Q?3qoKOd2TNsRYCqZ5iiHbTrrGIg72sHjRrkIUf3CxrcCj/XY3W7ahLxD1v4eG?=
 =?us-ascii?Q?Ah1eglFir4yr84TBMmUEI1J9E0kWJQ+DF1P52dy8QoVeVxpFDZx0wokK++vg?=
 =?us-ascii?Q?DxjI0IzX7kkdUQg9vgvaCqrrO/Ux7tx9mS8j335SXsW/SnhgiABbQDVsnoXC?=
 =?us-ascii?Q?iwGMSCrqAIpbayYNZjn0DaXCj37QoVjCGcnoo5xmXbPRdSEL4GUlCRSOBHKC?=
 =?us-ascii?Q?LWU8VcqTSrnIbJMcixHvRdhtZjaSdWnrwgXyszbtj3GV4SY7WOUnRYTCeITa?=
 =?us-ascii?Q?jkNaeDdU7M/ivC4In+PjpdjCBHi3FnID7sfoKhmWHE3x8D7/7N4thhKCu6M+?=
 =?us-ascii?Q?mOf3rgi3lmcsqnvHrYyu82k3A3Ia9g1J4Gu738rbVq3MBNPDVWUGF/KL+jGu?=
 =?us-ascii?Q?5ABYrKfszwyLfT++kwJNefC0SfENPfxJGQkrGaOiiwTnwos3BXZj+1o09AMS?=
 =?us-ascii?Q?UvRvuQHsaUR9nb0OSsOr9wZepnDUVvWsKywYOnOD3f668pMgwY7RAtte9MEA?=
 =?us-ascii?Q?cMnILeh8B5zLZ86clfRxCFUY8RtwYMMFZ3kxrgFMcxUq8jy8MJEJ/kv2VSpO?=
 =?us-ascii?Q?zGnGAP5Xcxs8jhcj6ynC+7B+vdTyY9x2swl3/62bRlh6ZY2cfRZQEafit6/+?=
 =?us-ascii?Q?ze5HwwjbkphWTAn0Z7hm+5tT2WwyppT0muRTuEC49/r0zra4mB2VwHkcllUb?=
 =?us-ascii?Q?745MStuYB8viwGogSYg94+jOpwR/64wJCKwCsDP3z3yxDOymWgOnUZzTAfyU?=
 =?us-ascii?Q?oY6RNUVUgwrWD7oG3JP/2lg4KycTKm//PcPQErpdNwknzjZcf+A4C6bG6d2N?=
 =?us-ascii?Q?rdHyyQo9wATYc70cGTbRlJzR9+yP+MFdybh47LaoSa1ChXLHb08oO/LGRSbc?=
 =?us-ascii?Q?E6ZDbfzDO82aDVPCNgfX1DM9QXI8DbwHDMGOqD9E51WELA2sOQMdo94617Tr?=
 =?us-ascii?Q?pCjUMvPS0S4vKi0KChUNzzo1uzoaCOWotq0Z2VmV5dXImI1RdGTh8Ufaq3hZ?=
 =?us-ascii?Q?QFDj3d6kpgxythbUc0YKHGK81ADyIm7M8cEI6y47puUf06/tRnwXUNKtJSBa?=
 =?us-ascii?Q?IC2nvE0dj3FLwQBtvtzKqbm0prSOUf7lu1uQACQdvI2SROqwoe4wyr5vIbNH?=
 =?us-ascii?Q?IGpf7dSNUrX/7FgMLWLnLqcqdekOUa3huNeYX6tfXFhIez9NaXLafwFJcax3?=
 =?us-ascii?Q?vKIR1bD+OCUPR3d0+0ccM6wvMd3jSvmoi9axhTYpN0UTpJWm+hzmEXA/LgeB?=
 =?us-ascii?Q?B7vBHszSFP87WuDmKlOZxFrx8MGG0CK08ScoNlqMJ6BmWXhf/QW3idLIhYyU?=
 =?us-ascii?Q?zWlfsYelbKgiX98kS+PCAvgJlAXFt0tkWW24KZ2o60iFdgatVHwscbOwoS5N?=
 =?us-ascii?Q?mcUi6PH0T5qkzzY1yEQWPbCydY/XG5xgUuQ/1xg4GG8eCw+ikZqQHKS0pUH3?=
 =?us-ascii?Q?9m2ON/jRF52R8KI1GtIy4vXoBtds+EqjMhzf6/srEeMsgt2yZuKG?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 62aa2728-fce2-4b41-128c-08df1533d47c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 03:20:46.3134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5I/8c63xUmiHIKjMNM+g5fDLpklK5sULp73DWOWSN8dV+I6TxzlrGGUjxFbPNOd3sZntFkZ6R7Ob3dmDgErLJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5141

The intreq_pcim_lperr interrupt carries Root Port AER notifications,
separately from the integrated MSI receiver interrupt. Describe it with
the "aer" name so the controller driver can use it for Root Port error
reporting.

Keep the fifth interrupt optional so existing device trees remain
valid. Extend the example accordingly.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 .../devicetree/bindings/pci/rcar-gen4-pci-host.yaml    | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
index 64f456c6a75a..b0f4e6e6a662 100644
--- a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
@@ -36,14 +36,17 @@ properties:
       - const: config
 
   interrupts:
-    maxItems: 4
+    minItems: 4
+    maxItems: 5
 
   interrupt-names:
+    minItems: 4
     items:
       - const: msi
       - const: dma
       - const: sft_ce
       - const: app
+      - const: aer
 
   clocks:
     maxItems: 2
@@ -106,8 +109,9 @@ examples:
             interrupts = <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
-            interrupt-names = "msi", "dma", "sft_ce", "app";
+                         <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "msi", "dma", "sft_ce", "app", "aer";
             clocks = <&cpg CPG_MOD 624>, <&pcie0_clkref>;
             clock-names = "core", "ref";
             power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
-- 
2.51.0

