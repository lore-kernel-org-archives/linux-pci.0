Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011053.outbound.protection.outlook.com [40.93.194.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CE8386448;
	Tue,  3 Mar 2026 07:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772522473; cv=fail; b=M4/bBR7rs30MPLBpA3mg6SdM7uaVFlUaULRZHDZGieEheGbpBWsELdkw6RTIR0HukxzNQsvpbRW4WR6IPQbqpChCmEOGkb9OPAqvnW8On1ex4ptabWon9gBK5KlAPAeHwDSYk32Q00CeuKe7UzFM3sBauCwB0YHYEtf5VCacVtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772522473; c=relaxed/simple;
	bh=zNTNb8JBPHzk+p/1fzv+cH+/pLgxQ8eOnK38ZtaFK1g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xl46qdvBvJWIhnmBsxZPfh0V1oaekfPVfbas1uIDHa0MzMK5eyS5HNvei0xHtcnF5bLovu8MuKZH5QT95pVqfKdU0/OoTbDYoYCEE3UHFN+LVEoUm7M8ktMihLrARogdbV8kHirMJWzGCaO012KkyqSJzflJLzaaKe8ng5MbIqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eaXQA+0z; arc=fail smtp.client-ip=40.93.194.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eaXQA+0z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fKayJQp0zbPORBiLijEBNlMLbKZPSdNzZfH2oXZyRoQWLWuamyajpR4/5roO75kTwL2CoagRsNoNh0bnfnyqAUAqBTAMSbSXG1/cFX/azQRKurL9qvJ8DPB0ONPFUSDgd+ZkbtTIjF+jie7zQDu60QeQqs5a40bAXlB2b5ffC2vZhiQBgVAhYsk3PALilXG9ESYYMoicDhER0ObFXf/5g+9s3Ja/HWd3mnPgzxsbr/Xi9MgT1D+f7gawAZ7Z8VQPufkACUw2+WbBwlcpuVrWPn91vgk6lz+7DW9Xt8HpnR/27c0n++sJoQmcvXfSgiKLSaxYK6gHoyAzStnXWPoHnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3xF/MPfQd404eTKm4qt8GdyyZdDyQkjwnlscCm6Cvo=;
 b=dg4D0FevprkFQSUB9ESRuX8Z3Er/8mRKFwnXpAz9pnSvkegnHQDj7zyYtdhSYKN8GC1feWIFExlGYEP2SoJ10UInrtLCPD82JKeGFkyYzHxXy/ReGqxLY05RkURbieCKna5welh6AY5PFMxwhA3BDZ1SW2xpLy4iaZo8STwjI3xonryKa5STm1mgM3R6pskd+HP61LnbOETBQjH3sdA7/6o6R/PHR8/v1aNEnbL19u76h5wussKdewxapDqltPsKgwZIyBdtB6ilQHFZ1CrmeMapDZ4zX+I39iOBuEJs6RncikLATgAV8sfXmngOmWGNIs8R43f9/Gu8Dx03vSwyVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3xF/MPfQd404eTKm4qt8GdyyZdDyQkjwnlscCm6Cvo=;
 b=eaXQA+0zAcz5i+PDq+8ZpvQj/U3dnBy2oJ+hvqyzqPgTzN2usluEqkiR20Eh6u5hBGbrMd/wWjrnqJ5oIq8hChda7E0d7XgGYndzzsuACKmYfxOBWMyozKUj3N1W+u5V0HrsqOoor2nfqSIA0EwuOIWEFZbv93/2RgMwGoBSjFnqfK2c9o4O08ufbbJknKS53e7HZFS7mO0TeZyzSfO7dml59YcatfU3qdr+dKatfsHj1ZgrttKxBW3tdJiZExgdWsMxAnD/u1EAtVqOZOSX2x4s2o9qpKREI6pJGDnQX/0jtgpHimp1ce5kGmN+2Oh6wCTL1s+zFDT152oHLB74bw==
Received: from BY3PR04CA0005.namprd04.prod.outlook.com (2603:10b6:a03:217::10)
 by SN7PR12MB7273.namprd12.prod.outlook.com (2603:10b6:806:2ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Tue, 3 Mar
 2026 07:21:07 +0000
Received: from MWH0EPF000C6193.namprd02.prod.outlook.com
 (2603:10b6:a03:217:cafe::f4) by BY3PR04CA0005.outlook.office365.com
 (2603:10b6:a03:217::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Tue,
 3 Mar 2026 07:21:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000C6193.mail.protection.outlook.com (10.167.249.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 3 Mar 2026 07:21:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 23:20:48 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Mar 2026 23:20:42 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<kishon@kernel.org>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
	<Frank.Li@nxp.com>, <den@valinux.co.jp>, <hongxing.zhu@nxp.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH v2 3/5] PCI: tegra194: Make BAR0 programmable and remove 1MB size limit
Date: Tue, 3 Mar 2026 12:50:02 +0530
Message-ID: <20260303072004.2384079-4-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260303072004.2384079-1-mmaddireddy@nvidia.com>
References: <20260303072004.2384079-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6193:EE_|SN7PR12MB7273:EE_
X-MS-Office365-Filtering-Correlation-Id: 57c6fe46-0627-4e22-d437-08de78f56fa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	HHbWaCWCD8ZJCGbBv8Sbnam4wNa4jyHfw7raZjSLWueA8IY+4LjAmsiWBP8Lw7Rnq1gg4Rgs2Fr9sSFdCi3AFUflNJATMRFuF8fx6rvlGLU8TyfujDB6i//E+KRsnCixnmIvDPJ+6c4sciOtyaqQ7Qb3OKzwS1/4v2/+mHTffOb8ianT17IZh0boqwTP3L0uIpMU8KVOTA/Mb0GK+Ds2NXjNCqSW9JdEfD6dG0Qbfj1/W7zVLe3LJhqvjMsiRxlPd5T0U41gaVbk0+N3A+zGxrj3XIlDA+KnvlL2byM5c/VcA1J7OoUlwCxHLs374PCyTIsUED4rptfH61sQqpG82rjeTzSFvEMqDrXOBxGUx2rbvWDN+svpFG9GW5EArGa7tQl5VSW18vX+ARUiMUszsul2TJfS2MMOaRMpvVq1RUxTwvmZctzmvZyl8/nBOoplEot79ewt1U1jiOo8N5wEgDE6KfUJL/NVGtJTJVRmNgYVMt23i0+jnHZB39aeAz4ddJgsn+9BCTKG8GXrgEcZs3rF/hoPf62cOFQH6Cpu+OJG78GzDE+LXlQld93Ry6vDOv25YcdKl8YynZ5Xnb4R1AFaRpWuBBsBtRpwtKjdEhip6XVl98+OTzqJLQnx3V5F+OW1IevKFvHHTrqzGOXb+XygezHDuy/yTGs8/Uzs7YBQ0IEg5BkhSXbx0G4p4q8RYb9y/yyyGKo6r03lpzGxKwVPIPVAvV/lzyv766wt+W+8wyZzrstW5s7INNVNZOCUY1SBsxcVyvp49Lrm8DZjvABGnl5Ka8rezmMW/3dpgb3L9i7vEh6czMS4sFqN2/MbuP/lpoxjQMe6r6VTLQ5y8LEPKnkW8NzRcPfTbXrLaGk=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wnnIh/HlJicJHGvv4REZsGF+V9De6/fHxyVQrUjvkmX7D00sYUgzAmvpjhAbRXzdYIxG+klzZU4gPCmIcNi/Q/KszvOzZgYQkWWKdI94u/T7IltRaWqxMdeW6qkJBIc8ZUY+yMMAxRNt5P3Je4WQFJOGCnirSbh7G7jGYEnZxChoqC6w8najgGG7/w8I28d/87cMFc845AJTzAuLDVOet8MbwXVmyr/+UWa4cQOEyG/AF7xH7ygvLMSJjGBg6yBQIP5geYI07N/h3eO5Z/RpoiWp6+pYrlN8MfzcHpBqJOBoC1CppdUDakfriuhB1qGfcufnQSX+VGlETPCW9zvMXRq5Rz/w1HwHMFTduriYEx0u+/YxuOct93FEbgh4nW82P1u5TXZsKKTwqJylD6APEVDeX8h8kcaHt2FgUS8EQ2jA3YocayxWcKG/OtgQHlRR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 07:21:06.7327
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c6fe46-0627-4e22-d437-08de78f56fa6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6193.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7273

The Tegra194/234 Endpoint does not support the Resizable BAR capability,
but BAR0 can be programmed to different sizes via the DBI2 BAR registers
in dw_pcie_ep_set_bar_programmable(). The BAR0 size is set once during
initialization.

Remove the fixed 1MB limit from pci_epc_features so Endpoint function
drivers can configure the BAR0 size they need.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
v2: drop .type init for BAR_0

 drivers/pci/controller/dwc/pcie-tegra194.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index ddb1570e257d..2f35f18ba766 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2001,11 +2001,11 @@ static int tegra_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 	return 0;
 }
 
+/* Tegra EP: BAR0 = 64-bit programmable BAR */
 static const struct pci_epc_features tegra_pcie_epc_features = {
 	.linkup_notifier = true,
 	.msi_capable = true,
-	.bar[BAR_0] = { .type = BAR_FIXED, .fixed_size = SZ_1M,
-			.only_64bit = true, },
+	.bar[BAR_0] = { .only_64bit = true, },
 	.bar[BAR_1] = { .type = BAR_64BIT_UPPER, },
 	.bar[BAR_2] = { .type = BAR_DISABLED, },
 	.bar[BAR_3] = { .type = BAR_DISABLED, },
-- 
2.34.1

