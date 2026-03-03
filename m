Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012039.outbound.protection.outlook.com [52.101.43.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF223859D4;
	Tue,  3 Mar 2026 06:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772521026; cv=fail; b=tZfT+SHKE+J4yXSqDSzJ8XN3zjcxAp/dglaMGvieRG1gTAIWTLxAfjvbengcq8ir9JdPQgmKGWZZ/BSG33GbLRdV8UsHpIsNlY05VDnd3V7zJlprnb/Zk56IJEAiyp9yjC0QtpzIo9wp6clpXytfBSTkGiFUUkEsip51uTV/iiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772521026; c=relaxed/simple;
	bh=2LN0OsQOovY0iGTPQ5gbZXb/G0MrPrDt5ATSHV4e4Cg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IK1oAbjeEfv8xay/okoDly/vja01aEzB5gl51EfrYK5C67bbKMP+kRt/TGgQYjgtwL/LwybL1UqGjUoIa70zGcMYRgbgAIAhsTB93lUufPvIT4YgzNE72uyohoyELnzdbU8VUzJfJM4gNeE7dFDc4BE4gXHx6Rbzo3wuXgqN/hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XVr8uQio; arc=fail smtp.client-ip=52.101.43.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XVr8uQio"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hp5QilTolyFky2UeY0EIS875SUGa9mceNEcTM9INMDCuH11DTY+p3Epy547P3JcO7RdQRK9mFbseWGPxAdsydfD34gyCE6SIVCuEobDWxSfBN8dcHAAmtGyakPhSdNOMz+TPhQbqY8JWztheKHkvDpYZtm/J+G+FPZ/KL+PvPdsW+fzPs4EhEmUIUyl5GJciDa+s00KHBlASXwg0/tFjURXy0rCbTPhMPqUBaL0qB1/X0VadgkytoVbLMZeuxCkcBbOuDz2hBiSJi7ghq29uMyw+5+p7207IOdER+u/um2Naj9WdSnqKop/W2ucWApR4vStZHUpqNHBoC/qeD1rCXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYFCrfIEaXfKJvIgaTn/ie6Nf/ZG+VsRXY+9lGL7Igo=;
 b=E1fCS38+j1KFff9YzQoLJ6pKj4hEMury7cdOWKEXOeTrl7abjFptKE1QPbW0jgTp21ffvtkGub/1X+9VRqqW0I7yMiUmuyd43zhaupSwX1DwsTKm2lb7wMMsXj/AwQDVyDttLeonP2fP7+xnH0ITH5PieUduQq3mz0eiTMrJmDk1UdMvIQSTIEQuzZK56qOV3mt2FoOu3vE7MblyIL51jdQaVkyrk6hPxhJ8wZ+qf0XL7tU14dwr5po01JD1xLcRNHii8ckusyhLRlTjpkdHPuqTXFAiKTbZDRXrnYUCLAhk+X8tmAGNM7cVNZyj1zBa4SgIAHFT+aWQDO7B325iHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYFCrfIEaXfKJvIgaTn/ie6Nf/ZG+VsRXY+9lGL7Igo=;
 b=XVr8uQio/OkilFNuz1iKC1T51ZdTNP0U2O9BaX9Bj6TBeCQrlh9/OyiCBXrTr5F+5vudgXN2WSYj+cPfj5A8keENnNZPsj2AiNkAvlNwmTKrYDHtWMcYnPjU753+N/gjQfTj+g4rGir7jZWm8bB8SOsHVAgAmaeR7ka8Az7Mxcd72cWxgmvZ/j/IXSPQr99MF1oJ4NIyhWO2JftBP2FT8mIa5eFQc0zfBNExOPzLOmmIrtCtkjY4hOfmFJ+D9Xtx87cqbjppY3w8RS+1juWM4cOprN14VNw8UXW1w1yTvrQFYzQ0BYznl97A4EPW8A728miIBMouleLU8Cl+/oA1fw==
Received: from BN9PR03CA0393.namprd03.prod.outlook.com (2603:10b6:408:111::8)
 by SN7PR12MB6692.namprd12.prod.outlook.com (2603:10b6:806:270::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Tue, 3 Mar
 2026 06:56:59 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:111:cafe::2a) by BN9PR03CA0393.outlook.office365.com
 (2603:10b6:408:111::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.20 via Frontend Transport; Tue,
 3 Mar 2026 06:56:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 06:56:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 22:56:46 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Mar 2026 22:56:39 -0800
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
Subject: [PATCH v7 13/13] PCI: tegra194: Free resources during controller deinitialization
Date: Tue, 3 Mar 2026 12:24:48 +0530
Message-ID: <20260303065448.2361488-14-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260303065448.2361488-1-mmaddireddy@nvidia.com>
References: <20260303065448.2361488-1-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|SN7PR12MB6692:EE_
X-MS-Office365-Filtering-Correlation-Id: 8db696cd-464c-4477-5b80-08de78f210d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	BxIRFB4ucn+KkeT66+TIbFAdEQSLa2jcIJKXD8g3hme3RStLfy7vZ7TtP2dP0oAb5JH7QH5lU8BvFE36XX9GhU+FRrKL04cKqxDKfpFUgD6vrlRiRxi4tQto8RfIpKwyLACH4YJ1fTpXyey5g6ZhUWzYwFFlUo6ct0HqHg4D3LjOYWSAwTRZ/6NXzN3aLgBpNj99vexThMiGK2z+MyQI0TEHuybe9XpECSU+SjvHJb32LzOqHS7VbexL1IzAzI9wKhGWy945ITJCgb4TsYLXEXXYdmKnhYIucio/CzRINErQk24o6sMT5TZeImFNIN8pSU/rSxT6OWLuLvSat3rHCFPxN1e8VKzrbtmsBk+IUvi+TkHYcScJHeIIyMfcXv2hwHInMhriqBFWR3ncU8SZbBbLHLUSl5nVidlGy3gZDJQPqaRE81NwlV9qS+L75qCO6sJQ+ZbApyIwaSfO04ZE5OhlhNzIg36UpNiSfLT0tRtKT/IfS/Ld7/iMaPLkW/0QxF0Pr+ljIO1rMGw2uMZnrarjUvE+JqDB4io503qv9GcDX8Rk4CF+wfVub30EFQ987C815bLFf1/XZ+3ZEYDkcZKimOAlOPGXmFEjafzYxh4+uMUYnJ6NDRphn4QT3YCZd+2oM0NfOA4uxp6eAsCdZDuU81WTAE66aTpwUDkl82+QUXG8P5OkMUD2UUmTztPUIsAHM9t2q4WW6vL7YGS1RoxvOluewcQPwUGFSfETl90BnLHaVcTlODtD0YWy4tJjI+PcuH6Ksu0RG6tEKGisD417I+Ag3FwS82XFyNjlaLzW1III3Py0mF+vLvfNq/q8Oiel/GfQ1AgXe719jNqwnAmjT83ox4c3g/6vrGezWzA=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	s+HmuocoG2SVbBPEJLpBk6UoJzOL3rkbQI2TCmPns67+TgXI1jiSjrP8aNVgnafqPrXRgl+IsSw8nzaD9zJzPTCcpzhC3IKVAFr0KBm2Xf1cras9VIypiXjyWsIJInyKa4vXRgyDDCJwf3angMTXwuEHQuFG2frgPdCfh5bh88Ar6ewjB8XPboon5SX/IFa2QByxcTe30+N1CDecK4md4olQJ7lHLpyQlwtCKFMFrfyJWxyf3Q8sAPRbQtzykDSI/QvD8mHdxnMgjb4mi6T3SwAWa0FNykqFdAZvyk1yIDR2OhJJu3/eDqqgy92VvIxIeIyPPRpyJl+yabLtp4xu1HCa03jDk567r4gSSf1jNEwlxsdgn9O1ApoX2FIrch/dRtyA+SenfR3Z9sxrvaFUYbM4PoDkK9F90AdvqTaatvwA/vlFG+KPVWl5a7hIxw/N
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 06:56:59.0759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db696cd-464c-4477-5b80-08de78f210d1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6692

From: Vidya Sagar <vidyas@nvidia.com>

Call pci_epc_deinit_notify() during controller deinitialization to free the
resources allocated by Endpoint function driver. This is safe to call
during PCIe assert sequence because we don't expect Endpoint function
driver to touch hardware in deinit function.

Fixes: 40e2125381dc ("PCI: tegra194: Move controller cleanups to pex_ep_event_pex_rst_deassert()")
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V5 -> V7: None
Changes V4 -> V5: Remove pci_epc_deinit_notify() call from pex_ep_event_pex_rst_deassert()
Changes V1 -> V4: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index a311c31109e3..b1ae46761915 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1624,12 +1624,16 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
 
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
@@ -1796,7 +1800,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	reset_control_deassert(pcie->core_rst);
 
 	/* Perform cleanup that requires refclk and core reset deasserted */
-	pci_epc_deinit_notify(pcie->pci.ep.epc);
 	dw_pcie_ep_cleanup(&pcie->pci.ep);
 
 	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
-- 
2.34.1

