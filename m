Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792563594;
	b=E7YZBE+XUWoZtNKH2nqveyKECnOiuAeARiyPv7GaM17jKxMvEXq8eUj5ui/QOqQ+Kiuu
	 0hMVmOYIjpnglSWxMMV3A14qDx9JOXg0YosHgi5owZp66FmDepUiMvBWNEwRi7SLbkoR5
	 v0GHV5mMRWQ518f8R9tmd66JO6T0up2flb9Zo6QY2gMvEV2AlPyzaHqmobNwKQMdRtnEv
	 MexzsOmWaBBzJ+QLF203H5pjb5Ae5MunmACHNl98/KMAfB2l7gR5WSWkG8au0kAlksF0S
	 P9sj3fcfgmxxAwKh4Hm2PAPA7eorRQgAZK3JT5QxHblrN8tpSN2VhjnTLiklMR/s/Gg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792563594;
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
	bh=hZf/inFTpFwuQaGQ/vufdFrRHEiZIITeTaClW8hF2/M=;
	b=38PeTvBh4nHSX9HuMGzpNRWx6wGWVPyp8qGWD/7VR3LIfxXGAWybpaSxq3VrAwQa/qxg
	 hUIfUfEHmRzwzYxtgkv2rdhm2hqbXGgZHHS+9MQxsPndp0rgmEpA9+lojzCWypYa30B1G
	 Cf1k7OmlaIY9o3MAK2cp8cBJLMuNJrAVpyvyh7dLdgGjQ7XdJgsNhimAtrK1RO7XLSCui
	 MMrDTFiZJepKmGqC8m3RnNRPwNFunsA4ttsYvS+cgnjY1X80k2jP8V9cVUSFcB0b3ED1s
	 L1p3IOFEDuM2LsZ81yn3EL6M3GIETTLlnFkPtLh2sUeDH2R0nhyaYPaez3KvF1ccpnQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JAE5baXh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.24
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012024.outbound.protection.outlook.com [40.107.209.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AAE606A321;
	Wed, 21 Oct 2026 06:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61AAE606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JAE5baXh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JFtEt4lz+0YAUBF5X5dwwr2yBTQab9axok+L4aJ+USP2RnA2X9hpj+XW9wNb3RVBqnH6D+ybBfUZO1h29/XOcjGjmrKu2pJC9UeeFrN9nxZM5JFYvrAyL3t034WGnEDcDAqDn3Q+uic0RO987lHotkSrNbVrhI//JG0ouoEx3nFKLs7N8reeIf3g30m7FcWrD4hwLCZ/IEwl8uNghahMkzGPhcDWqmSRKaOqNRY+Vshg+yvaPnR6JAfBLNYt+cMiPvPs3wg1QZvYyPxaJSijP64J/s4gN780gIjp3ysbfnwomTm43SLFSZVykyD5HeaJ6ERp81W32x1o3SUCVaE6Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZf/inFTpFwuQaGQ/vufdFrRHEiZIITeTaClW8hF2/M=;
 b=Px/P6VR/QBYT+Aqh0dFsljzmbNcXiDHK6Ed9a2v48VNe6Qye6Eu6SWAT2PexL5hPl/pmZvMCs0MxFr9RCMc+o4lhQ4dXao6WNzNyAusBwAuAhGwjSTf5zvIE5dCZsqBP50iOzaeN6D06VLyuZ+zHlQZXQq+J/SJGi38t+bbeXnVsYPrXmO4SIl7q9LiUU8K/tX2Z9+5yLxzb9f59T1y2fc+b1AOf/ZoT0FeMx47e1SiUoLQGyxsdqwLIRYc1ACzu6iPkTDsX4rE3X2TVcgsZpE+LQhKBhKHQVONW6QvBhNkJkSpwWTdeQMM2Z8CrXEKBVrPZ4WWrvbrlJ1cxedhhXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZf/inFTpFwuQaGQ/vufdFrRHEiZIITeTaClW8hF2/M=;
 b=JAE5baXhnG4j9BkwKqHOyn8+bWV6vsAoK1Z50OiAjBcO4ns3oVUbS7BbDDoPCcxB+UM//i87VPgpFFqA9pNlechNNmKWPw9kah6if25qfh5TSr0sJtjiQSHIZe75nVtvCGTYmrCQZqdDrmrUc1KrFptmqXcjbgVeI+RvF9tHHvpoV/eNg38mi05uN/zTQC/qK4Thq+t/hi/LYpFkuPu5Wl7MNzdopbTui/9NB5Ru4vpUds9rMoAMoTYsRMUptIPT5eQkviGKiav4q2x/jguLMzU/gDWnGd48WVn/PRZ7dtlunVl7X+xjZWZossClSJh4khF4+mxIqXRbCA5QGin3EA==
Received: from BN0PR03CA0029.namprd03.prod.outlook.com (2603:10b6:408:e6::34)
 by PH8PR12MB7328.namprd12.prod.outlook.com (2603:10b6:510:214::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:19:48 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:e6:cafe::97) by BN0PR03CA0029.outlook.office365.com
 (2603:10b6:408:e6::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 06:19:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:19:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 20 Oct
 2026 23:19:29 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 23:19:25 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <jingoohan1@gmail.com>, <mani@kernel.org>, <lpieralisi@kernel.org>,
	<kwilczynski@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <robh@kernel.org>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<vidyas@nvidia.com>, <cassel@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <mmaddireddy@nvidia.com>
Subject: [PATCH v2 2/3] PCI: tegra194: Avoid full Endpoint reinit on PERST#
Date: Wed, 21 Oct 2026 11:49:02 +0530
Message-ID: <20261021061903.1269605-3-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021061903.1269605-1-mmaddireddy@nvidia.com>
References: <20261021061903.1269605-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|PH8PR12MB7328:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b21f22f-a32d-4eb7-473d-08df2f3b4f12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|30052699003|1800799024|376014|23010399003|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	fQjWcO+36LhUZ+FJQMpr4IxIILwvPKQofx6mklSv7SyISwXLaN2bnsIHPTFMeN9cB1l798m5/gIg+Bs4AqyUMkZ1H+4q55Ssy98oHma9lmv1p1qDkk8/QBbrZBA7ptGOJ1ZelBgLsPnZjnp9DCgKpS7DqeT9IXPLrQ760Al8nOptwXzp4LhyKrILeT5RupkIsT9DEjWSowAaV2w6j3WU/R/bvmegaCACA9GwNNDfaTN1BUrBpBlvP+1x/bnBsBz8TdSjukqGZ4Z+xiyenIMMz7tDKBKqNoGq1fYaSwCoYhVtVqVG8wUzY2xqNvd2CfmnmZ970BU1M067p7pSWcAd7O54qGDQu2zU2ZORWsIQsdAIv80mpyus1suSL8+8xedw42ctFX9tSAeVzHyYhjIci6LaLGPWCBhbxJ0jmlFrrZa7brd3sKR9gZ+ococyijTfWXtQAeag2va11rQDrQLhJmQl2nUYwbb592iTrMVHzB3O2rcowqJBh8KEh8QNXSwi12SO3VjwEgd3eR2/bYWk/D2OsPxaYKjh5c6EcBvmu+0xcvrk+ll9tiXz75U8EhrGpoAhgYPh4cWPZlXMIQ1cpXFHKxSvLB+TIPTBh35bGpUvkUCeFmCLmPjRKeMRENK/RfwsXNWaDjJhxkW2/F15wTc5RBYK2d5VUjpJWH2sJlhryoIS+DZb9Xsn5WBszTIyi6nDNkHU314sBOVkIQ3a4w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(30052699003)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oqxepEWWiR9dJHVqVDevk+L4KC4F4iiGX0WwtllaLrN/NNOol5sBT5jR5OTj5EWrsrol5pvCDRnbwe8urXjCI3nTguQhsur4b5CbJaJwxFI8l/AWF9FAhJsJOZIzXKxujY2HzMdPAMPXrTwFf9QyaJV8SXS1r/mOBRxKouWelQsoXrkoAIWz9i2tGytcxSIbHQ+fkvDFgEZRjPxi1vjwiFcj++a7f6AVoYij5UN6UiZ7ws3yJOLUAyachvUxTK8U0Chc053O4Ksx5RaMbYHYfayaeUgmpdD6v669ZgRZ9t/OSq6q1OV+0WRdgosDPqmNN2xwqo6D0coiIwOCwTEZsjdNJiXllp0EkV8bkThlYnymrgXfRFz+I5uqY+XgnYvk85+oSu0xjjeWXAwW8s1XeuOhH2glD8AxnNVZ5WeUSmqc3ghdDOZR4kSIPfl0kInZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:19:48.4307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b21f22f-a32d-4eb7-473d-08df2f3b4f12
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7328

Tegra194 and Tegra234 lose controller register state across PERST#, but
the driver remains bound. The common DWC initialization path now
restores those registers while preserving its software resources. Tegra
therefore no longer needs to call dw_pcie_ep_cleanup() on each PERST#
cycle.

Remove the per-reset dw_pcie_ep_cleanup() call. The existing
dw_pcie_ep_init_registers() entry point now restores reset-lost
registers after the first initialization while retaining software
resources until final driver teardown. The allocation guards already
reuse the bitmaps, address array and per-function descriptors; this
change also avoids repeating the full debugfs/eDMA teardown and setup.

Keep the EPF deinit notification in the PERST# deassert path after
REFCLK is available and core reset has been deasserted, because EPF
deinit callbacks can clear BARs and need register access. The final
dw_pcie_ep_deinit() during driver removal still performs full cleanup.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V2:
- Keep the existing dw_pcie_ep_init_registers() call now that it handles
  both initial setup and reset recovery; only remove per-reset cleanup.
- Clarify the retained resource lifetimes and shorten the opening
  paragraph to focus on the Tegra change.

 drivers/pci/controller/dwc/pcie-tegra194.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 0f49ea6df8bc..47a83a69533d 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1914,7 +1914,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 
 	/* Perform cleanup that requires refclk and core reset deasserted */
 	pci_epc_deinit_notify(pcie->pci.ep.epc);
-	dw_pcie_ep_cleanup(&pcie->pci.ep);
 
 	val = dw_pcie_readl_dbi(pci, LINK_WIDTH_SPEED_CTRL);
 	val &= ~SPEED_CHANGE;
-- 
2.34.1

