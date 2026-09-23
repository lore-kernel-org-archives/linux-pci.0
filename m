Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012012.outbound.protection.outlook.com [52.101.48.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E51446C0B;
	Wed, 23 Sep 2026 07:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148415; cv=fail; b=sO7ZlqZp3IzRHB28ZOeCI/PiH2SJufqxAC+GxhujBP0VOPccmquLV2apDLMMQvISuaRP+TlNR87ai8Xoelbr3JkJBcJu4i7ZhvgSpQqfhRWifG+AXxMm5kob17JsaNbHdaKcMvkiFnh9o8V4QxzPpWdJKT2WhhW3lLPTJtWzl3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148415; c=relaxed/simple;
	bh=iYq3m2kL/lWotvDYAJTG6MjaXQ2ZCApoYaCDHYCyMu0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=efumerGG9Piuaj8FIyc85iakFAWS4Hh3tJhOs2katMCy0tp9fgJb0eq0+pLHgctt9kEINl1Jix7V5mJQ734qkkLwMyB4uUVb7vYtSMRcgT35S9pCaJuAGh78/9QeCTwSs4znNU/K7bwWqqTT4WJcMa+pXz1RDCM9pE+cginK/Uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bel7IHZB; arc=fail smtp.client-ip=52.101.48.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bel7IHZB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nvVSOPmkRXuibnTUs0Jtq8ccpKtbcbkBPuLhXvixE90e+BWnAFwWrhgnPGbhKTTV0ZrDlYSJeLDuS+os0u7POxXWKSsXwwfkliSO5HK6EIfg9TCi8qRm/l1MW27ze/75VTvNgy9xm3qAkj1gfTibDYMxG2h+ykHhhuDkNhENyCvyiVx6/yHHMKc8ji68T8OcD1LtjqOsKyOVmQWMxbzJOGblDuQOOqLzMTuafHm8lD4y2XWrkb+LptlXbjI4GupqVA2OeE1mdpjeykt0S4APvr5LYo7nBe8frYNI7kRvAAuDcUrk2L5NGH1Rbpw9jTnIctpEnb+a3n4MHmiR7V0P4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqwEQfVdFLdeImpIQ4wnE+Q+mJBOk9sv16vojYbNbU0=;
 b=zFGXBEVp9DLLmJW5hgTn1Lin3US4iraMDlD1FUjzSAL/v/CCKVjhWYhPF1Dax+030LBX2s+QN1o0ctV7EQ4dURl52mGkh1o3NqX2h9ivuaIK6b8rcHGhVMLF9dyuiXHCtumTUk/0vwVA+8Jn6O95RnG6A5vLmeHg6BimtlKNApIlsDMJrcmst+O411jh2mcZorS1DBbC8K2a4j1CyNBet0YPXqTp6O0LVeV+N+luri8nNZ7uhuZFNGqcTuHdaoOdEV4zc4WkI7vYLUX35VogkE4Y17lsiI9r6RVzYQfrbS+j//i+5b3KdF5CQpqY5efakHpltJdkLm6SF1aAbEcdNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqwEQfVdFLdeImpIQ4wnE+Q+mJBOk9sv16vojYbNbU0=;
 b=Bel7IHZBqezO0zFnnI9XldKDrL7EnVnBZ7dyUnFk7NUTe1ZSIm9F/wIRC6r/gubo9fm2MXmdkXcBK4bnOh/ajswbMAv+LxO2yFiMsdhAgHxCzoGdCsAj/r2QXS6i/PMsT8R0UjfMwO8RwDIDVqUd6NsEfIelftwVvIhlocuFFVX0viNzLoaMzY7ZpM2ael+kUfPdmEYXYdD3/UHjsqfUwedaICvfwjAx7vHgVI89xtmdY0+htny5n1SBQBlHIYDiGF+llYiFuuxG+4aMbkLWXyGFO9I2fRpL2tzwnM8XTASN6CX2TCa0Iaq8o0QIBbNs5IDHBypK77pNCFs6wK8YFQ==
Received: from MW4PR04CA0177.namprd04.prod.outlook.com (2603:10b6:303:85::32)
 by CH3PR12MB9281.namprd12.prod.outlook.com (2603:10b6:610:1c8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 07:26:43 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:303:85:cafe::5c) by MW4PR04CA0177.outlook.office365.com
 (2603:10b6:303:85::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 07:26:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 07:26:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 00:26:20 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 23 Sep 2026 00:26:16 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam
	<mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, "Krzysztof
 Wilczynski" <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
CC: Rob Herring <robh@kernel.org>, Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>,
	Niklas Cassel <cassel@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 0/3] PCI: dwc: Avoid full EP cleanup on PERST#
Date: Wed, 23 Sep 2026 12:55:51 +0530
Message-ID: <20260923072554.1141864-1-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|CH3PR12MB9281:EE_
X-MS-Office365-Filtering-Correlation-Id: cd1871b6-97a3-4000-e722-08df1944041b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|7416014|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	N77neBdTeJXEduPDhGIdvOvdQJisakeIuCv9aAFManzKe2y1wsou/Yq9tVq5G/ow85PTcu2HlPsWIrrZBcvKh21TOkrsgEu/KxYVo5mJMcnHqbUTFZvzix39UvMWkuZXHjo0xRHuFiP6zYFblvGmzf6KV9Ot3L+rsmAnDEJtfhfGfcKla4b1ZEonO21MkYSXwdmB1F5fV9ZNLKSbUtBY6tBkFM1eNC6aJP0MkRrR+HlUCTT7e4sAGMLeehSvrvLN990J7t0QDF/nph6L//bwTZZiaw9bWauickJQYmus5J2TfBOmEeqjJErHZ0Weo54HAtOk26zWUag01OOkZlwUoVqwt/voM7koDMC75QP9fRhQpwm9gsTLju1D4FXHUO9zUWcX3V35FqsKvvtP6XGglVlP9duVSknpo19HuslZyjOMqdqq5euBBXtqh+xHDxvpSkUwEZjyhdM8DKjv+SzcHTLaL//y0/i9gRpcLe4qaN/uGfjt8NakYYzay6hzJVWhb0ACYV8Ca5LiXbxGueu8HIZeMplSZqEuKfYsqRYAwTiFKhvOF7AbpUFG1mlD9Rb6jTBCmyqChHWoHdLtRrwrRj1sfVXmwlEsoj8Z+aVQJLvWz8QXx6iEOKJ+zPDzGiZsSTUSbpPjjN7LodHxj2EdVyX5BkXouNgDKWK2mqEOdy91ySULUPNd2z7zr4H3rg3FAEyao6kuq2F7BerW9PAo+g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(7416014)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	T+OWFra0z6Zz+Ocy85jyAC7hKgdcgDl2ZYI8tolL+6t5OsvFm8yZCw0UXV/zUeJU+c7qmTxre45LkVudR8FDwtSqMrfxC+VEXeu4n305uYJxSV5I3gvauEAH5LoiW5Y6hHs13tZqIQDAGsIMlvPISciDiy/i277SXu7X2FMnlxNVvyQk3Xk965FlJsFG/kshXqO2nqtBrVhRER66VRyA4ejEoAgf7yBFhQkrPV4rs2JFzxFS5E5D5NOhZ6ka9uywT5ZzcbQBh7RkNBJt9B+UYnHvv8Y7UpLjw6w8mrYLoRWnDyNvKvd0Y+VUGKvMJyiEmrDpULDsQE6ZbYS+Ih8S0+HXhAGJzpueOp4kZLnruS+qvTeMCr6qxaPsDAB7DRCs/qlXBU7xXtRxFE11TXCUTTo16ylxjPNGEomvRRzSElI1Ttt/lmvABYFK9RU1Y4XV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 07:26:42.6925
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd1871b6-97a3-4000-e722-08df1944041b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9281

This series avoids tearing down and reallocating DWC Endpoint software
resources on every PERST# assertion while still restoring reset-lost
hardware state on the following PERST# deassert.

The current Tegra194/234 Endpoint flow can run the full DWC EP
cleanup/init sequence for each PERST# cycle.  That is heavier than needed
for a link reset and can repeatedly free/reallocate devres/dmam-backed
resources that are intended to live for the driver lifetime.  It also risks
stale software users running after the host removes the link.

Patch 1 adds a common DWC EP reinit helper that preserves software
resources and reinitializes only reset-lost registers when resources
already exist.  Patch 2 switches Tegra194/234 Endpoint PERST# deassert to
that helper.  Patch 3 sends the software-only endpoint linkdown
notification on PERST# assert so EPF drivers stop outstanding work without
touching hardware after REFCLK may be gone.

The series keeps hardware-register cleanup in the PERST# deassert path
where REFCLK and resets are available.

Manikanta Maddireddy (3):
  PCI: dwc: Add Endpoint reinit helper
  PCI: tegra194: Avoid full Endpoint reinit on PERST#
  PCI: tegra194: Notify Endpoint functions on PERST# assert

 .../pci/controller/dwc/pcie-designware-ep.c   | 152 +++++++++++++-----
 drivers/pci/controller/dwc/pcie-designware.h  |  13 ++
 drivers/pci/controller/dwc/pcie-tegra194.c    |   8 +-
 3 files changed, 129 insertions(+), 44 deletions(-)

-- 
2.34.1

