Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793618895;
	b=ZQJxXhvzO60n48u89yBbd0kgizHxhadteqrwyIqh6Cyl6AVVDlLWR2YuWA0n0lifLvcZ
	 pX//tMsFb9tmZKJYlEZVLpMiktRkPtCloto7a21m9aeArbLYIg6p+RsJPWY34hFa9fIug
	 MljxHFH4i3OJfYEnMk+qqWLJXxai/YEOyKgU3YwDBmrZcwL/8PFLvDGqhruDhSMlFG4hA
	 so8WMDqnmX2ukDsIK6C2u78skHwg5RK1T+6Y3iYW5ns4FGfX9+YKnd/W7DeLnxr3ik/3n
	 PYDn/nQAWGDvEVKk/7KGwrhSmp0YIDsE64G9dxdJkNTM7mP9z0IE4/DjDiIp3h07Lyw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618895;
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
	bh=e9ir1owPYv28Aw7lnd48aG7WfrWaxyW7QMpwGXWH5HM=;
	b=qZfBsWnL3YQWmxeEmcvc+sKJo6mVsu6xNSaIpnPJ8vZqgvsJC8Tqk/t1y2L1qwqq43mP
	 S5Xg7voIlnR2rvHBKJWajLNSl642tZIoMeXMri//WxBGdJwUWi3FeyzpkJa1IkdQ9xbnM
	 XylERbbDlv/3BKsbtwihlZ/+FVnhmKXnPktMOLdEhhqthi9k4MJ8vPtdgyW5WfjSDNwkY
	 VgF7zPrUl2fJR6XqoNae/2V6zhT+FqPVW2gfl+NLLB4lA5Rzn+ER1wJoh7VTNVjMCdG+d
	 UhfoMOv+ZwG8R9Gvl1/cEYNce5pggHnUpIhxJzvyVPsTJYoUCZdoyx7nU0O3/OQ/C4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=SKb4MYOe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.43
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010043.outbound.protection.outlook.com [52.101.56.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B698606A32C;
	Mon,  2 Nov 2026 11:28:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B698606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=SKb4MYOe
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=figpp+49YuOHenacZfc/I2sooiZyPtxJdQWuz5cSrdsCIjFcJHiLeNEAFQoIGtUmxQIB0opa3ptC5pIl4GpWfAOnPTcc2eiqYr/PEDQg27ROki5LEMOlgdC14Oct1ccVYQ4jGTE4bxmCgP0g5IO3hETfDo6dUDDErHqOWMbRYM6rzQLi7I1CB1mhobNeIEhPjrb0yuDdzAFxl62RJohX+Qq7oB/BBzmM0n4Ful+5KY6LljPh2KusDyKOUzNfuh8xw4Abr6AA2r5Pa48Td9iUoIUzpMdRou4IMnrKWVWbG1N/k4xIYvY5JxXVhCh1h8FikoRSdrH6eTrGIq24KTb6UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9ir1owPYv28Aw7lnd48aG7WfrWaxyW7QMpwGXWH5HM=;
 b=hD17xvEHVG48/KWL4l5HtKCF4kLL9dpUQJJcO6p1N92JIWWjHub2aZujHoY2c5rHpe340GErDkXkF7eutoDmhQosj4EFIMQdme+H3F9DaMlyxM4jCXq2s7hLu21Wx2iZVa1WnF1Hu19jn5MxI4T0A9oasnZvQR3xwgn4YKwgjhNtNZINYpKg8u4MfTp9irQYsMV9vesFzbivBllz/13+BLAYTgwmPFswrP0+1ogDpFLuGXY5EX+hAyhADB45uBokxvggYeLzGDMAngyhTI3HPqa/gkeLFGR4kyg73i4heMzws96meJzQtF/TvZ4Yj08QgZ8T+X1GMGEpYUHfCYLWLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9ir1owPYv28Aw7lnd48aG7WfrWaxyW7QMpwGXWH5HM=;
 b=SKb4MYOe24TbeLCTI6o3mDbNAAFuYcTDXMrKmoizDP/xbJiWi20y77sY+u669wWC92NoVQy/ZaJwqtsbCm5ri4a4hirKHvxxCwNe7kSTJyCaKdKJ6fj7qGt9R36JeQmtZhX42eTHpAHQzBWsLEByaYBOSrqCzNw1XDrS1kTn9Ff6CK10NqibOWaos/w5XTSG+zwVbVpE9RaIHwIhtNtDPDOwihTfewYWy2jjiPiNjY3VzdpTkwLDCwgkb1bI+qgDSN/n7MVzXnfSklaIH8jn+y8i8bxkui6n+l8PXhxZRfsD7GAHL0npbks7s0pmdnd9Th5wax3As6RCfkbLdNkOqA==
Received: from BL1PR13CA0229.namprd13.prod.outlook.com (2603:10b6:208:2bf::24)
 by DS7PR12MB8249.namprd12.prod.outlook.com (2603:10b6:8:ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 11:28:06 +0000
Received: from BN2PEPF0000A88F.namprd04.prod.outlook.com
 (2603:10b6:208:2bf:cafe::8f) by BL1PR13CA0229.outlook.office365.com
 (2603:10b6:208:2bf::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Mon, 2
 Nov 2026 11:28:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF0000A88F.mail.protection.outlook.com (10.167.248.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 11:28:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 03:27:48 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 03:27:43 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <robh@kernel.org>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<kishon@kernel.org>, <Frank.Li@kernel.org>, <vidyas@nvidia.com>,
	<cassel@kernel.org>, <den@valinux.co.jp>, <marco.crivellari@suse.com>,
	<andriy.shevchenko@linux.intel.com>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mmaddireddy@nvidia.com>, Frank Li
	<Frank.Li@nxp.com>
Subject: [PATCH v3 02/10] PCI: tegra194: Check core reset deassertion
Date: Mon, 2 Nov 2026 16:57:11 +0530
Message-ID: <20261102112719.4022633-3-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A88F:EE_|DS7PR12MB8249:EE_
X-MS-Office365-Filtering-Correlation-Id: dfd6b466-6d86-478d-63b3-08df38d45da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|36860700016|82310400026|11063799006|56012099006|261009223027099003|261028144727099003|261021123027099003|261021121427099003|261022105027099003|261026140227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	FfDrNt8VlWN2pKbeLpIv/F1lCTCIi7vCOty5N1DBF6jdNMKgQKr0Z/x5m8mhUgjOfHFfAYwoROXXGOA5Ri6QAxohNdL61e2ULJ6ToU3OKa9kYKWcTZBIBGa2Wcdx9OBxZqCmEH3mYZC6Uw0r46WDE6GI6ly2fQUr0BRVJsDHI9ebq6LiRSHH38+d1vCWTPkZS+63cfhxIDy6tYKfrVLCCranuAn9RVWX8lvrtckXpnYXO234l7YYaGI5sTLaHQ8bFF5r+9L5Ge/uI35eLLJ0Hwn6ERiMvyQIq7nt6rqZpAfOM0LdTWCYVzWC/3mi50Q0j/WadBw/FF9a1j9g0hffbbAlDZUsdVvCm2RU5waOIkbz0UVmO62nwOyFZ3yGtMl7NzmIM4fcryuLS/i7X8qyEl9rnFu1MO9Mm4wvSQE3CdID643i5TpNplGvbumAaegal3bVvgJ+OPFi1YOzGhicsbTVojxA52w0BZbTqsvHxDM+WLweRbxUohjvCd+AH3VBqpHi25Rde8LNYIGYz1YaN5zwVSJ0Pg2PldMf8QlFwwUxJBsXxg41P4CqKrXtuWSo8q+Vw5WhZa7+WcyUt96mMPbI06bDU5KsZ8R+XbbTTIsgRw+GylS3tiysIOcWRPdu6CA2B9m/tGyOOI6MhfIBjXzylFYKcWbt1DlTtRWAXSyWY4U8OkfIK5e2SIVJyhU6ribaaVWITPNMHpS5VxmvrA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261026140227099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tVHCAe9lCXC1EniEkmroBfaMtxlKiRcNpG8kHBJTm67//y0LFQu65yzBCLqa9WDrzSI1wq0EkSIcBQLWtlhcw9KjaY81xA+p1cqiDlBTcxYzjVwNznqRKxqmVnCmplocbg4RKXvizSO2HO3JYrRsjZ6TG3RcPn9EULLz7rALV2xKx/UFhV54glAWG+8dA7XwPKlmLxhbLRjghXG+uQVzPyjOHS8GsRg3/XS6Elk61UBWGc+omu87R2vzJqd2Bhy41x0gmaiWBOxkN8qKFGunMF4y5e/rBIQnoEs2cK1sjOYKYxag2dLad8YN/BzCl8YVmvCmKgLUwRbJCgv0nL/1AdTL9dXDeIdbKXZWZkr6my7o1DYGI2fG4EFa1DvK9znRRUyGZob6Yd5mV858g043w9fNiXsfChAgrhCFvTtwC73D/LlW+gKGM+eOvn+/UQfg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 11:28:06.3549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd6b466-6d86-478d-63b3-08df38d45da6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A88F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8249

Several paths access DBI registers after deasserting the controller core
reset. If reset_control_deassert() fails, those DBI accesses can trigger a
CBB timeout, or setup can return success with the core still in reset.

Check core reset deassertion in Root Port setup, the DLF retry path and the
Endpoint PERST# deassert path. Unwind before DBI access when deassertion
fails.

Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
Changes V2 -> V3: None apart from rebasing.

Changes V1 -> V2: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 23 +++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 4490627a539a..d504d7cd3c49 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -955,6 +955,7 @@ static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
 	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
 	struct dw_pcie_rp *pp = &pci->pp;
 	u32 val, offset, tmp;
+	int ret;
 	bool retry = true;
 
 	if (pcie->of_data->mode == DW_PCIE_EP_TYPE) {
@@ -1010,7 +1011,12 @@ static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
 		appl_writel(pcie, val, APPL_CTRL);
 
 		reset_control_assert(pcie->core_rst);
-		reset_control_deassert(pcie->core_rst);
+		ret = reset_control_deassert(pcie->core_rst);
+		if (ret) {
+			dev_err(pci->dev, "Failed to deassert core reset: %d\n",
+				ret);
+			return ret;
+		}
 
 		offset = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_DLF);
 		val = dw_pcie_readl_dbi(pci, offset + PCI_DLF_CAP);
@@ -1456,10 +1462,16 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
 		    pcie->atu_dma_res->start & APPL_CFG_IATU_DMA_BASE_ADDR_MASK,
 		    APPL_CFG_IATU_DMA_BASE_ADDR);
 
-	reset_control_deassert(pcie->core_rst);
+	ret = reset_control_deassert(pcie->core_rst);
+	if (ret) {
+		dev_err(pcie->dev, "Failed to deassert core reset: %d\n", ret);
+		goto fail_core_rst;
+	}
 
 	return ret;
 
+fail_core_rst:
+	tegra_pcie_disable_phy(pcie);
 fail_phy:
 	reset_control_assert(pcie->core_apb_rst);
 fail_core_apb_rst:
@@ -1854,7 +1866,11 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	      LTR_NOSNOOP_MSG_REQ;
 	appl_writel(pcie, val, APPL_LTR_MSG_1);
 
-	reset_control_deassert(pcie->core_rst);
+	ret = reset_control_deassert(pcie->core_rst);
+	if (ret) {
+		dev_err(dev, "Failed to deassert core reset: %d\n", ret);
+		goto fail_core_rst;
+	}
 
 	/* Perform cleanup that requires refclk and core reset deasserted */
 	pci_epc_deinit_notify(pcie->pci.ep.epc);
@@ -1928,6 +1944,7 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 
 fail_init_complete:
 	reset_control_assert(pcie->core_rst);
+fail_core_rst:
 	tegra_pcie_disable_phy(pcie);
 fail_phy:
 	reset_control_assert(pcie->core_apb_rst);
-- 
2.34.1

