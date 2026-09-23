Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011027.outbound.protection.outlook.com [40.107.208.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B30443AB3;
	Wed, 23 Sep 2026 07:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148418; cv=fail; b=FuRenmRohMnUlMrXYI/ajOBPmHF2WA+96Lw1iyo5NwDsTtp8ioWO3vUTi1yRByp/hia6l5VlIvlhTy8lzhEQoucpaC1SGvebtCFIGPlJpgvk7KC9S4x8QQCPgF+dY9UFKTVbKAaL50FqUcnGpIpIhewWNgiE7Owsh1q3AQ8N3dY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148418; c=relaxed/simple;
	bh=Cbm5ECewrEho6DqMFVSQ7FfMAdAlmi+Wf8Z/JBfsgN0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FV9VEU/Yx4xeHfCq5dmmj1pDMGDMcHaIgR9TT6zvOx+SbO5Emsk0I6WjImZRYZnwI0Dq8KsIlWH4Y12R9/PCV2/u+nIH9P0XTvyP38VwKVk+rJu1Za8LY34+Qy4eOJ4PcI2S/JTe7e4ihEuBLhN9NT4b/9YLSqm6VyYWPAN7p7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=toy3J3f9; arc=fail smtp.client-ip=40.107.208.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="toy3J3f9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OI9zNcncx6qmtSevQRrSESIZyVQWWYhhB+9MerREUvMoXnyvVIwIQfhcoJjnmjrrYqOACh+ntv9aJcltmq22y3V2Q9h+Sea6JRYcgVfq482p6wkZgm9sV7UX7mftLP7sfz6mTKlCN4aS4ZPECYIVlmN0FyHghI2fEMuBGTGRGoRj6eMkv29rtQsmAmK8kyts2aZDBOGc0JUtQC410OXBAXb1jBY8MhswClSDwQ3gk2oU3qawzsYcMWl08fECnPniwmZPfHHB/4MVeZgmvj8dkNXpF2BZqWD6wodn1hmkl2eRr6d7yxioJShloFrBSRVwf3Awmxerc/NpT8n2C2mzsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1iz7+/G6wNuRGf8jutMPIw3XyV6zeJ8o5w40GynSbo=;
 b=aF8GkIazessU1+LjaH2EMGTmnubMQ+e1Gurvy34x/NaFBCUIvDR2gP8gmofA5RZVys2lPZuefWQ7BupXghzqAiSbn4VnG8O+HOuei2A7zUaDHq8gB4fXt6lIGosDfT4E8dL6PZPjTPcEki6KWgzeXL3/rL2rGglX4fo5ROZTPvHmqE90vwQWisrZ3sLBu1AAuFcNEf1+MCW1hG0oSQc08eumf1tuWUw4iVX39zqWV1PUCReJqldplk6hkIVcvCK876ZoS2eWOqfpLDg4Uvesw8bwHk75UHwaVGyhjyyd2YThS9ky+74hm0G5wacU7A9sE7IvVHWE7AKYsZDq2+ru2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1iz7+/G6wNuRGf8jutMPIw3XyV6zeJ8o5w40GynSbo=;
 b=toy3J3f9PLkDbOw/Vr+gzbCj1wH16Vxaj5wtMFCTO96SHxLpTLPqzukgc2O/co/o8TxpjYXIwG4pdZ0ZnejW7neO2OcXLqr4QgHoLbHdrSQ9U+Z15Y94TVaiTIr6NJLh6Z7nbwWnox6xP/vJmqdvTMszRXZSA/cUoqVY0PzFdHkfRGuLEaG3Y3394EV9sRqoOLxD5t3A+aelZtQrLGpaYM7ssfqBOFtdJBN5Y81U2mT9eJBEf7k/S3aC1Xs7WLbGaWElziW+uiz9TXduRznXm6dcnxouoDwG/MD5oq/LAzfpNQod/iaF71IVpC26kCGOg9ymzzQ4gwa1xeXjU61KcA==
Received: from SJ0PR05CA0181.namprd05.prod.outlook.com (2603:10b6:a03:330::6)
 by DS7PR12MB6143.namprd12.prod.outlook.com (2603:10b6:8:99::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 07:26:51 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::62) by SJ0PR05CA0181.outlook.office365.com
 (2603:10b6:a03:330::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.8 via Frontend Transport; Wed, 23
 Sep 2026 07:26:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 07:26:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 00:26:28 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 23 Sep 2026 00:26:24 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam
	<mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, "Krzysztof
 Wilczynski" <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
CC: Rob Herring <robh@kernel.org>, Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>,
	Niklas Cassel <cassel@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 2/3] PCI: tegra194: Avoid full Endpoint reinit on PERST#
Date: Wed, 23 Sep 2026 12:55:53 +0530
Message-ID: <20260923072554.1141864-3-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923072554.1141864-1-mmaddireddy@nvidia.com>
References: <20260923072554.1141864-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|DS7PR12MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: 78e37601-1217-499e-5363-08df1944095b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|7416014|376014|10067099003|56012099006|6133799003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	lu8SUPgYThZ0BhlbRFG23qhAZXR0Truntf6Jqz74mlHi1rRBQ5fZKNU+49LNGs2EtoitRNfPDYTXxhpiG0syI0iL+E/eXPlLGwZHhrkyClKGmgRpsy1vphEyfapUd7817FhBSd3N4NCbPFugny7MCPzIVyPACOLY9VJaMLFSHT63TuiFnFn+P1iLcVHe0vzg8orgcn7adRVhEU8HJ3WFC1E9yFi0Hh60iJ+JZaU0yyhY1zcVibzUdqZSVcl/FAHytonRbS99Jm971F5VaFHxUHupHbEakJMn6czyDgcilDEhgh787ffX7QvFMzOz9GcmWnJRMf3ZatfPxCJsIB24xeBC6zQ/5p/psGx6CG1b4KjBNEWi1DdchI1btgLJElg3nUlI/ndFDcxOUPpEhySLF5HFpC57GYkujRQiErHymd7yGCMvZ284R/zPGDN9n8chNmXpLLyEN0wdOq3EnGuvmdtNrR25P+rcT5qDBkREOw5hNWUhknSmijMuzlIVeoedbYpMkJBbG9JSgtON/ywx7H/aLZEUgRK+VyAkEQClHikodxEm0Bm9tevTxZHasfoUztIBl+ovrsR4nUEaQx6F6wDX1FjwYcD9p2w/TxTjgYZl9am+f+RNzQ9PObQUZ8gc8R4BmqAJyZ7dw3i5q88RBaqJmBc2B8f9qSMK14z1XPvvblfTd7F2WUm4LffUwBs6rcNVGL7AW0ZHZsuUGNUISw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(7416014)(376014)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2ZIOAmfxrNs3bog3yJb0n1DU3B5NTYdLjnlrsMFJRrgcgtDFy9XArWjrFi27ZBw6ku+1Cl61z1bO/46ueNrPOU2Zl0I10DWKC1rnMakyJ3wG6Nx4tPiz+FBg2CvsPpgo35ZBwbhi1CcfUlcktJTskoM+/SIhq97V9RpWJBdV5jF0tRHv5ZGZglWK0d8490aAWo3xSCIAIP+7yBJ+u3MYWYDIrJPe2+BMse6grhO4uVhQYJ7qjw92osucJaP2DTRdugCsLofkEyHU5iECcml6Isol3GPFKnHB5XmVse53YZMibRYO1CZvqzFSkxw8bD6PyYMKxebOFNaIr41ZM1jPpHoxQj2f1BtWtb03ySmjcpntGLbKuwrskKlu4R1CodvL6Ql5QjhG02AvNf9UGmIbiXmoaP4nwF34/9wlD8spxMmo/K7xD+eTcPSMnCJrSmGi
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 07:26:51.5011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e37601-1217-499e-5363-08df1944095b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6143

Tegra194 and Tegra234 Endpoint mode receive PERST# as a fundamental
reset. Controller registers are lost across that reset, but DWC
Endpoint resources live for the controller lifetime.

Use the DWC init-or-reinit helper for Tegra PERST# deassertions so only
reset-lost registers are restored after the first initialization. Keep
the EPF deinit notification in the deassert path where refclk and core
reset are available.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 513299541f18..dd3f4c30ba52 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1914,7 +1914,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 
 	/* Perform cleanup that requires refclk and core reset deasserted */
 	pci_epc_deinit_notify(pcie->pci.ep.epc);
-	dw_pcie_ep_cleanup(&pcie->pci.ep);
 
 	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
 	val &= ~PORT_LOGIC_SPEED_CHANGE;
@@ -1958,7 +1957,7 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	val = (upper_32_bits(ep->msi_mem_phys) & MSIX_ADDR_MATCH_HIGH_OFF_MASK);
 	dw_pcie_writel_dbi(pci, MSIX_ADDR_MATCH_HIGH_OFF, val);
 
-	ret = dw_pcie_ep_init_registers(ep);
+	ret = dw_pcie_ep_init_or_reinit_registers(ep);
 	if (ret) {
 		dev_err(dev, "Failed to complete initialization: %d\n", ret);
 		goto fail_init_complete;
-- 
2.34.1

