Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010002.outbound.protection.outlook.com [52.101.61.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75CA2EDD78;
	Sun,  8 Feb 2026 18:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770574118; cv=fail; b=ScuQB1h4u8hi1fcBdGOZoc5rJVbwmlh9Pgd6LR3kjmW4xUy8ROqLiwN3uoh3TI0gtrzDhyrZdaCVi+iuZYJBI6jCtpWxy5T4DG9EM03qrS8MKQEfwSl+H4XZuAe0WXLTPvAO5pgqLoqpUB9orLn53pV2lth9f99U99jcHZWeFQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770574118; c=relaxed/simple;
	bh=SDsDSr7ehckJHLDoVnr4SfZ139mh9Eep7+RhZK0E15o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YcQoA+g1JqOcifvMSTHGdqGcGY+TUFafRfHJLYOISpIi6Yb0v+hX9TkbAHPj9wUg621Y9U4cMK2dyLUoyyDyu6Q4NJGCDMhAvKKykEmjXyHb8tcnRTahku9rPPrMzbeLkvMWHFLSd/HkQB1CsFjmpv6Uj3xkBReFshxzxavDLK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mOgCLDZp; arc=fail smtp.client-ip=52.101.61.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mOgCLDZp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QYB4xXxi3w6+o7LQXrS3AS0upuSfCo3rp11KenFJq4kCm/cwSyDCaEbEyx/VzFjqkRHX7R5GBB99snlYlZR1AJRF57qY7u/t/55vVYrc3Cfc5BEKvqAvzpEtkVviVYFwsInPpVwCBbhzn04Y4GrHchgom85A1hYSg8t+LS+JP4a7op7vp6oHWw+3om08JNCtn2uDjdrjEZqXDsgmV5j3PNP1v6obM+Pg1dATIVDTMbszKjoUmXR4aj2Mof0E8xqsESFkETeAA2tFHJsEvzar85OmcBHtxMuh71DM0WoEOLB5tOJAthEco8nT6uJ1Ln5P4t8VA0asFNhxRYLNFBQPSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xxL04jyUwcrZ7xAgZ+Kw7HTwDqVaXtmDy0yO5x1b9M=;
 b=eHycDP1D6Ah12J1BEcwQL9BS2qd8uBrVJ3eQOglkbMPGU8MAc4IQSPDcwiglztrgVbbroElDp2isXmTh2+BGriR9dzjDLDU6xigdW9jyMzaHdsEz1r0e+OQhh/6SZkt3mrJK2/tAbw8xfsYyoldj3Fs3lnW7ke2n/e0QRcvmTmAJkedUJstYKIR3+xT529ZN9nxJe8DQyxdHAPR7XqlTux5vGW+UpEdAMeLrxjq6MrCWeFjHTrSu7U81wMCn2JMviZw+6KDa9tTMYCSHWZivJbmF8Qf9anL71pbjZgG9BabezBdYOEpcJgo8rR2kvVyK3rR9sIAA0I7mQsqSUU5Hcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xxL04jyUwcrZ7xAgZ+Kw7HTwDqVaXtmDy0yO5x1b9M=;
 b=mOgCLDZptYVur6kbdNCEBl+8dwY1QwMRcK+Hb4VkD++Q9+hiD3jlrpTGa0aOoChONtfcKnMnZ0GXNqD6SOZzt+xDJ1gixrOGTVhdKEHmMLnPmKpgr6+PMh1bUpP8bEeLhb9oBclq2cXdvm1hM7wt87olfZEC9QIdDTChUf+tE0B34jhkORCvScaeYxczxT8GxRSutkzfuBDo25XGl0zb0aFhF2M5ARVtisby5FgBWQNqdmYr6BkK5NcMsUp02VWQvgs+5lDXzwxP4uokYPJYe1wBibeheCbsIcvlWP12nQn7KgzbTJO0m8qQsKy0L4fW0KhIl0XRGAef/fjq5LNh0g==
Received: from BY3PR05CA0032.namprd05.prod.outlook.com (2603:10b6:a03:39b::7)
 by IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 18:08:33 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:a03:39b:cafe::f3) by BY3PR05CA0032.outlook.office365.com
 (2603:10b6:a03:39b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.5 via Frontend Transport; Sun, 8
 Feb 2026 18:08:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 8 Feb 2026 18:08:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Feb
 2026 10:08:20 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 8 Feb 2026 10:08:14 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [V5,02/13] PCI: tegra194: Refactor LTSSM state polling on surprise down
Date: Sun, 8 Feb 2026 23:37:35 +0530
Message-ID: <20260208180746.2024338-3-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260208180746.2024338-1-mmaddireddy@nvidia.com>
References: <20260208180746.2024338-1-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|IA1PR12MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: b73e56cd-9455-4e7c-ac59-08de673d11f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DDi7T93idQsgJF1KM/uWqcjls0DCC0khE39uJWyf0wm7A4BmHo461pGrwzOS?=
 =?us-ascii?Q?a30IqcM9xGA98ZA3OZyNluxw8zR+xNTZ2eQOcur8h3cqOiDj1/XvrwgHpORp?=
 =?us-ascii?Q?MdB9JeF4hj86/vrVRP/OYuIPw5Nxp69kWmf8Fp23HcDAmz7XEL8EQ+O4rHWG?=
 =?us-ascii?Q?LQ5ChFgjeadBqkyFr6Jky4pbyl/y6CF1yojJe7L0qusxCIb1qoMleJ48YAop?=
 =?us-ascii?Q?6AEY0YVOB9TiM9MjRj5f+1Kl7yJX7RzXwnkjhO+KWKuBpSQEdRJ5hBb6AamR?=
 =?us-ascii?Q?fFAD8N1oyHLyxonq1kXcEzGFyL4SZjE04xR4jDjnqBzuVj+cONAiucWxyvcO?=
 =?us-ascii?Q?dyjrhSOkBqpQH4UZQf3je3kLtxDPMLz9+QvlHuSF2dRrdV7660DG3Y2tJpB6?=
 =?us-ascii?Q?AIGMzH1wAEbtQYhKC2dS+atDgYW/roHEPo685SjsiWathZKofZX9ntmBjA/P?=
 =?us-ascii?Q?a+0H0JrouS7ZQgDqw9FlpuPXK+6+La8TBZyUR7mXh+lY1A20Up2hHKyzEBUf?=
 =?us-ascii?Q?GqDAv1m/wUwmIuOL/Gs/M12W3wiSCvoUqeCetrpTC6VTzXEaskyIvRb02kxO?=
 =?us-ascii?Q?pxMhtf358r3Pzxnd45bhrcsg+7+2GojNYdBdwrjm3VEypHvaq+YwEHhl9uE1?=
 =?us-ascii?Q?8eaqE9G5dxsXVq++3hdPpjAfpFCtfgVFwGf1B3dvvrU5DzTllrahA3lWJb2E?=
 =?us-ascii?Q?fE0NaKFzJfWwnwN4P0A2K2/BjZi8ERl1RxSIlQQ4vV1qeEgVZML1BJrh5yxb?=
 =?us-ascii?Q?n1EJEGRq4TdokOpQMMb6tLo8Y2h55lTtlA0KOSMp3NGymV/qmQ504LtfLzad?=
 =?us-ascii?Q?3odB/B+sh3t0A16ev0L08AB+XGaZE9NiDvXh69hqYxTBXT1K+mjuYKNzEmxj?=
 =?us-ascii?Q?mDrczzs5wBVlZ3kJAuyXBacpF12y9iVjGEL+FC0dzW+k+dGuMzbOfVI/usN2?=
 =?us-ascii?Q?9BEs65xWBVioT3k4pLtEkLlcpgOnqbnhu6e7MYG8bx3kqNmz7xfnbWsA7jGV?=
 =?us-ascii?Q?p9nCfC6F1shMm/jMa27XE2hIFJ5oG75ETgGpTf59N6DI9HjMX90kYZ56KSwo?=
 =?us-ascii?Q?8kcvSE0zssOsvf1EK2EjkCZbuFHjEDm/yAjsZ0ewC5lmNqLamclSgnTbBFU7?=
 =?us-ascii?Q?KZ1uc6ZQ9PoF7DBG/BEEWuQWj89gk0SAqc/v1c9eKrxakQWsTFNxq458NKc+?=
 =?us-ascii?Q?c+inhgtDSRGZEqirQpde6GvOasNRfnJYsLsNPOi1E7aauohy6WHJK3WwSX1y?=
 =?us-ascii?Q?qLo0kBIWZyMcnGEjsnDHdrIYwEcFWLHsulfAOZFtIGNtMfqfnnXf9g2ae9MI?=
 =?us-ascii?Q?HrTEqO2UVnkL7l7Gx5IzMRHVEeRnsr8B2cMndQS6owA8nS4M9Tv1Yx016k/p?=
 =?us-ascii?Q?Ft5jDeNTc8Zd8EP+T5LK0woABYmky4gN5eU9n+J19OIAgA3ugZ8DAuDs5Tw8?=
 =?us-ascii?Q?xyFPAqqzxRLGMnYJG4gBsUf+uRw20oeSht+cLuuBxbKJ4YNgaGMqs/ePSdT8?=
 =?us-ascii?Q?nSCkgHyGAidWgxjlMjLaXTki6yyZJEU9Yw5kPa2FETAKqLNYmXUpOUh0jms/?=
 =?us-ascii?Q?aW8YUTJLubG+Tt5aUNqmCU/XAW7jg/EVlDOnXMSwC/GH3s30YvdGFdO72PC+?=
 =?us-ascii?Q?9EZaCDaUbmgdxyFw0fWccAE3tsVCTQiK7SHYCl4CZJmzg2wW9FEM0iUGoUlE?=
 =?us-ascii?Q?J8h5BxmnjwyG78u4FbIP12/Skjs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fxJJUPHE+OBk0eYpUqFzH53qpknAhDYbIkHquRvnsN9rJvCCvKlj9evhcqVf4xb1K2q8lyWBygGbfS7SGYHOO42nrLTKoGjFXAsvXZETALl87Px7k0yQFIPlNjwHnfkRA+JCsBwCcW96x8TV6ZTy3idTN3Jiz29by6N104LB2dFExBbV3RshbDpgElkwNeKm+5sAfa6JqZZHHkOnxhmvP34Enh2NPSXR7Kcqwyw2IHBXmNaTCyvswEnKUvY3wFyj65eu80fvAZJ6uTeLlW2PCU08i+ErIQ628b2Bq8VoblgnFzmnHey49SLxVLxmBmUZIWcfDrNaJkb58w4uOfuZdg/P3nH8NUwzJfpinaHGr0q6XE1NGvdP4jM5KFT6XnA1KHcKcMns3VFzly9+PxO/AK0pm0qmxUkwpl/dKY5xYDSx+6ooU8zyR3quq0+Myo8v
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 18:08:32.3774
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b73e56cd-9455-4e7c-ac59-08de673d11f5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6604

From: Vidya Sagar <vidyas@nvidia.com>

On surprise down, LTSSM state transits from L0 -> Recovery.RcvrLock ->
Recovery.RcvrSpeed -> Gen1 Recovery.RcvrLock -> Detect. Recovery.RcvrLock
and Recovery.RcvrSpeed transit times are 24 msec and 48 msec respectively.
So, the total time taken to transit from L0 to detect state is ~96 msec.
Hence, increase the poll time to 120 msec.

Disable the LTSSM state after it transits to detect to avoid LTSSM
toggling between polling and detect states.

tegra_pcie_dw_pme_turnoff() function is called in non-atomic context
only, so use the non-atomic poll function.

Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V5:
* None

V4:
* None

V3:
* None

V2:
* None

 drivers/pci/controller/dwc/pcie-tegra194.c | 55 +++++++++++++---------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 96d38571a7e7..4ac6b1cea13f 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -137,7 +137,11 @@
 #define APPL_DEBUG_PM_LINKST_IN_L0		0x11
 #define APPL_DEBUG_LTSSM_STATE_MASK		GENMASK(8, 3)
 #define APPL_DEBUG_LTSSM_STATE_SHIFT		3
-#define LTSSM_STATE_PRE_DETECT			5
+#define LTSSM_STATE_DETECT_QUIET		0x00
+#define LTSSM_STATE_DETECT_ACT			0x08
+#define LTSSM_STATE_PRE_DETECT_QUIET		0x28
+#define LTSSM_STATE_DETECT_WAIT			0x30
+#define LTSSM_STATE_L2_IDLE			0xa8
 
 #define APPL_RADM_STATUS			0xE4
 #define APPL_PM_XMT_TURNOFF_STATE		BIT(0)
@@ -201,7 +205,8 @@
 #define PME_ACK_DELAY		100   /* 100 us */
 #define PME_ACK_TIMEOUT		10000 /* 10 ms */
 
-#define LTSSM_TIMEOUT 50000	/* 50ms */
+#define LTSSM_DELAY		10000	/* 10 ms */
+#define LTSSM_TIMEOUT		120000	/* 120 ms */
 
 #define GEN3_GEN4_EQ_PRESET_INIT	5
 
@@ -1591,23 +1596,22 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
 		data &= ~APPL_PINMUX_PEX_RST;
 		appl_writel(pcie, data, APPL_PINMUX);
 
+		err = readl_poll_timeout(pcie->appl_base + APPL_DEBUG, data,
+			((data & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_QUIET) ||
+			((data & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_ACT) ||
+			((data & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_PRE_DETECT_QUIET) ||
+			((data & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_WAIT),
+			LTSSM_DELAY, LTSSM_TIMEOUT);
+		if (err)
+			dev_info(pcie->dev, "Link didn't go to detect state\n");
+
 		/*
-		 * Some cards do not go to detect state even after de-asserting
-		 * PERST#. So, de-assert LTSSM to bring link to detect state.
+		 * Deassert LTSSM state to stop the state toggling between
+		 * polling and detect.
 		 */
 		data = readl(pcie->appl_base + APPL_CTRL);
 		data &= ~APPL_CTRL_LTSSM_EN;
 		writel(data, pcie->appl_base + APPL_CTRL);
-
-		err = readl_poll_timeout_atomic(pcie->appl_base + APPL_DEBUG,
-						data,
-						((data &
-						APPL_DEBUG_LTSSM_STATE_MASK) >>
-						APPL_DEBUG_LTSSM_STATE_SHIFT) ==
-						LTSSM_STATE_PRE_DETECT,
-						1, LTSSM_TIMEOUT);
-		if (err)
-			dev_info(pcie->dev, "Link didn't go to detect state\n");
 	}
 	/*
 	 * DBI registers may not be accessible after this as PLL-E would be
@@ -1681,19 +1685,24 @@ static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
 	if (pcie->ep_state == EP_STATE_DISABLED)
 		return;
 
-	/* Disable LTSSM */
+	ret = readl_poll_timeout(pcie->appl_base + APPL_DEBUG, val,
+		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_QUIET) ||
+		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_ACT) ||
+		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_PRE_DETECT_QUIET) ||
+		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_WAIT) ||
+		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_L2_IDLE),
+		LTSSM_DELAY, LTSSM_TIMEOUT);
+	if (ret)
+		dev_err(pcie->dev, "LTSSM state: 0x%x timeout: %d\n", val, ret);
+
+	/*
+	 * Deassert LTSSM state to stop the state toggling between
+	 * polling and detect.
+	 */
 	val = appl_readl(pcie, APPL_CTRL);
 	val &= ~APPL_CTRL_LTSSM_EN;
 	appl_writel(pcie, val, APPL_CTRL);
 
-	ret = readl_poll_timeout(pcie->appl_base + APPL_DEBUG, val,
-				 ((val & APPL_DEBUG_LTSSM_STATE_MASK) >>
-				 APPL_DEBUG_LTSSM_STATE_SHIFT) ==
-				 LTSSM_STATE_PRE_DETECT,
-				 1, LTSSM_TIMEOUT);
-	if (ret)
-		dev_err(pcie->dev, "Failed to go Detect state: %d\n", ret);
-
 	reset_control_assert(pcie->core_rst);
 
 	tegra_pcie_disable_phy(pcie);
-- 
2.34.1

