Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792563587;
	b=Z2jq5a+UY4iPR9ja9T1MvoFtzXjZ3tJt8DmXCavG8IdJSkxqBvmedVzt0XSSiHcxK3PX
	 uB7UX3wDmI8KfJfZpv+3zvVbRbgCSZ1aq2/xv139lmdmGzglYGQp7mcbkg335dQ9bd/+Q
	 A+sSufjp3e1h2QGTQ+ru2Nl9Z+NH8kmcF+w1n4/H1P8I7FJ6VutpMuDoDmCvxm+U5JJMb
	 NwSvrUJgbMaAKSQhGsTGObwszgSC68bW9I3GUDO7yDyBqauhmneVKq2K8XQ35Czk1hZnF
	 r0pYtAV2AWIZtjCvNPdn9QspF1p0/Gu0KOIC1O14SjR8HvRUBZrKFQfj61NZY5cjzjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792563587;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 X-NVConfidentiality:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=NE3XMI+DarU7TdMJUz0B1KKeEuzd8T/kIzkhxG46ECE=;
	b=UfdJTr2NMg+AUzN+OkHj7vaorMYXwQF1o99mXf4yNoIdOm1SxSTnG/m6fzTJAdZUiwHe
	 CbpfCpHHJ4VSHctlwwM+bdgnhRhWBAhqGGx1BDFYmYVC6u82deyGVKndKADWMAXqOiccg
	 lC0R+PBEcspwi+p1l9G/sOiqzZiGqFFlwc7NUp9HpkfxOmlonK+KzXs56C0B0vRQwrXVu
	 mvYnCThEebJKnQRWcDBtw08tPuwI1VMBb3zV4jZKEEKljF7d7HuyG3iU2Q5ljoKXOzSpK
	 FCVoZNrIDXBPHATXkZCy9+0Z0Pe1HeNAUUK9XaGBtl6qm1vGeqnAEiH0tPxE4I8tBWA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LBwCbmiX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.29
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013029.outbound.protection.outlook.com [40.107.201.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E3D606A31B;
	Wed, 21 Oct 2026 06:19:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80E3D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LBwCbmiX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXfHB89TgrIIzpeDssICPvORRq1OHxRbJ321hnbotTUdS+kRVt0vTpyreeD/qSwYksnS/4FszmTMyJspk/SNDnaUyW62PpxrT6Y6/fB/t6Q6KA5GZ2iIsUdzfEKPQmThT+bDs3MQan74c2Q/BOxwd5Eyml7U4dCtO5IC6msyeZ37JjyfUcZvntbARyBuyiwFF6FyZjoBkOlPEP6JqxLZehMV55pmRNoAayS5JzGC1Zuqedj3XX8n9Ai65Fj+HmTDhcK+/lIrrJJlsxvwhhi9aucY85Q4oDEZkfryuPiDJhih9fVBFCSNnIVLhtfcD8c+RcXblfqyZ4TIqNa6seJ11g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NE3XMI+DarU7TdMJUz0B1KKeEuzd8T/kIzkhxG46ECE=;
 b=pwi9b4CNdvLGj5ng8ksox2c14mlQPmAB2lyEzHREk7odnswknJPPE6ieYQVCm29iZs6/6+lEOGlmlh2apcvZtkJ93yuireyjB3kwOQhMCEBRXY6Qb7mufaWcepiEE4td5uyJ8iNNsRgvF8oyRea1FfNY1h3dlOaqHVk6FLS3O7+P8DAGBie31T5hdBIEac3tCz+RGSBCItlbbLO0xPyhycrcVk1BHjz2ji3aLIhaRomD8ZGREuHfxirFEc6bb0N8UCr8069ZZ//UwDEnT3w81x/NwHr4+LFI3fH1fEXYJVLI5xOhCcDlMpJB27LI4Su3jVgxVIElaVFIKkxbT+aeOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NE3XMI+DarU7TdMJUz0B1KKeEuzd8T/kIzkhxG46ECE=;
 b=LBwCbmiXbb7OGQjp7Bgsth9FXbMZ8FVtW4rvGDSkurnlW+SoX5NSKokzC4zErFQ8He5cxdiOPT6A0HMgf3zDO/iUYSLCMpBGWNkyYmxYhk8cRNpklDxyWjfQXawxLQk9j8h4BpClE5THo/MLs3Uxy/+9dpZ2gtVeovlNxBL/SyBx0XHkQsShwngkhJ+P8/Id48aLtEU+4vDmmujUMnjkrczlFlymHOwyKdBFhJFFwigF9SK/FxtXEcBDF0LnVV39iaPPd2D1uV0zF6Kc59CiQNbnNBkgWRh22LX93o1sNlMOgXf3ZcD0pN11LkWYBP5SNK/IJO+j+lRc1EUs5LWn3Q==
Received: from BN0PR03CA0014.namprd03.prod.outlook.com (2603:10b6:408:e6::19)
 by LV2PR12MB539562.namprd12.prod.outlook.com (2603:10b6:408:417::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:19:43 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:e6:cafe::95) by BN0PR03CA0014.outlook.office365.com
 (2603:10b6:408:e6::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 06:19:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:19:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 20 Oct
 2026 23:19:20 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 23:19:16 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <jingoohan1@gmail.com>, <mani@kernel.org>, <lpieralisi@kernel.org>,
	<kwilczynski@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <robh@kernel.org>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<vidyas@nvidia.com>, <cassel@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <mmaddireddy@nvidia.com>
Subject: [PATCH v2 0/3] PCI: dwc: Avoid full EP cleanup on PERST#
Date: Wed, 21 Oct 2026 11:49:00 +0530
Message-ID: <20261021061903.1269605-1-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|LV2PR12MB539562:EE_
X-MS-Office365-Filtering-Correlation-Id: a43a5afd-571c-4f36-5bac-08df2f3b4bb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|23010399003|36860700016|56012099006|5023799004|11063799006|261009223027099003|10067099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	ClyDbfhnJ0JXjGzgTHbzCyV+2Hc/62EZeCaJpGZugMJpQlj4QRVx5jyJn04dnOTJiXyGoPW2gtoqvP+p6tVrWa2td88R4r46S4PTMgzXXPqGvrAWj5Fjfg55BRPgGZfFTzAK7Wx41eqSbzWF3LDVDd5hYzZTDMiwLt20HkYvzzHDzV4WFgmezJosehRWW6SZPyGHgbvLyu0qVRmtSMsIBYSH5IpVvQ3/Jd161/Vl4RxUmXWhLOTqA7qK3Jze3XZZnAFChDW6oLVE4qqj37FjrOrEurOJDxk8Vd/8miSpV5Y/aOCqBvnHW6ASz2KkpOWChFAJ8f6v4zxkzDLFYxOSX6Js5uzMVNiJ4JZJBPEN1uxzfFmzvoRbu2sFbGb0HZlNxRWidEWUMUZ9vPIaP21vxcbsCj5f5+sO7t4so4OxPwUPJsrJaRNgIxeQfX7mwTCp25/BhVKMlq/Efj7+FgyXNrWjBgZEtQBpjtfBG55k8Rk8hnUnaOMEGoeX1GqP+cgfF1LExzQ3BsNWlbIbU5BgFLaooa0WdgbdIUkK9FU2fWc3OL+0pp0K8gZdl1bCLv90Wm0OjIgXtMavd3rTNd8C2bREnnWJIPCtBLJTJgjoOx20PfPsFiD1cg5tW4Cg4V8cEUJvTzq2g13QpRGME1DMq/BlC9mXfi9rC/G0Ivn8UfIDJnAvbZg3lbcrbyuZtzmbCpreTsmj997YHw2qKuJ5cA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(23010399003)(36860700016)(56012099006)(5023799004)(11063799006)(261009223027099003)(10067099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8rimpvNVMhWeVcDGndsIYOh8eMuS/bfGOFtDxxTF3fs+rkh/2NTWDZlDwp7/6VXpozW5+u0386wFAZiunCMLi5YRMtwbFOxS/GKoXM0DYoE+RV4aGv8ZJG1Ja4lc/FGbiT9OqoFnRr1/3JZO0mzMOc91N4OFeW08ez40hx8JD0GLs7q3clXSAPNnw3KhsDOnZ8dDSw9K8EyLYdMq+BPQjgUybZs6SNY8ORHIAU5lDWyCkhMW6Unsf/OrZKPrPPBPYR4/AuWi2o8AFjhZOGJaG5bCmmPFhKCxrMjW+Ioxnlhh5R6RZm5XO4MpwxmzheV2bhPbuLsr/zabklKGPxdqzwCn+JVdYYkVvEGWg5knpFdh7s2feV7U21wDslsCvRYYhs3fdvgDtOAlaRzXvpQ2gd0ih8TkF54rTC3VXM/tTJ2YHMMYZO6leGm6QG4I3moG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:19:42.8116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a43a5afd-571c-4f36-5bac-08df2f3b4bb9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB539562

This series avoids repeating full DWC Endpoint software resource cleanup
and initialization on every PERST# cycle while still restoring reset-lost
hardware state on the following PERST# deassertion.

The current Tegra194/234 Endpoint flow runs the full DWC EP cleanup/init
sequence for each PERST# cycle. The allocation bitmaps, outbound-address
array and per-function descriptors already have allocation guards and can
be reused. Repeated full cleanup/init also removes and recreates debugfs
entries and unregisters and reprobes eDMA where present; eDMA detection
allocates managed linked-list memory retained until device detach.

Patch 1 folds initial setup and reset recovery into the existing
dw_pcie_ep_init_registers() API. It tracks successful resource setup and
uses a private helper to restore reset-lost registers on subsequent calls.
After hardware resets the iATU, cached outbound mapping state is reset so
stale bookkeeping does not hide available windows. This does not disable
or unmap live hardware windows.

Patch 2 removes the full DWC EP cleanup from Tegra PERST# deassertion,
allowing the existing initialization API to retain software resources and
restore registers. Patch 3 notifies EPFs of link down before powering off
the controller on PERST# assertion, allowing their callbacks to quiesce
work. It calls pci_epc_linkdown() directly to avoid the DWC linkdown
helper's DBI register reinitialization after REFCLK may have disappeared.
EPF callbacks can still access MMIO; the notification is not a guarantee
of register-free execution.

Hardware-dependent EPF deinitialization remains in the PERST# deassert
path where REFCLK is available and core reset has been deasserted.

This series is prepared on top of the v2 Tegra Endpoint/Root Port
corner-case fixes and the preceding DWC register-field cleanup series.

Changes in v2:
- Rename the outbound helper to dw_pcie_ep_reset_outbound_state() and
  clarify that it invalidates software state after hardware reset rather
  than disabling live iATU mappings.
- Fold init/reinit selection into dw_pcie_ep_init_registers(). Remove the
  separate init-or-reinit API and keep register restoration private.
- Document the reset and quiescence prerequisites and retain full
  initialization after dw_pcie_ep_cleanup() clears the resource-state flag.
- Clarify which resources are retained and avoid implying that the
  existing guarded allocations were repeated on every reset.
- Keep Tegra's existing initialization call; only remove per-reset cleanup.
- Narrow the linkdown notification's safety claim and remove unrelated
  pointer cleanup and teardown discussion from patch 3.
- Reword the resource-lifetime explanations in patches 1 and 2.

Validation:
- ARM64 compilation of the DWC EP, host, core and Tegra objects passed.
- Per-patch checkpatch and whitespace checks passed.
- Verified Endpoint reset sequence multiple times.
- Verified ./pci_endpoint_test tests after Endpoint reset sequence.

v1: https://lore.kernel.org/linux-pci/20260923072554.1141864-1-mmaddireddy@nvidia.com/

Manikanta Maddireddy (3):
  PCI: dwc: Reuse Endpoint resources after fundamental reset
  PCI: tegra194: Avoid full Endpoint reinit on PERST#
  PCI: tegra194: Notify Endpoint functions on PERST# assert

 .../pci/controller/dwc/pcie-designware-ep.c   | 149 +++++++++++++-----
 drivers/pci/controller/dwc/pcie-designware.h  |   1 +
 drivers/pci/controller/dwc/pcie-tegra194.c    |   4 +-
 3 files changed, 111 insertions(+), 43 deletions(-)

-- 
2.34.1

