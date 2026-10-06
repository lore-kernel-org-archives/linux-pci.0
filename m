Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021081.outbound.protection.outlook.com [40.107.74.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE76D3BED06;
	Tue,  6 Oct 2026 08:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276425; cv=fail; b=MhaSSxhgh0mNhSJOunBsbfL4GzC8mt3LMhfOJN/S1dtV+O2JAyEoI+qFzaJ2bM4Hg08dfrrTDvb64dlXLHZlTku85F85w3M2Lg4JgTkM5/mxCeYTv0U+DPeZduobgGXRMlXwho+bejFeR1ne6DfrsgxhCRvby3ledkQZ2NGx5y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276425; c=relaxed/simple;
	bh=VnuBeiZQffQ/soJp9zsEf90hF/NbzZ+kQVN2GrzNXhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dX2fUGIsllr+anpxPQS0JrHedtFz/9t29VpVI+zrExrsJ11SOxcWgEfjt4eJ1k/TnR0MUQba9b8jMo2LgwNCoiO2fdAfT26lLhjKBaNQs2OVu3VyN1TvDCmh1xh2SpwJDT/+HeIHm028wj0aps//tTtwThuSKpWRPX1zMX9VCgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=erJg5r5T; arc=fail smtp.client-ip=40.107.74.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="erJg5r5T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KbNKE9VmH4A/4DgRkojAxYpKQSPvsUb8nigsf8rVhhXTBWvGS97V7nJ7jNCeLmAku46bcoBO2Lws54jcsaYKuQVRZKUB04DdXj5fTn1b1PAYWpQmUIc9q/ESZkzRhHWeRHVWa5YzQhOG/UKfN/pIPzvvnZCLu1CW5jQF0sKP35G6PzooqeVFLipWFgzGKwOBtZeL1LI+hs/H7y5txhrz+b0xIkCOJSZNZj2iKrGak2pYbSWIBbirvKhGATrNBVghvKftCZI0dSyjYeyZarYkyO5K47LfzCukzAfym1GbQ75APUlbL78SHhwl6Hxfvr0c5EzK4Sp7In1nod339ZGxpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAiyUvvM74inlzAYnyFQDVezBXU9Fxg60tHGtlyfmTo=;
 b=jotwYcp8eBMDiUOZN6ssyZQk2kWp1ANbubs3XYsd5d/VAIygmtzWqRtQjymyp1r8U1pq8csnYOTEl/W2dnAZzcsV3Y0hBBF66q8D4PEVDrQ5MxlKS6NgJtsY3wnTJKxV6Wtt98qcBAgWKINFJQCXO01DOYuYXFGryBPAWEP+I0FlKozIG+/EpLGUb574Pf0RK10PdzJxoXg/uN04LJCbR+HnV8wV7SbYR1HHIWFZh2ElYAIex5MvhJ60byYE4gZxvOkSG9y0AZZ6aq40YM893P2CZMW2gbhLmxmtz3OQB0TFBx/VMzQ/nhJwf7M9TXZp2wnyKJOmU5EpgUPQi3u9hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAiyUvvM74inlzAYnyFQDVezBXU9Fxg60tHGtlyfmTo=;
 b=erJg5r5T18zRhqohRwfB0tvYYDDV3GGH8V6/pY3Ehzz9FGmpXfe5mhPCyQXnsAOCbxnpRzsATveclVzklEG1QSRxSQC62eOwPneCpYile2TPfK7L1zQ7/OsrihY4w8iIYqQYouuf1XazmbEuFK94FgVOXoNWV/zlDc/MG/EoRPY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB4983.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:341::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 08:46:51 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 08:46:51 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
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
Subject: [PATCH v3 06/18] PCI: rcar-gen4: Move deinitialization helpers before SoC initialization
Date: Tue,  6 Oct 2026 17:46:26 +0900
Message-ID: <20261006084638.3821710-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261006084638.3821710-1-den@valinux.co.jp>
References: <20261006084638.3821710-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0021.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::6) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB4983:EE_
X-MS-Office365-Filtering-Correlation-Id: 49159467-a0d0-4abe-377f-08df23865d77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|23010399003|1800799024|10067099003|56012099006|6133799003|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	TMGwSHe3haGAmDQKYwjzTlU0XUYuECqC4ZiZMBDwTcTdJB576ahWyFzRlAfV9jpKPovUWnf8HMD8rBL8IWmZVXi7mgdARURrfNgKa2sXRS+Mn1uuI070dabjgITJqyJQzutXMpqvGnmmYJAgj5TIJIdPvsLtN51XVZ7w1HIXv/xQJZvRD9nswRPDpcfex3+oQlCvSQwc7n9DKXkM3n0DP6nLpDYCjJLJHVzYEB8BlgAH5w/oyqRXwV7+4N2kJgIErOkyZKEpgythlSGxEDBHjFcdhK6kBtpAwS/7hha2PL4O7qdT+58GyySRFRQ6FmGlZY3fVSIWMiIRLY+Q2CqJUx3Gx05FSom+1i8lhwKmXDHtGQyonrs6muNksMcwPTUizk8tzlHiTEHt7VSM7Ek6+I4e5QtK7ZEWviCvretBZxapKui5HGuaCw1H/zg+SbbW/Y5uk+hv6JrkLqjmoKjuAQWsyRaLUTA2TILZpAi3UA20yp3jqhoOCY7BMx9doa4NpfjlKIAdyvMFqlOd+k7pNdKVXCJhhVcCTK2YMqfsF2y2wBMaQgNiHuMxbDwEsT5bOxPyXgIINviY2nT+vRCXw7gUlbI6vvEUEOoEYBKzvMNV6r2ttg4UK2RljOASjb0/pBPKrCW9CIUyC8l2Y7yuprCUvXRDeJ0B/fPVp9+iMq8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(23010399003)(1800799024)(10067099003)(56012099006)(6133799003)(921020)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fve70+Vs8mcsKw0xRMsxt7PO4s3dQkaSqmxXWO1uvh4TwJLx+aqp8sPGZpFi?=
 =?us-ascii?Q?hfVuSqIbN99IHrdDdubqHspR91JpGA8FTJzX5oerQQJyixaBDeRX5Xrk4048?=
 =?us-ascii?Q?r2W23PrqxwigZGaJrtzR4x9fBkaaGd0unUp4wfGKqOQHu/RAY0nQYLCNSsEM?=
 =?us-ascii?Q?zBwkvWoApK+xk3+DtdxtBhxf7zzRT5h39IK1FoZ04lRn2p4hCZbXY5CN3nB4?=
 =?us-ascii?Q?x/DM9YLGhZG2Rs23IvXVQHkF/HOdLoLN4eySZbXb0ewNcXULUa/szgZYw4++?=
 =?us-ascii?Q?4OexA/F+l6y7A0KhKmGu3gO5zz7m8ULmCi6E4f3J0z45szjZzNTaDdlhIepB?=
 =?us-ascii?Q?8uGDL41ItrWZWWUrPs0xosg1wYNP99BtvMOYa43lDpQIMsMdXWGWx/2kqMAC?=
 =?us-ascii?Q?3sH6TSW2rsjcszB4Za4FEEoSOCGbPLoicDtiqxNaXt4CkEgORUAiDItlkYxD?=
 =?us-ascii?Q?gyMUO7A0OMYUAeMxJ8QSGloyyfVTVXdFjMpUmaWL1dkpAvw6vBdRdKd6CzQ+?=
 =?us-ascii?Q?PHjheHkam9XCpBEeuXPm0WeADho0/U+J8pEoBKOOx3r1FnhkWqdm0+ZQNVvV?=
 =?us-ascii?Q?g+fFXpyLqtg/bIwHJOPlu3wfEhaMtB7H6rc3XW0quXDNC7TfLpkJyQ6KjaOy?=
 =?us-ascii?Q?Y7zZI48Wki7EPHmM8iFmbhJ29YBVvbwxwC0fSRAEq7tmKyHylRyefnbx8U15?=
 =?us-ascii?Q?7IKDNZ+OBSaMU3kOtfjCmzESIdxba2PWg9QziHnCe5cval7obRfl4icn7mfu?=
 =?us-ascii?Q?NnR1Ltzqd/BzTZPxvKXYFF6DGtX8WrF+MhHgw61P1pRywMbLI6u7ktM9xpAH?=
 =?us-ascii?Q?tUdvyCUg0OsA0XpKm72T3dFs8hqG+0Gt9AYxiOAh31YoP7lDuC9193jyW6FO?=
 =?us-ascii?Q?1D+ErEAtArjk86F6QQp8QTP60jjEr8RBUn5tOhsJowdopBJ8KITct0f+vUDt?=
 =?us-ascii?Q?sjHrVKuXwNv77yoM+5ZN13WxJ5tgCizwggHOz/v7WDpxUHAKM0y6fn3lKXvX?=
 =?us-ascii?Q?8LxJ2hW90YPBm0hLOQr8Yoy2i1jZjhbJitLfqNEC5/UbrSiOY26M/JrXVWw1?=
 =?us-ascii?Q?T/3PK4DscmLXPZ3wmDvgWBmZkTOZASCv8svL9Dq/EDqd71OXcbqJRIZ6Nd3Q?=
 =?us-ascii?Q?OGjE2TsDndKNdAVWD0GbWg/7qH4++GFEduauYMka/i7M7kNqbjslmJbE31Hz?=
 =?us-ascii?Q?C2Y5e9UoVWVgG5cI/WCXn80+DVG6PTFxFxTtNLmEKquJ+codbCstufooqaaC?=
 =?us-ascii?Q?pwxkSxRTGIbjPBzKxMypcsuinqa0PRuV8EWXxS+R2zFx8lE6524LK6TYf6Qb?=
 =?us-ascii?Q?Hfw1RmryefG35eIfi6+vghG7+XqMWrYdaSMPKAkzdUqfShBpBEnBVbn9xxRd?=
 =?us-ascii?Q?6T6EQ9bI7DEV5fH0ykF3rc4JVtoPgqdcIa4cpIQeSAjJCwH/cklHkOiRDK5w?=
 =?us-ascii?Q?OpmaKRaB2JMkbJmjqVi4cdVjrit62CmTdkimgo357zLrtJjw/7MpSgfarBu4?=
 =?us-ascii?Q?5sbcS5Op78tXgApfpPRaZhvB2nJqLBLx8uz2GfWe4ULVc3nnwlYM3bVK9T82?=
 =?us-ascii?Q?IFdBf+5eik0J4r8dQTX1wF35mBa48d01FZpsPwDRJlfaGd8+cNkdjmzUb5/0?=
 =?us-ascii?Q?nB6aVzb0ZcLJuei4AzMmUVx7KN1BVtyOc5k7w+ZtGEgUmArD59o6SBhpQEfP?=
 =?us-ascii?Q?DJ0UWqO08u5ieW5ezlrmibKWWIvso6c2eIg180BB6g+SR4j3lH3xQQa/C4L7?=
 =?us-ascii?Q?Yez9vmXBe3JXkJa9l+0BqPLALKu9lwDXkk59dpJuMdb5GsCaOQaq?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 49159467-a0d0-4abe-377f-08df23865d77
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 08:46:51.1440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dHuoOazYQYevWHoJ+hfcYH5an1de1ZUOlFe7gJGzqiHlJf8KIay0A/q+ZeWzUe18gAo77T9i2Lfl9qBEAlWcVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB4983

