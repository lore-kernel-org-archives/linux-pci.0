Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793618139;
	b=ugt1iwTBYIxvlG+nfo/QF2GBwyOafyDSRl54lRiSqtaQHVpe0jAq8RbEPnHHw5X5l1kC
	 7mJzIO9OQ0mGf4cOKeTgUIUCi40oEJ1x8PEV/3XGNQqbLfNv/Ybxnj00gyDFWV0ykTbk0
	 8YwciEBOygY7JB34PD7JoQ3hWenOR3DXb6+6JzxV1G9yxTlSrteLMmPu47Aw+jwLavz7M
	 CYd0tGNYq0AHnJiC/dYRuGN35md2fTsMEb9Xi+w/4Xncc6E/oEOPYNQdFt3+t+ky5nlEz
	 3yg7AmYB8bbPsiAALHSeGmjeq6UhIOihizVQQzfjg5P8HfwE2RJCFb+41mE3BN2L6HQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618139;
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
	bh=q3RK+7pn724Er6xhAPR59+Z/kA6jQpycg1boCWSFUZI=;
	b=5rpNBNVZc5ylMURpB2O+9VVHwUtCz8FA3VxlHwnsaNIJ/BF54U3gd7OgIjgWqf+Xuejw
	 SP9reYrTHyhapOyUHt/v7QyZB2TfQM4VBaM0/AepQeCnMENBGplazzZUeDz16YmlNzCoY
	 RlKFhH+GneFm9klDCzsV3XpXBjvCUE39SVeYEhy960B4NAppqdnZZu8bY/Y8HgpGmx8Yf
	 EBe83ki07RXVSkdhVSxXRh/z/wTlkpJe2vhKw2OtyeAnHM+cKb4l+49wffMM6WdyMoVzu
	 1RnGA50gSi88BXbtvKpaQpI7sdfsaHKOIQMTnvOWF2Zhghs45WIz6sTTGHjG84Pb4wQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KO2vzZNL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.28
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011028.outbound.protection.outlook.com [52.101.57.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B54606A324;
	Mon,  2 Nov 2026 11:15:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20B54606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KO2vzZNL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3dQBuxTdmQD1tnz5DiGmPxa2OAcElGt7FM0y+7w0dfVvyXvx5scPu4LdejnDorTz+3VpzY8Hq5zjOr7v2Izj1S+NrZUc7FLQpDjOIV/D+vAwy23Yf6kx/6dvWp94GsXUaoumnPCtZ5HT3/ayWxSoQUOXTgq4HTlUapKVrXOFdvSfzxa1rBT1PKC2RgtkN9bEgd84xokuFwmP2rRWx+c8pTWor7iEjTmMjuOLnCZ7YAeFQEobqRJXkh1x8MWhHxl6a3yXcVpIebnJ3WrmXLnLp0COdBPQQw4hGNSOKF3ejITYqPFfgS6meagGIL8CzgnzTGZKZLzbOLtjuuaaxRwyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3RK+7pn724Er6xhAPR59+Z/kA6jQpycg1boCWSFUZI=;
 b=dq6AmuEOsd02y/PqO7pSWsqBjyt8jJDrVpwYrBkUCUjulmZKhjo6EdeKu9IG1PtmuFz03v0IeLPUr9b0Nzfb54xG+GeQenR6xBn74RDbk4TrAUNn4E1McRXjHPapYxHYLLiGMqf8iNRSCnJlT5AE8WIIyQT78ZbON9ccsoc3RBNq07S0Q4QBvDY8Lc7mXDp6tn988dLIGIQ3Z80w8uYJJcl+VgKMIqhvOSCzI1ygzPWV2zyDCAWqQfUTCxXP20CXjvV8R6n48gXnfHIyw3n9WAcwDvMgWaynfxOp8Hr+bAzXA65ns2mRyMIRxdhRpqGhdEe7ZKeur7LeRqBBZdnAVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3RK+7pn724Er6xhAPR59+Z/kA6jQpycg1boCWSFUZI=;
 b=KO2vzZNLQa93S0UL2bkVY8RJbcZ05LopR7hRtlpo5vz2GCapqHR6V+PEfhzxlr33dzC7DIJAJnvX0i/Mn2iEzL0zQ7xZmsyGZfTDHDVoBx5MFXYli3skaLX5XeJsOoKaQcJjyo+RgfMHRDrkjKRQBav2RMxebGrsM0birGFGWGf9krXLE1A+6J1hCYtXWxNILv0rzX0X0SmmGZ1p48DzPab7YZHZZZFBJkGuFYYYV37g8+abgVRq0lV7GM68zpyS2pIpUGRZL3dRPXWbltuf1Vt/GAFUFCsNHnZKj9Fhl8gDVlOZoHSufCkruvjEgbTbZjzzoTkFBr0L8xHn8xwbFA==
Received: from BN9PR03CA0452.namprd03.prod.outlook.com (2603:10b6:408:139::7)
 by DM4PR12MB5819.namprd12.prod.outlook.com (2603:10b6:8:63::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 11:15:34 +0000
Received: from BN1PEPF00018072.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::e) by BN9PR03CA0452.outlook.office365.com
 (2603:10b6:408:139::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 2
 Nov 2026 11:15:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00018072.mail.protection.outlook.com (10.167.245.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 11:15:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 03:15:17 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 03:15:12 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <jingoohan1@gmail.com>, <mani@kernel.org>, <lpieralisi@kernel.org>,
	<kwilczynski@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <robh@kernel.org>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<vidyas@nvidia.com>, <cassel@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <mmaddireddy@nvidia.com>
Subject: [PATCH v3 2/4] PCI: tegra194: Avoid full Endpoint reinit on PERST#
Date: Mon, 2 Nov 2026 16:44:48 +0530
Message-ID: <20261102111450.4010818-3-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261102111450.4010818-1-mmaddireddy@nvidia.com>
References: <20261102111450.4010818-1-mmaddireddy@nvidia.com>
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
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018072:EE_|DM4PR12MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ff936ef-999e-438a-a061-08df38d29d1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|23010399003|376014|7416014|1800799024|82310400026|36860700016|261021123027099003|261021121427099003|11063799006|56012099006|261009223027099003|261028144727099003|261026121527099003|261026140227099003|261022105027099003|261022075727099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	JIabw3oLgn7wRmb8gi0vAmQXa1RXWyG5YYV/gNZWjm+KZWbluvE6eAAGm5pbDxlk38Byfw4S/T7IoaTsMa2GMmO47RJgGADRHxlzt2OvmGMBcHlQj8PUYWKk88DfTf8Wed51ceJX7Dw4n3ODSb2X0WKefkrLM0tBrMo5Dz/zcPF285pENRiHgK4pmXE6p1Q7JMhrdUvghjUZNNAOFa2GW+YPmzfZEqU4sIv3v3MiOZaIxSbnOvSIHWt91N+MOgp6u0Eg5MenT1WE/nidDXnnOJSPOVfowS+Hkt6bKlslnvSNyURlwTz9qbqvk2A6C9MeaN2Y9iiT8qVuUUuSxyPa9Yu4DJTVkGOxO6ffqJY3OAT2++mFtZI4apPMix7HuDe+BLLSlH+hIktopnUwDNsJ+NzXwm94Lapz7uS0Npru4IUyMhlz/5MxvUsjJeQh+IS/H3kNoVYf8J5GNUuaM7HPZPtHYUL1O9XSJO+IFFt4s0izfKePdAkVairP6CFgDt8MZ+111ydNtI7G+u1HXK4/8DodgM+XpzaSs6PTX2njZeEwxgw3XYya6GH8W5Q5xDxqq6nnRMy9goUCtsWC3AnA6TmNL0QC08V1fAWTrLtRElPX1HIVZKFtQro/SHFBWY4HTp8oUW8CeBJwWlsCxuuTZWVCuwqr2CvMaoWCyaqYNY+ZD/e5rdit2lqFURsKT8XtU+tm4fcIPq15ItNHkrGuLg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(30052699003)(23010399003)(376014)(7416014)(1800799024)(82310400026)(36860700016)(261021123027099003)(261021121427099003)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261022075727099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eXJMpLBE6gBLCsPXl8gGFIEHZ12LRZwtiA6FBetW/X3UeJosnS2CGEEzZa2NDomgGyawwFR3BX1vwpM1yQw2HHJKkPG2OVuj2NWWuOU/PPBNc5hJz30vm4dF+4NexAKKwMD+Wt8t4jRA2Eg2Bb3eWrEtI8uyW6dLbmhbYlNYhzWMKTl5Y599siI1vxwF5U3cBRRL60W/tp01fERlAszKqKqu30KaRw9RfUyuRZmKXHU4BqkG3Ca73NAUFYFiFT+Agn52Py+lmjSGdJA8N1s9CZbWiCf09ouibY4CQNVvDrt41cNNQ3hJG23p00ChEfPO7tGvywD3PvV7aca7p+qHlnYizVrIph0FazUHmFbpyfPlS6vJD3gJFIg21W3Gls6Nbf+vVd//OT9BQj2ZGtrOI7oUfn7id4SUnyUp8bJSJxCTAbR53FLINy+UfdIGkxDM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 11:15:33.8420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff936ef-999e-438a-a061-08df38d29d1c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5819

Tegra194 and Tegra234 lose controller register state across PERST#, but
the driver remains bound. The common DWC initialization path now
restores those registers while preserving its software resources. Tegra
therefore no longer needs to call dw_pcie_ep_cleanup() on each PERST#
cycle.

Remove the per-reset dw_pcie_ep_cleanup() call. The existing
dw_pcie_ep_init_registers() entry point now restores reset-lost
registers after the first initialization while retaining software
resources until final driver teardown. The allocation guards already
reuse the bitmaps, address array and per-function descriptors; this
change also avoids repeating the full debugfs/eDMA teardown and setup.

Keep the EPF deinit notification in the PERST# deassert path after
REFCLK is available and core reset has been deasserted, because EPF
deinit callbacks can clear BARs and need register access. The final
dw_pcie_ep_deinit() during driver removal still performs full cleanup.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V2 -> V3:
- No code changes from v2; rebased onto the current PCI main-based stack.

Changes V1 -> V2:
- Keep the existing dw_pcie_ep_init_registers() call now that it handles
  both initial setup and reset recovery; only remove per-reset cleanup.
- Clarify the retained resource lifetimes and shorten the opening
  paragraph to focus on the Tegra change.

 drivers/pci/controller/dwc/pcie-tegra194.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 72158fc5c639..08d6f4c5220f 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1909,7 +1909,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 
 	/* Perform cleanup that requires refclk and core reset deasserted */
 	pci_epc_deinit_notify(pcie->pci.ep.epc);
-	dw_pcie_ep_cleanup(&pcie->pci.ep);
 
 	val = dw_pcie_readl_dbi(pci, LINK_WIDTH_SPEED_CTRL);
 	val &= ~SPEED_CHANGE;
-- 
2.34.1

