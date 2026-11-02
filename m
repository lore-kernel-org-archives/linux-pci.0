Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793618879;
	b=THhH0uZl9Z6N01lqtFDEYl8GVyB0BUg1wr4epq61pv8Hr1eIU1KqWH5GPs7ZePojNU+v
	 5og5FB6vQtqr6c/Ri2knqFZti1QGtT5RISFG9n+4RwBoPMpbpgWWSTLo3H5JAJCdHMixN
	 YUbSbJ4N61gbU0qelTeMekMjrYoSJxb9g0/N4kKjHwKGvK1yohtBf/kY8z6+9ZEm/x9Xf
	 lNltToeA2SlP2I6hJmexUOpym7emTOij9ZeqdWLPCTnU/Uq2GPkYZd8Mi27pYD5OgAAUs
	 6jOd3Ph9yJDRikZE6twQ7ms1dOls043r1i6QA4GZainOwlPHo7CZ/q4oDFRAKrPTr6g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618879;
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
	bh=FkEcUolvK+75CjdpgJXBQbhiH00pjZSWNltqlTvFAhs=;
	b=rQcg9Vakr6rPs+KeknxzdrAvq+FCt0LDG3zK8OTInOkhlkhkrPX3tN4eb/RyMoYoyGkx
	 BS/CkwRuKZ0/8X5sCRhH7YKnqI+U0/DZAS7XVHGIMZJp0ItwUjesP2RYk41HXrJdVdF99
	 ECho9KE191KKWlCWiRDx8ImgypuK8vHLks7bog3GH3OdnTxKBoTLjk9U9+jEQxYG5ngBI
	 +jMf8uAVCNr19rhyhfJTGlYMIh4SKLWb1lPlSkrlsJYzUwLBckg54aWQtge7pLg7uic4+
	 aeB+ZnacDNUdGoUkSMHesNi9pGIJmCiFeajI4h3Gr6RtVV6xLCVbqKkaNtRjgRBiN0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DmKKlrih;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.1
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011001.outbound.protection.outlook.com [40.107.208.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D230606A327;
	Mon,  2 Nov 2026 11:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D230606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DmKKlrih
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dUono7Io4pcVEwMihpqE9tVnQdhPHDnzG5Pj7F7gPqBU6AXtGZobuHsx2xRNso9fjuaoix9k7THUj2shckTUq2enlf04EdDLIMci/d9oL+2XYgdvlGONh32eQvoKa7yAauVaaEP3O1woN9A5W/ip2bsTBokvRkx+fp285+adRzvcPmiKKVtqbVxZP6VbrZ+xuNJBIMByNLSrOufptHf62S+tzHFgtcsy5sbnUBrlgupAuPBm60khnv2oaaAujTbzFt1erYoPTKr+jJ8TEp4SW+lsMH6Xzj59VkU37vU6qGVvN3Ehv59lJXrKIYSpxf0n9SvjJgqJbDxJH4G7+5S6Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkEcUolvK+75CjdpgJXBQbhiH00pjZSWNltqlTvFAhs=;
 b=sOJ8k1t/zpJpa3FXlI+MPQ+/AvH52Hzfk92vQNXMt/lHJl30pPVU2vAC3BsKK8n1gJuncFHX2jKueNeEXUOKFckjuWc5rVgLImDODVPTjD1raH0hcx13Poulyto0ub9dHCuGKWo40lkHlcxqIMxwxTtyZ0/4clf5JnJiL8klJVClzbYQaJkzR/c7lplp936BRtKwKksO2G2AJFczsgLdTSnDb+uZdULzBFMsh/vQENtBTEU5csWgYKlyPnzD3Si4eAUehnWhyat+cMRcu9MBbU8njssPitrZo5n2KKxoELHQNG2eVy4Qx0zJuurI2yZobYZ865++BX9hh70qeLFA5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkEcUolvK+75CjdpgJXBQbhiH00pjZSWNltqlTvFAhs=;
 b=DmKKlrihh+fs4Xe7iKdRyN6m7d+1gsapykRdjKHTwmoZ6vVu31D34RSjB/9x2TB8xDsA3vwn4LkIKhBySd23ytGSMoMa++xzaLH7JUAKG1h23YVnzQ2/hmMPMV2yKlHxQ7pl5/OQzn0Os4EWnDyOE9FzXPiLmYYk5mBXOYS3mRmZooOzBLtIj9lPFq7Ldb4LprDEc4tzY7YZkwNpjvb7bchEBcDrB1aZQVvqqakDDl8NQ9sRGygSnINPem0O4rJDiueEZVbcgKyMq9kyoJA3zdl9IKRtoj/ulGK7JkH46bk4phZu0tfUamyEG3Cp7nOFzEQsppflufkoQSVZbhZnzg==
Received: from BN0PR04CA0092.namprd04.prod.outlook.com (2603:10b6:408:ec::7)
 by IA0PR12MB8982.namprd12.prod.outlook.com (2603:10b6:208:481::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 11:27:53 +0000
Received: from BN2PEPF0000A894.namprd04.prod.outlook.com
 (2603:10b6:408:ec:cafe::53) by BN0PR04CA0092.outlook.office365.com
 (2603:10b6:408:ec::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 11:27:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF0000A894.mail.protection.outlook.com (10.167.248.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 11:27:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 03:27:36 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 03:27:31 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <robh@kernel.org>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<kishon@kernel.org>, <Frank.Li@kernel.org>, <vidyas@nvidia.com>,
	<cassel@kernel.org>, <den@valinux.co.jp>, <marco.crivellari@suse.com>,
	<andriy.shevchenko@linux.intel.com>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mmaddireddy@nvidia.com>
Subject: [PATCH v3 00/10] PCI: tegra194: Fix EP and Root Port corner cases
Date: Mon, 2 Nov 2026 16:57:09 +0530
Message-ID: <20261102112719.4022633-1-mmaddireddy@nvidia.com>
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
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A894:EE_|IA0PR12MB8982:EE_
X-MS-Office365-Filtering-Correlation-Id: 6756cae0-64dc-4b48-7fab-08df38d455ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|36860700016|82310400026|261021133027099003|11063799006|56012099006|261009223027099003|261028144727099003|261021123027099003|261021121427099003|261021130227099003|261021135927099003|261026135527099003|261026121527099003|261022115727099003|261022075727099003|261022105027099003|261026130827099003|261022113327099003|261026140227099003|10067099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	MhcBbmfkTM8LVsbOA42qz3COpAJDpN3ORSWTOjVrGTCgVbDf1Jf5jBJ+AiJbb/LMo/9+gz9WSbyp/8sQqJi1bZ3jByLBG1zgNdrk6LHUnMGC23qTlZ8LcBjDJAs9tqQ+ZU/D+dQzrS3SQ8x/3H8TADoW3V6V3TyA0pMus4OVbzZeocCRNGRKJoBQQQG1v1AnmpKRT1A29Whq9pFx7BsKEEK5/M6pkI1wo1kxzY6Dhyb+S8WJvvlC1uwMSLzSdFz0/S2gKKT5zlDXuRjzc1nRRbQjEU/bYDVBCAcM7SmNCxI8cUJxf8qW6Wqv38Yu6kdl6F5st+T8ivgPVHrwpYR8l4sDl4PWo0WnnAQA18QFi3pBZnltScczpUYGbQ9lLFJKaSbuOXlhUtWbcN/YPna4S7+aXJNJemYwa1BNWP406mc9vVTVICeh+xkmgBoUwgFLyv25ZIFPS5lVVlbOVw7rU3Fd4M2Un4aniPKAIWJBGE+KLYftUnQCRIkIlp6K9/d47yvk3JAszT/kBIZIErd4PQSjQTSsqQWMDOTxI4NTcKrGvIcb8PbhP9Cx6Pm1IpY+srXLpSbyJbyAHio1OS0f/sfsHaFPdhelEDuroCss06CnCLHStYOcxwat0elSKo/jlO0nWa8s4r6e3eedyDXHaAcmR1ofLB1TqqPIfJ8iAYJQef20xebsyawSNieGMDhGQSj+jbKU2fD8D8tb0/Ff1A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(261021133027099003)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261021123027099003)(261021121427099003)(261021130227099003)(261021135927099003)(261026135527099003)(261026121527099003)(261022115727099003)(261022075727099003)(261022105027099003)(261026130827099003)(261022113327099003)(261026140227099003)(10067099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	52tfzF/xsmCrv2N8VrXBcHMyKmRteJDKWoeeJGxuc6M4Lh/LxwpPyLHfKFESPq2IcPbQ0UJ72yqQZgreaUOgdGxdyxAbAJAMCJzsTxQxVDsVcPZ7yPBM2QDTFLwSNKG2FAynhTGHaAvzKkV2RYAMSvcM1li8wGtX/sOGCvhgDDJkKJrGxCjSKoY4kW4MNF12KqJOO/Ai2ALjAIhsCv535AuSk9JwBpPys+JOM0XC2+137+hsooQDORrmU8wCh+6kSUXB0gYrERq+nr/LJ7U6JWVRoxcKCT3bUhC2xYXPndXFUJruKiWDMdM4/hHmx4oGl6KDQiMziHofyGoJK0WvHAESBHi6EPer+fjmIhkkK0wsD2M65nsoVfOq3uaiCmZwbnSjISCyVFxrAYMchaLfXEhnAD/Z9eQ50LFWs5oOnHGe86exAy3eyprYK5foqN1U
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 11:27:53.0739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6756cae0-64dc-4b48-7fab-08df38d455ba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A894.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8982

This series fixes a set of independent Tegra194/Tegra234 PCIe controller
issues found while testing Root Port and Endpoint flows.

The Root Port fixes tighten probe/remove and suspend/resume error handling:
propagate optional GPIO failures, check reset deassertion, avoid skipping
cleanup when no link came up, and enable the optional core monitor clock
only after link setup and final core clock rate selection.

The Endpoint fixes cover PERST# IRQ suspend handling, PHY/PLL error
unwinds, capability checks before programming optional PCIe extended
capabilities, hiding Tegra234 EP L1.2 advertisement for the documented
hardware limitation, and rejecting invalid MSI interrupt number zero.

The patches are ordered from low-level error handling toward Endpoint
capability checks and MSI validation. MSI-X enablement, MSI-X doorbell
changes and fixed MSI-X table handling are deferred; MSI-X remains
disabled in the Tegra EPC features.

Changes in v3:
- Rebase onto the current PCI main-based stack after the DWC register-field
  cleanup series. Patches 1-8 and 10 have no code changes from v2.
- Rework patch 9 and rename it to "Enable core monitor clock after link
  setup". Set the core clock rate to 500 MHz before enabling it, program
  the controller, train the link, select the negotiated-speed core rate,
  and then enable the monitor clock.
- Propagate initial and negotiated core rate-setting errors and monitor
  enable failures. Keep monitor operations out of the host initialization
  callback and DLF retry path, and release the monitor during remove,
  suspend and shutdown without a separate reference-state flag.
- Expand patch 9's explanation of the Boot and Power Management Processor
  (BPMP) firmware voltage requirement and false frequency-monitor faults
  during rate transitions.
- Retain Frank Li's Reviewed-by tags from v2 on unchanged patches 1-8
  and 10.

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

Validation reported with v2:
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

v2: https://lore.kernel.org/linux-pci/20261021061349.1265704-1-mmaddireddy@nvidia.com/

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
  PCI: tegra194: Enable core monitor clock after link setup
  PCI: tegra194: Reject zero MSI interrupt number

 drivers/pci/controller/dwc/pcie-tegra194.c | 239 +++++++++++++--------
 1 file changed, 151 insertions(+), 88 deletions(-)


base-commit: d447e8cfe376cc0cc4db8266d01356d0b3ebb695
-- 
2.34.1