Move common_deinit() next to common_init(), ahead of
rcar_gen5_pcie_init(), which will call it when PHY initialization fails.
Place rcar_gen5_pcie_deinit() before rcar_gen5_pcie_init() as well.

Keep these moves separate from the following initialization refactoring
to make that patch easier to review. The function bodies are unchanged.

No functional changes.

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Add Marek's R-b tag.
  - Use function names in the commit message to avoid ambiguous Gen5
    references. No code changes.

v2: https://lore.kernel.org/r/20260928165230.3397664-6-den@valinux.co.jp/

 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 30 ++++++++++-----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index b101ad7dbc31..0a845b67f6c1 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -301,6 +301,15 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
 	return ret;
 }
 
+static void rcar_gen4_pcie_common_deinit(struct rcar_gen4_pcie *rcar)
+{
+	struct dw_pcie *dw = &rcar->dw;
+
+	reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
+	reset_control_assert(dw->core_rsts[DW_PCIE_CORE_RST].rstc);
+	clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
+}
+
 static int rcar_gen4_v4h_v4m_pcie_init(struct rcar_gen4_pcie *rcar)
 {
 	struct dw_pcie *dw = &rcar->dw;
@@ -326,6 +335,12 @@ static int rcar_gen4_v4h_v4m_pcie_init(struct rcar_gen4_pcie *rcar)
 	return 0;
 }
 
+static void rcar_gen5_pcie_deinit(struct rcar_gen4_pcie *rcar)
+{
+	phy_exit(rcar->phy);
+	rcar_gen4_pcie_common_deinit(rcar);
+}
+
 static int rcar_gen5_pcie_init(struct rcar_gen4_pcie *rcar)
 {
 	struct dw_pcie *dw = &rcar->dw;
@@ -369,21 +384,6 @@ static int rcar_gen5_pcie_init(struct rcar_gen4_pcie *rcar)
 	return ret;
 }
 
-static void rcar_gen4_pcie_common_deinit(struct rcar_gen4_pcie *rcar)
-{
-	struct dw_pcie *dw = &rcar->dw;
-
-	reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
-	reset_control_assert(dw->core_rsts[DW_PCIE_CORE_RST].rstc);
-	clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
-}
-
-static void rcar_gen5_pcie_deinit(struct rcar_gen4_pcie *rcar)
-{
-	phy_exit(rcar->phy);
-	rcar_gen4_pcie_common_deinit(rcar);
-}
-
 static int rcar_gen4_pcie_prepare(struct rcar_gen4_pcie *rcar)
 {
 	struct device *dev = rcar->dw.dev;
-- 
2.51.0

