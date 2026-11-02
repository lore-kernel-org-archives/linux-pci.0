Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793618930;
	b=EohCJVTnKpvzm+Umvjx2tcSGzPOGtLWdD2GWZKQv5ATxUAg23P4N3fZNpHElh+o+kgGb
	 x0LB4BDbfrbjo5E4rtgrZgJmL9+a0cMWxRHCFuGB0JLWnsN6xnymjiRbc9KjGj6zPiBJJ
	 3CeubInBGaciqfyiS0M22JrUyQ+xvgR4E9iqdse+fNAUXsFvnkSGhKYaaH9OnpjbKKbkX
	 KlVA+HMC5nwouFPGZLXOMNag51SfhbaG3WK5IUrtwsl5y4MvZ1Hzqlk6k3joMkqEta7xU
	 Hge4X0nCmtSAw4ptFNYbvFXKkPKxZMRQRJfaP6ZrIKej/Qzsw2uahGNtg/7UoPPEJYQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618930;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=V+DabifmEE2fmqxpzV2F4VyutHFv87M9UXrvTjA9348=;
	b=zkTmgd/SxdW0IBkN1vprUrVfGNu1CgHE0aUngShP8EKGXjPh7WH9DX1V7uXdsMpdmPdx
	 b8a3AIkGUzwlq1kHC8SWZabIC/I01GwsOs07DayXnQWJzs0J4NvyXuOc82jJdy+juvBR7
	 a7mg/NbjWEExgfh/TJKc97U+3D8Q/d1sJytqzxjDUGmxR2hUj2kuXI2trpis1zlLXdSeh
	 klq6gD0wPRnqW0n9X70ViZs2ZJSdgdOXMzszR+9J1neJt33Fo9rsjnB7G3uyB3O0J0yHh
	 NicoQZhlX5bcbgOAZ77hi4zyhrO1hPIgeiytPE4ZTDaOmsTcC+pbEscGE5pO4Ynta/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rAx1CfdR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.46
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010046.outbound.protection.outlook.com [52.101.56.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE5860A6F5F;
	Mon,  2 Nov 2026 11:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CE5860A6F5F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rAx1CfdR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTrLh87AMgXgYr65PZKcA2mSm4BiyIbS7bcDrdXY/9sbbfRuwJSSoe7Beu8mliNqa6rPGTN+6KGLWkIlkuRMn7yGizQ2OwFn2XrypbmqC1lq8fsIH7wxYeHPiozAgaElRwG6YuOj/CbsA3Ckg1HgdLHh9vaC6OJmsKGTc68opSUfVG+MvH5V+7UliAExlH7oMIlSUVfrOVSWc9pmL2twJ2Tc+2ayT70shSXuhB44l/BgZLa4vDqp4o1xyvCOLS6WwSCmKUK3bO87Q8TqbsCQper1P328kAlOrckqSpHcBRt5KTLtWjiuOI5N5d81uaGVgBcm/Y5D/hrhMk74DPkaag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+DabifmEE2fmqxpzV2F4VyutHFv87M9UXrvTjA9348=;
 b=J7447UZx/A9C0JFNmj/me7csqwgZeREp4d0RV37okBB5IIo0s1Avrt1+h9OIHUfgvVC9tM0TzvKfAwi5D+FP0lEReovLSc+G1pYO8r7UTmB3aOGOZzdsSxeVWSvvMYDcCgicGLtyIOFNEawxt4hRP0NzKdBsYiSBpLIT0H3hmfAwwpY/r0sNbtx3LGgSi2j853BSejF7bgHH/heAaR0xtEYbf1aSedKumP+jLQj0EDRLRCeOi+b/0sS8A5txDgn/oHZ0DVK6B7WZIUBYt6jQf0ZmZaAXUFEZfTuoeKMNNC8BMXPVQdqX+HXKrLlpMq6TT38hYb2GmvRtovnpDyLZaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+DabifmEE2fmqxpzV2F4VyutHFv87M9UXrvTjA9348=;
 b=rAx1CfdRKRDFMkMrH2+MzHrpeFzIeRLtY3QIhb13uucLf29auPhGbNevM2z2x58vzeMK7JR5HagTOR2GvcW19+EtJZKUan7DGnX5F6Eja5dNUK8s08R3968I9Jso6ClkvSesmxycX5ED937n3C0b/Z6dLz+qnpwRAS1V0LIxK2SGEDCzw4Toft+kXMex5ZS8TCjoA1Cup9Y8JuZhVzsxNIzYPvbT6AskTdALfOe0g0O/oq7mqbHrxs6cql6BiLBuQEs3wsvvRdYrIxLIvF+SWt9N/BMf4S8mc7i5N/PCChECbfBUmoZwz4c6oCKIhV7nZQy1qfExQDxPDvMDIEWI9Q==
Received: from BN9PR03CA0265.namprd03.prod.outlook.com (2603:10b6:408:ff::30)
 by BL3PR12MB6377.namprd12.prod.outlook.com (2603:10b6:208:3b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 11:28:45 +0000
Received: from BN2PEPF0000A88E.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::4a) by BN9PR03CA0265.outlook.office365.com
 (2603:10b6:408:ff::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 11:28:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF0000A88E.mail.protection.outlook.com (10.167.248.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 11:28:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 03:28:29 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 03:28:24 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <robh@kernel.org>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<kishon@kernel.org>, <Frank.Li@kernel.org>, <vidyas@nvidia.com>,
	<cassel@kernel.org>, <den@valinux.co.jp>, <marco.crivellari@suse.com>,
	<andriy.shevchenko@linux.intel.com>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mmaddireddy@nvidia.com>
Subject: [PATCH v3 09/10] PCI: tegra194: Enable core monitor clock after link setup
Date: Mon, 2 Nov 2026 16:57:18 +0530
Message-ID: <20261102112719.4022633-10-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261102112719.4022633-1-mmaddireddy@nvidia.com>
References: <20261102112719.4022633-1-mmaddireddy@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A88E:EE_|BL3PR12MB6377:EE_
X-MS-Office365-Filtering-Correlation-Id: 32d288e1-b57a-42a8-dd72-08df38d47486
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|30052699003|36860700016|82310400026|11063799006|56012099006|261009223027099003|261028144727099003|261021123027099003|261021121427099003|261026121527099003|261022075727099003|261022105027099003|261026140227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	6bjT9RYDG+AGNynNyFvzVMJ6hdrkSSE2XocfauWGNGe9BRoEi9rOeL/VfPdqh+DOHUwMM9+13xuUf8lhG2x0LZX6tFZjnRwIzMZHjuvsOf+lsJK8j9p2ZJrqQ1huA/hwYqjxL/ch2TF1SQFglpqNyXqkdIP+XmZK2nXzxq/gMwtsBxnyBrWomkXSeqq48vIh8MDJINVy7YVDtMpXczm2pHS9T4LIPxElLZ9f3aapGuQN9pCdv1L2Ge0Wt7hBiDewFW2RWo0e66fGzNViA6IeeIBS+3yfdldoGe8QFTHE7jBfXK1K0jwORSgNyPpcGpIvDsnuKQX9roGjMJxJsLmGfA2U7ZAxIJKKtAoQFedRBiDd7diIUTwhRs+UlOc4J6v5mpXeNr9yLSi0PMOk+3WejMHwuBanOCEVe5Ql5zi9oF/G5Rli5Z88JCyGzcq4fLK/uYB2zmG0pvzAzAuk1hz6VaaPIV5CmrF0DqDo7sDiGt7G7EzKJekozSJSS6IlyIkNogTDVr0vuiZ4GDF+yJoxB9ZX8kHfZXYNAMHG7N0yRBthkpNxg5pQGNC9P0q0PU2y2rkk84LHzLQkylE/aSsa9bkpPfuQHY1A38XyoA8QZW0pKGisMsrTtri88mE2sTEs6SSe2nme/hojmbQI3lVqYnMqHqHHB6ztrkNCaN9YOqb/BmHPip9JUGIe6kYY2jcbO8SfhTbqUOagHppnLRFJ0g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(30052699003)(36860700016)(82310400026)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261021123027099003)(261021121427099003)(261026121527099003)(261022075727099003)(261022105027099003)(261026140227099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BRG965/w4JBc18Idb3SQl9oo8hGRtb/2jZteYQbzT6e0TW2WVMGwKlRM2Pqlx1wWi5R7vsTAT9eyhqnZaULUgcD1snvDQGcukSv+c7/zBKX8hF/nn/x8wu+lnZz4urKaEDEAlTnkwBbrUTaWrc3FT5/PvD8sNcGzjr2v78u2SGf++2BQLLZrYzt15ynTw1Dxo7EIdpswihSP7ALZH89OrUU+fDTlfHMj2ou6Y8T/xOTMHVkOnrY3VpnExxUwk3HPTub/9a32LpqtUnDRYZcO9E3E391evmAfgaauNXrUD0EMmLNiV0osyd+KUNt15X85GyeiaRm3Zkm18JKKALEnJa6zgvU6htQ+9tvPPxqFPzmrO/gQ0Y5bouNC8pz68EeREYUdCDgUakUGAIEtm+auAJl3i2J8M99vic7y1fXa0LmoJ6PZJkTKfGVZwC5Gh8BA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 11:28:44.7356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d288e1-b57a-42a8-dd72-08df38d47486
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A88E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6377

Commit a86ca8698c88 ("PCI: tegra194: Add core monitor clock support")
enables the monitor clock in tegra_pcie_dw_host_init(), before link
training completes and the core clock rate is adjusted for the negotiated
speed. Monitoring during these transitions can cause false frequency
monitor faults.

The existing initialization also enables the core clock before requesting
its initial rate. Boot and Power Management Processor (BPMP) firmware uses
the requested rate to determine the voltage requirement, so enabling the
clock first can leave a window where the voltage requirement does not
cover the rate needed during link training.

Monitor clock ownership is also spread across the host initialization
callback, DLF retry and teardown paths. Monitor enable failures are only
logged, while some later initialization failures can unconfigure the
controller without releasing the acquired monitor clock reference.

Use the following sequence:

  1. Set the core clock rate to 500 MHz, the highest supported rate.
  2. Enable the core clock only.
  3. Program the PCIe registers.
  4. Train the PCIe link to the target speed.
  5. Set the core clock rate for the negotiated link speed.
  6. Enable the monitor clock.

Requesting 500 MHz before enabling core establishes the voltage requirement
for the highest possible training speed. Once training completes, reduce
the requested rate as appropriate for the negotiated speed.

The monitor clock is a virtual clock controlling the PCIe frequency
monitor. Its rate must not be programmed separately. Enable it only after
the final core rate has been selected, avoiding monitoring faults during
configuration and training.

Move the initial core rate request into controller configuration and
propagate rate-setting errors. Enable the monitor clock after successful
Root Port initialization and at the end of resume, propagating enable
failures. Keep monitor clock operations out of the host initialization
callback and DLF retry path.

Release the monitor clock during remove, suspend and shutdown. Failures
before monitor enable unwind the controller without disabling an
unacquired monitor clock reference.

Fixes: a86ca8698c88 ("PCI: tegra194: Add core monitor clock support")
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V2 -> V3:
- Rename the patch to "Enable core monitor clock after link setup".
- Request the 500 MHz core rate before enabling core so BPMP firmware
  establishes the voltage requirement before link training.
- Keep the monitor disabled through register setup, link training and
  negotiated core rate selection; enable it after Root Port initialization
  and at the end of resume.
- Return core rate-setting errors and monitor enable failures.
- Remove the reference-state flag and common monitor-disable helper;
  balance monitor operations in remove, suspend and shutdown, keeping
  host initialization and DLF retry free of monitor-clock operations.
- Explain the required sequencing and the risk of false frequency-monitor
  faults during clock-rate transitions.

Changes V1 -> V2: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 51 +++++++++++++++-------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index e08d99efd616..981cff740cd2 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -305,10 +305,11 @@ static inline u32 appl_readl(struct tegra_pcie_dw *pcie, const u32 reg)
 	return readl_relaxed(pcie->appl_base + reg);
 }
 
-static void tegra_pcie_icc_set(struct tegra_pcie_dw *pcie)
+static int tegra_pcie_icc_set(struct tegra_pcie_dw *pcie)
 {
 	struct dw_pcie *pci = &pcie->pci;
 	u32 val, speed, width;
+	int ret;
 
 	val = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA);
 
@@ -323,7 +324,13 @@ static void tegra_pcie_icc_set(struct tegra_pcie_dw *pcie)
 	if (speed >= ARRAY_SIZE(pcie_gen_freq))
 		speed = 0;
 
-	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed]);
+	ret = clk_set_rate(pcie->core_clk, pcie_gen_freq[speed]);
+	if (ret) {
+		dev_err(pcie->dev, "Failed to set core clock rate: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
 }
 
 static void apply_bad_link_workaround(struct dw_pcie_rp *pp)
@@ -965,10 +972,6 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
 		dw_pcie_writel_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF, val);
 	}
 
