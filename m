Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792563278;
	b=jZpYqAVuIAA8KSGwlMp+TDhJNu5sQHFHuVNlPenM4xCjagGueHf52cZxgMbgHaSNqNEB
	 xkMghmF+OxUHXldzyIG0y7On63yjsWTzcOQEdqwrEr5njbbfId2/T8CMvXvwhLoIrEBwO
	 1CArIm54sgpbzC8kpZq/bVb6nUGhfqkVXdBxRmr2pkv1uYoczm/MH1Ir0wZZ/j70gwZGg
	 Zmvdhrp8v5EKTRptht1FmnS+iNTdZ7tQPn9h9mE4pgDWgUziu/Ibv0cMZtqGU2Jx1ROmn
	 t+9OU1Jhz4LwDPKjBmCM1epPpEyAcQVSNo3XFrvcf8JBBf/qCQ9JNYlWmrXhvJD8mCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792563278;
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
	bh=FCT33dE8SuAE3hzn6ENzbNOSV1zQ0FaCitijqJdYavI=;
	b=gc1a0EhyFaCztS2GZ5VyCVCx5cjy+bLofRXu/sTU4J//iQMWQZO8z5fxane/zDcOQj+t
	 mUVTkRk+gORgMgS6EGg9z+9/bi2d2vJ7vhetOOz/85yn9DiNhobu0VBGbvZJicN3XK408
	 lCxFBGmhTtBKZ4u5ski7AfbaRrQo0wxryhz1vM/oa96L53j4OwsLdnePdRU4xvg1cpDo4
	 8b8jSf+ZvQzA2KSm1+2eZKAIpgH8FtxldR6qj4ERx8ZGWG7H/+0PJRqZ95I6zVTTysFev
	 vQWn7DhwSMBLZBJ6jUabL0mhqRCbf3JzTyEDThC/CABOaeo1e31Oaz3gSqXI0gJ1eCw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DW2SqwSw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.48
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012048.outbound.protection.outlook.com [40.107.200.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A99B606A319;
	Wed, 21 Oct 2026 06:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A99B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DW2SqwSw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9+AGrDT55kwv+HSm9W1lfubG46hWZAHBYcNUoVXPzdgQ0ngIMbmBt4+YuBK359/TX9r+RHbcIXKd1KQ6GrCM12G7lGDKSsFV6K4EacWLamRYFn12aW/WMB1NSbxP7sH1bOTqWbAIHP/c6afUOg1dn7fQRehznpct+LI/l574X1+KtM3DWg61gi2BGtteCES9DOc57UMXbbnEgL3hMKMOOS3SQzMfJw+N5UwIT1cDkjkc8Wh1WUiOx2NP4rS2bwntUE0lkG+GgrLMSsLukdt95uDMzXKohjtyCZhLyfaV8at6Rmmj+q+I294GCPRVLsu9z+oxQv4mdxYTHk8obrVhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCT33dE8SuAE3hzn6ENzbNOSV1zQ0FaCitijqJdYavI=;
 b=uZMoxHDKm++OXzOWFUZKhrvbGzp11X2I6onHabQUKiqnhaW75eBoJWoqD80jem8BEMQoWFASQKaVraOhN1VnmLCvhnYymQN17nRiO5wZZNB5X/713R/2Nlwlfw5K3ECt5Pwwtgl6AtYpuRRFOQuCxzn4y4ttz72hWXEvCiLhEELrl8qFdUWVEkIxCFMzgSrz3Rql/EWOR4qXaQE31PHRR6lK4aicdAgCQWXCIEUqk9KFaGjgTu6cUd0RSsR1Mfu7V7rgZ35MIFlveAizX0VkVTA9hxacW9CUe9nvj/WdH19moRQCafqWN0cEOnv1zl2o3cpn+Oxy9Z9KY4SocRd/8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCT33dE8SuAE3hzn6ENzbNOSV1zQ0FaCitijqJdYavI=;
 b=DW2SqwSwMUCU58j57kckm3h5i2DArqaf9X95LlMX+czhVToFNPkkOYfLUAueDrM9ry17zNIgSjsgx8are1+5cNbTK0q6sao658ZZWjdjiCXPzqm+Cfg4vWAywXD6d9Q7yZbsJ/Pyk6M2tG5JkaPX9D1glik3yguKLDy7b0rVrPHDvxHMNrOZCftV1AQ+x04NQCdJ1SeL2QineCMpw0KFwXQRLWTOPeoxSGl+F4rJWGSDjAkNLINUhGFnxIU5vZSwhka7xIQB8q5V7eZskt8JCFb2eHQxLnc0Ij8aaP1fahIMqkjVMJqEuQA3oSY67R1XR/h1HwTznHAUYxkb2D/lig==
Received: from SJ0PR03CA0163.namprd03.prod.outlook.com (2603:10b6:a03:338::18)
 by DS2PR12MB9639.namprd12.prod.outlook.com (2603:10b6:8:27a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 06:14:31 +0000
Received: from EA8PEPF00000008.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::90) by SJ0PR03CA0163.outlook.office365.com
 (2603:10b6:a03:338::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 21
 Oct 2026 06:14:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 EA8PEPF00000008.mail.protection.outlook.com (10.167.249.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:14:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 20 Oct
 2026 23:14:09 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 23:14:03 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <robh@kernel.org>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<kishon@kernel.org>, <Frank.Li@kernel.org>, <vidyas@nvidia.com>,
	<cassel@kernel.org>, <den@valinux.co.jp>, <marco.crivellari@suse.com>,
	<andriy.shevchenko@linux.intel.com>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mmaddireddy@nvidia.com>
Subject: [PATCH v2 00/10] PCI: tegra194: Fix EP and Root Port corner cases
Date: Wed, 21 Oct 2026 11:43:39 +0530
Message-ID: <20261021061349.1265704-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: EA8PEPF00000008:EE_|DS2PR12MB9639:EE_
X-MS-Office365-Filtering-Correlation-Id: 74fd5b15-3722-4e80-6f2a-08df2f3a918a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|7416014|376014|261009223027099003|10067099003|56012099006|6133799003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	tuiKSeJsVGwE4P6DxfMaK4nz7jqNrCEvLAEjDCgf8O0mbT5J9U5cIoHLB/ddJcZWinGp0+CuDsFn6Tt6cI1Y0qnTU6aeQWwhEMr5MRMyl0RgVqGfq0xH/fxhJgK/y7Q/GFgDUBOAMx0YCdyrVttv5S2gGRPGMOIieykAcPkj13imaaNTBfGJlGcg36LtVcSSk0+0D59QUSfa/s6aXdovoZ006WTA8wWoDWAXTZnPmUZwS33UuDoRfD7eg86KKEoNFRLBnG5U39EPs/+FJUve0KuBTJHPlKRdKH2s62wFKaLSPb/YZTwHSxklST7azb+fDYGfDXrEPeJjdknoYEtNMXQZmoyNIuRA6153fNjWObEN/+VENFZK4URDpK2TEKjp8qAcBanQ/GLMTcijiU/3KtzyFGlsP58K2eFbKd8FNRuGpBQBE153V+eNbAEc+Xr61dcgAWzh69xlgfy0CwyXZX67Qfyr/eaUGO1a3NJFnOKFWtDFMNw+7vpBUkM235RanOsG8i5C7mREC4Wf1aEGPYPsSUPTClR/43ka/enzQ+mYLemVf3gxBVS43VFR73iVUyhfC+PKp4ccy6/MKdQa0mN2SG8iEud2ZRo/Y5gp2x/2eOyGolE1p09ZES+23l+HXG4+WQ8cRE+Sur/NLDvTpdTEKqE62fE/rAI3y7FMXtZzzx562iVZzWlsN+WQ0NyDYfp1zl/lrnN+CgkELljVcw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(7416014)(376014)(261009223027099003)(10067099003)(56012099006)(6133799003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Xr46gDmNALEe1XN6ZKrcsy49sLoo7Ayv1fVH7iiF6JssdQCO5NjmxyG8TznRZgYuAvJjsuvWnbWO5vvM3S5TaZzIwtQ2lu73TG1gZwVCDfpbAITWQJjm/FdHK0BncdHZdLufIwGIzU+4kjuWJyxaJ4K9c0wqz/VbCV1VenE8OfU2F9ERzX9YOErvn6qH9jvDenRfP5o7IQp3ZfCveQJ9tpYOJ4f/QbOud1FrzxealHHe6VpgYAhXI2uqNbSqsBSmWtkp2rmA4q+TPQeTeOVCdf+mV2vy8KgfOgUj9OIER/yp1fgQ/QCv6g8MJgDBlVhGE9/6ihuT/nrK4OXoq3ip6qkH2KbPsiSDfWKDtsawp4n9Kk7wJd/v2Zge8Rfw2LyseMqTkxbwkVa0PaIuzXP2yoJNxwf2/Akh7MPg1Ga7w695Ydl2LRuxboGtG1UcPkPK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:14:30.5189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74fd5b15-3722-4e80-6f2a-08df2f3a918a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	EA8PEPF00000008.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9639

This series fixes a set of independent Tegra194/Tegra234 PCIe controller
issues found while testing Root Port and Endpoint flows.

The Root Port fixes tighten probe/remove and suspend/resume error handling:
propagate optional GPIO failures, check reset deassertion, avoid skipping
cleanup when no link came up, and balance the optional core monitor clock
on failures.

The Endpoint fixes cover PERST# IRQ suspend handling, PHY/PLL error
unwinds, capability checks before programming optional PCIe extended
capabilities, hiding Tegra234 EP L1.2 advertisement for the documented
hardware limitation, and rejecting invalid MSI interrupt number zero.

The patches are ordered from low-level error handling toward Endpoint
capability checks and MSI validation. MSI-X enablement, MSI-X doorbell
changes and fixed MSI-X table handling are deferred; MSI-X remains
disabled in the Tegra EPC features.

Changes in v2:
- Expand the PERST# suspend-race explanation to describe how an IRQ thread
  can enable the endpoint after the original state check. Explain how
  disable_irq() drains that thread and preserves the existing suspend
  policy, and add a synchronization comment.
- Split the MSI-only zero check out of the former MSI/MSI-X patch, with a
  focused title and commit message. Treat it as defensive validation and
  omit the Fixes tag from that patch.
- Drop all MSI-X changes and the fixed MSI-X table patch (v1 patch 11),
  reducing the series from eleven patches to ten.
- Adapt register names to the preceding DWC register-field cleanup series.

Validation:
- ARM64 compilation of the Tegra driver passed.
- Checkpatch and whitespace checks passed.
- Tegra PCIe EP link up with pci-epf-test driver.
- pci_endpoint_test
  - pci_ep_bar.BAR0.BAR_TEST
  - pci_ep_basic.CONSECUTIVE_BAR_TEST
  - pci_ep_basic.LEGACY_IRQ_TEST
  - pci_ep_basic.MSI_TEST
  - pci_ep_data_transfer.memcpy.READ_TEST
  - pci_ep_data_transfer.memcpy.WRITE_TEST
  - pci_ep_data_transfer.memcpy.COPY_TEST

v1: https://lore.kernel.org/linux-pci/20260923072237.1139013-1-mmaddireddy@nvidia.com/

Manikanta Maddireddy (10):
  PCI: tegra194: Propagate REFCLK select GPIO errors
  PCI: tegra194: Check core reset deassertion
  PCI: tegra194: Fix Endpoint PERST# IRQ suspend race
  PCI: tegra194: Do not skip no-link Root Port remove cleanup
  PCI: tegra194: Check for 16 GT/s capability before programming
  PCI: tegra194: Check for L1SS capability before programming
  PCI: tegra194: Always disable Tegra234 Endpoint L1.2
  PCI: tegra194: Guard Endpoint PLL-off error path
  PCI: tegra194: Balance core monitor clock on failures
  PCI: tegra194: Reject zero MSI interrupt number

 drivers/pci/controller/dwc/pcie-tegra194.c | 221 +++++++++++++--------
 1 file changed, 142 insertions(+), 79 deletions(-)

-- 
2.34.1

