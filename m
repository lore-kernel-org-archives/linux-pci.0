Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010015.outbound.protection.outlook.com [52.101.56.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CC93112A1;
	Mon, 26 Jan 2026 07:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769413618; cv=fail; b=VhiXX15rHXnt/TSWmoS5rRLooNZKu9rdALrhM93Y2fVvukbaqPPiKTFQ61aFaEbb4xUE1NTWW7nTC039Kxbma1WlU4g9GvMHrlTbrnKjxuk4uQAy15SilaN25VINIIP9DTT/+na/FQ2rLtsOkv23ozZwAs3HBf3xXa50EmPKzTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769413618; c=relaxed/simple;
	bh=PycBrxJeeMkeuGMJfXevoZ9ONTiYY0LZiN6lZAD3q98=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eOuqQGpRqJMhHG5kKpx+Rtqu6DjXNKevGkk1wdPNO0r3Th+n3Lt3EevkO3Nkpd27ybGYLFUq2i6ZVfwMoj2uqkOt1GsQoP9C+ngB7cWCst+o3mPPgzetuxjpnhr6FYadbVxz7y6GVDBepE/rGMwi17m3SKa92U69JQ09HrqUJgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yb5PQZr1; arc=fail smtp.client-ip=52.101.56.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yb5PQZr1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JogqSvo91CZhIUL+N+h5/6nV4+vfgaPMZ58qEfgozdL7Wba/6qnZsWSHF573dccDKJgV0yYYcVnB/UzEcQm9xOJra2Esc4SRr6QpMeertQhtUo0Mms0OWWXo1KXadLdDPtZ/ib/j0CrlipootYdMjKbu1xniErcp9pTfxkA9qiF1xKze3AVMdXkum5hXwxDl5DfLbS/VP7cRlQKRChoxjTbVq2o2nMVtdWjfpCVfEkfZflqQ20UJTUDlAwVImSzU0MOm8pnnTCZbbfsVWA/uBcYAceusWJ1/RNWf86a7ktn/Xr/cNMjPIUY32oKlXydmJoHkSBWh2qmlVSvZDBBTgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkagdSVoNZQe+QVjzNqBgngpSpQPAPLuriIBfTiEfB0=;
 b=vGnMYs5gc29ssaUn7azclvxNq2nfkr/HwMPUBGGvssdYUImOvdZaYBK1ZHgBsjp0tKY5J97I7myULP5xE6hNsvvpfDqfSo2Uc6XZpTAsi0wdaY2UreNJtprnF42mS0cnVVIos5MHJeMZBGAe0ip5IsQ7rkCX/YLGOX+j9uuTIpshEtSf677yDtY3sjCVh1xHO/StGrAlxWQo7o7RG00BhFPC8xG3zRgRRyGaYlhshUSPr4GhRZY+xrz+6uPKtTvUT7icPijKggzKZSrUsMedGTtggLc9Nxu8msTRG547bXHbD0+YFOzGgYQP/DO5asY4GQPgLxDXmG+G6Ozk6EDT+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkagdSVoNZQe+QVjzNqBgngpSpQPAPLuriIBfTiEfB0=;
 b=Yb5PQZr1j5Tw2gFBzyTfh3w47f6Bw1RFl+96tc9d8mv6vqPbFMUsGyU5DQUjamuMLFBurBsjIWku3DIMpSVTn9N/HUnCK7VZWqZpOiPi2LE3pqwYx3tAsyNXUT6X3g9uK0kBiE1tzQhHMXY8s0ImDz4/MvNpEI7Ns6NhozPGuv8UVFYcPosgw585yy0fFC/fjJUE6W8W0EJAoCuVoVzBYMx67HamS5YeAlkZZmwsOYXwRyUOg7Sg0JvEjiZ2JN66eeNc821CLzUOIyV/0mwLEnEJ7zaualYhuB/tr5LIjrA7L8CVVPScTD3SQQ9ykKAwrotizzAYek1N18D7gcJP8g==
Received: from SJ0PR13CA0075.namprd13.prod.outlook.com (2603:10b6:a03:2c4::20)
 by DS7PR12MB8250.namprd12.prod.outlook.com (2603:10b6:8:db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 07:46:52 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::45) by SJ0PR13CA0075.outlook.office365.com
 (2603:10b6:a03:2c4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.6 via Frontend Transport; Mon,
 26 Jan 2026 07:46:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 07:46:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 23:46:37 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 25 Jan 2026 23:46:31 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [PATCH V4 08/22] PCI: tegra194: Free resources during controller deinitialization
Date: Mon, 26 Jan 2026 13:15:05 +0530
Message-ID: <20260126074519.3426742-9-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260126074519.3426742-1-mmaddireddy@nvidia.com>
References: <20260126074519.3426742-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|DS7PR12MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: 934737ae-0985-4300-e901-08de5caf1239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v59S+GapEIRSpxupVcjXP9bTuiQxk+PNlG2qfKXbM/fbr8GlkLPfPn52+SNF?=
 =?us-ascii?Q?yr8mSfb56yRhHSHc5TmBBCt0968daOb+FCLLtIkovQWCd1Rk+eQKHQucYN9w?=
 =?us-ascii?Q?Z6DZcTv6F7av3TSR8A2gKIXIv+aOxHJ9PBKfCjQJMpD2txS0c3UhFVSpcQ+k?=
 =?us-ascii?Q?GLjl+xuqmOGFef8b+hVKknGVygeqmMigvPDdO6oIhE20Fuq6RiReP9RZakit?=
 =?us-ascii?Q?2hz7Zr3e9fb13knrRDEFaF07+aXOY6GtKAanAywUB0nr9nBW+yfvOYUkQPd4?=
 =?us-ascii?Q?LzqBV2bahrxi9bfqic+MePu4EFYqVmg8Crl+b9+OMPF96avCLBXYVTPGcPU7?=
 =?us-ascii?Q?q/r3pLaltsX76F46xbay5YbGYyk6jQSBAKvmdjo7h2JFHNzC/oBdPtMVXGaU?=
 =?us-ascii?Q?WyDnSIG27mu0Ef4nOlmGSwKTq4X/RCq6H+/fFmKpTpw5wIJhxAZDiuUFcn8i?=
 =?us-ascii?Q?JMXt8LuFyVpQ1BkQO3gVYujR1C192dAG2p3wudEbt+/VBQKQac22aPbZFuqF?=
 =?us-ascii?Q?rnzoGokOgU0J5o6b+f0stisXXYep5lxhvF1Y4W40dPo93Flm4huBW5KwGbmn?=
 =?us-ascii?Q?Ts9f4gzzUbsanM2Os0u+m3UxHsaJ9zlTaHx3xVjCYBMs/VzGXjRd3GmdzyRE?=
 =?us-ascii?Q?2zFmgbQNC11kL6cEoXiVGbeyCPKVGF4aw/HBLSXb0EZC7+cF+ZAnw8mVNfZR?=
 =?us-ascii?Q?/w9Xf9B2zbqsMQBErNDxTZxXvSYDd6KeypgadoS0ha0ApnpbkraPmPHoARFO?=
 =?us-ascii?Q?uz9Ko0LKs5Sx2VRwGJFFQ2Q8++b54RaQDtxkYemo1Em2Jh3WMTbbQ87YAcUR?=
 =?us-ascii?Q?VPpRXcg6ytV3mdwxIda/5n1m39vQnGnBiWTzBelt22m2Nb6Sb3/0EuE47e86?=
 =?us-ascii?Q?gBi1sm0/LbQX7u+l2WWJlFI2rBpTaW15XNSBJCwhcicKTCkEfCibMX8YsRyI?=
 =?us-ascii?Q?WPwACrwyYWwbOqygn9Xie3EKpZSuD9hJV/GIXJWOBCUs6q05ubKnuSLB2P+7?=
 =?us-ascii?Q?FGgy4haUU2rmzmIz11z7uKMzP4crBQDJRwH676zYyCryVJjfse0dMeW7+91o?=
 =?us-ascii?Q?qkp8KvagXCfNA50m5Zl+vIagMwn8j2XFAjDfb0F6a+JXafFA3Jy9ocoEeEUC?=
 =?us-ascii?Q?oPraipS6qM2L2xYH3rY4xCP784eqdgyK7bv5B8L6wAmWZ3BdF5M6TgBEXYwi?=
 =?us-ascii?Q?+ejgVPlNhl1tQ/5kPNH5jMLaHUwHfHKqZZWSMbmzudjc/rvbDEPgnj70UFMp?=
 =?us-ascii?Q?K1qwa3hSctdVS1z0utLQYTwroGuwPA7CyoQDN8q4QBmOxihf4WlDllJkW25W?=
 =?us-ascii?Q?j0BmI3Jwbsb4r+O/xfJUzI1AhpeQN/C3mOpTFnUtx+3BnCqfQB1W/P9+HgwD?=
 =?us-ascii?Q?HxyM8Semyv6Y6yhrlCuN5EfWfaoL8+UNWsmA7Ajxgahr/WHXtbTTEuG/LVje?=
 =?us-ascii?Q?jGZpvjinoyjhvi9FVHTKJuEA/hTJNuspwSGigeFbP2P8Jbmwgn6pHPWOYGVd?=
 =?us-ascii?Q?3yi+Gr90vZeUn7J2or72l/DRYWCsgFrcyk+7ZxmA0UmON+4ylYpJK4mZjqDw?=
 =?us-ascii?Q?RHKVlWPYoddtuPFoYtm2CptM4KGbm5b/Dlq/RnGT3DKqlRLl8AfcDiUoOD7h?=
 =?us-ascii?Q?X+k6W62RHJkJGo/ceU1DXCcDkblUOywEo5pNNbFehCoMGMJCdSxZ/LE3e47M?=
 =?us-ascii?Q?jwy5DX4ay7BmfOdp8zhuG1SMWms=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 07:46:52.6511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 934737ae-0985-4300-e901-08de5caf1239
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8250

From: Vidya Sagar <vidyas@nvidia.com>

Call dw_pcie_ep_deinit() during controller deinitialization to free the
resources allocated in common DesignWare driver.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V4:
* None

V3:
* This is a new patch in this series

 drivers/pci/controller/dwc/pcie-tegra194.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index f69bc416b031..40f9e1ab03c1 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1678,12 +1678,16 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
 
 static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
 {
+	struct dw_pcie *pci = &pcie->pci;
+	struct dw_pcie_ep *ep = &pci->ep;
 	u32 val;
 	int ret;
 
 	if (pcie->ep_state == EP_STATE_DISABLED)
 		return;
 
+	pci_epc_deinit_notify(ep->epc);
+
 	ret = readl_poll_timeout(pcie->appl_base + APPL_DEBUG, val,
 		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_QUIET) ||
 		((val & APPL_DEBUG_LTSSM_STATE_MASK) == LTSSM_STATE_DETECT_ACT) ||
-- 
2.34.1