-	clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
-	if (clk_prepare_enable(pcie->core_clk_m))
-		dev_err(pci->dev, "Failed to enable core monitor clock\n");
-
 	return 0;
 }
 
@@ -1045,20 +1048,19 @@ static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
 		val &= ~PCI_DLF_EXCHANGE_ENABLE;
 		dw_pcie_writel_dbi(pci, offset + PCI_DLF_CAP, val);
 
-		/*
-		 * core_clk_m is enabled as part of host_init callback in
-		 * dw_pcie_host_init(). Disable the clock since below
-		 * tegra_pcie_dw_host_init() will enable it again.
-		 */
-		clk_disable_unprepare(pcie->core_clk_m);
-		tegra_pcie_dw_host_init(pp);
+		ret = tegra_pcie_dw_host_init(pp);
+		if (ret)
+			return ret;
+
 		dw_pcie_setup_rc(pp);
 
 		retry = false;
 		goto retry_link;
 	}
 
-	tegra_pcie_icc_set(pcie);
+	ret = tegra_pcie_icc_set(pcie);
+	if (ret)
+		return ret;
 
 	tegra_pcie_enable_interrupts(pp);
 
@@ -1413,6 +1415,12 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
 		goto fail_reg_en;
 	}
 
+	ret = clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
+	if (ret) {
+		dev_err(pcie->dev, "Failed to set initial core clock rate: %d\n", ret);
+		goto fail_core_clk;
+	}
+
 	ret = clk_prepare_enable(pcie->core_clk);
 	if (ret) {
 		dev_err(pcie->dev, "Failed to enable core clock: %d\n", ret);
@@ -1654,7 +1662,6 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
 
 static void tegra_pcie_deinit_controller(struct tegra_pcie_dw *pcie)
 {
-	clk_disable_unprepare(pcie->core_clk_m);
 	dw_pcie_host_deinit(&pcie->pci.pp);
 	tegra_pcie_dw_pme_turnoff(pcie);
 	tegra_pcie_unconfig_controller(pcie);
@@ -1692,6 +1699,12 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
 		goto fail_host_init;
 	}
 
+	ret = clk_prepare_enable(pcie->core_clk_m);
+	if (ret) {
+		dev_err(dev, "Failed to enable core monitor clock: %d\n", ret);
+		goto fail_host_init;
+	}
+
 	init_debugfs(pcie);
 
 	return ret;
@@ -2379,6 +2392,7 @@ static void tegra_pcie_dw_remove(struct platform_device *pdev)
 	if (pcie->of_data->mode == DW_PCIE_RC_TYPE) {
 		if (pcie->link_state) {
 			debugfs_remove_recursive(pcie->debugfs);
+			clk_disable_unprepare(pcie->core_clk_m);
 			tegra_pcie_deinit_controller(pcie);
 			pm_runtime_put_sync(pcie->dev);
 			pm_runtime_disable(pcie->dev);
@@ -2486,6 +2500,12 @@ static int tegra_pcie_dw_resume_noirq(struct device *dev)
 	if (ret < 0)
 		goto fail_host_init;
 
+	ret = clk_prepare_enable(pcie->core_clk_m);
+	if (ret) {
+		dev_err(dev, "Failed to enable core monitor clock: %d\n", ret);
+		goto fail_host_init;
+	}
+
 	return 0;
 
 fail_host_init:
@@ -2530,6 +2550,7 @@ static void tegra_pcie_dw_shutdown(struct platform_device *pdev)
 		if (IS_ENABLED(CONFIG_PCI_MSI))
 			disable_irq(pcie->pci.pp.msi_irq[0]);
 
+		clk_disable_unprepare(pcie->core_clk_m);
 		tegra_pcie_dw_pme_turnoff(pcie);
 		tegra_pcie_unconfig_controller(pcie);
 		pm_runtime_put_sync(pcie->dev);
-- 
2.34.1

