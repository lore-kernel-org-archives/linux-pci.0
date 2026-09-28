Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021116.outbound.protection.outlook.com [40.107.74.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D434F30E3;
	Mon, 28 Sep 2026 16:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614392; cv=fail; b=cw17sqZjxBh3LaAGKWjd6VmtovzrL9l2Fydr62kkhymhYh+ia7A4qbK6VEKguO8rhweN/QBSOoKiETQdsBxsHTfAc/VoZ47iDHJJQTr0qzedRn+N8Ua5W5DlupdMLxmOKXwseVpQA/o+Efa2yjM6v3OZsoMgaLJ0/bSgcbkemxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614392; c=relaxed/simple;
	bh=vrbaadlTq16TFTcRhPZx8UHKl9+coqPkI+od7SFudAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R9wVad02rDH7bcrZKRWMUPnGqjdvbpEIQE5+7SkrnRy77gujjhEKfXFaO8GucEufbgOvVuWCs96NHiyl+a/qH84mc9zPluJPjDlPrq7jbe3PWeClku6KkgWxHbpDUGb6Ag5klzgASyadiBNdCEHrn+OyYnJvYGo30DC6+8Z+gG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=A/ItSlut; arc=fail smtp.client-ip=40.107.74.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="A/ItSlut"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyXhSehCDy9rJUItmKB01bBMDgeb5Y2p3CSP9Ednp78iu/5OsTklGfE2mYjJv8Hnyb9lPNZoPCBolo1xwIFYWTOPGReKZPKl+dxuNvKssD73Psi/Vz1k167RNY7ai8MtVrUZAseiHT5Qal2ig0AcyWyS7aZR2isgUNRx8UdLWwMRGzgbTEM8t+coj1pW9oQQpJoGHINRQcGZgxKfVjcUMVsO1aYmzMCC42LBUsjzakJSQu41Yc34DWWngqyoUBGdGlKPY5rRAGU1X+W+elFZyfG+L7pHueKJPao2k0FUYLCq4mM7pGqf4DjDPqfmKPcUHJB0Vw2IclyKr9RC36iNyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4B+ew4lVZb6IGy/h6usTWoaWOjPqzbXVh/hveSefs40=;
 b=E02rRQ2nebTfiow/BK46hQ/KgYvBtxXF1exH79Xu65qHb9Nkd7x+LXBxoUj0Vv0W4CL+JsiMr9x9BmY6fC9YMBZYZYaPKvYDleT2V25olt7c1id2YKBZ556s5sQuu3cUzvn2w+OG8A6sIqls6qWuBZjU1FP/EELU1O0wD70kn2YXgefKnzyuyVdovUZmfRsoTolKIfARJoqQ7t3nBjK7eLkfBpRJPAy7nTh/4TB8ZK71daRes2PhHvCMJEIYs01HnFh7/sRug5idt8uqNjvRtEFvZyS/hT68z29j4fhLE6XG/YFSa+Q51GVyXYI4DoY4GS2bGlhjRuuJ8PDcYdJSTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4B+ew4lVZb6IGy/h6usTWoaWOjPqzbXVh/hveSefs40=;
 b=A/ItSlutpRgrowuhATETnoOYHpLroiKXQqZS7lmq8B227GDPs7v/EJhq0c97qN6a7MzDtwYn04Qj0gbI8WosZkVtFVXkuGOx1M1AsPDdjR37BlNQaYuOuBTeP64Da/l4W5vD38BkIIEH/u5VeTbiBS+wElUwRNfVvQUxlMS28Rc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYCP286MB3638.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 16:53:04 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 16:53:04 +0000
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
Subject: [PATCH v2 05/15] PCI: rcar-gen4: Move deinitialization helpers before SoC initialization
Date: Tue, 29 Sep 2026 01:52:20 +0900
Message-ID: <20260928165230.3397664-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260928165230.3397664-1-den@valinux.co.jp>
References: <20260928165230.3397664-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0009.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::12) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYCP286MB3638:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e54404a-a351-430d-43f6-08df1d80f6a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10070799003|56012099006|6133799003|10067099003|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1YPxHZZ9W9AUC87gUe9/RX7/QnZdARfcHaLhEI0Tkcl1ySOXLdPn0mjwXWjptr/GV7eh/cbnMvO+9xaXcJXDRJfFYZSGNA2l2rSe8oAScX83GP7wuQ6XVRxJ5lAenVkkvdKqgDefeN7wLzO56r0CuP7EDRLV/7pj02QXnIzuo3mGKUu53hGWF+MIlGO3jmytR5NLYS+ACSIFTWLeQDLDN+BbOjbe979C5WRWB6Hnm5I1d+b3hZS8Shm4U1IAdYjI21Mdeewjb8h4i0c9xSzkOWdnAAdfYeFHL1/gGAj9PZlyCj65K5iMcBvQbhNrqrMq7KR3AHdU/LjYQhGgNKoJ50VunbfBGIxJTph4NSWJZbDzFXXyZpl2u0xQA5IA9JuVcQ4Kv5C3xniJWqDEu/ONvUw7c48ogi8nWjuMG6HnuV+2QH98rPhnbA0zWOR7nqoSUQaVdBnF/czk3orx1fkQB8FUZFb8hFKGU9M521arURYvYCAC37jju4zITrLonR1LvXHR1JjtmqEi9cf3mKjkVLLBVyidLSV3tUYWBny1BydUkp6xJXKm4K81uB9eJRNUnsZIKxOyuYmWjAqDW0Tw9rd8CKuh5lz6+y07EgStAKodhFXpPaHKonc8LI71CXaJ7rayViD3CBmsA9/HGhoP4A0sxlKUYTotr9bqjEu58erX80k9v/NLHaGK749w+FBBK7imbjoUywudqQ0JcJrZ/A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10070799003)(56012099006)(6133799003)(10067099003)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AxAkEeX8h4jz0ifw2ohGqnaFVPYjpov40FPn6ZSMWBdr0lQHG7dcFU8W8kr+?=
 =?us-ascii?Q?HG3pakobEKJdRP+47P6wstskkitUAg1ndEyJV9O3q2RwHcMuyXg7IraIOWU6?=
 =?us-ascii?Q?aYobv9Fm7GvpicFKkRi/m/RCzJvUJSgwie5kS90rh9U3LbJ+UkPy6qmIfUYU?=
 =?us-ascii?Q?n9hanv8+xgzyIwR75P5mN2+UoAilNwzAikbUXGe6B9bn8hOQfTUm79TcA8To?=
 =?us-ascii?Q?Nbd8RmpTpMeKmPuoZv1XL8/9WUbFtKw+t7gevqbT0py6RlBXiEJXPGQDh0O0?=
 =?us-ascii?Q?UxUcsFjCCjVpjp8tc/Qi5yBzaggM8cRIJmKTSPJFzXD7u1K9okpEIWy6lypI?=
 =?us-ascii?Q?une4ADZ8SEO0CPvQmO33dbUek6Ps/ImaqLgYOb5OMPcAAdMx+SqOERlCsf+J?=
 =?us-ascii?Q?kYqYKdMWg8l9eeFtyQsXLnX1XPsSjbo5hp0jdzQWD1SNsfQptXIEb7X1a9V7?=
 =?us-ascii?Q?6xS2m+uGkanzaQoxSozDWTNatrJx+SbfTMPg7zzjj7YZO8UOAI0N7RoQRCQp?=
 =?us-ascii?Q?e/AqfptB6/jSk2dT+8M8qhDdZvloaNBNtTZjeGjd+BbJl7z598shWUaJ+aWR?=
 =?us-ascii?Q?Hc2J1wqbYNLzRF+SzPQGCWYVqMR7uHgkJKz2BbCGd0Jxm3lPDdGeNvWnivCs?=
 =?us-ascii?Q?xcDsCFe439xAiLzH9HzUEQQSCGtKRInNgD0gHc6kil7USD13cymT7rjBNNve?=
 =?us-ascii?Q?CpxYvvG+QP5F17F0Mp1mrmqC+MsxOhr3Ox92TPH0BNLCRaFgC94+xMf4aYmi?=
 =?us-ascii?Q?3bX4putvTV6aRP2q19hDvLFEIEE9ZlqhblRMEHEEaMXWJpACUvZfvTQVqye2?=
 =?us-ascii?Q?9HDevPZCfFGg7EaogQp4QcXkqv4/JQjzI4bZkV5iMqqHYUSS1dX16vjiHhCc?=
 =?us-ascii?Q?EtDkuDqCKvFBP4RZyP8EV89TuT/p07p6fe16wnxCLOQSfruiSaJXCy3kQhy+?=
 =?us-ascii?Q?ahfoPlERgRJ09plQPzTOTV244RXvVen48jY0Acl12pJtLiYKa8U+WXoy4D9V?=
 =?us-ascii?Q?+VG3SrxcfEYfkPjkR7DqutBRYkbym0CEX3yoHTRCnVJq27YI9IKhvjHawv6H?=
 =?us-ascii?Q?suqU8IpJr0WFH1YwgME0Ta/td+F2EjE095zriGhapEyaOr27y4ynWBdqJVDj?=
 =?us-ascii?Q?8bw0nALFrCA/mRLk8U38XnLdnBWKeM58MOaazviLi3sExfy8ongwe0glurmJ?=
 =?us-ascii?Q?TqoW+aUvwzERyPkrNq7SjI5wbouL+vaBmQG/rMYzI8Jw7ihm6kE57mxHYcTP?=
 =?us-ascii?Q?UJOz4Pq0bV/MWK+cDKiiWKVDwPljUsofs6gCSx9AGGljevRwuHBJ/4TzGYB3?=
 =?us-ascii?Q?y5vPFlILdFJRsdAhbsVCrKr5spzLItv06ZL7M/BExgAf0nWeea4ghIgASkXW?=
 =?us-ascii?Q?ixkeb9x5P4MxhQgBljQktzd5C0X5SBLFkmPPEVMH3lPUWPzO0DF7WNay8jcW?=
 =?us-ascii?Q?09gtkJTAnmItY/iZAsplCgdl0KQivqTnKG+WutUW83aGsuhw3yjt0KcsvmVC?=
 =?us-ascii?Q?58WiNaAY0z9igdjR6oAjF1JnvNlBILapVsjtDDSeqGHv5WN3ZAaHKAu3iVwY?=
 =?us-ascii?Q?AN0kIbUO0+vlgOa2eyPN60uIfBuMJUOgLIAIdF0Yi1IpJaGCViBkVeQPIqlL?=
 =?us-ascii?Q?biDe3esmrR7IbZrFYnFToCQZmZl34teghUFc/udKy8L5DCSP4fw1I8KImBzo?=
 =?us-ascii?Q?JHtRuZT8iMT7CxYJrB9u5NGbmDEYRFEwhaEy4YbAvAWgNGDdPyNp63J/s0CG?=
 =?us-ascii?Q?Qqkh0xeRFDUi+3k9bs8cPwJsQghwY4O4dhqbvmgd2Ybx3Rpkqv3v?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e54404a-a351-430d-43f6-08df1d80f6a5
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 16:53:04.1602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FF7qFxgTCNzFPvYfmT/V+oW0tqV7OQrwM69bq+bXoOntxnUYFVphQlTmIqQciFI12JMtUXuvP0iXc8Y9ZN8/lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3638

Move common_deinit() next to common_init(), ahead of the Gen5 .init()
that will call it when PHY initialization fails. Place the Gen5 .deinit()
before the Gen5 initialization code as well.

Keep these moves separate from the following initialization refactoring
to make that patch easier to review. The function bodies are unchanged.

No functional changes.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - New patch, separating the deinitialization helper moves from the
    hardware initialization refactoring, for easier review.

 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 30 ++++++++++-----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 4dabcda051a5..f9241ec0f116 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -303,6 +303,15 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
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
@@ -328,6 +337,12 @@ static int rcar_gen4_v4h_v4m_pcie_init(struct rcar_gen4_pcie *rcar)
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
@@ -371,21 +386,6 @@ static int rcar_gen5_pcie_init(struct rcar_gen4_pcie *rcar)
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

