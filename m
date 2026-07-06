Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013069.outbound.protection.outlook.com [52.101.83.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A222E3A9002;
	Mon,  6 Jul 2026 02:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783305880; cv=fail; b=E+kGJ8jJzCi11yvDPx2L3qhG9qCqh9icax7iDR4430xqAJNlZe4miqpBiM7aMDnpL+qZ97P+CT6YT7gBaxFfNtQhTQBVhT5aYh3xylLi5wMU0lIox4LlATa7EfogQ+hY0t0UudTuIxUpcLajZEhIW81UzNbjJmvOFYW4cEk/rDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783305880; c=relaxed/simple;
	bh=FRPBInHJDaCAQ2kGiTE8O1eo9zXl1pS38161w8vNaCY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Ta5pFtFxSOzT9enYIb3J7lDg5S4yTCRIi8+trEZbjoLEHDNoQkCOQZ2vyM5wBcxyRc3DEf3fKPz799OJLK5Hp+vWHdYzrO6cblYOHl1AHNVTsgheAHrUst07EZeDH7J8+5/2t6IPxq+Bf2b5NwUzvtjjNh6oOQCssgqwzki7PNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=wPgMtMYd; arc=fail smtp.client-ip=52.101.83.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wPgMtMYd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pFdIQmMc/Art+dLbFwNjO1a9sUvBWKxQSWZ12J84zRYx7SHxa/uZG/inGUd2JXS9S/Rbg7mNq7o6nrRvt+E1m2p9N3JKW3uNxaCeLRGUtnVGWESHtvYq+YZVuVCbr22lV/JTeayJnQqEZLJsUrfDS9cdcUv1Njqb4xk/Pv3Hb4GsLP8hkMJso6HHn5XHkLfj27nBxJuxrcnPwC3ZDhuz/euyIHvqSiGDuhIdyLpIPAsTTzlJhcm+Dxfxcrnwhvy3KZelhhMIWpq5ZMXiHQ9Uwl5cyFd7bzggmIOYT9Zuy+uqqalHyVy6NGcw3cD8vE1MHvkYV8QpLsnxWdNjBKz+eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZTyIBSRDOP/XkKhj5OJBprAVtSv39vOpmIrevTNv+k=;
 b=F3z/zdSv7oJr9ULj2qMoLY8+CLFesnXeFl+FyVuddF6S2mw5HFnPntMIloDPE6RASd2nTcyExTHZshK9u8yXqo3Qrw60kg0znF5ItVgZjtxQ9NIBgdBLfOq1DbWoclcB9tUCPtHVpHHLvXxS/O8my8m5k1nYZrEOwLMEs/p9BedMl0VLYrIhfEuN4ykVLNV29W17Eehf9D89siQkzAcSwja+NY1A9w8nZRKNqs4SyrxFJr7fXQSpxJaPvdTfeRJNDCD7VA4HZtIOUk9kYGizLZugMvhcTAUrkogoYlQutyAE8hGyka6TnhzrGw4Ci9iRL4wbyl75zmoQGK2EEGuTvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZTyIBSRDOP/XkKhj5OJBprAVtSv39vOpmIrevTNv+k=;
 b=wPgMtMYd1j0jwWoHx5VDb+ERP8WkK3OqAXsFTdBACakZgjWqABtKDEkbOIMNvHmTwFPawSxi+CHsF+afE4a5LElHYAIbSSGb4IJLEmmI7bD05yH0lJz0Yury4zLdF1Whkz07wx9u6bwv8orB3ifa3C4ONg0NNCg3QOqvGAAZijOmGkdA0myzb5xX9HOJlWFsO1j/zDWMZ7CdQn2QDKN+1OCkXnby1SaQeDEnsCcc4NvCxhcMXgFtTU8XAuzeshjsNNyhzk92pdPIcDlEKx4biXLnOzhzfBCg/T3RSUaLLl9B471K+C9hHhe4Q/BtadHyn6zV5ZCx9SUbtzDlOikOqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8096.eurprd04.prod.outlook.com (2603:10a6:102:1c7::19)
 by PA4PR04MB9440.eurprd04.prod.outlook.com (2603:10a6:102:2ac::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 02:44:35 +0000
Received: from PAXPR04MB8096.eurprd04.prod.outlook.com
 ([fe80::68be:f721:5000:3f2d]) by PAXPR04MB8096.eurprd04.prod.outlook.com
 ([fe80::68be:f721:5000:3f2d%5]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 02:44:34 +0000
From: hongxing.zhu@oss.nxp.com
To: frank.li@nxp.com,
	jingoohan1@gmail.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v1] PCI: dwc: Add force_l2 flag for platforms requiring L2 entry without D3cold
Date: Mon,  6 Jul 2026 10:47:52 +0800
Message-Id: <20260706024752.3256106-1-hongxing.zhu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::6) To PAXPR04MB8096.eurprd04.prod.outlook.com
 (2603:10a6:102:1c7::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8096:EE_|PA4PR04MB9440:EE_
X-MS-Office365-Filtering-Correlation-Id: bbed836f-a0f6-4260-f1fb-08dedb088358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|19092799006|23010399003|921020|18002099003|11063799006|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	9jHAAvT6gGkJ+H0tqeefHCUHoWL149T+UW55T9E2Zp6HJM+yf1ZhGnpeRFMyNodW3jD5Yq62+mCgCoN6pTAAsLvvu7QgaBOIldmylMQ76FvGcE4AflToCvR9wDvnuZy8ayL9rQA4YIhHbOsGxIB9W0ufT0a+JKXhuFm0DyrSJDHRd7bMPUqoh+DFeWFBa4xzsJry5wnEYLRbhDdQnGWLj3fLWRfu9lahS5mbfucGokv4tubY/AsmKP93/TEmStK1xI69Vr/jBDYWqgtF8B4AVWifZx6UB4PMhdpPy3zonkeNsItl4uoxDc9LzolErSiQ4ggNGb6P0phTDBMUC9ePH0c9LTvaCqJPYtA2tiT46P6LNhk2HqZsz/ZNvdrXL6fjhWvzQby2EcqJk9YZsgYCFzQVKGy5gbDJgE5alcOsjphTyiV48sBh2zU2gNuNMMs4LHSDPckHOs3s6KXG3Wp3Uhvz0KGehPmDcIOYt75NY/rLcJw6cwQ5hqCMc6Gf6f0nk6FGaOTmfQAF3pdUUQ/y90eAbqKJrmJ6ma0mQ429OGw9/sWSrK3SjxP10xvcNGQ7TkE9Ch8/vvfbSZjfZs4jI+8jeWjVtUH8gXM2voKJEIbKv81yReEPjOGLDu2hN093U9dkGbZIg9bxM6A8TWeupqBj17aEy1PQnNDMOJ3IWdFP18YWVGwaCYrIakdTa3QfClVb9o10GrvWcE5vRj5GBA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8096.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(19092799006)(23010399003)(921020)(18002099003)(11063799006)(5023799004)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LzNUyph6KM7NcOnNnbio8XAKgcHfxZ7nyWTZRoueHFKOPV/dnMKvJodQ8Xi8?=
 =?us-ascii?Q?voHI5FN4w4UmmfZnMSNlxK2avsNv79iHSEXJOkot+wrhNfKXuvL3n4VU+QKE?=
 =?us-ascii?Q?PkrD7fz4/Q1YGg+l0emaefwYEbIZBZFcZ00x6zkLGbZnjnOl3JuG7prKY+gv?=
 =?us-ascii?Q?3qdSXFrv5B6Vo8uiJExyCHjkwjsmMB7arQImkSFlkzF5Uorj6HudH83s35TT?=
 =?us-ascii?Q?6NxG3iH09ghleHft91DntfWcK4pwoabxAPICTLK32lzm1a3QYrDxZkM5cYbl?=
 =?us-ascii?Q?hlpmYMxZEQH6J6MIav5bA8PAnLdrsX/ailws1/tYxKtobSeSxG/bbb+KmF/e?=
 =?us-ascii?Q?+vInDC+NnNEiVENVelHGsKV2KpjnbQlAWT/F4Ib3v4xVPKG/0H98Ldo6DdCU?=
 =?us-ascii?Q?mgKSSE4peQoI0Vsd1tcMovnQZ1iIAIOB3csp15ziuxHf/T3tthl4D2o+o0TT?=
 =?us-ascii?Q?A5kTw0K1Z2COqewQAMF/MC3opAtciI9uruFP7na7G9B12EB1nW7AeM5MyEtS?=
 =?us-ascii?Q?1PF8DJFC6al7SPZfr73i46CO5Rs/WxTCxN2v5VyGmk/B4Y8IVu/1rI0fKD0V?=
 =?us-ascii?Q?jbah0VJgC58cmBav1hA1yLOQHTwYdTcH1SCRqXT0YZ2ocFOErIXPYdF2HWtB?=
 =?us-ascii?Q?AB/2xLQgiCvFj55qbOEZbkfN7PaXyJvTtxyvJMLKP4fElZhXco6uP3YSxj6K?=
 =?us-ascii?Q?ucgBAt48oO9ZMaBzCfJkUBsJO90SjpPz4mTkSHB551kd2DKRaLYsSyul+9xW?=
 =?us-ascii?Q?yCp5HSfM64aLFCo2TTRtQ8vOFkihTGxkCnKJgB2gcOSidUGFHHlDl/O1QO8r?=
 =?us-ascii?Q?bWA6BUAM/AKhNvZ5lRYeErQ0oDJw0allK7dtY5KjtnTRvdukPLpBlnuwkepp?=
 =?us-ascii?Q?XRzSZOASZtFL6ju14K+8wVm9kHc4NK3Y2dmeA2QGAbLWZJyT4OTLtD5vV5zl?=
 =?us-ascii?Q?nBQzD3+5MV6HcSOWiQDehlnZ0EOBfLS/ZSAgJ46K4IUnjI8UhmXpdHpkMjdo?=
 =?us-ascii?Q?O6NQGbHCvHNdTrcaJ1oDm2QYESasGUgvuGwECKFc80OUYZkkkn50Jwps8LH4?=
 =?us-ascii?Q?7k08vyFKSrhYDtz6WD6DF48jijNmZiqYmnvoYtEjG2v1zZeRoubBvtZz7Il+?=
 =?us-ascii?Q?AVJH6VkJ18/9nyvXf5zNVSeuYCF5JnKvZqz1JTxNUs1dIBApZ9IUqBjrc8gS?=
 =?us-ascii?Q?EwT2ZRhyxLF8dc1z1TEWvlpe6jVUhamuOih1em0099JZHPfuFnJXiHUGzZI3?=
 =?us-ascii?Q?2/WvMQewibDclDvtT7ILRI42nDk9bHQmfYZiefg4GdPFl7FIY2e1Mx2DuAQG?=
 =?us-ascii?Q?q5dzsEO4Lwkscr+e/IWjGUQNN6ITfIFTQ4SFyYYVQmF8orxpqdEBX12G+MfP?=
 =?us-ascii?Q?rzaZEDx2+PhcrJ5Y9j51AbneDFmL6lQPoSZ8M+VyCJUN0ZCHaAVnvShAED5L?=
 =?us-ascii?Q?BD/JmZNWQAcH096PJOK4qlF6+npAZsH7stAoxMr9jpW0mtFnNNkscGXmC1az?=
 =?us-ascii?Q?NMEY+DUImtlF2MdWkG1t61T2UxqgpaTBlX8u2Sv65mcoaD89ZWc8T6mvIM3A?=
 =?us-ascii?Q?aUcgdoz9eoA13h1t+6Ei7fcPtsVhK6h5vMuRkPCp/qNV08QcnEPWc6fAtAHs?=
 =?us-ascii?Q?OBaDNtvHuEoa5GR92TrSoWh2KX+IKw8TxYlf/8j39Rb6fiSX6S2r+KssOOTw?=
 =?us-ascii?Q?UJFTuqhAi6cnkjoUZLHYcTniV9ZdeO18j7X742iW91n9Fl8pdeI7S/u49N6G?=
 =?us-ascii?Q?3Q7Sed/oTlPNmx+ea840tQ+5x4R4sKNGM12QVXk+Z1HMgMX9SyT/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbed836f-a0f6-4260-f1fb-08dedb088358
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8096.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 02:44:34.8193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHgskAFX5+ul9ZJZUcdHd4D/N2nNcNy3JpJyzyBHTP99NviGKO2RhxeCtx0i+OLGJdfsxWFgt2Erpr+ZqjroI3Zdu1I/M4IGp+DjXThVtudsxxbjxUlO/v4CgTFi64hi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9440

From: Richard Zhu <hongxing.zhu@nxp.com>

Some platforms like i.MX have their PCIe RC controllers powered off
during system suspend, requiring full re-initialization on resume.
These platforms need to enter L2 state to properly notify endpoints
before power loss, even when D3cold is not supported.

Add a force_l2 flag to allow platform drivers to request L2 entry
during suspend regardless of D3cold capability, and enable it for
i.MX PCIe controllers.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c             | 5 +++++
 drivers/pci/controller/dwc/pcie-designware-host.c | 8 ++++++--
 drivers/pci/controller/dwc/pcie-designware.h      | 5 +++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index f55a68f60eea9..ea0b4eb03c1d0 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1966,6 +1966,11 @@ static int imx_pcie_probe(struct platform_device *pdev)
 		 */
 		imx_pcie_add_lut_by_rid(imx_pcie, 0);
 	} else {
+		/*
+		 * i.MX RC is powered off during suspend, force L2 entry to
+		 * ensure proper endpoint notification before power loss.
+		 */
+		pci->pp.force_l2 = true;
 		if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_SKIP_L23_READY))
 			pci->pp.skip_l23_ready = true;
 		if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_KEEP_MSI_CAP))
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 06722259d2e37..e3f022d2d453a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1222,14 +1222,18 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
 
 int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 {
-	bool pme_capable = false;
+	bool d3cold, pme_capable = false;
 	int ret = 0;
 	u32 val;
 
 	if (!dw_pcie_link_up(pci))
 		goto stop_link;
 
-	if (!pci_host_common_d3cold_possible(pci->pp.bridge, &pme_capable))
+	d3cold = pci_host_common_d3cold_possible(pci->pp.bridge, &pme_capable);
+	/*
+	 * Enter L2 if D3cold is possible or platform requires forced L2 entry
+	 */
+	if (!d3cold && !pci->pp.force_l2)
 		return 0;
 
 	if (pci->pp.ops->pme_turn_off) {
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index de4b245b1758c..5e88459e0cfa0 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -471,6 +471,11 @@ struct dw_pcie_rp {
 	bool			native_ecam;
 	bool                    skip_l23_ready;
 	bool			skip_pwrctrl_off;
+	/*
+	 * Force L2 entry even if D3cold not possible (e.g., when RC loses
+	 * power).
+	 */
+	bool                    force_l2;
 };
 
 struct dw_pcie_ep_ops {
-- 
2.34.1

