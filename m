Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793618919;
	b=VeHTXFgg4pzovkWKVKOWLHcuNc4fF/1QrI+uhvPIV1nQJ5qJL2EV7oI4qtQx0eQmvas6
	 jhytYZPZXkvBf5zRJPzH3Pp28z5Rylt/S/wSHrwj1+JFV8ZLTvahd6NAy8nh6WGNIiEoA
	 Tqc6YOZJi51DW6HkZ9sKLdChD+UEZ4ReY7FZPKB3sisxwaM00hUw5tXfbrmMx8rJ4MR8z
	 +tFWRZu7yg3RazRFyze1cVF98hHPipKBqIU6keGvbb8MoxrkI2eHEcTrnlgW8CXYp0t/m
	 PXdYy75CoNx/m0ISU6usbJKOXWZmTxO2Z0HjJ4Czo3U76N8JpvBWCfvAB1/biPSYl3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618919;
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
	bh=Gn2cEY0+kEGG06pXqlvmHAPWT4J9qcRCIY5U4w+DWP8=;
	b=QtKNddLqhMsipnrEky8hBaXVAykB4g1xUHCqtCXa5eecEkDmH2VDx56oEj4lndwc19Fa
	 7b1zRyHy4/djT1CV3tTZvJee4caKq8r2AnzhvdRRFtvE2sP69mj29m4bBm4yTQjjnHKx5
	 Fuva1iuYCevRYAJ90OVE/nXnT4IFFgPmwibKkW2NDU8s7Js6zjZ4+aMfWFB0fmnBmjgP8
	 VKOswFRhGpfyQnvP9wV85xjt66Z2xQfzCG1EZ3QnPP9Jt0SJCPKtASB8qj6mtehxyTeAo
	 Bg0g+M5sEMm5Rp3h1PqYeoJoFKlT34u6mOqtz6Etr2N+YF/jTD79o7RWdQSLs1EWzwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=W1jJQIuy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.70
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011070.outbound.protection.outlook.com [40.107.208.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AAA606A329;
	Mon,  2 Nov 2026 11:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67AAA606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=W1jJQIuy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUGSOjDGDPvaACz0BUJxUFvvfoC+yFAvpgGj+4FQB5cRBekJDue3J/N1nPm737EMT0FlOq4stKKBPay1M7UsL6hgXa+qVB0DZk4rkwFLn8PRzDn7IDNSjNcIBiN79rolEFQO7wn5rCTbAPbVmSUlG5fmJRZinKk4N1TuaPSbbnfw+MYRtpy7mOPTBaezKCb16ZWxZSIQEMJ+6pCR1HDBNkn6RnE733zRzcTPETiAYj8uHVVFZQTFUrjmguC0Od9cXiSdgRr1u/iNi5ouZpsAq/9XkOLHtAb3pCf6CmxtccuYyUJtvyykpb5umQcHGZmEQSeeIzweqw6WThRlfuq0Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gn2cEY0+kEGG06pXqlvmHAPWT4J9qcRCIY5U4w+DWP8=;
 b=cXJIE/H/977E6qHcEsyclGSqYpoLRhADnriCWVFrkWEB1huH/bAT2tPEmmnxXOyqkc/FJKR9XbU5Ew+oJtT5r7hrXiUkelC/UqfqpXYGAg4M1rNqpeKSZ44gsbQRcapn6D61+D1N1ZFR1AC+6V37ZYIAm7qHbA81yTseJ9SYzjHAyVqkzDIrJOyPgHd1TObz7dE0GbyQi5qq47cYb+RauVkq1EkqpBnFEmdkEtA9+bN5Xw1vYCu53S7zgsoM6suSju54oq0xQUudsNzfkB4uWDgcvBXi5pVolBIvANej16Jm8IRXnByxSN638NiQXpqUTtMT3sBhy9uG38y5imyptA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gn2cEY0+kEGG06pXqlvmHAPWT4J9qcRCIY5U4w+DWP8=;
 b=W1jJQIuyRkxkQ2PXTYUXRul6UahlrVu4ff9Gh5CmPcgnxfHeRA7UkjccB2xf9xGjLc0bkmsSSa/jC4/rOFXgfDB6d2I3MIqqiAMHbmiI3fy6slKY7k4dxjb4MLiYbOXkcUC0pDwUoJUi+NHEA0gCMcyFoMHYWcUeYW1qCvuRrsIf2VtSxcLErexjffrYuLsid6tUS7XWF1yMmkNvvxVdnvPdUWu/3vSIGYQ1h6cl4GAdKu0LeTbY5sX/2fk4pkbZS/wx1IdaALwnZWS34W9w8wkoq1XCkeInzAZeAZNvdA543PSx+ynQA9hCBIg7+zFp43e/76wyLRT2XOuxFRqNBw==
Received: from DS7PR03CA0102.namprd03.prod.outlook.com (2603:10b6:5:3b7::17)
 by BY5PR12MB4209.namprd12.prod.outlook.com (2603:10b6:a03:20d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 11:28:35 +0000
Received: from DS8PEPF000000E0.namprd05.prod.outlook.com
 (2603:10b6:5:3b7:cafe::74) by DS7PR03CA0102.outlook.office365.com
 (2603:10b6:5:3b7::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 11:28:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS8PEPF000000E0.mail.protection.outlook.com (10.167.23.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 11:28:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 03:28:24 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 03:28:18 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <robh@kernel.org>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<kishon@kernel.org>, <Frank.Li@kernel.org>, <vidyas@nvidia.com>,
	<cassel@kernel.org>, <den@valinux.co.jp>, <marco.crivellari@suse.com>,
	<andriy.shevchenko@linux.intel.com>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mmaddireddy@nvidia.com>, Frank Li
	<Frank.Li@nxp.com>
Subject: [PATCH v3 08/10] PCI: tegra194: Guard Endpoint PLL-off error path
Date: Mon, 2 Nov 2026 16:57:17 +0530
Message-ID: <20261102112719.4022633-9-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS8PEPF000000E0:EE_|BY5PR12MB4209:EE_
X-MS-Office365-Filtering-Correlation-Id: 21fc1c84-8b5f-4a18-7c91-08df38d46eb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|7416014|376014|1800799024|6133799003|10067099003|18002099003|22082099003|56012099006|11063799006|261021123027099003|261026121527099003|261026140227099003|261022105027099003|261022075727099003|261009223027099003|261028144727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	LcM7N3aSCyeQG1dPdCK3HJ8STfCNu62ZbuTTfx7VLAtSFXPOnW5aHGh/2RNiGA+gCWhLOQOuXYXGB5GMxMouK+r+icFnpF92UsMSJbLD4aVx/y+ryelUu1W3KeJ3QA8pYNBIl8rqfuaE0s52ZLVnD/nv4lAZHOaTmV5i1TkEYoaJC/P+TXTmzzhKoQymF4DQMv6C0ENlGLr8TB9IexI6J5G5+L2iqzMwKeHI52TUbfkkRjAIVipk3lDAFPNcvdOF/ugKinL4XmytbBfsIqBqR908PkJQY0k9rwypGOPsuAyrtsmpV/IKnh5IWGuzw0iYDCuYBec4WR19N8GJl6kdpipCCtQpO8F0ogOrDHrLJmNc1w63CywFN6rwOAgWTK+O/TvAUZWOZR9hZd6SzjsZQNJ5/qYJAzK2PBNhb78BJBNDOcFi/FRTMJxYCVov+HfGJXSvYdNRYmV/IlFiQrTI9p4Z3bvRI89eCG+t0sd3tvSytq4mAp+IEoSMwK+zwk9eaLTi3CCgOyz3nqAr68SKli84FrY7sKNPK4WIoqwEj8UKX3cKH//InV8YxczQZ4zGUy95+qN4PMZNRhvUyZxydeIF/KYJYgKEX51qvoq8+ATtC8wKxxj37YHlFECPDDqb1MtcU0ObXpWlb5jaglu1XpRTOYtx9iJynXbn0QCT0yrfrUiUaWpYdtW7cpIuTHFvbIrug/2WUmg5E/o5ldB3bg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(7416014)(376014)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(261021123027099003)(261026121527099003)(261026140227099003)(261022105027099003)(261022075727099003)(261009223027099003)(261028144727099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Eu5FYgI/KduNpNbvLgip7doAnvHwUCJ3Kion+5/SpRESSWPtwlC8X8XvZsjX03neUi2M7I3Tt/V5ZGs/ibvp2hGGXWZIogOhMT6Cxd9faFbdsgdWMK8V3OK9OYiQ+KRaSNDwhU0ZErItnxAiuiLKjNUhGrw6y7rGiS65jkeZ7UD4tbneUrisEF1wHUiPf69mBHXwpOnURR/A1m1V87+c0T4bkCIumlUXxJ8Gf/BvO2acnE7SHa0LcEcZ1DzcC7ZQ/zhxdE5MLaGJonOseYlpfO99y524LBwrAeAMLzdmgDK670kGiwU+GbpvIMH6CYCIJTNz0ssEkRBt1wtCj0PgRlAIvo79/GEs7JE2clRB41ib/PntoJajsbwb6m0mottwvgtfeqFzQ99s+kSwughMCekQ9i/8MVnMNXt0ncRAydd/iTnec1HFQL3n5i90g37m
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 11:28:34.9932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21fc1c84-8b5f-4a18-7c91-08df38d46eb3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS8PEPF000000E0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4209

The Endpoint PERST# deassert path initializes the external-refclk PLL only
when enable_ext_refclk is set, but the error unwind always sent the PLL-off
request.

Guard the PLL-off request with enable_ext_refclk so Tegra234 Endpoint
configurations that did not enable the PLL do not send a spurious BPMP
PLL-off command.

Fixes: a54e19073718 ("PCI: tegra194: Add Tegra234 PCIe support")
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
Changes V2 -> V3: None apart from rebasing.

Changes V1 -> V2: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 0ae7adc16054..e08d99efd616 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1974,7 +1974,8 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 fail_core_apb_rst:
 	clk_disable_unprepare(pcie->core_clk);
 fail_core_clk_enable:
-	tegra_pcie_bpmp_set_pll_state(pcie, false);
+	if (pcie->enable_ext_refclk)
+		tegra_pcie_bpmp_set_pll_state(pcie, false);
 fail_pll_init:
 	tegra_pcie_bpmp_set_ctrl_state(pcie, false);
 fail_set_ctrl_state:
-- 
2.34.1

