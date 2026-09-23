Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011044.outbound.protection.outlook.com [40.107.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7131D442B06;
	Wed, 23 Sep 2026 07:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148199; cv=fail; b=fJxBHfeO+4AK4dO8fNs7r9bgdOWNap/zt7Pp5Vv32cBPp/h1ozLJUlvUxYmPY9OA2nfSZn29qBTelo0Yv9IkP/8KPMozoixI2HZ6LzhqSfMYxqmwF/kUMEaLDsnhrZk99QJOvnA8DZYUy8gsVwW+qQJiEqi6lhhLLN9x1Giwd+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148199; c=relaxed/simple;
	bh=P/8WZD8OpoJSamNd6RkxxZSiQ85v31uyxs7zfD2vNvc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D4xfmeoeR6klhbbnJvO8L6/t1JKuo/6PLZ3gVE3tz4MTSzI4J9g9xRyiWhBy6AWbCpBgd9zMrPakXhcZlMoWrYLWFQ8ObH2QHid5EtZAmPBo9QpYFKqTpcAni/wZIyOVYxuCRchh2bl/ZRFVK+UEUGmBRCXP+G4j7JyUoch21PI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=atjdaJ7k; arc=fail smtp.client-ip=40.107.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="atjdaJ7k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bYfw65BcA+M34dxEYUrICVCIg6fe7sBUFLWIngOqJYpXZZRMrV+SwRMIfEo1HXgL+tfYNfvJC/BRuBz1wjOd0oCD/xtQN8zCiTUN4OpGV2Gb01zQ1sEOq8b2rffR4ik01MXIp1DAjBhDgVNFDQkgISVIf6pXUdkOOhl9Hw5NFVo+zDAfiNhzTRNCVNxnYK2yynHnReohADigt3qbk0rQ1YS59aFQc6WYKcJzBwHJ0Il2NYiYHuSwuuQ3rH2dj5Md48lZjOta52pwt78ilSEASU4eLhElpBR4NXnDeBZfGPFdO4hXjskQgvFf/Kh2eO1mPRnqCzIDBIhXzaBPIO6LMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XjeUjGqhQy4jLjixZiMCp+wCOrf6doql4xvOPutx6FY=;
 b=wygkgqD6hvcVuAPNWjOgAIYxlCwk+v6eNm4hlIyH/k6p9lrmGFnotcS5Lii/H+x9mRGbFw1ofJPinFW92Vovkekh+rsMJxhMvHXSrL5sXOZ1Q+IbC9XlWHZTkSQKe5sJEXzi2QALOj4cui2aUgKiTfFETPv2mdXbW0kWa9LJoDs4QZttMERxoL8v+Ckp/FF109FzA1ZRESnXLhIHzMCWJerX13nd4ToB9gk4eW46QL0oO9XTFo0JYo8bKNFxNkFkfoDIAkSPU5v/AXa2xxWqriiBIu+Gusm/X9X/TUlx4zIK6J6mSQIG0e7px2cNtQh6kx+w79ZLQLus21hMd8lCWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjeUjGqhQy4jLjixZiMCp+wCOrf6doql4xvOPutx6FY=;
 b=atjdaJ7kC2T0/9OTAgftTOEIBm9+ajhFIdA577Xgi8elcU/cUMZ33AHTJYy/5H+yA5ecWTq5nXcF+4th+XBvQucpptK7D/0WyRePpJH/fhgXzY/+5lIrQitJ+bHS82YLtR5U6cEDTeiekbbAU2Tq46fZswOQp5PlXvdmmLs3QVVyjCHxQfgds5p9Zyrx+mLBRDRZbFElZL6cBzDl531fOVe4lLt+5OialEclIvnHqgztX/aihpK1o3Tbwj+WCCU0dReDOYXnSrBMd93CGbCfvy8uu5yxqFu0IvmYVXfkDIYPeestrEcbmigrfVZOBJXVZ+UzZSMU9h8SBlAnH64ouw==
Received: from SJ0PR03CA0373.namprd03.prod.outlook.com (2603:10b6:a03:3a1::18)
 by CH2PR12MB4149.namprd12.prod.outlook.com (2603:10b6:610:7c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.15; Wed, 23 Sep
 2026 07:23:08 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::a4) by SJ0PR03CA0373.outlook.office365.com
 (2603:10b6:a03:3a1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 07:23:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 07:23:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 00:22:56 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 23 Sep 2026 00:22:51 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof Wilczynski
	<kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: Rob Herring <robh@kernel.org>, Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, Kishon Vijay Abraham I
	<kishon@kernel.org>, Frank Li <Frank.Li@kernel.org>, Vidya Sagar
	<vidyas@nvidia.com>, Niklas Cassel <cassel@kernel.org>, Koichiro Den
	<den@valinux.co.jp>, Marco Crivellari <marco.crivellari@suse.com>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [PATCH 00/11] PCI: tegra194: Fix EP and Root Port corner cases
Date: Wed, 23 Sep 2026 12:52:26 +0530
Message-ID: <20260923072237.1139013-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|CH2PR12MB4149:EE_
X-MS-Office365-Filtering-Correlation-Id: a45aa776-cee9-4c12-f5b0-08df19438449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|7416014|376014|23010399003|56012099006|11063799006|6133799003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	PotvlmX/S/sEMHJOYRw+DSAUG3guZMyZJ1KazNJYHKLksR/qoLM9P2CMLSBexYA/5VVW1WKqoG6UCIKsjaht7BcaHvxg/HkpVjUR/dkJ7Lie2xxgw9Fxci36/6e/CpMvebx+RrGk64HAUOxjWlgmKj3UJPsf03BcYhkZPyDR/FPnH0aK3Qvj7CYYfGly9dnsKdwRpJWLWXhwWdWQAL6x565LXuwhgnCEWxBB/b+z9o5RzEKGahTMWJpE9FOw4eeLdUbWY6g0IeZNAqiEqbeBX8UD/sSbOgTOWAB1lYyr0nh+3aywPpqt9hQkOSNyp07Zqw5X59hWPjXe/o/oG0hyUE3oLTDRihz2Zo8C8TeSpIiUb5rbQDx81bvIxY8w5Qn2eUVmkkg90hCDRcgwZZGwBW7u0DocuLoPk0tZwy+LgSKU70o8SjloNv8Wkueqou51v+4qP+jvLaf6tMs3tZRtlAUoGp21f5LDwmWaKXHc0LQ36REOBOFDiA1fu/nnE1hJ8PlTHSceZ0BARBzzbgHQNjBnvvCwBpIrcBid2riilHZCbPo7OlAghG8ja2DBZ9ySDOWwQchedvAUlBbbAAfJRw0vQar3/apHcJbUYOD32+oq46iC2nAfScRpaWWYl2pz0GI+7I0eHJL3wFAg8C+RPSYTrK3ApfzJ4JIJ5se5PCNOvI2hH51rzcvQg7nKlYSlofn2JzUxQHW6rYLYT+f7MQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(7416014)(376014)(23010399003)(56012099006)(11063799006)(6133799003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ou20JQYf+DphMQQHx76ay9rfUzEB2ztTsMO9z8s04z/ONDxAlaBh6/vArr5QsqR+KkucbxIiXo5RbKG76hjzoD6XBudxP07AwvftwvWNTZjINKuVl9kTDo1BWn7xMd8TmIREdBBrJhxY80LeE6kihC+lzqYePubFrjCv5vJTxopDhLhziVd2XHHoSD2s5BBXlYab2//tW+fGO85JZY+PR1CkgeXjVNBlRiRumq5UZ4F4eI+QU+wjnGOxVlXZWv/J+VVU86rCLhP0WAUq5x6hB3uQVU4ubBWFae8sgzSAJQr3svnjVwPjtwp38BsE6BJaRO2y04reZaSHktjJdClntE8JTmPgB9Q0LPss4tBiiMDqtqZ7LoJhfl5h78vunjj74s0vpdcqqzq+hBuABp6J5zl12Z9+6lCEXlbjMhIN1fc2FSGKvPnBfR5WJQsR5Jq5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 07:23:08.2476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a45aa776-cee9-4c12-f5b0-08df19438449
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4149

This series fixes a set of independent Tegra194/Tegra234 PCIe
controller issues found while testing Root Port and Endpoint flows.

The Root Port fixes tighten probe/remove and suspend/resume error handling:
propagate optional GPIO failures, check reset deassertion, avoid skipping
cleanup when no link came up, and balance the optional core monitor clock
on failures.

The Endpoint fixes cover PERST# IRQ suspend handling, PHY/PLL error
unwinds, capability checks before programming optional PCIe extended
capabilities, hiding Tegra234 EP L1.2 advertisement for the documented
hardware limitation, and MSI/MSI-X handling.  The MSI-X patches also keep
pci_epf_test from relocating controller-owned MSI-X table/PBA storage when
the EPC describes a fixed MSI-X BAR layout.

The patches are ordered from low-level error handling toward endpoint
capability/MSI-X fixes so each change remains reviewable and
self-contained.

Manikanta Maddireddy (11):
  PCI: tegra194: Propagate REFCLK select GPIO errors
  PCI: tegra194: Check core reset deassertion
  PCI: tegra194: Fix Endpoint PERST# IRQ suspend race
  PCI: tegra194: Do not skip no-link Root Port remove cleanup
  PCI: tegra194: Check for 16 GT/s capability before programming
  PCI: tegra194: Check for L1SS capability before programming
  PCI: tegra194: Always disable Tegra234 Endpoint L1.2
  PCI: tegra194: Guard Endpoint PLL-off error path
  PCI: tegra194: Balance core monitor clock on failures
  PCI: tegra194: Fix Endpoint MSI/MSI-X numbering
  PCI: endpoint: test: Do not relocate fixed MSI-X tables

 drivers/pci/controller/dwc/pcie-tegra194.c    | 243 ++++++++++++------
 drivers/pci/endpoint/functions/pci-epf-test.c |  27 +-
 2 files changed, 186 insertions(+), 84 deletions(-)

-- 
2.34.1

